package controller.client.cart;

import com.google.gson.JsonObject;
import dao.admin.BillAdminDAO;
import dao.client.OrderDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/cart/DiscountControl")
public class DiscountControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reductionCode = request.getParameter("reductionCode");
        int isSuc = 0;
        isSuc = OrderDAO.checkDiscount(reductionCode);
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("isSuc", isSuc);
        response.getWriter().println(jsonObject);
    }
}
