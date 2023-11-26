package controller.client.cart;

import context.DB;
import dao.client.OrderDAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import bean.Log;

@WebServlet("/cart/CartControl")
public class CartControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String namelog ="Payer";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String ipAddress =request.getRemoteAddr();
        Log log = new Log(Log.INFO,ipAddress,-1,this.namelog,"",0);

        try {
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("acc");
            if(account==null){

                request.getRequestDispatcher("/client/Login.jsp").forward(request, response);

            }
            else{


            Object obj = session.getAttribute("cart");// luu tam vao session
            int totalQuantity = 0;
            double total = 0;
            List<Order> listOrders = OrderDAO.getListOrderByAcountId(String.valueOf(account.getId()));
            Collections.reverse(listOrders);
            Map<Integer, List<OrderDetail>> map = new HashMap<>();
            for (int i = 0; i < listOrders.size(); i++) {
                List<OrderDetail> listProducts = OrderDAO.getOrderDetailByBid(String.valueOf(listOrders.get(i).getId()));
                map.put(i, listProducts);

            }
            if (obj != null) {
                Map<String, List<OrderDetail>> cartTemp = (Map<String, List<OrderDetail>>) obj;
                for (Map.Entry<String, List<OrderDetail>> entry : cartTemp.entrySet()) {
                    List<OrderDetail> orderDetails = entry.getValue();
                    for (OrderDetail orderDetail : orderDetails) {
                        total += orderDetail.getQuantity() * orderDetail.getPrice();
                        totalQuantity += orderDetail.getQuantity();
                    }
                }
            }
              log.setSrc(namelog +" PAYER");
                 log.setContent("PAYER SUCCESS: USER -" +account.getAccountName());
                 log.setUserId(account.getId());

                DB.me().insert(log);

            request.setAttribute("total", total);
            request.setAttribute("products", map);
            request.setAttribute("listOrders", listOrders);
            session.setAttribute("cartTotalQuantity", totalQuantity);
            request.getRequestDispatcher("/client/Cart.jsp").forward(request, response);


            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
