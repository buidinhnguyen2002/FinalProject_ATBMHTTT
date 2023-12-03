package controller.admin.log;

import dao.AuthDAO.SecurityDAO;
import dao.admin.LogDAO;
import entity.Account;
import entity.Log;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
@WebServlet("/admin-log/show-log")
public class ShowLogController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Account account = (Account) request.getSession().getAttribute("admin");
		if (account==null){
			RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
			return;
		}
		if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-log"), account.getAccountName(), "read")) {
			List<Log> logs = LogDAO.getListLog();
			request.setAttribute("logs", logs);
			request.getRequestDispatcher("/admin/admin-log-manager.jsp").forward(request, response);
		}else {
			request.getRequestDispatcher("/client/403.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
