package controller.admin.user;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
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
import dao.AuthDAO.SecurityDAO;
import dao.admin.AccountDAO;
import entity.Account;
import entity.Role;
import bean.Log;

@WebServlet("/admin-user/UserDelete")
public class UserDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String namelog = "Remove";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("admin");
        if (account==null){
            RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
            return;
        }
        if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-user"), account.getAccountName(), "remove")) {
            response.setContentType("text/html;charset=UTF-8");
            String uid = request.getParameter("uid");
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.WARNING, ipAddress, -1, this.namelog, "", 0);
            boolean isSuc = false;
            isSuc = AccountDAO.removeAccount(uid);
            Gson gson = new Gson();
            JsonArray jsonArray = new JsonArray();
            jsonArray.add(gson.toJson(AccountDAO.getListAccount()));
            JsonObject jsonObject = new JsonObject();
            jsonObject.add("listAccount", jsonArray);
            jsonObject.addProperty("isSuc", isSuc);
            boolean isAdmin = false;
            for (Role role : account.getRoles()
            ) {
                if (role.getName().equals("admin")) {
                    isAdmin = true;
                    break;
                }

            }
            log.setSrc(namelog + " REMOVE");
            log.setContent("DELETE USER SUCCESS BY USER: " + account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
            jsonObject.addProperty("isAdmin", isAdmin);
            UpdateAccountEndPoint.notifyUserUpdate(Integer.parseInt(uid), "remove");
            response.getWriter().println(gson.toJson(jsonObject));
        } else {
            boolean isSuc = false;
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", isSuc);
            response.getWriter().println(jsonObject);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }

}
