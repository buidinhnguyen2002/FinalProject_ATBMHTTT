package dao.admin;

import java.sql.*;
import java.util.*;

import context.*;
import dao.client.UtilDAO;
import entity.*;
import org.jdbi.v3.core.*;

public class ProductAdminDAO {
    public static List<Product> getListProduct(int index) {
        Jdbi me = DBContext.me();
        String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice,p.isActive FROM products p join suppliers s on p.idSupplier = s.id join product_prices pp on pp.idProduct = p.id where p.isActive = '1' and s.isActive ='1' order by p.id limit ?,10";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, ((index - 1) * 10))
                .map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
                        rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
                        rs.getInt("discount"), rs.getDouble("discountPrice"), rs.getString("isActive")))
                .list());
    }

    public static int getTotalProduct() {
        String query = "select count(p.nameProduct) from products p join product_prices pp on p.id = pp.idProduct";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static int getTotalProductOuOtOfStock() {
        String query = "select count(p.nameProduct) from products p join product_prices pp on p.id = pp.idProduct where p.id = (SELECT idProduct FROM inventorys where idProduct = p.id having  SUM(quantity) < 20)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static List<Product> getListProductOuOtOfStock() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.id, p.nameProduct, pp.listPrice, pp.discount, ct.nameCategorie, sp.size, sp.color,invent.quantity FROM products p join product_prices pp on p.id = pp.idProduct join inventorys invent on invent.idProduct = p.id join categories ct on p.idCategorie = ct.id join size_color_products sp on invent.id_size_color = sp.id where p.id IN (select p1.id  from products p1 join inventorys i on p1.id = i.idProduct WHERE i.quantity between 0 and 5 ) GROUP BY p.id, sp.size, sp.color,invent.quantity";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setNameProduct(rs.getString("nameProduct") + "_" + rs.getString("size") + "/" + rs.getString("color"));
                product.setInventory(new Inventory(rs.getInt("quantity")));
                product.setCategory(new Category(rs.getString("nameCategorie")));
                if (product.getInventory().getQuantity() < 5 && product.getInventory().getQuantity() > 0) {
                    list.add(product);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Product> getListProductInventory() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.id, p.nameProduct, description,listPrice, nameCategorie, pp.discount, pp.discountPrice, i.totalQuantity AS quantity\n" +
                "FROM products p\n" +
                "JOIN product_prices pp ON p.id = pp.idProduct\n" +
                "JOIN categories c ON p.idCategorie = c.id\n" +
                "JOIN (SELECT idProduct, SUM(quantity) AS totalQuantity FROM inventorys GROUP BY idProduct HAVING SUM(quantity) > 100) i ON p.id = i.idProduct\n" +
                "WHERE p.id = (SELECT idProduct FROM inventorys WHERE idProduct = p.id HAVING SUM(quantity) > 100) and p.id not in (SELECT p.id FROM products p join product_prices pp on p.id = pp.idProduct join inventorys  invent on invent.idProduct = p.id join categories ct on p.idCategorie = ct.id where p.id IN (SELECT orr.idProduct FROM order_details orr JOIN orders od ON orr.idOrder = od.id WHERE od.status = 'Hoàn thành' AND YEAR(od.createAt) = YEAR(CURRENT_DATE())) GROUP BY p.id ORDER BY SUM(invent.quantity))\n";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setNameProduct(rs.getString("nameProduct"));
                product.setInventory(new Inventory(rs.getInt("quantity")));
                product.setCategory(new Category(rs.getString("nameCategorie")));
                list.add(product);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static int getTotalActiveProduct() {
        String query = "select count(id) from products where isActive = '1'";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .mapTo(Integer.class)
                    .findOne()
                    .orElse(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void removeProduct(String pid) {
        String query = "DELETE FROM Product WHERE [pid] = ?";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, pid);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {

        }
    }

    public static List<Category> getListCategory() {
        ArrayList<Category> list = new ArrayList<>();
        String query = "select * from categories ";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;

    }

    public static int getTotalOutOfStock() {
        String query = "SELECT count(quantity) FROM inventorys where quantity = 0";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .mapTo(Integer.class)
                    .findOne()
                    .orElse(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static List<Product> getSellingProducts() {
        String query = "SELECT p.id, p.nameProduct, pp.listPrice, pp.discount, pp.discountPrice, ct.nameCategorie FROM products p join product_prices pp on p.id = pp.idProduct join inventorys  invent on invent.idProduct = p.id join categories ct on p.idCategorie = ct.id where p.id IN (SELECT orr.idProduct FROM order_details orr JOIN orders od ON orr.idOrder = od.id WHERE od.status = 'Hoàn thành' AND YEAR(od.createAt) = YEAR(CURRENT_DATE())) GROUP BY p.id ORDER BY SUM(invent.quantity) LIMIT 10";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"), rs.getDouble("listPrice"), new Category(rs.getString("nameCategorie")))).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Product> getProductOOS() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.id, p.nameProduct, pp.listPrice, pp.discount, ct.nameCategorie, sp.size, sp.color,invent.quantity FROM products p join product_prices pp on p.id = pp.idProduct join inventorys invent on invent.idProduct = p.id join categories ct on p.idCategorie = ct.id join size_color_products sp on invent.id_size_color = sp.id where p.id IN (select p1.id  from products p1 join inventorys i on p1.id = i.idProduct WHERE i.quantity =0) GROUP BY p.id, sp.size, sp.color,invent.quantity";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setNameProduct(rs.getString("nameProduct") + "_" + rs.getString("size") + "/" + rs.getString("color"));
                product.setListPrice(rs.getDouble("listPrice"));
                product.setCategory(new Category(rs.getString("nameCategorie")));
                product.setInventory(new Inventory(rs.getInt("quantity")));
                if (product.getInventory().getQuantity() == 0) {
                    list.add(product);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Product> showlistproduct() {
        List<Product> list;
        Jdbi me = DBContext.me();
        String query = "select distinct p.id,p.nameProduct,pd.nameProducer,p.status ,pp.listPrice,pp.discount,pp.discountPrice,cate.nameCategorie , p.isActive,p.isDelete  \n" +
                "                                    from products p join  product_prices pp on p.id = pp.idProduct \n" +
                "                                      join categories cate on cate.id = p.idCategorie \n" +
                "                                    join size_color_products sizepro on sizepro.idProduct = p.id\n" +
                "                                      join producers pd on pd.id = p.idProducer           \n" +
                "                    where p.isActive =1 ";
        return list = me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct")
                    , rs.getDouble("listPrice"), new Category(rs.getString("nameCategorie")), new Producer(rs.getString("nameProducer")), UtilDAO.findListImageByIdProduct(rs.getInt("id")), UtilDAO.findListSizeColorByIdProduct(rs.getInt("id"))
                    , rs.getString("isActive"), rs.getString("isDelete"), rs.getInt("discount"), rs.getDouble("discountPrice"), rs.getString("status"))).list();
        });
    }

    public static boolean deleteproduct(String idpro) {
        Jdbi me = DBContext.me();
        String query = "UPdate products p\n" +
                "set p.isActive = 0 , p.isDelete =1\n" +
                "where id = ?";

        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idpro).execute() == 1);
    }

    public static int updatenameproduct(Product p) {
        Jdbi me = DBContext.me();
        String query = "update products set nameProduct = ? where id = ? ";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, p.getNameProduct()).bind(1, p.getId()).execute());

    }

    public static int updatecost(Product p) {
        Jdbi me = DBContext.me();
        String query = "update product_prices set listPrice = ? where idProduct = ? ";
        return me.withHandle(handle ->
                handle.createUpdate(query).bind(0, p.getListPrice()).bind(1, p.getId()).execute());

    }

    public static int updatediscount(Product p) {
        Jdbi me = DBContext.me();
        String query = "update product_prices set discount = ? where idProduct = ? ";
        return me.withHandle(handle ->
                handle.createUpdate(query).bind(0, p.getDiscount()).bind(1, p.getId()).execute());
    }

    public static int updatequantity(Product p) {
        Jdbi me = DBContext.me();
        String query = "update products set nameProduct = ? where id = ? ";
        return me.withHandle(handle ->
                handle.createUpdate(query).bind(0, p.getNameProduct()).bind(1, p.getId()).execute());
    }

    public static int updatestatus(Product p) {
        Jdbi me = DBContext.me();
        String query = "update products set status = ?  where id = ? ";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, p.getStatus()).bind(1, p.getId()).execute());
    }

    public static List<Category> listcate() {
        Jdbi me = DBContext.me();
        List<Category> list;
        String query = "select  id , nameCategorie from categories ";
        list = me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> new Category(rs.getInt("id"), rs.getString("nameCategorie"))).list();

        });
        return list;
    }

    public static int idproduct(String name) {
        Jdbi me = DBContext.me();
        String query = "Select id from categories where nameCategorie =?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, name).mapTo(Integer.class).one());

    }

    public static int updateidcate(Product p) {
        Jdbi me = DBContext.me();
        String query = "update products set idCategorie = ?  where id = ? ";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, p.getIdCategory()).bind(1, p.getId()).execute());

    }

    public static int quantityofsize(Product p) {
        Jdbi me = DBContext.me();
        String query = "select i.quantity from size_color_products s join inventorys i \n" +
                "on i.id_size_color = s.id where i.idProduct = ? and i.id_size_color =?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, p.getId()).bind(1, p.getInventory())).mapTo(Integer.class).one();
    }

    public static int updatecolor(SizeColorProduct s) {
        Jdbi me = DBContext.me();
        String query = "update size_color_products set color = ? where idProduct = ? and id = ?";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, s.getColor()).bind(1, s.getIdProduct()).bind(2, s.getId()).execute());
    }

    public static int updatenumber(Inventory i) {
        Jdbi me = DBContext.me();
        String query = "update inventorys set quantity = ? where id_size_color = ? and idProduct=?";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, i.getQuantity()).bind(1, i.getId_size_color()).bind(2, i.getIdProduct()).execute());

    }

    public static SizeColorProduct colorsize(SizeColorProduct s) {
        Jdbi me = DBContext.me();
        String query = "select s.id,s.idProduct,s.color,i.quantity from size_color_products s join inventorys i on s.id =i.id_size_color where s.id =? and s.idProduct =?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, s.getId()).bind(1, s.getIdProduct()).map((rs, ctx) -> new SizeColorProduct(rs.getInt("id"), rs.getInt("idProduct"), rs.getString("color"), rs.getInt("quantity"))).findFirst().orElse(null));
    }

    public static int insertProduct(String nameProduct, int idSupplier, int idCattegory, int idProducer, String description) {
        String query = "insert into products (nameProduct, description, idSupplier, idProducer, idCategorie, isActive, isDelete, status) values(?, ?, ?, ?, ?, 1, 0, 'Còn hàng')";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, nameProduct).bind(1, description).bind(2, idSupplier).bind(3, idProducer).bind(4, idCattegory).execute());
    }

    public static int getIdCategory(String category) {
        String query = "SELECT id FROM categories where nameCategorie = ?";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .bind(0, category).mapTo(Integer.class)
                    .findOne()
                    .orElse(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int getIdProducer(String producer) {
        String query = "select id from producers where nameProducer = ?";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .bind(0, producer).mapTo(Integer.class)
                    .findOne()
                    .orElse(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int getIdSupplier(String supplier) {
        String query = "select id from suppliers where nameSupplier = ?";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .bind(0, supplier).mapTo(Integer.class)
                    .findOne()
                    .orElse(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static List<Producer> getListProducer() {
        ArrayList<Producer> list = new ArrayList<>();
        String query = "select * from producers";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Producer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Supplier> getListSupplier() {
        ArrayList<Supplier> list = new ArrayList<>();
        String query = "select * from suppliers";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Supplier(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int insertPriceAndSell(int idProduct, String nameProduct, String price, String sell) {
        double discountPrice = Math.round(Double.valueOf(price) - (Double.valueOf(price) * Double.valueOf(sell) / 100));
        String query = "insert into product_prices (idProduct, nameProduct, listPrice, discount,discountPrice) values(?, ?, ?, ?,?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idProduct).bind(1, nameProduct).bind(2, price).bind(3, sell).bind(4, discountPrice).execute());
    }

    public static int getIdProduct(String nameProduct) {
        String query = "select id from products where nameProduct = ?";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .bind(0, nameProduct).mapTo(Integer.class)
                    .findOne()
                    .orElse(0);
        } catch (Exception e) {
            return 0;
        }

    }

    public static int insertSizeColor(SizeColorProduct sizeColorProduct) {
        String query = "INSERT INTO size_color_products (idProduct, size, color) VALUES (?, ?, ?)";
        Jdbi jdbi = DBContext.me();

        Integer generatedId = jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, sizeColorProduct.getIdProduct())
                        .bind(1, sizeColorProduct.getSize())
                        .bind(2, sizeColorProduct.getColor())
                        .executeAndReturnGeneratedKeys(String.valueOf(Statement.RETURN_GENERATED_KEYS))
                        .mapTo(Integer.class)
                        .one()
        );
        return (generatedId != null) ? generatedId : 0;
    }

    public static int insertQuantity(int setSizeColor, SizeColorProduct sizeColorProduct) {
        String query = "INSERT INTO inventorys (idProduct, id_size_color, quantity) VALUES (?, ?, ?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, sizeColorProduct.getIdProduct()).bind(1, setSizeColor).bind(2, sizeColorProduct.getQuantity()).execute());
    }

    public static int getImage(int idProduct, String mainImageFileName) {
        String query = "INSERT INTO image_products (idProduct, image) VALUES (?, ?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idProduct).bind(1, mainImageFileName).execute());
    }

    public static int getChildImage(int idProduct, String descriptionImageFileName) {
        String query = "INSERT INTO image_products (idProduct, image) VALUES (?, ?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idProduct).bind(1, descriptionImageFileName).execute());
    }

    public static boolean checkNameProductEq(String nameProduct) {
        Jdbi jdbi = DBContext.me();
        String query = "SELECT COUNT(*) FROM products WHERE nameProduct = :nameProduct";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("nameProduct", nameProduct)
                .mapTo(Integer.class)
                .findFirst()
                .orElse(0) > 0);
    }

    public static boolean addProducer(String nameProducer) {
        String query = "INSERT INTO producers (nameProducer,isActive) VALUES (?, 1)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, nameProducer).execute() == 1);
    }

    public static boolean addSupplier(String nameSupplier) {
        String query = "INSERT INTO suppliers (nameSupplier,isActive) VALUES (?, 1)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, nameSupplier).execute() == 1);
    }

    public static boolean addCategorie(String nameCategorie) {
        String query = "INSERT INTO categories (nameCategorie) VALUES (?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, nameCategorie).execute() == 1);
    }

    public static void main(String[] args) {
        System.out.println(getListProductOuOtOfStock());
    }

}
