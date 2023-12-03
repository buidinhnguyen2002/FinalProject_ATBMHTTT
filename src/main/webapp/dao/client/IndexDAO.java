package dao.client;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import context.DB;
import org.jdbi.v3.core.Jdbi;

import context.DBContext;
import entity.Product;
import entity.View;

public class IndexDAO {
	public static List<Product> getSellProduct() {
		Jdbi me = DBContext.me();
		String query ="SELECT products.id,products.nameProduct,product_prices.listPrice,discount,discountPrice FROM products join product_prices on products.id = product_prices.idProduct WHERE  isActive = 1 and isDelete = 0 and id IN (SELECT idProduct FROM order_details JOIN orders ON order_details.idOrder = orders.id WHERE orders.status = 'Hoàn thành'  AND YEAR(orders.createAt) = YEAR(CURRENT_DATE()) AND MONTH(orders.createAt) = MONTH(CURRENT_DATE()) GROUP BY idProduct ORDER BY SUM(quantity) DESC) LIMIT 4 ; ";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}

	public static List<Product> getSellProductTwo() {
		Jdbi me = DBContext.me();
		String query ="SELECT products.id,products.nameProduct,product_prices.listPrice,discount,discountPrice FROM products join product_prices on products.id = product_prices.idProduct WHERE  isActive = 1 and isDelete = 0 and id IN (SELECT idProduct FROM order_details JOIN orders ON order_details.idOrder = orders.id WHERE orders.status = 'Hoàn thành'  AND YEAR(orders.createAt) = YEAR(CURRENT_DATE()) AND MONTH(orders.createAt) = MONTH(CURRENT_DATE()) GROUP BY idProduct ORDER BY SUM(quantity) DESC) LIMIT 4,4 ; ";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}


	public static List<Product> getOutstandingProduct() {
		Jdbi me = DBContext.me();
		String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice FROM products p join suppliers s on p.idSupplier = s.id join product_prices pp on pp.idProduct = p.id where p.isActive = '1' and s.isActive ='1' limit 3";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());

	}

	public static List<Product> getOutstandingProductShoes() {
		Jdbi me = DBContext.me();
		List<Product> list = new ArrayList<>();
		String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice from products p join product_prices pp \n" +
				"on p.id = pp.idProduct join producers pd \n" +
				"on p.idProducer = pd.id  join categories ct\n" +
				"on p.idCategorie = ct.id \n" +
				"where p.isActive =1  and isDelete = 0 and ct.id in (1,3,5,6)\n" +
				"limit 2";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}

	public static List<Product> getNewProductBoy() {
		Jdbi me = DBContext.me();
		List<Product> list = new ArrayList<>();
		String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice from products p join product_prices pp \n" +
				"on p.id = pp.idProduct join producers pd \n" +
				"on p.idProducer = pd.id  join categories ct\n" +
				"on p.idCategorie = ct.id \n" +
				"where p.isActive =1 and isDelete = 0 and ct.id in (1,2,5,7,9,13)\n" +
				"limit 4";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}


	public static List<Product> getNewProductGirl() {
		Jdbi me = DBContext.me();
		List<Product> list = new ArrayList<>();
		String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice from products p join product_prices pp \n" +
				"on p.id = pp.idProduct join producers pd \n" +
				"on p.idProducer = pd.id  join categories ct\n" +
				"on p.idCategorie = ct.id \n" +
				"where p.isActive =1 and isDelete = 0 and ct.id in (3,4,6,8,11,12,13)\n" +
				"limit 4";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}
	public static List<Product> getNewProductAccessory() {
		Jdbi me = DBContext.me();
		List<Product> list = new ArrayList<>();

		String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice from products p join product_prices pp \n" +
				"on p.id = pp.idProduct join producers pd \n" +
				"on p.idProducer = pd.id  join categories ct\n" +
				"on p.idCategorie = ct.id \n" +
				"where p.isActive =1 and isDelete = 0 and ct.id in (14,15)\n" +
				"limit 4";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}
	public static List<Product> getSuperSellProduct() {
		Jdbi me = DBContext.me();
		List<Product> list = new ArrayList<>();

		String query = "SELECT p.id,p.nameProduct,pp.listPrice,pp.discount,pp.discountPrice from products p join product_prices pp on p.id = pp.idProduct join producers pd  on p.idProducer = pd.id  join categories ct\ton p.idCategorie = ct.id where p.isActive = 1 and p.isDelete = 0 AND pp.discount > 30 and pp.discount<70";
		return me.withHandle(handle -> handle.createQuery(query)
				.map((rs, ctx) -> new Product(rs.getInt("id"), rs.getString("nameProduct"),
						rs.getDouble("listPrice"), UtilDAO.findListImageByIdProduct(rs.getInt("id")),
						rs.getInt("discount"),rs.getDouble("discountPrice")))
				.list());
	}


	public static void main(String[] args) {
		System.out.println(getSuperSellProduct());
//		System.out.println(getSellProductTwo());

	}
}