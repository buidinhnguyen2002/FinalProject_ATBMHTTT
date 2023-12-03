package controller.admin.user;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import context.DB;
import controller.admin.webSocket.UpdateAccountEndPoint;
import dao.admin.AccountDAO;
import dao.client.AuthDAO;
import dao.client.UtilDAO;
import entity.Account;
import entity.Resource;
import entity.Role;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import bean.Log;
@WebServlet("/admin-user/PermissionAddController")
public class PermissionAddController extends HttpServlet {
        String namelog ="Addpermission";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            List<Resource> resources = AccountDAO.getAllResource();
            Gson gson = new Gson();
            JsonObject jsonObject = new JsonObject();
            jsonObject.add("resources", gson.toJsonTree(resources));
            response.getWriter().println(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String ipAddress =request.getRemoteAddr();
            Log log = new Log(Log.WARNING,ipAddress,-1,this.namelog,"",0);
            HttpSession session = request.getSession();
              Account account = (Account) session.getAttribute("acc");

        try {
            String[] accessAdd = request.getParameterValues("accessAdd[]");
            String resource = request.getParameter("resource");
            String idRole = request.getParameter("idRole");
            AccountDAO.insertRoleRessource(idRole, resource);
            for (String s : AccountDAO.getListIdByIdRole(idRole)) {
                UpdateAccountEndPoint.notifyUserUpdate(Integer.parseInt(s), "update");
            }
            log.setSrc(namelog +" Add");
            log.setContent("ADD PERMISSION SUCCESS BY USER: "+account.getAccountName());
            log.setUserId(account.getId());
            DB.me().insert(log);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
