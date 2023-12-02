package controller.admin.product;

import com.google.gson.JsonObject;
import dao.admin.ProductAdminDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin-products/ProductAddProperties")
public class ProductAddProperties extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String type = request.getParameter("type");
            if (type.equalsIgnoreCase("producer")) {
                String nameProducer = request.getParameter("nameProducer");
                boolean isSuc = false;
                isSuc = ProductAdminDAO.addProducer(nameProducer);
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("isSuc", isSuc);
                response.getWriter().println(jsonObject);
                return;
            }
            if (type.equalsIgnoreCase("supplier")) {
                String nameSupplier = request.getParameter("nameSupplier");
                boolean isSuc = false;
                isSuc = ProductAdminDAO.addSupplier(nameSupplier);
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("isSuc", isSuc);
                response.getWriter().println(jsonObject);
                return;
            }
            if (type.equalsIgnoreCase("categorie")) {
                String nameCategorie = request.getParameter("nameCategorie");
                boolean isSuc = false;
                isSuc = ProductAdminDAO.addCategorie(nameCategorie);
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("isSuc", isSuc);
                response.getWriter().println(jsonObject);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
