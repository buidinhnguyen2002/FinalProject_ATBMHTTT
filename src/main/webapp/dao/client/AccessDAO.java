package dao.client;

import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import entity.*;
import org.jdbi.v3.core.Handle;

public class AccessDAO {
	public static List<Product> searchByName(String txtSearch) {
		try (Handle handle = DBContext.me().open()) {
			String query = "SELECT p.id, p.nameProduct, listPrice, description, nameSupplier, nameProducer, nameCategorie, pp.discount, pp.discountPrice, i.quantity " + "FROM products p " + "JOIN product_prices pp ON p.id = pp.idProduct " + "JOIN suppliers s ON p.idSupplier = s.id " + "JOIN producers ps ON ps.id = p.idProducer " + "JOIN categories c ON p.idCategorie = c.id " + "JOIN inventorys i ON i.idProduct = p.id " + "WHERE p.isActive = '1' AND s.isActive = '1' AND p.nameProduct LIKE ?";
			return handle.createQuery(query).bind(0, "%" + txtSearch + "%").map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
							rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
							rs.getInt("discount"),rs.getDouble("discountPrice")))
					.list();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	public static int getTotalProductSearch(String txtSearch) {
		try (Handle handle = DBContext.me().open()) {
			String query = "SELECT COUNT(nameProduct) FROM products p WHERE p.isActive ='1' and  nameProduct LIKE ? ";
			return handle.createQuery(query).bind(0, "%" + txtSearch + "%").mapTo(Integer.class).one();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public static List<Product> pagingProductSearch(int index, String txtSearch, String sort, String type) {
		String query = "select p.id, p.nameProduct, pp.listPrice,pp.discount, pp.discountPrice from products p join product_prices pp on p.id = pp.idProduct where p.isActive ='1' and  p.nameProduct like ? order by " + sort + " " + type + "  limit ?,12";
		try (Handle handle = DBContext.me().open()) {
			return handle.createQuery(query).bind(0,"%" + txtSearch + "%").bind(1, (index-1)*12).map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
							rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
							rs.getInt("discount"),rs.getDouble("discountPrice")))
					.list();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	public static void main(String[] args) {
		System.out.println(pagingProductSearch(1, "Váy", "id", "asc").size());
	}
}
