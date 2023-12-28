package controller.admin.bill;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.admin.BillAdminDAO;
import dao.client.UtilDAO;
import entity.Account;
import entity.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin-bill/ShowOrderDetail")
public class ShowOrderDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String id = request.getParameter("id");
            Order order = BillAdminDAO.getOrderById(id);
            Account account = UtilDAO.findAccountById(order.getIdAccount());
            Gson gson = new Gson();
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("account", gson.toJson(account));
            jsonObject.addProperty("order", gson.toJson(order));
            response.getWriter().println(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
