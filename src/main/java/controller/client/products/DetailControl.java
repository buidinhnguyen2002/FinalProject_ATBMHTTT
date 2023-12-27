package controller.client.products;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.OrderDAO;
import dao.client.ProductDAO;
import dao.client.UtilDAO;
import entity.*;

@WebServlet("/DetailControl")
public class DetailControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("pid");

        try {
            Product p = UtilDAO.findProductById(Integer.parseInt(id));
            String pid = request.getParameter("pid");
            List<Comment> listcmt = ProductDAO.displayfiveproduct(p.getId(), null, true);
            int num = ProductDAO.numberofcomment();
            request.setAttribute("Checknumber",num);
            request.setAttribute("list", listcmt);
            response.getWriter().println(listcmt);
            request.setAttribute("detail", p);
            double averageRating = UtilDAO.getAverageRatingByIdProduct(id);
            int ratingCount = UtilDAO.getRatingCountByIdProduct(id);
            if (ratingCount == 0) {
                request.setAttribute("averageRating", 0);
                request.setAttribute("ratingCount", ratingCount);
            } else {
                request.setAttribute("averageRating", averageRating);
                request.setAttribute("ratingCount", ratingCount);
            }

            Account account = (Account) request.getSession().getAttribute("acc");
            boolean isSucPay = false;
            if (account != null) {
                List<Order> listOrders = OrderDAO.getListOrderByAcountId(String.valueOf(account.getId()));
                for (int i = 0; i < listOrders.size(); i++) {
                    List<OrderDetail> listProducts = OrderDAO.getOrderDetailByBid(String.valueOf(listOrders.get(i).getId()));
                    for (OrderDetail orderDetail : listProducts) {
                        if (pid.equalsIgnoreCase(String.valueOf(orderDetail.getIdProduct()))) {
                            isSucPay = true;
                            break;
                        }
                    }
                }
                String rate = UtilDAO.RatesByIdProductAndIdAccount(String.valueOf(account.getId()), id);
                request.setAttribute("rate", rate);
                request.setAttribute("isSucPay", isSucPay);
            }
            request.getRequestDispatcher("/client/Detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
