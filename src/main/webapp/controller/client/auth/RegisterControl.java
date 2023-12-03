package controller.client.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import context.DB;
import dao.client.AuthDAO;
import entity.Account;
import bean.Log;
import util.VerifyRecaptchas;

@WebServlet("/Register")
public class RegisterControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String namelog ="Register";
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String user = request.getParameter("user");
		String name = request.getParameter("name");
		String passWord = request.getParameter("password");
		String repassWord = request.getParameter("repassword");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String phone = request.getParameter("phoneNumber");
		String gRecap = request.getParameter("g-recaptcha-response");
		boolean verify = VerifyRecaptchas.verify(gRecap);
		request.setAttribute("name", name);
		request.setAttribute("user", user);
		request.setAttribute("email", email);
		request.setAttribute("address", address);
		request.setAttribute("phone", phone);
		String ipAddress =request.getRemoteAddr();
		Log log = new Log(Log.INFO , ipAddress ,-1, this.namelog,"",0);

		if (!verify) {
			log.setSrc(this.namelog +" REGISTER");
			log.setContent("REGISTER FAIL");
			log.setLevel(Log.WARNING);
			request.setAttribute("error", "Chưa nhập Capcha ");
			request.getRequestDispatcher("/client/Register.jsp").forward(request, response);

		}else if(!passWord.matches("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$")) {
			log.setSrc(this.namelog +" REGISTER");
			log.setContent("REGISTER FAIL");
			log.setLevel(Log.WARNING);
			request.setAttribute("errorpass", "Mật khẩu ko đúng yêu cầu");
			request.getRequestDispatcher("/client/Register.jsp").forward(request, response);

		} else if (!passWord.equals(repassWord)) {
			log.setSrc(this.namelog +" REGISTER");
			log.setContent("REGISTER FAIL");
			log.setLevel(Log.WARNING);
			request.setAttribute("error", "Mật khẩu không trùng khớp");
			request.getRequestDispatcher("/client/Register.jsp").forward(request, response);

		} else if (AuthDAO.checkAccountExist(user) ==true ) {
			log.setSrc(this.namelog +" REGISTER");
			log.setContent("REGISTER FAIL");
			log.setLevel(Log.WARNING);
			request.setAttribute("userexit", "Người dùng đã tồn tại! ");
			request.getRequestDispatcher("/client/Register.jsp").forward(request, response);

		} else if (AuthDAO.checkEmailExist(email) ==true ) {
			log.setSrc(this.namelog +" REGISTER");
			log.setContent("REGISTER FAIL");
			log.setLevel(Log.WARNING);
			request.setAttribute("emailexit", "Email đã tồn tại!");
			request.getRequestDispatcher("/client/Register.jsp").forward(request, response);

		} else {
			Account a = new Account(user, passWord, name, address, email, phone);
			log.setSrc(this.namelog +" REGISTER");
			log.setContent("REGISTER SUCCESS");
			log.setLevel(Log.WARNING);
			request.setAttribute("cus", a);
			request.getRequestDispatcher("/VerifyEmailControl").forward(request, response);
		}
		DB.me().insert(log);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}