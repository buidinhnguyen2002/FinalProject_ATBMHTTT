package dao.AuthDAO;

import context.DBContext;
import dao.client.UtilDAO;
import entity.*;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SecurityDAO {
    public static boolean hasPermission(String idResource, String accountName, String action) {
        String query = "SELECT DISTINCT p.id\n" +
                "FROM accounts a\n" +
                "JOIN account_roles ar ON a.id = ar.idAccount\n" +
                "JOIN role_resource res ON ar.idRole = res.idRole\n" +
                "JOIN resources rs ON res.idResource = rs.id\n" +
                "JOIN permissions p ON p.idRole = ar.idRole\n" +
                "WHERE a.accountName = ?\n" +
                "AND p.action = ?\n" +
                "and p.idResource = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, accountName);
            ps.setString(2, action);
            ps.setString(3, idResource);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static String getIdResource(String url) {
        String query = "select id from resources where url = ?";
        try (Handle handle = DBContext.me().open()) {
            return handle.createQuery(query)
                    .bind(0, url).mapTo(String.class)
                    .findOne()
                    .orElse("0");
        } catch (Exception e) {
            return "0";
        }

    }

    public static void main(String[] args) {
//        System.out.println(hasPermission("/admin-discount", "locancuc", "remove"));
        System.out.println(getIdResource("/admin-discount"));
    }
}

