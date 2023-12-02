package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import context.DBContext;

public class AdminDAO {
	public static String getSumBill() {
		String query = "select COUNT(*) from Bill ";
		try {
			Connection conn = DBContext.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {

		}
		return null;
	}

	public static String getSumPrice() {
		String query = "select SUM(priceTotal) from Bill";
		try {
			Connection conn = DBContext.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
