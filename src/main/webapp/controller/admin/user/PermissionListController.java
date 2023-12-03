package controller.admin.user;

import context.DB;
import controller.admin.webSocket.UpdateAccountEndPoint;
import dao.AuthDAO.SecurityDAO;
import dao.admin.AccountDAO;
import entity.Account;
import entity.Permission;
import entity.Resource;
import entity.Role;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import bean.Log;

@WebServlet("/admin-user/permission")
public class PermissionListController extends HttpServlet {
    String namelog="List-permission";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("admin");
        if (account==null){
            RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
            return;
        }
        if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-user"), account.getAccountName(), "read")) {
            List<Role> roles = AccountDAO.getAllRoles();
            request.setAttribute("roles", roles);
            request.getRequestDispatcher("/admin/admin-roles-manager.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/client/403.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String isChecked = request.getParameter("isChecked");
        String resourceId = request.getParameter("resourceId");
        String idRole = request.getParameter("idRole");
        boolean isCheck = Boolean.parseBoolean(isChecked);
        String ipAddress =request.getRemoteAddr();
        Log log = new Log(Log.WARNING,ipAddress,-1,this.namelog,"",0);
        Account account = (Account) request.getSession().getAttribute("admin");
        if (!isCheck) {
            AccountDAO.removePermission(resourceId,idRole, action);
            log.setSrc(namelog + " DELETE ");
            log.setContent("DELETE PERMISSION SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
        } else {
            log.setSrc(namelog + " ADD ");
            log.setContent("ADD PERMISSION SUCCESS BY USER: "+ account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
            AccountDAO.insertPermission(resourceId,idRole, action);
        }
        for (String s : AccountDAO.getListIdByIdRole(idRole)) {
            UpdateAccountEndPoint.notifyUserUpdate(Integer.parseInt(s), "update");
        }
    }
}
