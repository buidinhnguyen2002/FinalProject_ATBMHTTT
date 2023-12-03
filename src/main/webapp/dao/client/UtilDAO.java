package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.*;
import org.jdbi.v3.core.Jdbi;

import context.DBContext;

public class UtilDAO {
    public static List<ImageProduct> findListImageByIdProduct(int idProduct) {
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery("SELECT id,idProduct,image FROM image_products where idProduct = ?").bind(0, idProduct).mapToBean(ImageProduct.class).list());
    }

    public static List<SizeColorProduct> findListSizeColorByIdProduct(int idProduct) {
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery("SELECT id,sl.idProduct,size,color,i.quantity FROM size_color_products sl join inventorys i  on i.id_size_color = sl.id  where sl.idProduct = ?").bind(0, idProduct).mapToBean(SizeColorProduct.class).list());
    }

    public static Product findProductById(int idProduct) {
        Jdbi me = DBContext.me();
        String query = "SELECT p.id,p.nameProduct,listPrice,description,nameSupplier,nameProducer,nameCategorie,pp.discount,pp.discountPrice,i.quantity,i.id_size_color FROM products p join product_prices pp on p.id = pp.idProduct join suppliers s on p.idSupplier = s.id join producers ps on ps.id = p.idProducer join categories c on p.idCategorie = c.id join inventorys i on i.idProduct = p.id where p.isActive ='1' and s.isActive= '1' and p.id = ?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idProduct).map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
                        rs.getDouble("listPrice"), rs.getString("description"), new Supplier(rs.getString("nameSupplier")), new Producer(rs.getString("nameProducer")), new Category(rs.getString("nameCategorie")),
                        UtilDAO.findListImageByIdProduct(rs.getInt("id")), UtilDAO.findListSizeColorByIdProduct(rs.getInt("id")), rs.getInt("discount"), rs.getDouble("discountPrice")))
                .findFirst().orElse(null));
    }

    public static Product findproductByID(int idp) {
        Jdbi me = DBContext.me();
        String query = "select  id, nameProduct  from products  where id = ? and isActive =1 ";
        return (Product) me.withHandle(handle -> handle.createQuery(query).bind(0, idp).map((rs, ctx) -> new Product(rs.getInt("id")
                , rs.getString("nameProduct"))).findFirst().orElse(null));
    }

    public static Account findAccountById(int idAccount) {
        Jdbi me = DBContext.me();
        String query = "select id,accountName,password,fullName,address,email,phone,idRoleMember,isActive  from accounts where id =?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idAccount).map((rs, ctx) -> new Account(rs.getInt("id"), rs.getString("accountName"), rs.getString("password"), rs.getString("fullName"), rs.getString("address"), rs.getString("email"), rs.getString("phone"), rs.getInt("idRoleMember"), rs.getBoolean("isActive"))).findFirst().orElse(null));

    }

    public static Product findProduct(int idProduct) {
        Jdbi me = DBContext.me();
        String query = "SELECT p.id,p.nameProduct,p.status,listPrice,description,nameSupplier,ps.nameProducer,c.nameCategorie,pp.discount,pp.discountPrice,i.quantity,i.id_size_color FROM products p join product_prices pp on p.id = pp.idProduct join suppliers s on p.idSupplier = s.id join producers ps on ps.id = p.idProducer join categories c on p.idCategorie = c.id join inventorys i on i.idProduct = p.id  where p.isActive ='1' and s.isActive= '1' and p.id = ?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idProduct).map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
                        rs.getDouble("listPrice"), rs.getString("description"), new Supplier(rs.getString("nameSupplier")), new Producer(rs.getString("nameProducer")), new Category(rs.getString("nameCategorie")),
                        UtilDAO.findListImageByIdProduct(rs.getInt("id")), UtilDAO.findListSizeColorByIdProduct(rs.getInt("id")), rs.getInt("discount"), rs.getDouble("discountPrice"), rs.getString("status")))
                .findFirst().orElse(null));
    }

    public static boolean insertRates(Rate rate) {
        Jdbi me = DBContext.me();
        String query = "insert INTO rates (idAccount,idProduct,numberStar,status) values (?,?,?,1)";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, rate.getIdAccount()).bind(1, rate.getIdProduct()).bind(2, rate.getNumberStar()).execute() == 1);
    }

    public static boolean updateRates(Rate rate) {
        Jdbi me = DBContext.me();
        String query = "update rates set  numberStar = ? where idAccount = ? and idProduct =?";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, rate.getNumberStar()).bind(1, rate.getIdAccount()).bind(2, rate.getIdProduct()).execute() == 1);
    }

    public static boolean checkRateEq(String idAccount, String idProduct) {
        Jdbi me = DBContext.me();
        String query = "SELECT EXISTS(SELECT 1 FROM rates WHERE idAccount = ? AND idProduct = ?)";
        boolean result = me.withHandle(handle -> handle.createQuery(query)
                .bind(0, idAccount)
                .bind(1, idProduct)
                .mapTo(Boolean.class)
                .findOnly());
        return result;
    }

    public static String RatesByIdProductAndIdAccount(String idAccount, String idProduct) {
        Jdbi me = DBContext.me();
        String query = "select numberStar from  rates   where idAccount = ? and idProduct =?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idAccount)
                .bind(1, idProduct).mapTo(String.class).findFirst().orElse(null));
    }

    public static boolean isAverageRatingAboveThreshold(String idProduct, int threshold) {
        Jdbi me = DBContext.me();
        String query = "SELECT AVG(numberStar) AS averageRating FROM rates WHERE idProduct = ?";
        Double averageRating = me.withHandle(handle -> handle.createQuery(query)
                .bind(0, idProduct)
                .mapTo(Double.class)
                .findFirst()
                .orElse(null));

        if (averageRating != null && averageRating >= threshold) {
            return true;
        } else {
            return false;
        }
    }
    public static Double getAverageRatingByIdProduct(String idProduct) {
        Jdbi me = DBContext.me();
        String query = "SELECT IFNULL(AVG(numberStar), 0) AS averageRating, CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS hasRating FROM rates WHERE idProduct = ? AND status = '1';\n";
        return me.withHandle(handle -> handle.createQuery(query)
                .bind(0, idProduct).mapTo(Double.class).findFirst().orElse(0.0));
    }


    public static Integer getRatingCountByIdProduct(String idProduct) {
        Jdbi me = DBContext.me();
        String query = "SELECT COUNT(*) AS ratingCount FROM rates WHERE idProduct = ? AND status = '1';\n";
        return me.withHandle(handle -> handle.createQuery(query)
                .bind(0, idProduct).mapTo(Integer.class).findFirst().orElse(null));
    }

    public static void main(String[] args) {
//        System.out.println(updateRates(new Rate(0, 2, 1, 5, 1)));
        System.out.println(getRatingCountByIdProduct("4"));
//        System.out.println(checkRateEq("2","5"));
    }


}
