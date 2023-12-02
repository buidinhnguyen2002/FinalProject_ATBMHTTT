package dao.client;

import java.sql.*;
import java.util.*;

import context.DB;
import context.DBContext;
import entity.Comment;
import entity.Product;
import org.jdbi.v3.core.Jdbi;

public class ProductDAO {
	public static int getTotalProduct(int cid) {
		String query = "";
		switch (cid) {
			case 0: //tất cả sản phẩm
				query = "select count(p.nameProduct) from products p join product_prices pp on p.id = pp.idProduct where p.isActive ='1'";
				break;
			case 1: //góc bé trai
				query = "select count(p.nameProduct) from products p join categories C on p.idCategorie = c.id where p.isActive ='1' and  c.id in(1,2,5,7,9,13)";
				break;
			case 2: //góc bé gái
				query = "select count(p.nameProduct) from products p join categories C on p.idCategorie = c.id  where p.isActive ='1' and  idCategorie in(3,4,6,8,10,11,13)";
				break;
			case 3: //phụ kiện
				query = "select count(p.nameProduct) from products p join categories C on p.idCategorie = c.id  where p.isActive ='1' and  idCategorie in(14,15)";
				break;
			case 4: //khuyến mãi
				query = "select count(p.nameProduct) from products p join categories C on p.idCategorie = c.id join product_prices pp on pp.idProduct = p.id where p.isActive ='1' and  pp.listPrice > pp.discountPrice";
				break;
			case 5: //đồ chơi
				query = "select count(p.nameProduct) from products p join categories C on p.idCategorie = c.id  where p.isActive ='1' and  idCategorie in(12)";
				break;
			default:
				break;
		}
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
	public static int numberofcomment() {
		Jdbi me = DBContext.me();
		String query = "SELECT COUNT(id) FROM comments WHERE idParent IS NULL";
		return me.withHandle(handle -> handle.createQuery(query)
				.mapTo(Integer.class)
				.findFirst()
				.orElse(0));
	}
	public static List<Product> pagingProduct(int index, int cid, String sort, String type) {
		List<Product> list = new ArrayList<>();
		String query = "";
		switch (cid) {
			case 0:
				query = "select p.id, p.nameProduct, pp.listPrice, pp.discountPrice, pp.discount  from products p join product_prices pp on p.id = pp.idProduct where p.isActive ='1' order by " + sort + " " + type
						+ "  limit ?,12";
				break;
			case 1:
				query = "select p.id, p.nameProduct, pp.listPrice, pp.discountPrice, pp.discount from products p join categories c on p.idCategorie = c.id join product_prices pp on p.id = pp.idProduct where p.isActive ='1' and  idCategorie in(1,2,5,7,9,13) order by "
						+ sort + " " + type + "  limit ?,12";
				break;
			case 2:
				query = "select p.id, p.nameProduct, pp.listPrice, pp.discountPrice, pp.discount from products p join categories c on p.idCategorie = c.id join product_prices pp on p.id = pp.idProduct where p.isActive ='1' and  idCategorie in(3,4,6,8,10,11,13) order by "
						+ sort + " " + type + "  limit ?,12";
				break;
			case 3:
				query = "select p.id, p.nameProduct, pp.listPrice, pp.discountPrice, pp.discount from products p join categories c on p.idCategorie = c.id join product_prices pp on p.id = pp.idProduct where p.isActive ='1' and  idCategorie in(14,15) order by "
						+ sort + " " + type + "  limit ?,12";
				break;
			case 4:
				query = "select p.id, p.nameProduct, pp.listPrice, pp.discountPrice, pp.discount from products p join categories c on p.idCategorie = c.id join product_prices pp on p.id = pp.idProduct where p.isActive ='1' and  pp.listPrice > pp.discountPrice order by "
						+ sort + " " + type + "  limit ?,12";
				break;
			case 5:
				query = "select p.id, p.nameProduct, pp.listPrice, pp.discountPrice, pp.discount from products p join categories c on p.idCategorie = c.id join product_prices pp on p.id = pp.idProduct where p.isActive ='1' and  idCategorie in(12) order by "
						+ sort + " " + type + "  limit ?,12";
				break;
			default:
				break;
		}

		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query);) {
			ps.setInt(1, (index - 1) * 12);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(new Product(rs.getInt("id"), rs.getString("nameProduct"),
							rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
							rs.getInt("discount"), rs.getDouble("discountPrice")));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public static Comment findcommentbyid (int idcmt){
		Jdbi me = DBContext.me();
		String query="Select content,idCustomer,idProduct,createAt,nameAccount from comments where id =? ";
		return me.withHandle(handle -> handle.createQuery(query).bind(0,idcmt).mapToBean(Comment.class).findFirst().orElse(null));
	}
	public static Comment commentproduct(String content ,int idcustomer,int idproduct,String name) {
		Jdbi me = DBContext.me();
		String query = "INSERT into comments (content,idCustomer,idProduct,createAt,nameaccount) values (?,?,?,now(),?);";
		int id = me.withHandle(handle -> handle.createUpdate(query).bind(0, content).bind(1, idcustomer).bind(2, idproduct).bind(3, name).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one());
		return findcommentbyid(id);
	}
	public static List<Comment> displayfiveproduct(int idproduct,String idparent,boolean bigcmt){

		List<Comment> listcoment ;
		String query;
		Jdbi me = DBContext.me();
		if(bigcmt){
			query ="select id,content,idCustomer,idProduct ,nameaccount,createAt  from comments  where idProduct = ? and idParent is null order by createAt desc limit 5   ";

			listcoment = me.withHandle(handle->{
				return handle.createQuery(query).bind(0,idproduct)
						.mapToBean(Comment.class).list();
			});
		} else {
			query = "select  id,content,idCustomer,idProduct ,nameaccount,createAt  from comments  where idProduct = ? and idParent =? order by createAt desc limit 2 ";
			listcoment = me.withHandle(handle -> {
				return handle.createQuery(query).bind(0,idproduct).bind(1,idparent)
						.mapToBean(Comment.class).list();
			});
		}
		for (Comment cmts:listcoment){
			cmts.setListreply(displayfiveproduct(idproduct,String.valueOf(cmts.getId()),false));

		}
		return listcoment;
	}
	public static List<Comment> showmore(int idproduct,int length){
		List<Comment> listmore;
		String query="select id,content,idCustomer,idProduct ,nameaccount,createAt from comments  " +
				" where idProduct =? and idParent is null order " +
				"by createAt desc limit 3  offset ? ;\n" ;
		Jdbi me = DBContext.me();
		listmore = me.withHandle(handle -> {
			return handle.createQuery(query).bind(0,idproduct).bind(1,length).map((rs, ctx) -> new Comment(rs.getInt("id"),rs.getString("content")
			,rs.getInt("idCustomer"),rs.getInt("idProduct"),rs.getString("createAt"),rs.getString("nameAccount"),listcmtcon(rs.getInt("id")))).list();

		});
		return listmore;
	}
	public static List<Comment> listcmtcon(int idparent){
		List<Comment> list = null;
		Jdbi me = DBContext.me();
		String query ="SELECT id,content,idProduct ,idParent,createAt,nameAccount  FROM comments where idParent =?";
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind(0,idparent).mapToBean(Comment.class).list();
		});

	}
	public static Comment replycommentproduct(String content , int idcustomer, int idproduct, String name, String idParent) {
		Jdbi me = DBContext.me();
		String query = "INSERT into comments (content,idCustomer,idProduct,createAt,nameaccount,idParent) values (?,?,?,now(),?,?);";
		int id = me.withHandle(handle -> handle.createUpdate(query).bind(0, content).bind(1, idcustomer).bind(2, idproduct).bind(3, name).bind(4,idParent).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one());

		return findcommentbyid(id);
	}

	public static void main(String[] args) {

//		System.out.println(pagingProduct(1, 0, "idProduct", "asc"));
		System.out.println(commentproduct("Hàng này thật đẹp",3,1,"Lê Minh Long"));
//		System.out.println(displayfiveproduct(1,"3",true));
//		System.out.println(replycommentproduct("tôi đồng ý",1,1,"Lê Minh Long","1"));

	}
}
