package controller.admin.bill;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import context.DB;
import dao.admin.AccountDAO;
import dao.admin.BillAdminDAO;
import dao.client.OrderDAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import util.API;
import bean.Log;

@WebServlet("/admin-bill/BillManagerController")
public class BillManagerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String namelog ="Updte";
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("orderId");
        String type = request.getParameter("type");
        String ipAddress = request.getRemoteAddr();
        Log log = new Log(Log.WARNING,ipAddress,-1,this.namelog,"",0);
        Account account = (Account) request.getSession().getAttribute("admin");
        boolean isSuc = false;
        if (type.equals("browse")) {
            isSuc = BillAdminDAO.updateBill("Đã xác nhận", id);
            log.setSrc(namelog + " UPDATE ");
            log.setContent("UPDATE BILL SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
        }
        if (type.equals("transport")) {
            isSuc =  BillAdminDAO.updateBill("Đang vận chuyển", id);
            Order od = BillAdminDAO.getOrderById(id);
            API.registerTransport("1540", "440505", od.getDistrictId(), od.getWardId(), "20", "20", "20", "100");
            log.setSrc(namelog + " UPDATE ");
            log.setContent("UPDATE BILL SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
        }
        if (type.equals("deny")) {
            isSuc = BillAdminDAO.updateBill("Đã hủy", id);
            log.setSrc(namelog + " UPDATE ");
            log.setContent("UPDATE BILL SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
        }
        if (type.equals("back")) {
            isSuc = BillAdminDAO.updateBill("Đã xác nhận", id);
            log.setSrc(namelog + " UPDATE ");
            log.setContent("UPDATE BILL SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
        }
        if (type.equals("success")) {
            isSuc = BillAdminDAO.updateBill("Hoàn thành", id);
                    BillAdminDAO.updateBillStatusPay("Đã thanh toán",id);
                    BillAdminDAO.updateBillDeliveryAt(id);
            log.setSrc(namelog + " UPDATE ");
            log.setContent("UPDATE BILL SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
        }
        DB.me().insert(log);
        Order order = BillAdminDAO.getOrderById(id);
        JsonObject jsonObject = new JsonObject();
        Gson gson = new Gson();
        jsonObject.addProperty("order",gson.toJson(order));
        jsonObject.addProperty("isSuc", isSuc);
        response.getWriter().println(jsonObject);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
