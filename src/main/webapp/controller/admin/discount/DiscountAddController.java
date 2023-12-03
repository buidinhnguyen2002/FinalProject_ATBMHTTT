package controller.admin.discount;

import bean.Log;
import com.google.gson.JsonObject;
import context.DB;
import dao.AuthDAO.SecurityDAO;
import dao.admin.DiscountDAO;
import entity.Account;
import entity.Discount;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin-discount/add")
public class DiscountAddController extends HttpServlet {
    String namelog = "Add-bill";

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
        if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-discount"), account.getAccountName(), "write")) {
            boolean isSuc = false;
            String nameDiscount = request.getParameter("nameDiscount");
            String description = request.getParameter("description");
            String codeDiscount = request.getParameter("codeDiscount");
            String percentage = request.getParameter("percentage");
            String quantity = request.getParameter("quantity");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String status = request.getParameter("status");
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.WARNING, ipAddress, -1, this.namelog, "", 0);
            Discount discount = new Discount(0, nameDiscount, description, codeDiscount, Double.parseDouble(percentage), Integer.parseInt(quantity), startTime, endTime, status);
            isSuc = DiscountDAO.insertDiscount(discount);
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", isSuc);
            log.setSrc(namelog + " ADD ");
            log.setContent("ADD BILL SUCCESS BY USER: " + account.getAccountName());
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
