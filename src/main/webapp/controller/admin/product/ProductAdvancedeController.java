package controller.admin.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.admin.ProductAdminDAO;
import dao.client.ProductDAO;
import dao.client.UtilDAO;
import entity.Product;

@WebServlet("/admin-products/Edit")
public class ProductAdvancedeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            String id = request.getParameter("id");
            Product render = UtilDAO.findProductById(Integer.parseInt(id));
            request.setAttribute("rendercolorsize", render);
            System.out.println(render);
            request.getRequestDispatcher("/admin/admin-advanced-editing.jsp").forward(request, response);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);

}}
