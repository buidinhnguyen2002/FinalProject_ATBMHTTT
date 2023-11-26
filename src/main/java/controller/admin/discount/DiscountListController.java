package controller.admin.discount;

import dao.AuthDAO.SecurityDAO;
import dao.admin.BillAdminDAO;
import dao.admin.DiscountDAO;
import dao.client.OrderDAO;
import entity.Account;
import entity.Discount;
import entity.Order;
import entity.OrderDetail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin-discount/discount")
public class DiscountListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Account account = (Account) request.getSession().getAttribute("admin");
            if (account==null){
                RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
                return;
            }
            if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-discount"), account.getAccountName(), "read")) {
                List<Discount> listDiscount = DiscountDAO.getListDiscount();
                request.setAttribute("listDiscount", listDiscount);
                for (Discount discount : listDiscount
                ) {
                    LocalDateTime startTime = LocalDateTime.parse(discount.getStartTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    String startTimeString = startTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
                    discount.setStartTime(startTimeString);
                    LocalDateTime endTime = LocalDateTime.parse(discount.getEndTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    String endTimeString = endTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
                    discount.setEndTime(endTimeString);
                }
                request.getRequestDispatcher("/admin/admin-discount-manager.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/client/403.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
