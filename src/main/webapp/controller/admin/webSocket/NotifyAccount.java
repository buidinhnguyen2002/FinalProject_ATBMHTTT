package controller.admin.webSocket;

import com.mysql.cj.Session;
import dao.admin.AccountDAO;
import dao.client.AccessDAO;
import dao.client.AuthDAO;
import dao.client.UtilDAO;
import entity.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/client/NotifyAccount")
public class NotifyAccount extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try{
           int idUser = Integer.parseInt(request.getParameter("idUser"));
           String typeAction = request.getParameter("typeAction");
           if(typeAction.equals("delete")){
               response.getWriter().println(idUser);
               request.getSession().invalidate();
           }
           if(typeAction.equals("edit")){
               Account acc = (Account) request.getSession().getAttribute("acc");
               Account newAcc = AuthDAO.findAccountIdAddSession(String.valueOf(acc.getId()));
               System.out.println(newAcc);
               request.getSession().setAttribute("acc",newAcc);
           }
       }catch (Exception e){
           e.printStackTrace();
       }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
