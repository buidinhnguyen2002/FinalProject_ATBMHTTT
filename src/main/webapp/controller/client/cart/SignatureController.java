package controller.client.cart;

import com.google.gson.JsonObject;
import dao.client.OrderDAO;
import entity.Account;
import entity.ElectronicSignature;
import entity.Order;
import entity.PublicKeyUser;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;

@WebServlet("/cart/SignatureController")
public class SignatureController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("acc");
        int idAccount = account.getId();
        String id = req.getParameter("id");
        Order order = OrderDAO.getOrderByBid(id);
        order.setAccount(account);
        PublicKeyUser publicKeyUser = OrderDAO.getPublicKeyById(order.getPublicKeyId());
        order.setOrderDetails(OrderDAO.getOrderDetailByBid(id));
        String signature = OrderDAO.getSignatureById(Integer.parseInt(id));
        String data = order.orderInfo();
        System.out.println(publicKeyUser.getPublicKey());
        boolean result = false;
        try {
            result = ElectronicSignature.checkSignature(publicKeyUser.getPublicKey(), data, signature);
//            result = ElectronicSignature.checkSignature("MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxItJJw0yM2Ecc8lmf7F8DHGHN/vpPQIbgIkwX9zX3ZiThf7c0Xyj8QfjP50eD7gzyS500L/abZlKAz9+cWdo4T2UD2m9TCDEueHfF8j2yB9qDe4fu1LhdnYepeH0s28pyYSZJUuNxTJFoFsC7j4LCM7Zwzh2BmoWVxFRsK2H1W7II5ZqKmXgzNMZ+IjyoUxhF1tmUr0b/9gIQKxod+g63woq7WQ2ilfOA3Wp65+HpT782NCwoz82jlFrobwY3XfOL5/e3CzBoXguSg42R71WvSG0rjl/tParWrcUfo7x5Zhb6sX8SBtfdm+qdZH8sl5f1zWHm8QNhQRTF9QFKkhW4wIDAQAB", data, signature);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeyException e) {
            throw new RuntimeException(e);
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }
        JsonObject jsonObject = new com.google.gson.JsonObject();
        jsonObject.addProperty("verify", result);
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(jsonObject);
    }
}
