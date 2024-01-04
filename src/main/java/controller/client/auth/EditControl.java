package controller.client.auth;

import dao.client.AuthDAO;
import entity.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/account/EditControl")
public class EditControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String query = request.getQueryString();
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("acc");
		try {
			if (query != null) {
				if (query.equalsIgnoreCase("editInfo")) {
					String name = request.getParameter("name");
					String address = request.getParameter("address");
					String phoneNumber = request.getParameter("phoneNumber");
					AuthDAO.editAccountInfo(name, address, phoneNumber, String.valueOf(account.getId()));
					account.setFullName(name);
					account.setAddress(address);
					account.setPhone(phoneNumber);
					session.setAttribute("acc", account);
					request.setAttribute("sucinfo", "Đổi thông tin thành công");
					request.getRequestDispatcher("/client/Account.jsp").forward(request, response);
					return;
				}
				if (query.equalsIgnoreCase("editPassword")) {
					String oldpass = request.getParameter("oldpass");
					String newpass = request.getParameter("newpass");
					String renewpass = request.getParameter("renewpass");
					if (newpass.equals(renewpass)) {
						Account editAccount = AuthDAO.checkAccountOldPassword(String.valueOf(account.getId()), oldpass,oldpass);
						if(editAccount!=null) {
							if(account.getEmail().equalsIgnoreCase(editAccount.getEmail())) {
								AuthDAO.editAccountPassword(String.valueOf(account.getId()), renewpass);
								request.setAttribute("suc", "Đổi mật khẩu thành công");
							}
						}else {
							request.setAttribute("error", "Mật khẩu củ sai");
						}
					}else{
						request.setAttribute("error", "Mật khẩu mới và nhập lại mật khẩu không trùng nhau");
					}
					request.getRequestDispatcher("/client/Account.jsp").forward(request, response);
				}
			}else{
				request.getRequestDispatcher("/client/Account.jsp").forward(request, response);
			}
		}catch (Exception e){
			e.printStackTrace();
		}
	}

}
