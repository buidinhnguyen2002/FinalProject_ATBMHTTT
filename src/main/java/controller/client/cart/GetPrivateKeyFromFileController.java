package controller.client.cart;

import com.google.gson.JsonObject;
import entity.AES;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.util.Base64;

@WebServlet("/cart/GetPrivateKeyFromFile")
public class GetPrivateKeyFromFileController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String privateKey = req.getParameter("privateKey");
        byte[] privateKeyBytes = Base64.getDecoder().decode(privateKey);
        AES aes = new AES();
        String decryptedText = "";
        try {
            byte[] output = aes.decryptAESFile(privateKeyBytes, "");
            decryptedText = new String(output, StandardCharsets.UTF_8);
            System.out.println("TEXT: " + decryptedText);
        } catch (NoSuchPaddingException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeyException e) {
            throw new RuntimeException(e);
        } catch (IllegalBlockSizeException e) {
            throw new RuntimeException(e);
        } catch (BadPaddingException e) {
            throw new RuntimeException(e);
        } catch (NoSuchProviderException e) {
            throw new RuntimeException(e);
        } catch (InvalidAlgorithmParameterException e) {
            throw new RuntimeException(e);
        }
        JsonObject jsonObject = new com.google.gson.JsonObject();
        jsonObject.addProperty("privateKey", decryptedText);
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(jsonObject);
    }
}
