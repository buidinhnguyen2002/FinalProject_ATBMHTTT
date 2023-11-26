package controller.client.cart;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import dao.client.OrderDAO;
import entity.OrderDetail;

@WebServlet("/cart/MinusBillProductControl")
public class MinusBillProductControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String key = request.getParameter("key");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int quantity = 1;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Object obj = session.getAttribute("cart");
        if (obj != null) {
            Map<String, List<OrderDetail>> map = (Map<String, List<OrderDetail>>) obj;
            for (Map.Entry<String, List<OrderDetail>> entry : map.entrySet()) {
                List<OrderDetail> orderDetails = entry.getValue();
                for (OrderDetail o : orderDetails) {
                    if (String.valueOf(o.getProduct().getId()).equalsIgnoreCase(key)) {
                        if (o.getProductSize() == null && size == null || o.getProductSize() != null && o.getProductSize().equals(size)) {
                            if (o.getProductColor() == null && color == null || o.getProductColor() != null && o.getProductColor().equals(color)) {
                                if (o.getQuantity() > 1) {
                                    int idProductSizeColor = OrderDAO.getIdSizeColor(o.getProduct().getId(), o.getProductSize(), o.getProductColor());
                                    int quantitySizeColor = OrderDAO.getQuantitySizeColor(o.getProduct().getId(), idProductSizeColor);
                                    if (quantitySizeColor == 0) {
                                        orderDetails.remove(o);
                                        if(orderDetails.isEmpty()){
                                            session.removeAttribute("cart");
                                            request.getRequestDispatcher("CartControl").forward(request, response);
                                            return;
                                        }
                                    } else {
                                        if (quantitySizeColor < o.getQuantity()) {
                                            o.setQuantity(quantitySizeColor);
                                            quantity = o.getQuantity();
                                        } else {
                                            o.setQuantity(o.getQuantity() - 1);
                                            quantity = o.getQuantity();
                                        }
                                    }
                                    quantity = o.getQuantity();
                                }
                            }
                        }
                    }

                }
            }
            session.setAttribute("cart", map); // update lại vào session
        }
        int totalQuantity = 0;
        double total = 0;
        Map<String, List<OrderDetail>> cartTemp = (Map<String, List<OrderDetail>>) obj;
        for (Map.Entry<String, List<OrderDetail>> entry : cartTemp.entrySet()) {
            List<OrderDetail> orderDetails = entry.getValue();
            for (OrderDetail orderDetail : orderDetails) {
                total += orderDetail.getQuantity() * orderDetail.getPrice();
                totalQuantity += orderDetail.getQuantity();
            }
        }
        session.setAttribute("cartTotalQuantity", totalQuantity);
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("quantity", quantity);
        jsonObject.addProperty("total", total);
        jsonObject.addProperty("totalQuantity", totalQuantity);
        response.getWriter().println(jsonObject);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
