package controller.admin.auth;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import context.DB;
import dao.AuthDAO.SecurityDAO;
import dao.admin.LoginAdminDAO;
import dao.client.AuthDAO;
import entity.Account;
import entity.Role;
import bean.Log;

@WebServlet("/admin/AdminLoginController")
public class AdminLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String namelog = "Login";

//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        getServletContext().getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
//    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String ipAddress = request.getRemoteAddr();
        Log log = new Log(Log.INFO, ipAddress, -1, this.namelog, "", 0);
        try {
            String username = request.getParameter("admin-username");
            String password = request.getParameter("admin-password");
            HttpSession session = request.getSession();
            Account a = LoginAdminDAO.loginAdmin(username, password);
            Account account = AuthDAO.login(username, password, password);
            if (a != null) {
                if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin"), a.getAccountName(), "read")) {
                    session.setAttribute("admin", a);
                    session.setAttribute("acc", account);
                    Account acc = AuthDAO.login(username, password, password);
                    session.setAttribute("acc", acc);
                    log.setSrc(namelog + " LOGIN ADMIN");
                    log.setContent("LOGIN ADMIN SUCCESS: USER " + a.getAccountName());
                    log.setUserId(a.getId());
                    DB.me().insert(log);
                    RequestDispatcher rd = request.getRequestDispatcher("/admin-index");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Tài khoản đăng nhập hoặc mật khẩu sai !!!");
                    log.setSrc(namelog + " LOGIN ");
                    log.setContent("LOGIN ADMIN FAIL ");
                    log.setLevel(Log.WARNING);
                    DB.me().insert(log);
                    RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
                    rd.forward(request, response);
                }
            } else {
                log.setSrc(namelog + " LOGIN ");
                log.setContent("LOGIN ADMIN FAIL");
                log.setLevel(Log.WARNING);
                DB.me().insert(log);
                request.setAttribute("errorMessage", "Tài khoản đăng nhập hoặc mật khẩu sai !!!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
