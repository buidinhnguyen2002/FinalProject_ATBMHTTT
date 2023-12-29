package controller.client.cart;

import com.google.gson.JsonObject;
import entity.Account;
import entity.ElectronicSignature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@WebServlet("/cart/CheckKeyControl")
public class CheckKeyController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("acc");
        int idAccount = account.getId();
        String key = req.getParameter("key");
        boolean result = false;
        try {
            result = ElectronicSignature.isPrivateKey(key, idAccount);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        JsonObject jsonObject = new com.google.gson.JsonObject();
        jsonObject.addProperty("verify", result);
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(jsonObject);
    }
}
