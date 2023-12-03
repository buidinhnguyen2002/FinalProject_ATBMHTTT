package controller.admin.product;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.admin.ProductAdminDAO;

@WebServlet("/ProductDeleteController")
public class ProductDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");

		ProductAdminDAO.removeProduct(id);
		HttpSession session = request.getSession();
		String sessionID = ";jsessionid="+session.getId();
		response.sendRedirect(request.getContextPath() + "/ProductListController"+sessionID);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
