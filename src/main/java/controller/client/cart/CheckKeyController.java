package controller.client.cart;

import com.google.gson.JsonObject;
import entity.ElectronicSignature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart/CheckKeyControl")
public class CheckKeyController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String key = req.getParameter("key");
        boolean result = ElectronicSignature.isPrivateKey(key);
        JsonObject jsonObject = new com.google.gson.JsonObject();
        jsonObject.addProperty("verify", result);
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(jsonObject);
    }
}
