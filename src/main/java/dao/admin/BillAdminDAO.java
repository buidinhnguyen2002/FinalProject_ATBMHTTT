package dao.admin;

import java.util.List;

import context.DBContext;
import dao.client.UtilDAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

public class BillAdminDAO {
	public static List<Order> getListOrder() {
		Jdbi me = DBContext.me();
		String query = "SELECT od.id,od.createAt,deliveryAt,statusPay,od.status,od.idAccount,acc.accountName,od.totalPrice  FROM orders od join accounts acc on od.idAccount = acc.id";
		return me.withHandle(handle -> handle.createQuery(query).map((rs, ctx) -> new Order(rs.getInt("id"), rs.getString("createAt"),rs.getString("deliveryAt"), rs.getString("statusPay"), rs.getString("status"), new Account(rs.getInt("idAccount"), rs.getString("accountName")),rs.getDouble("totalPrice"))).list());
	}
	public static List<Order> getListOrderLimit() {
		Jdbi me = DBContext.me();
		String query = "SELECT od.id,od.createAt,deliveryAt,statusPay,od.status,od.idAccount,acc.fullName,od.totalPrice  FROM orders od join accounts acc on od.idAccount = acc.id order by id desc limit 4";
		return me.withHandle(handle -> handle.createQuery(query).map((rs, ctx) -> new Order(rs.getInt("id"), rs.getString("createAt"),rs.getString("deliveryAt"), rs.getString("statusPay"), rs.getString("status"), new Account(rs.getInt("idAccount"), rs.getString("fullName")),rs.getDouble("totalPrice"))).list());
	}
	public static Order getOrderById(String idOrder) {
		Jdbi me = DBContext.me();
		String query = "SELECT id,createAt,deliveryAt,statusPay,idAccount,feeship,totalPrice,status,address,wardId,districtId,note FROM orders where id = ?";
		return me.withHandle(handle -> handle.createQuery(query).bind(0,idOrder).mapToBean(Order.class).findFirst().orElse(null));
	}

	public static List<OrderDetail> getOrderDetail() {
		Jdbi me = DBContext.me();
		String query = "SELECT od.id,idOrder,idProduct,nameProduct,quantity,price,node,productSize,productColor FROM order_details od join orders o on  o.id = od.idOrder join products p on od.idProduct = p.id";
		return me.withHandle(handle -> handle.createQuery(query).map((rs, ctx) -> new OrderDetail(rs.getInt("id"), rs.getInt("idOrder"), rs.getInt("idProduct"), new Product(rs.getInt("idProduct"), rs.getString("nameProduct"), UtilDAO.findListImageByIdProduct(rs.getInt("idProduct"))),rs.getInt("quantity"),rs.getDouble("price"),rs.getString("node"),rs.getString("productSize"),rs.getString("productColor"))).list());
	}
	public static boolean removeBill(String bid) {
		Jdbi me = DBContext.me();
		String query = "delete from orders where id = ?";
		return me.withHandle(handle -> handle.createUpdate(query).bind(0,bid).execute()==1);
	}

	public static boolean updateBill(String status, String bid) {
		String query = "update orders set status = ? where id =?;";
		Jdbi me = DBContext.me();
		return me.withHandle(handle -> handle.createUpdate(query).bind(0,status).bind(1,bid).execute())==1;
	}
	public static boolean updateBillDeliveryAt(String bid) {
		String query = "update orders set deliveryAt =NOW() where id =?;";
		Jdbi me = DBContext.me();
		return me.withHandle(handle -> handle.createUpdate(query).bind(0,bid).execute())==1;
	}
	public static int getTotalAcceptProduct() {
		String query = "SELECT count(createAt) FROM orders where status = 'Hoàn thành'and month (createAt) = month(current_date())";
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
	public static int getTotalNoYetOrder() {
		String query = "SELECT COUNT(p.id) AS so_san_pham_chua_ban\n" +
				"FROM products p\n" +
				"WHERE p.id NOT IN (\n" +
				"  SELECT od.idProduct\n" +
				"  FROM orders o\n" +
				"  JOIN order_details od ON o.id = od.idOrder\n" +
				"  WHERE MONTH(o.createAt) = MONTH(CURRENT_DATE())\n" +
				");";
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

	public static int getTotalCancelProduct() {
		String query = "SELECT count(createAt) FROM orders where status = 'Đã hủy' and month(createAt) = month(current_date())";
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

	public static int getTotalPrice() {
		String query = "SELECT sum(totalPrice) FROM orders where status = 'Hoàn thành' and month(createAt) = month(current_date())";
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

	public static int thisMonth() {
		String query = "SELECT distinct month(current_date()) FROM orders";
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

	public static int sumNewMembers() {
		String query = "select count(id) from accounts a join account_roles ar on a.id = ar.idAccount where month(createAt) = month(current_date()) and ar.idRole in (2,3,4)";
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

	public static List<Order> getListOrderSucess() {
		Jdbi me = DBContext.me();
		String query = "SELECT od.id,od.createAt,statusPay,od.idAccount,acc.fullName,od.totalPrice  FROM orders od join accounts acc on od.idAccount = acc.id where od.status = 'Hoàn thành'";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Order(rs.getInt("id"), new Account(rs.getInt("id"),
						rs.getString("fullName")),rs.getDouble("totalPrice"))).list());
	}

	public static int sumBillInMonth(int month) {
		String query = "select sum(od.quantity) from order_details od join orders o on od.idOrder = o.id where year(o.createAt) = year(current_date()) and month(o.createAt) = ? and o.status = 'Hoàn thành'";
		try (Handle handle = DBContext.me().open()) {
			return handle.createQuery(query).bind(0, month).mapTo(Integer.class).findOne().orElse(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public static int SumMoneyInMonth(int month) {
		String query = "select sum(o.totalPrice) from order_details od join orders o on od.idOrder = o.id where year(o.createAt) = year(current_date()) and month(o.createAt) = ? and o.status = 'Hoàn thành'";
		try (Handle handle = DBContext.me().open()) {
			return handle.createQuery(query).bind(0, month).mapTo(Integer.class).findOne().orElse(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public static int sumAllBillInMonth(int month) {
		String query = "select sum(od.quantity) from order_details od join orders o on od.idOrder = o.id where year(o.createAt) = year(current_date()) and month(o.createAt) = ?";
		try (Handle handle = DBContext.me().open()) {
			return handle.createQuery(query).bind(0, month).mapTo(Integer.class).findOne().orElse(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public static void main(String[] args) {
		System.out.println(getTotalNoYetOrder());
	}

}
