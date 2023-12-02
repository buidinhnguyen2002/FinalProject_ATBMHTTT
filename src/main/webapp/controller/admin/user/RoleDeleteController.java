package controller.admin.user;

import com.google.gson.JsonObject;
import context.DB;
import dao.AuthDAO.SecurityDAO;
import dao.admin.AccountDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import bean.Log;
import entity.Account;

@WebServlet("/admin-user/role-delete")
public class RoleDeleteController extends HttpServlet {
    String namelog = "Delete-role";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("admin");
        if (account==null){
            RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
            return;
        }
        if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-user"), account.getAccountName(), "remove")) {
            String idRole = request.getParameter("idRole");
            boolean isSuc = false;
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.DANGER, ipAddress, -1, this.namelog, "", 0);
            isSuc = AccountDAO.removeRole(idRole);
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", isSuc);
            log.setSrc(namelog + " DELETE ");
            log.setContent("DELETE ROLE SUCCESS BY USER: " + account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
            response.getWriter().println(jsonObject);
        } else {
            boolean isSuc = false;
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", isSuc);
            response.getWriter().println(jsonObject);
        }
    }
}
