package controller.admin.revenue;

import dao.admin.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

import dao.client.OrderDAO;
import entity.*;

@WebServlet("/admin-products/RevenueShowController")
public class RevenueShowController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<Integer , List<OrderDetail>> map = new HashMap<>();

        // Sum accounts
        int sumAccount = AccountDAO.getTotalAccount();
        request.setAttribute("sumAccount", sumAccount);

        // Sum product isActive
        int sumProduct = ProductAdminDAO.getTotalActiveProduct();
        request.setAttribute("sumProduct", sumProduct);

        // Sum success orders
        int sumOrder = BillAdminDAO.getTotalAcceptProduct();
        request.setAttribute("sumOrder", sumOrder);

        // Sum cancel orders
        int sumOrderCancel = BillAdminDAO.getTotalCancelProduct();
        request.setAttribute("sumOrderCancel", sumOrderCancel);

        // Sum price in this month
        int sumPrice = BillAdminDAO.getTotalPrice();
        request.setAttribute("sumPrice", sumPrice);

        // Get this month
        int thisMonth = BillAdminDAO.thisMonth();
        request.setAttribute("thisMonth", thisMonth);

        // Sum new members
        int sumNewMembers = BillAdminDAO.sumNewMembers();
        request.setAttribute("sumNewMembers", sumNewMembers);

        // Sum out of stock
        int sumOutOfStock = ProductAdminDAO.getTotalOutOfStock();
        request.setAttribute("sumOutOfStock", sumOutOfStock);

        // Sum out of getTotalNoYetOrder
        int getTotalNoYetOrder = BillAdminDAO.getTotalNoYetOrder();
        request.setAttribute("getTotalNoYetOrder", getTotalNoYetOrder);

        //take detail orders
        List<Order> listOrder = BillAdminDAO.getListOrderSucess();
        for (int i = 0; i < listOrder.size(); i++){
            List<OrderDetail> listProducts = OrderDAO.getOrderDetailByBid(String.valueOf(listOrder.get(i).getId()));
            map.put(i, listProducts);
        }
        request.setAttribute("products", map);
        request.setAttribute("listOrders", listOrder);


        //take selling products
        List<Product> listProduct = ProductAdminDAO.getSellingProducts();
        request.setAttribute("listProduct", listProduct);

        //Take products out of stock
        List<Product> listProductOOS = ProductAdminDAO.getProductOOS();
        request.setAttribute("listProductOOS", listProductOOS);
        System.out.println(listProductOOS);

        //Take sum orders every month
        List<Integer> ordersMonth = new ArrayList<>();
        for(int i = 1; i <= 12; i++ ){
            int sumOrdersMonth = BillAdminDAO.sumBillInMonth(i);
            ordersMonth.add(sumOrdersMonth);
        }
        request.setAttribute("sumOrdersMonth", ordersMonth);

        //Take sum money every month
        List<Integer> moneyMonth = new ArrayList<>();
        for(int i = 1; i <= 12; i++ ){
            int sumOrdersMonth = BillAdminDAO.SumMoneyInMonth(i);
            moneyMonth.add(sumOrdersMonth);
        }
        request.setAttribute("sumMoneyMonth", moneyMonth);

        request.getRequestDispatcher("/admin/admin-revenue-manager.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}