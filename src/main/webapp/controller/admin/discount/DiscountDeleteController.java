package controller.admin.discount;

import com.google.gson.JsonObject;
import context.DB;
import dao.AuthDAO.SecurityDAO;
import dao.admin.BillAdminDAO;
import dao.admin.DiscountDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import bean.Log;
import entity.Account;

@WebServlet("/admin-discount/delete")
public class DiscountDeleteController extends HttpServlet {
    String namelog = "Remove";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("admin");
        if (account==null){
            RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
            return;
        }
        if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-discount"), account.getAccountName(), "remove")) {
            String id = request.getParameter("id");
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.WARNING, ipAddress, -1, this.namelog, "", 0);
            boolean isSuc = true;
            isSuc = DiscountDAO.deleteDiscount(id);
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", isSuc);
            log.setSrc(namelog + " REMOVE");
            log.setContent("DELETE DISCOUT SUCCESS BY USER: " + account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
            response.getWriter().println(jsonObject);
        } else {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", false);
            response.getWriter().println(jsonObject);
        }
    }

}
