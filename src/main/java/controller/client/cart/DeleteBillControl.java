package controller.client.cart;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AuthDAO.SecurityDAO;
import entity.OrderDetail;
import util.Util;

@WebServlet("/cart/DeleteBillControl")
public class DeleteBillControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String key = request.getParameter("key");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Object obj = session.getAttribute("cart");
        if (obj != null) {
            Map<String, List<OrderDetail>> map = (Map<String, List<OrderDetail>>) obj;
            Iterator<Map.Entry<String, List<OrderDetail>>> iterator = map.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, List<OrderDetail>> entry = iterator.next();
                List<OrderDetail> orderDetails = entry.getValue();
                Iterator<OrderDetail> orderDetailIterator = orderDetails.iterator();
                while (orderDetailIterator.hasNext()) {
                    OrderDetail o = orderDetailIterator.next();
                    if (String.valueOf(o.getProduct().getId()).equalsIgnoreCase(key)) {
                        if ((o.getProductSize() == null && size == null) || (o.getProductSize() != null && o.getProductSize().equals(size))) {
                            if ((o.getProductColor() == null && color == null) || (o.getProductColor() != null && o.getProductColor().equals(color))) {
                                orderDetailIterator.remove();
                            }
                        }
                    }
                }
                if (entry.getValue().isEmpty()) {
                    iterator.remove();
                }
            }
            session.setAttribute("cart", map);
        }

        request.getRequestDispatcher("CartControl").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
