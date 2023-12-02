package controller.admin.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Log;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import context.DB;
import dao.AuthDAO.SecurityDAO;
import dao.admin.ProductAdminDAO;
import dao.client.ProductDAO;
import dao.client.UtilDAO;
import entity.Account;
import entity.Product;


@WebServlet("/admin-products/ProductListController")
public class ProductListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String namelog = "Remove";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Product> render = ProductAdminDAO.showlistproduct();
            request.setAttribute("renderproduct", render);
            request.getRequestDispatcher("/admin/admin-product-manager.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("admin");
        if (account==null){
            RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
            return;
        }
        if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-user"), account.getAccountName(), "remove")) {
            String id = request.getParameter("idproduct");
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.WARNING, ipAddress, -1, this.namelog, "", 0);
            boolean isdelete = false;
            isdelete = ProductAdminDAO.deleteproduct(id);
            JsonObject obj = new JsonObject();
            obj.addProperty("isDel", isdelete);
            log.setSrc(namelog + " REMOVE ");
            log.setContent("DELETE PRODUCT SUCCESS BY USER: " + account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
            response.getWriter().println(obj);
        } else {
            boolean isdelete = false;
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("isDel", isdelete);
            response.getWriter().println(jsonObject);
        }
    }

}
