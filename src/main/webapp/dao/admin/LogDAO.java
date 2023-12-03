package dao.admin;

import context.DBContext;
import entity.Account;
import entity.Log;
import entity.Order;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class LogDAO {
    public static List<Log> getListLog() {
        Jdbi me = DBContext.me();
        String query = "select id, level, ip, idAccount, src, content, createAt, status, updateAt from logs";
        return me.withHandle(handle -> handle.createQuery(query).map((rs, ctx) -> new Log(rs.getInt("id"),rs.getInt("level"),rs.getString("ip"),rs.getInt("idAccount"),rs.getString("src"),rs.getString("content"),rs.getTimestamp("createAt"))).list());
    }

    public static void main(String[] args) {
        System.out.println(getListLog());
    }
}
