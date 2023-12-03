package controller.client.cart;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import dao.client.OrderDAO;
import entity.OrderDetail;

@WebServlet("/cart/AddBillProductControl")
public class AddBillProductControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String key = request.getParameter("key");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int quantity = 0;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
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
                                    int idProductSizeColor = OrderDAO.getIdSizeColor(o.getProduct().getId(), o.getProductSize(), o.getProductColor());
                                    if (OrderDAO.getQuantitySizeColor(o.getProduct().getId(), idProductSizeColor) >= o.getQuantity() + 1) {
                                        o.setQuantity(o.getQuantity() + 1);
                                        quantity = o.getQuantity();
                                    } else {
                                        request.setAttribute("sorry", "Xin lỗi chúng tôi không đủ số lượng sản phẩm này");
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
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
