package controller.client.auth;

import com.google.gson.JsonObject;
import dao.client.AuthDAO;
import entity.Account;
import entity.ElectronicSignature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/HadKeyControl")
public class HadKeyControl extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account customer = (Account) session.getAttribute("acc");

        String inputKey = request.getParameter("input");
        boolean isSuc = false;
        if (ElectronicSignature.isPublicKey(inputKey) && !AuthDAO.selectSamePublicKey(inputKey)) {
            AuthDAO.updateExpiredPublicKey(customer.getId());
            AuthDAO.insertNewPublicKey(customer.getId(), inputKey);
            isSuc = true;
        } else {
            isSuc = false;
        }
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("isSuc", isSuc);
        response.getWriter().println(jsonObject);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
