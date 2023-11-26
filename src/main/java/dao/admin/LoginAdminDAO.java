package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import context.DBContext;
import dao.client.AuthDAO;
import entity.Account;
import org.jdbi.v3.core.Jdbi;
import util.EnCode;

public class LoginAdminDAO {
    public static Account loginAdmin(String username, String pass) {
        Jdbi me = DBContext.me();
        String passEncode = EnCode.toSHA1(pass);
        String queryLogin = "select id,accountName,password,fullName,address,email,phone,idRoleMember from accounts where accountName = ? and password  = ?";
        Account account;
        account = me.withHandle(handle -> {
            return handle.createQuery(queryLogin)
                    .bind(0, username).bind(1, passEncode).mapToBean(Account.class).findFirst().orElse(null);
        });
        if (account != null) {
            account.setRoles(AuthDAO.getRoles(account.getId()));
            account.setResources(AuthDAO.getResources(account.getId()));
            account.setPermissions(AuthDAO.getPermissions(account.getId()));
        }
        return account;
    }

    public static void main(String[] args) {
        System.out.println(loginAdmin("locancuc", "L0374781483Lll@"));
    }

}
