package controller.admin.user;

import bean.Log;
import context.DB;
import dao.admin.AccountDAO;
import entity.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin-user/role-add")
public class RoleAddController extends HttpServlet {
    String namelog="Add-role";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ipAddress = request.getRemoteAddr();
        Log log = new Log(Log.WARNING,ipAddress,-1,this.namelog,"",0);
        Account account = (Account) request.getSession().getAttribute("admin");
        try {
            String nameRole = request.getParameter("nameRole");
            AccountDAO.insertRole(nameRole);
            log.setSrc(namelog + " ADD ");
            log.setContent("ADD ROLE SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
