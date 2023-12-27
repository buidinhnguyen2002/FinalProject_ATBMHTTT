package controller.client.auth;

import dao.client.AccessDAO;
import dao.client.AuthDAO;
import entity.Account;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

@WebServlet("/HadKeyControl")
public class HadKeyControl extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account customer = (Account) session.getAttribute("custemp");

        String inputKey = request.getParameter("input");

        boolean authDAO;
        if (AuthDAO.updateExpiredPublicKey(customer.getId())){
            authDAO = AuthDAO.insertNewPublicKey(customer.getId(), inputKey);
            request.setAttribute("success", "Cập nhật key thành công!");
        }
        else authDAO = false;
    }
}
