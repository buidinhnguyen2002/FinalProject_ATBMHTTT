package controller.client.cart;

import dao.client.OrderDAO;
import entity.Order;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/cart/CancelBill")
public class CancelBill extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        OrderDAO.updateStatusOrder("Đã hủy",id);
        request.getRequestDispatcher("CartControl").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
