package dao.admin;

import java.util.*;
import java.util.stream.Collectors;

import context.DBContext;
import dao.client.AuthDAO;
import entity.Account;
import entity.Permission;
import entity.Resource;
import entity.Role;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;
import util.EnCode;

public class AccountDAO {
    public static List<Account> getListAccount() {
        Jdbi me = DBContext.me();
        String query = "SELECT DISTINCT a.id, accountName, password, fullName, address, email, phone,isDelete,isActive, " +
                "GROUP_CONCAT(r.id) AS roleIds, GROUP_CONCAT(r.name) AS roleNames " +
                "FROM accounts a " +
                "JOIN account_roles ar ON a.id = ar.idAccount " +
                "JOIN roles r ON ar.idRole = r.id " +
                "WHERE isDelete = 0 AND r.name != 'admin' " +
                "GROUP BY a.id";

        return me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> {
                Account account = new Account();
                account.setId(rs.getInt("id"));
                account.setAccountName(rs.getString("accountName"));
                account.setPassword(rs.getString("password"));
                account.setFullName(rs.getString("fullName"));
                account.setAddress(rs.getString("address"));
                account.setEmail(rs.getString("email"));
                account.setPhone(rs.getString("phone"));
                account.setActive(rs.getBoolean("isActive"));
                account.setDelete(rs.getBoolean("isDelete"));
                String roleIds = rs.getString("roleIds");
                String roleNames = rs.getString("roleNames");

                // Chuyển chuỗi roleIds thành danh sách các ID vai trò
                List<Integer> roleIdList = Arrays.stream(roleIds.split(","))
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());

                // Chuyển chuỗi roleNames thành danh sách tên vai trò
                List<String> roleNameList = Arrays.asList(roleNames.split(","));

                // Tạo danh sách các đối tượng Role từ roleIdList và roleNameList
                List<Role> roleList = new ArrayList<>();
                for (int i = 0; i < roleIdList.size(); i++) {
                    long roleId = roleIdList.get(i);
                    String roleName = roleNameList.get(i);
                    Role role = new Role(roleId, roleName);
                    roleList.add(role);
                }

                // Gán danh sách vai trò vào trường roles của tài khoản
                account.setRoles(new HashSet<>(roleList));
                return account;
            }).list();
        });
    }
    public static List<String> getListIdByIdRole(String idRole){
            Jdbi me = DBContext.me();
            String query = "select a.id from accounts a join account_roles ar on ar.idAccount = a.id where ar.idRole = ?";
            return me.withHandle(handle -> handle.createQuery(query).bind(0,idRole).mapTo(String.class).list());
    }
    public static List<Account> getListNewAccount() {
        Jdbi me = DBContext.me();
        String query = "SELECT DISTINCT a.id, accountName, password, fullName, address, email,isActive, phone, " +
                "GROUP_CONCAT(r.id) AS roleIds, GROUP_CONCAT(r.name) AS roleNames " +
                "FROM accounts a " +
                "JOIN account_roles ar ON a.id = ar.idAccount " +
                "JOIN roles r ON ar.idRole = r.id " +
                "WHERE isDelete = 0 AND r.name != 'admin' " +
                "GROUP BY a.id order by a.id desc limit 4";

        return me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> {
                Account account = new Account();
                account.setId(rs.getInt("id"));
                account.setAccountName(rs.getString("accountName"));
                account.setPassword(rs.getString("password"));
                account.setFullName(rs.getString("fullName"));
                account.setAddress(rs.getString("address"));
                account.setEmail(rs.getString("email"));
                account.setActive(rs.getBoolean("isActive"));
                account.setPhone(rs.getString("phone"));
                String roleIds = rs.getString("roleIds");
                String roleNames = rs.getString("roleNames");

                // Chuyển chuỗi roleIds thành danh sách các ID vai trò
                List<Integer> roleIdList = Arrays.stream(roleIds.split(","))
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());

                // Chuyển chuỗi roleNames thành danh sách tên vai trò
                List<String> roleNameList = Arrays.asList(roleNames.split(","));

                // Tạo danh sách các đối tượng Role từ roleIdList và roleNameList
                List<Role> roleList = new ArrayList<>();
                for (int i = 0; i < roleIdList.size(); i++) {
                    long roleId = roleIdList.get(i);
                    String roleName = roleNameList.get(i);
                    Role role = new Role(roleId, roleName);
                    roleList.add(role);
                }

                // Gán danh sách vai trò vào trường roles của tài khoản
                account.setRoles(new HashSet<>(roleList));

                return account;
            }).list();
        });
    }

    public static Account findAccountById(int idAccount) {
        Jdbi me = DBContext.me();
        String queryLogin = "select id,accountName,password,fullName,address,email,phone,idRoleMember from accounts where id=?";
        Account account;
        account = me.withHandle(handle -> {
            return handle.createQuery(queryLogin)
                    .bind(0, idAccount).mapToBean(Account.class).findFirst().orElse(null);
        });
        account.setRoles(AuthDAO.getRoles(account.getId()));
        account.setResources(AuthDAO.getResources(account.getId()));
//        account.setPermissions(AuthDAO.getPermissions(account.getId()));
        return account;
    }


    public static boolean removeAccount(String uid) {
        String query = "update accounts set isDelete = 1,isActive =0 where id = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, uid).execute()==1);
    }

    public static int removeAccountPermission(String pid) {
        String query = "delete from permissions where id = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, pid).execute());
    }
    public static boolean removeRole(String idRole) {
        String query = "delete from roles where id = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idRole).execute()==1);
    }

    public static List<Role> getAllRoles() {
        String query = "select id,name from roles where id not in(4)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery(query).mapToBean(Role.class).list());
    }

    public static List<Resource> getResourceForRoles(String idRole) {
        String query = "select id,name,url,description from resources r join role_resource rr on r.id = rr.idResource where idRole =?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idRole).mapToBean(Resource.class).list());
    }
    public static List<Role> getResourceForRoles() {
        String query = "select id,name from roles";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery(query).mapToBean(Role.class).list());
    }
    public static List<Resource> getAllResource() {
        String query = "select id,name,url,description from resources where id !=10 ";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery(query).mapToBean(Resource.class).list());
    }

    public static List<Permission> getPermissionForRole(String idRole) {
        String query = "SELECT r.id,idRole,idResource,name,r.url,r.description,action FROM permissions p join resources r on r.id = p.idResource where idResource =?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createQuery(query).bind(0, idRole).map((rs, ctx) -> new Permission(rs.getLong("id"),rs.getInt("idRole"), new Resource(rs.getLong("idResource"), rs.getString("name"), rs.getString("url"), rs.getString("description")), rs.getString("action"))).list());
    }
    public static int updateAccount(Account a,String activeStatus) {
        String newpass = EnCode.toSHA1(a.getPassword());
        String query = "update accounts set accountName = ?,fullName=?,email=?,phone=?,password=?,address=?,isActive=? where id = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, a.getAccountName()).bind(1, a.getFullName()).bind(2, a.getEmail()).bind(3, a.getPhone()).bind(4, newpass).bind(5, a.getAddress()).bind(8,activeStatus).bind(7, a.getId()).execute());
    }

    public static int updateRoleAccount(String idAccount, String[] selectedRoles) {
        Jdbi jdbi = DBContext.me();
        // Xóa các vai trò hiện có của tài khoản trong bảng account_roles
        jdbi.useHandle(handle -> {
            handle.createUpdate("DELETE FROM account_roles WHERE idAccount = :idAccount")
                    .bind("idAccount", idAccount)
                    .execute();
        });

        // Thêm mới các vai trò đã chọn vào bảng account_roles
        int rowsAffected = jdbi.withHandle(handle -> {
            PreparedBatch batch = handle.prepareBatch("INSERT INTO account_roles (idRole, idAccount) VALUES (:idRole, :idAccount)");
            boolean role1Exists = false;

            for (String role : selectedRoles) {
                if (role.equals("1")) {
                    role1Exists = true;
                }
                batch.bind("idRole", role)
                        .bind("idAccount", idAccount)
                        .add();
            }

            // Kiểm tra nếu "1" chưa tồn tại trong selectedRoles, thì thêm vào câu truy vấn
            if (!role1Exists) {
                batch.bind("idRole", "1")
                        .bind("idAccount", idAccount)
                        .add();
            }

            return batch.execute().length;
        });

        return rowsAffected;
    }

    public static int updateAccountNoPass(Account a,String activeStatus) {
        String query = "update accounts set accountName = ?,fullName=?,email=?,phone=?,address=?,isActive=? where id = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, a.getAccountName()).bind(1, a.getFullName()).bind(2, a.getEmail()).bind(3, a.getPhone()).bind(4, a.getAddress()).bind(5,activeStatus).bind(6, a.getId()).execute());
    }
    public static int getTotalAccount() {
        String query = "SELECT count(id) FROM accounts where isDelete = 0";
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

    public static int removePermission(String idResource,String idRole, String action) {
        String query = "DELETE FROM permissions where idResource=? and action= ? and idRole = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idResource).bind(1, action).bind(2,idRole).execute());
    }
    public static int removePermission(String idResource,String idRole) {
        String query = "DELETE FROM permissions where idResource=? and idRole = ?";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idResource).bind(1,idRole).execute());
    }
    public static boolean removeRoleRessource(String idRole, String idResource) {
        String query = "DELETE FROM role_resource where idRole=? and idResource=?";
        Jdbi me = DBContext.me();
        removePermission(idResource,idRole);
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idRole).bind(1, idResource).execute()==1);
    }
    public static int insertPermission(String idResource,String idRole, String action) {
        String query = "insert into permissions (idResource,idRole,action) values(?,?,?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idResource).bind(1, idRole).bind(2,action).execute());
    }
    public static int insertRoleRessource(String idRole, String idResource) {
        String query = "insert into role_resource (idRole,idResource) values(?,?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, idRole).bind(1, idResource).execute());
    }
    public static int insertRole(String name) {
        String query = "insert into roles (name) values(?)";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, name).execute());
    }

    public static void main(String[] args) {
        System.out.println(getListAccount());
    }
}
