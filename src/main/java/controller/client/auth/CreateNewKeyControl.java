package controller.client.auth;

import dao.client.AuthDAO;
import entity.Account;
import entity.RSA;
import util.SendEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CreateNewKeyControl")
public class CreateNewKeyControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account customer = (Account) session.getAttribute("acc");

        RSA rsa = new RSA(2048);
        String publicKey = rsa.exportPublicKey();

        SendEmail.sendMailKey(customer.getEmail(), publicKey, rsa.exportPrivateKey());

        AuthDAO.updateExpiredPublicKey(customer.getId());
        AuthDAO.insertNewPublicKey(customer.getId(), publicKey);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    public static void main(String[] args) {
        RSA rsa = new RSA(2048);
        String publicKey = rsa.exportPublicKey();
        String privateKey = rsa.exportPrivateKey();
        System.out.println(publicKey);
        System.out.println("==========================");
        System.out.println(privateKey);
    }
}
