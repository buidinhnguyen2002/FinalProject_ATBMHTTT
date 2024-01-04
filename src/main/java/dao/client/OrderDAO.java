package dao.client;//package dao.client;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import context.DBContext;
import entity.*;
import org.jdbi.v3.core.Jdbi;

public class OrderDAO {
    public static List<Order> getListOrderByAcountId(String uid) {
        Jdbi me = DBContext.me();
        String query = "SELECT od.id,od.createAt,statusPay,od.status,od.idAccount,acc.accountName,od.totalPrice  FROM orders od join accounts acc on od.idAccount = acc.id where acc.id = ?;";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, uid).map((rs, ctx) -> new Order(rs.getInt("id"), rs.getString("createAt"), rs.getString("statusPay"), rs.getString("status"), new Account(rs.getInt("idAccount"), rs.getString("accountName")), rs.getDouble("totalPrice"))).list());
    }

    public static List<OrderDetail> getOrderDetailByBid(String pId) {
        Jdbi me = DBContext.me();
        String query = "SELECT od.id,idOrder,idProduct,nameProduct,quantity,price,node,productSize,productColor FROM order_details od join orders o on  o.id = od.idOrder join products p on od.idProduct = p.id where idOrder =?;";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, pId).map((rs, ctx) -> new OrderDetail(rs.getInt("id"), rs.getInt("idOrder"), rs.getInt("idProduct"), new Product(rs.getInt("idProduct"), rs.getString("nameProduct"), UtilDAO.findListImageByIdProduct(rs.getInt("idProduct"))), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("node"), rs.getString("productSize"), rs.getString("productColor"))).list());
    }

    public static int createOrder(int idAccount) {
        Jdbi me = DBContext.me();
        String query = "insert into orders (idAccount) values(?);";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idAccount).executeAndReturnGeneratedKeys("id").mapTo(int.class).one());
    }

//    public static Order createOrder(int idAccount) {
//        Jdbi me = DBContext.me();
//        String query = "insert into orders (idAccount) values(?);";
//        Order order = new Order();
//        int idOrder = me.withHandle(handle -> handle.createUpdate(query).bind(0, idAccount).executeAndReturnGeneratedKeys("id").mapTo(int.class).one());
//        order.setId(idOrder);
//        order.setIdAccount(idAccount);
//        String createAt = getCreateAtOrder(idOrder);
//        order.setCreateAt(createAt);
//        return order;
//    }

    public static int deleteOrder(int idOrder) {
        Jdbi me = DBContext.me();
        String query = "delete from orders where id = ?;";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idOrder).execute());
    }
    public static int createOrderDetail(OrderDetail orderDetail) {
        Jdbi me = DBContext.me();
        String query = "insert into order_details (idOrder,idProduct,quantity,price,productSize,productColor) values(?,?,?,?,?,?);";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, orderDetail.getIdOrder()).bind(1, orderDetail.getProduct().getId()).bind(2, orderDetail.getQuantity()).bind(3, orderDetail.getPrice()).bind(4, orderDetail.getProductSize()).bind(5, orderDetail.getProductColor()).executeAndReturnGeneratedKeys().mapTo(Integer.class).one());
    }

    public static void updateOrder(Order order) {
        Jdbi me = DBContext.me();
        String query = "update orders set totalPrice = ?,sale=?,status=?,statusPay=?,address=?,note=?,wardId=?,districtId=?,signature=?,transactionId = ? , feeship = ? where id = ?";
        me.withHandle(handle -> handle.createUpdate(query).bind(0, order.getTotalPrice()).bind(1, order.getSale()).bind(2, order.getStatus()).
                bind(3, order.getStatusPay()).bind(4, order.getAddress()).bind(5, order.getNote()).bind(6, order.getWardId()).
                bind(7, order.getDistrictId()).bind(8, order.getSignature()).bind(9,order.getTransactionId()).bind(10, order.getFeeship()).bind(11, order.getId()).execute());
    }

    public static void updateStatusOrder(String status, String id) {
        Jdbi me = DBContext.me();
        String query = "update orders set status = ?  where id = ?";
        me.withHandle(handle -> handle.createUpdate(query).bind(0, status).bind(1, id).execute());
    }
    public static void updateStatusPayOrder(String statusPay, String id) {
        Jdbi me = DBContext.me();
        String query = "update orders set statusPay = ?  where id = ?";
        me.withHandle(handle -> handle.createUpdate(query).bind(0, statusPay).bind(1, id).execute());
    }

    public static Order getOrderByBid(String id) {
        Jdbi me = DBContext.me();
        String query = "select id,createAt,deliveryAt,statusPay,idAccount,sale,totalPrice,status,address,note, wardId, districtId,idEmployee,updateAt,publicKeyId,transactionId,feeship from orders where id = ?";
        Order order = me.withHandle(handle -> handle.createQuery(query).bind(0, id).mapToBean(Order.class).one());
        order.setAccount(UtilDAO.findAccountById(order.getIdAccount()));
        return order;
    }

    public static int updateInventoryProduct(String idProduct, int new_quantity, int idSizeColor) {
        Jdbi me = DBContext.me();
        String query = "update inventorys set quantity = ? where idProduct = ? and id_size_color = ?";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, new_quantity).bind(1, idProduct).bind(2, idSizeColor).execute());
    }

    public static int getIdSizeColor(int idProduct, String productSize, String productColor) {
        Jdbi me = DBContext.me();
        String query = "SELECT id FROM size_color_products where idProduct = ? and size = ? and color = ?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idProduct).bind(1, productSize).bind(2, productColor).mapTo(Integer.class).findFirst().orElse(null))
                ;
    }

    public static int getQuantitySizeColor(int idProduct, int idSizeColor) {
        Jdbi me = DBContext.me();
        String query = "SELECT quantity FROM inventorys where idProduct = ? and id_size_color=?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idProduct).bind(1, idSizeColor).mapTo(Integer.class).findFirst().orElse(null))
                ;
    }

    public static int checkDiscount(String reductionCode) {
        Jdbi me = DBContext.me();
        String query = "SELECT percentage FROM discounts WHERE codeDiscount = ? AND status = 1 and isDelete = 0 AND NOW() BETWEEN startTime AND endTime";
        return me.withHandle(handle -> handle.createQuery(query)
                .bind(0, reductionCode)
                .mapTo(Integer.class)
                .findFirst()
                .orElse(0));
    }

    public static String getSignatureById(int idOrder) {
        Jdbi me = DBContext.me();
        String query = "SELECT signature FROM orders where id = ?";
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idOrder).mapTo(String.class).findOne().orElse(null));
    }

    public static List<PublicKeyUser> getPublicKeyById(int id, String createAt) {
        Jdbi me = DBContext.me();
        String query = "SELECT publicKey,expired,createAt FROM public_key_signature where idAccount = ? AND ((createAt < ? AND ? < expired) OR (expired IS NULL)) ";
        List<PublicKeyUser>  publicKeyUser = me.withHandle(handle -> handle.createQuery(query).bind(0, id).bind(1, createAt).bind(2, createAt).mapToBean(PublicKeyUser.class).list());
        return publicKeyUser;
    }
    public static PublicKeyUser getPublicKeyById(int id) {
        Jdbi me = DBContext.me();
        String query = "SELECT publicKey,expired,createAt FROM public_key_signature where idAccount = ? AND expired IS NULL ";
        PublicKeyUser  publicKeyUser = me.withHandle(handle -> handle.createQuery(query).bind(0, id).mapToBean(PublicKeyUser.class).one());
        return publicKeyUser;
    }
public static String getCreateAtOrder(int id) {
    Jdbi me = DBContext.me();
    String query = "select createAt from orders where id = ?";
    Timestamp createAt = me.withHandle(handle ->
            handle.createQuery(query)
                    .bind(0, id)
                    .mapTo(Timestamp.class)
                    .one()
    );
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(createAt);
}


    public static void main(String[] args) {
//        System.out.println(getOrderDetailByBid("135"));
//       System.out.println(getOrderDetailByBid("133"));
//       System.out.println(getPublicKeyById(1));
       updateStatusPayOrder("Đã hoàn tiền","174");
    }

}
