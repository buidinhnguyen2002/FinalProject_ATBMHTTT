package controller.client.cart;

import dao.client.OrderDAO;
import entity.Order;
import util.PayPalRefund;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/cart/CancelBill")
public class CancelBill extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try {
           String id = request.getParameter("id");
           String status = request.getParameter("status");
           if(status.equals("UnPay")){
               OrderDAO.updateStatusOrder("Đã hủy",id);
           }else if(status.equals("Payed")){
               Order order =  OrderDAO.getOrderByBid(id);
               if (order.getStatus().equals("Đang xử lý")){
                   Boolean checkRefund =PayPalRefund.refundPayPal(order.getTransactionId());
                   if (checkRefund){
                       OrderDAO.updateStatusPayOrder("Đã hoàn tiền",id);
                       System.out.println("Hoàn Tiền thành công");
                   }else {
                       System.out.println("Không thể hoàn tiền");
                   }
                   OrderDAO.updateStatusOrder("Đã hủy",id);
               }else {
                   OrderDAO.updateStatusOrder("Yêu cầu hoàn tiền",id);
               }
           }
           request.getRequestDispatcher("CartControl").forward(request, response);
       }catch (Exception e){
           e.printStackTrace();
       }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
