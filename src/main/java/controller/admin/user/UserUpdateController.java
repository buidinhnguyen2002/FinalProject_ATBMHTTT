package controller.admin.user;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import context.DB;
import controller.admin.webSocket.UpdateAccountEndPoint;
import dao.admin.AccountDAO;
import dao.client.AuthDAO;
import dao.client.UtilDAO;
import entity.Account;
import entity.Role;
import bean.Log;

/**
 * Servlet implementation class UserUpdateController
 */
@WebServlet("/admin-user/UserUpdate")
public class UserUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String namelog ="Update";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserUpdateController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setContentType("text/html;charset=UTF-8");
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.WARNING,ipAddress,-1,this.namelog,"",0);
        try {
            String user_id = request.getParameter("uid");
            Account account = UtilDAO.findAccountById(Integer.parseInt(user_id));
            Set<Role> roles = AuthDAO.getRoles(Integer.parseInt(user_id));
            List<Role> allRoles = AccountDAO.getAllRoles();
            request.setAttribute("account", account);
            Gson gson = new Gson();
            JsonObject jsonObject = new JsonObject();
            jsonObject.add("roles", gson.toJsonTree(roles));
            jsonObject.add("allRoles", gson.toJsonTree(allRoles));
            jsonObject.add("account", gson.toJsonTree(account));
            log.setSrc(namelog + " UPDATE");
            log.setContent("UPDATE USER SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
            response.getWriter().println(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
            String user_id = request.getParameter("uid");
            String user_name = request.getParameter("user-name");
            String full_name = request.getParameter("full-name");
            String user_email = request.getParameter("user-email");
            String user_phone = request.getParameter("user-phone");
            String user_password = request.getParameter("user-password");
            String user_address = request.getParameter("user-address");
            String activeStatus = request.getParameter("activeStatus");
            String[] roles = request.getParameterValues("role");
            Account a = new Account(Integer.parseInt(user_id), user_name, user_password, full_name, user_address, user_email,
                    user_phone);
            Account account = AccountDAO.findAccountById(Integer.parseInt(user_id));
            if (a.getPassword().equals(account.getPassword()) || a.getPassword() == null) {
                AccountDAO.updateAccountNoPass(a,activeStatus);
                AccountDAO.updateRoleAccount(user_id,roles);
            } else {
                AccountDAO.updateAccount(a,activeStatus);
                AccountDAO.updateRoleAccount(user_id,roles);
            }
            Gson gson = new Gson();
            JsonArray jsonArray = new JsonArray();
            jsonArray.add(gson.toJson(AccountDAO.getListAccount()));
            JsonObject jsonObject = new JsonObject();
            jsonObject.add("listAccount", jsonArray);
            Account acc = (Account) request.getSession().getAttribute("admin");
            boolean isAdmin = false;
            for (Role role : acc.getRoles()
            ) {
                if (role.getName().equals("admin")) {
                    isAdmin = true;
                    break;
                }

            }
            jsonObject.addProperty("isAdmin", isAdmin);
            UpdateAccountEndPoint.notifyUserUpdate(Integer.parseInt(user_id), "update");
            response.getWriter().println(gson.toJson(jsonObject));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
