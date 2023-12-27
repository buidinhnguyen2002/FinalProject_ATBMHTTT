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
import java.util.List;

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
        List<PublicKeyUser> publicKeyUsers = OrderDAO.getPublicKeyById(order.getIdAccount(), order.getCreateAt());
        order.setOrderDetails(OrderDAO.getOrderDetailByBid(id));
        String signature = OrderDAO.getSignatureById(Integer.parseInt(id));
        String data = order.orderInfo();
        boolean result = false;
        for(PublicKeyUser publicKeyUser: publicKeyUsers){
            try {
                result = ElectronicSignature.checkSignature(publicKeyUser.getPublicKey(), data, signature);
                if(result) break;
            } catch (InvalidKeySpecException e) {
                throw new RuntimeException(e);
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException(e);
            } catch (InvalidKeyException e) {
                throw new RuntimeException(e);
            } catch (SignatureException e) {
                throw new RuntimeException(e);
            }
        }
        JsonObject jsonObject = new com.google.gson.JsonObject();
        jsonObject.addProperty("verify", result);
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(jsonObject);
    }
}
