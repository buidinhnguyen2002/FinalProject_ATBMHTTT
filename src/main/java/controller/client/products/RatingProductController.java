package controller.client.products;

import com.google.gson.JsonObject;
import dao.admin.BillAdminDAO;
import dao.client.OrderDAO;
import dao.client.UtilDAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import entity.Rate;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/rating-product")
public class RatingProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String rating = request.getParameter("rating");
            String idProduct = request.getParameter("idProduct");
            Account account = (Account) request.getSession().getAttribute("acc");
            boolean isSuc = false;
            boolean isSucPay = false;
            if (account != null) {
                List<Order> listOrders = OrderDAO.getListOrderByAcountId(String.valueOf(account.getId()));
                for (int i = 0; i < listOrders.size(); i++) {
                    List<OrderDetail> listProducts = OrderDAO.getOrderDetailByBid(String.valueOf(listOrders.get(i).getId()));
                    for (OrderDetail orderDetail : listProducts) {
                        if (idProduct.equalsIgnoreCase(String.valueOf(orderDetail.getIdProduct()))) {
                            isSucPay = true;
                            break;
                        }
                    }
                }
                if (isSucPay) {
                    if (UtilDAO.checkRateEq(String.valueOf(account.getId()), idProduct)) {
                        isSuc = UtilDAO.updateRates(new Rate(0, account.getId(), Integer.parseInt(idProduct), Integer.parseInt(rating), 1));
                    } else {
                        isSuc = UtilDAO.insertRates(new Rate(0, account.getId(), Integer.parseInt(idProduct), Integer.parseInt(rating), 1));
                    }
                }
            }
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isSuc", isSuc);
            jsonObject.addProperty("isSucPay", isSucPay);
            response.getWriter().println(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
