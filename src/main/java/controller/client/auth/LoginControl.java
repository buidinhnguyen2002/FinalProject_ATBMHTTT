package controller.client.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Log;
import context.DB;
import dao.client.AuthDAO;
import entity.Account;
import entity.Role;
import util.VerifyRecaptchas;

@WebServlet("/Login")
public class LoginControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String name = "Login";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
            String userName = request.getParameter("email");
            String passWord = request.getParameter("password");
            String pid = request.getParameter("pid");
            String gRecap = request.getParameter("g-recaptcha-response");
            String typeHeader = "customer";
            boolean verify = VerifyRecaptchas.verify(gRecap);
            HttpSession session = request.getSession();
            Account account = AuthDAO.login(userName, passWord,passWord);
            boolean accountCheck = AuthDAO.checkAccountExist(userName);
            String ipAddress = request.getRemoteAddr();
            Log log = new Log(Log.INFO, ipAddress, -1, this.name, "", 0);
            int num ;
            if (accountCheck) {
                num = AuthDAO.loginFail(userName);
                int fail = 0;
                if (num >= 5) {
                    request.setAttribute("error", "Bạn đã nhập sai quá 5 lần. Vui lòng liên hệ Admin để mở khóa đăng nhập ");
                    request.getRequestDispatcher("/client/Login.jsp").forward(request, response);
                } else {
                    if (account == null && verify) {
                        log.setSrc(this.name + " LOGIN FALSE");
                        log.setContent("LOGIN FALSE: USER - " + userName);
                        log.setLevel(Log.WARNING);
                        request.setAttribute("error", "Bạn nhập sai mật khẩu " + num + " lần (Nếu 5 liên tục nhập sai 5 lần tài khoản của bạn sẽ bị khóa)");
                        request.getRequestDispatcher("/client/Login.jsp").forward(request, response);
                    } else {
                        if (!verify) {
                            request.setAttribute("error", "Chưa nhập Captcha ");
                            request.getRequestDispatcher("/client/Login.jsp").forward(request, response);
                        } else {
                            session.setAttribute("acc", account);
                            session.setMaxInactiveInterval(1800);
                            log.setSrc(this.name + " LOGIN");
                            log.setUserId(account.getId());
                            log.setContent("LOGIN SUCCESS: USER - " + userName);
                            AuthDAO.resetlogin(userName);
                            for (Role r : account.getRoles()
                            ) {
                                typeHeader = r.getName();
                            }
                            session.setAttribute("typeacc", typeHeader);
                            if (pid == null) {
                                request.getRequestDispatcher("IndexControl").forward(request, response);
                            } else {
                                response.sendRedirect("DetailControl?pid=" + pid);
                            }
                        }

                    }
                    DB.me().insert(log);
                }
            } else {
                log.setSrc(this.name + " LOGIN FALSE");
                log.setContent("LOGIN FALSE: USER - " + userName);
                log.setLevel(Log.WARNING);
                DB.me().insert(log);
                request.setAttribute("error", "Tài khoản hoặc mật khẩu không hợp lệ");
                request.getRequestDispatcher("/client/Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}