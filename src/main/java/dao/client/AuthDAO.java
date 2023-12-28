package dao.client;

import context.DBContext;
import entity.Account;
import entity.Permission;
import entity.Resource;
import entity.Role;
import org.jdbi.v3.core.Jdbi;
import util.EnCode;

import java.util.Set;
import java.util.stream.Collectors;

public class AuthDAO {
    public AuthDAO() {
        super();
    }

    public static Set<Role> getRoles(int idAccount) {
        Jdbi me = DBContext.me();
        // Lấy ra danh sách role của account
        Set<Role> roles;
        return roles = me.withHandle(handle -> {
            return handle.createQuery("select roles.* from roles join account_roles on roles.id = account_roles.idRole where account_roles.idAccount = ?")
                    .bind(0, idAccount)
                    .mapToBean(Role.class)
                    .collect(Collectors.toSet());
        });
    }

    public static Set<Resource> getResources(int idAccount) {
        Jdbi me = DBContext.me();
        // Lấy ra danh sách role của account
        Set<Resource> resources;
        return resources = me.withHandle(handle -> {
            return handle.createQuery("select DISTINCT resources.* from resources join permissions on resources.id = permissions.idResource join role_resource rr on rr.idResource =resources.id  where rr.idRole in (select roles.id from roles join account_roles on roles.id = account_roles.idRole where account_roles.idAccount = ?)")
                    .bind(0, idAccount)
                    .mapToBean(Resource.class)
                    .collect(Collectors.toSet());
        });
    }

    public static Set<Permission> getPermissions(int idAccount) {
        Jdbi me = DBContext.me();
        Set<Permission> permissions;
        return permissions = me.withHandle(handle -> {
            return handle.createQuery("select DISTINCT  p.id,p.idRole,r.id,r.name,r.url,p.action from resources r join permissions p on r.id = p.idResource join role_resource rr on rr.idResource =r.id  where p.idRole in (select roles.id from roles join account_roles on roles.id = account_roles.idRole where account_roles.idAccount = ?)")
                    .bind(0, idAccount)
                    .map((rs, ctx) -> new Permission(rs.getLong("id"),rs.getInt("idRole"), new Resource(rs.getLong("id"), rs.getString("name"), rs.getString("url")), rs.getString("action")))
                    .collect(Collectors.toSet());
        });
    }

    public static Account login(String username, String pass,String currentPassword) {
        Jdbi me = DBContext.me();
        String passEncode = EnCode.toSHA1(pass);
        String encurrentPassword = EnCode.toSHA1(currentPassword);
        String queryLogin = "select id,accountName,password,fullName,address,email,phone,idRoleMember from accounts where accountName = ? and (password  = ? or (currentPassword = ? and  TIMESTAMPDIFF(MINUTE, timestamp, NOW()) <= 5)) and isDelete = 0 and isActive =1";
        Account account;
        account = me.withHandle(handle -> {
            return handle.createQuery(queryLogin)
                    .bind(0, username).bind(1, passEncode).bind(2,encurrentPassword).mapToBean(Account.class).findFirst().orElse(null);
        });
        if (account != null) {
            account.setRoles(getRoles(account.getId()));
            account.setResources(getResources(account.getId()));
            account.setPermissions(getPermissions(account.getId()));
        }
        return account;
    }
    public static Account findAccountIdAddSession(String id) {
        Jdbi me = DBContext.me();
        String queryLogin = "select id,accountName,password,fullName,address,email,phone,idRoleMember from accounts where id = ? and isDelete = 0 and isActive =1";
        Account account;
        account = me.withHandle(handle -> {
            return handle.createQuery(queryLogin)
                    .bind(0, id).mapToBean(Account.class).findFirst().orElse(null);
        });
        if (account != null) {
            account.setRoles(getRoles(account.getId()));
            account.setResources(getResources(account.getId()));
            account.setPermissions(getPermissions(account.getId()));
        }
        return account;
    }


    public static Account checkAccountExistByEmail(String email) { // ton tai la true
        String queryLogin = "select id,accountName,password,fullName,address,email,phone,idRoleMember from accounts where email =?";
        Jdbi me = DBContext.me();

        return me.withHandle(handle -> {
            return handle.createQuery(queryLogin)
                    .bind(0, email).mapToBean(Account.class).findFirst().orElse(null);
        });
    }

    public static boolean checkAccountExist(String userName) { // ton tai la true
        Jdbi me = DBContext.me();
        try {
            return me.withHandle(handle -> handle
                    .createQuery("SELECT EXISTS(SELECT id FROM accounts WHERE accountName = ? and isDelete = 0 and isActive =1 )")
                    .bind(0, userName).mapTo(Boolean.class).one());
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    public static int loginFail(String username) {
        Jdbi me = DBContext.me();
        try {
            int num = me.withHandle(handle -> handle.createQuery(
                            "SELECT numberloginfail FROM accounts WHERE accountName = ?")
                    .bind(0, username).mapTo(int.class).one());
            if (num >= 5) {
                return 5;
            }
            me.withHandle(handle -> handle.createUpdate(
                            "UPDATE accounts SET numberloginfail = ? WHERE accountName = ?")
                    .bind(0, num + 1).bind(1, username).execute());
            return num + 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void resetlogin(String username) {
        Jdbi me = DBContext.me();
        try {
            me.withHandle(handle -> handle.createQuery(
                            "SELECT numberloginfail FROM accounts WHERE accountName = ?")
                    .bind(0, username).mapTo(int.class).one());
            me.withHandle(handle -> handle.createUpdate(
                            "UPDATE accounts SET numberloginfail = ? WHERE accountName = ?")
                    .bind(0, 0).bind(1, username).execute());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static boolean checkEmailExist(String email) { // ton tai la true
        Jdbi me = DBContext.me();
        try {
            return me.withHandle(handle -> handle
                    .createQuery("SELECT EXISTS(SELECT id FROM accounts WHERE  Email = ?)")
                    .bind(0, email).mapTo(Boolean.class).one());
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

//    public static boolean signUp(String userName, String password, String name, String email, String address, String NumberPhone) {
//        String signInQuery = "INSERT INTO accounts (accountName, password, fullName, email, address, phone) VALUES (?, ?, ?, ?, ?, ?);";
//        String rollAccountQuery = "INSERT INTO account_roles (idRole,idAccount) VALUES (1,?);";
//        String passEncode = EnCode.toSHA1(password);
//        Jdbi me = DBContext.me();
//        me.withHandle(handle -> {
//            try {
//                handle.begin();
//                long accountId = handle.createUpdate(signInQuery)
//                        .bind(0, userName)
//                        .bind(1, passEncode)
//                        .bind(2, name)
//                        .bind(3, email)
//                        .bind(4, address)
//                        .bind(5, NumberPhone)
//                        .executeAndReturnGeneratedKeys()
//                        .mapTo(Long.class)
//                        .one();
//
//                handle.createUpdate(rollAccountQuery)
//                        .bind(0, accountId)
//                        .execute();
//
//                handle.commit();
//                return true;
//            } catch (Exception e) {
//                handle.rollback();
//                e.printStackTrace();
//            }
//            return false;
//        });
//        return false;
//    }

    public static boolean signUp(String userName, String password, String name, String email, String address, String NumberPhone, String publicKey) {
        String signInQuery = "INSERT INTO accounts (accountName, password, fullName, email, address, phone) VALUES (?, ?, ?, ?, ?, ?);";
        String rollAccountQuery = "INSERT INTO account_roles (idRole,idAccount) VALUES (1,?);";
        String keySignatureQuery = "INSERT INTO public_key_signature (idAccount, publicKey) VALUES (?,?);";
        String passEncode = EnCode.toSHA1(password);
        Jdbi me = DBContext.me();
        me.withHandle(handle -> {
            try {
                handle.begin();
                long accountId = handle.createUpdate(signInQuery)
                        .bind(0, userName)
                        .bind(1, passEncode)
                        .bind(2, name)
                        .bind(3, email)
                        .bind(4, address)
                        .bind(5, NumberPhone)
                        .executeAndReturnGeneratedKeys()
                        .mapTo(Long.class)
                        .one();

                handle.createUpdate(rollAccountQuery)
                        .bind(0, accountId)
                        .execute();
                handle.createUpdate(keySignatureQuery).bind(0, accountId).bind(1, publicKey).execute();
                handle.commit();
                return true;
            } catch (Exception e) {
                handle.rollback();
                e.printStackTrace();
            }
            return false;
        });
        return false;
    }


    public static int editAccountInfo(String fullName, String address, String phone, String id) {
        String query = "update accounts set fullName = ? ,address = ?,phone = ?  where id = ?;";
        Jdbi me = DBContext.me();
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, fullName).bind(1, address).bind(2, phone).bind(3, id).execute());
    }

    public static Account checkAccountOldPassword(String uid, String pass,String currentPassword) {
        pass = EnCode.toSHA1(pass);
        currentPassword = EnCode.toSHA1(currentPassword);
        String query = "select id,accountName,password,fullName,address,email,phone from accounts where id = ? and (password  = ? or (currentPassword = ? and  TIMESTAMPDIFF(MINUTE, timestamp, NOW()) <= 5)) and isDelete = 0 and isActive =1";
        Jdbi me = DBContext.me();
        String finalPass = pass;
        String finalCurrentPassword = currentPassword;
        return me.withHandle(handle -> handle.createQuery(query).bind(0, uid).bind(1, finalPass).bind(2, finalCurrentPassword).mapToBean(Account.class).findFirst().orElse(null));
    }

    public static int editAccountPassword(String uid, String newpass) {
        String query = "update accounts set password = ? where id = ?;";
        newpass = EnCode.toSHA1(newpass);
        Jdbi me = DBContext.me();
        String finalNewpass = newpass;
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, finalNewpass).bind(1, uid).execute());
    }
	public static int updateAccountCurrentPassword(String uid, String currentPassword) {
		String query = "update accounts set currentPassword = ?, timestamp=NOW() where id = ?;";
		currentPassword = EnCode.toSHA1(currentPassword);
		Jdbi me = DBContext.me();
		String finalCurrentPassword = currentPassword;
		return me.withHandle(handle -> handle.createUpdate(query).bind(0, finalCurrentPassword).bind(1, uid).execute());
	}

    public static void signUpGoogle(String id, String name, String email, String picture) {
        String ggCus = "INSERT INTO accounts (accountName, password, fullName, email, image, type, idOther, isDelete, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        Jdbi me = DBContext.me();
        me.useHandle(handle -> {
            try {
                handle.begin();
                long accountId = handle.createUpdate(ggCus)
                        .bind(0, EnCode.toSHA1(EnCode.toSHA1(name)))
                        .bind(1, EnCode.toSHA1(EnCode.toSHA1(email)))
                        .bind(2, name)
                        .bind(3, email)
                        .bind(4, picture)
                        .bind(5, 3)
                        .bind(6, id)
                        .bind(7, 0)
                        .bind(8, 1)
                        .executeAndReturnGeneratedKeys()
                        .mapTo(Long.class)
                        .one();

                String rollAccountQuery = "INSERT INTO account_roles (idRole, idAccount) VALUES (1, ?);";
                handle.createUpdate(rollAccountQuery)
                        .bind(0, accountId)
                        .execute();

                handle.commit();
            } catch (Exception e) {
                handle.rollback();
                e.printStackTrace();
            }
        });
    }


    private static Account getAccount(String id, String loginBy) {
        Jdbi me = DBContext.me();
        return (Account) me.withHandle(handle -> {
            return handle.createQuery(loginBy).bind(0, id).mapToBean(Account.class).findFirst().orElse(null);
        });
    }

    public static Account loginGG(String id) {
        String loginGGQuery = "select id, accountName, password, fullName, email, image, type, idOther from accounts where idOther= ? and type = 3";
        Account account;
        account = getAccount(id, loginGGQuery);
        if (account != null) {
            account.setRoles(getRoles(account.getId()));
            account.setResources(getResources(account.getId()));
            account.setPermissions(getPermissions(account.getId()));
        }
        return account;
    }

    public static void signUpFacebook(String id, String name, String email, String pic) {
        String fbCus = "INSERT INTO accounts (accountName, password, fullName, email, image, type, idOther) VALUES (?, ?, ?, ?, ?, ?, ?);";
        Jdbi me = DBContext.me();
        me.useHandle(handle -> {
            try {
                handle.begin();
                long accountId = handle.createUpdate(fbCus)
                        .bind(0, EnCode.toSHA1(EnCode.toSHA1(name)))
                        .bind(1, EnCode.toSHA1(EnCode.toSHA1(email)))
                        .bind(2, name)
                        .bind(3, email)
                        .bind(4, pic)
                        .bind(5, 2)
                        .bind(6, id)
                        .executeAndReturnGeneratedKeys()
                        .mapTo(Long.class)
                        .one();

                String rollAccountQuery = "INSERT INTO account_roles (idRole, idAccount) VALUES (1, ?);";
                handle.createUpdate(rollAccountQuery)
                        .bind(0, accountId)
                        .execute();

                handle.commit();
            } catch (Exception e) {
                handle.rollback();
                e.printStackTrace();
            }
        });
    }


    public static Account loginFacebook(String id) {
        String loginFBQuery = "select id, accountName, password, fullName, email, image, type, idOther from accounts where idOther= ? and type = 2";
        Account account;
        account = getAccount(id, loginFBQuery);
        if (account != null) {
            account.setRoles(getRoles(account.getId()));
            account.setResources(getResources(account.getId()));
            account.setPermissions(getPermissions(account.getId()));
        }
        return account;
    }

    //update Expired key
    public static boolean updateExpiredPublicKey(int id) {
        Jdbi me = DBContext.me();
        String query = "update public_key_signature set expired = now() where idAccount = ? ORDER BY createAt DESC LIMIT 1";
        return me.withHandle(handle -> handle.createUpdate(query).bind(0, id).execute() == 1);
    }

    //insert new key
    public static boolean insertNewPublicKey(int id, String publicKey) {
        String insert = "INSERT INTO public_key_signature (idAccount, publicKey) VALUES (?, ?)";
        Jdbi me = DBContext.me();

        me.useHandle(handle -> {
            try {
                handle.begin();
                handle.createUpdate(insert)
                        .bind(0, id)
                        .bind(1, publicKey)
                        .execute();
                handle.commit();
            } catch (Exception e) {
                handle.rollback();
                e.printStackTrace();
            }
        });
        return false;
    }

    //check key which is same
    public static boolean selectSamePublicKey(String publicKey) {
        Jdbi jdbi  = DBContext.me();
        String query = "select Count(publicKey) from public_key_signature where publicKey = ?";
        Integer count = jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, publicKey)
                        .mapTo(Integer.class) // Map kết quả thành Integer
                        .one() // Đảm bảo kết quả chỉ có một hàng
        );
        // Trả về true nếu count > 0, tức là publicKey đã tồn tại; ngược lại trả về false
        return count != null && count > 0;
    }

    public static void main(String[] args) {
//        System.out.println(login("leminhlong@gmail.com","L0374781483Lll@","null"));
        System.out.println(updateExpiredPublicKey(35));
    }

}