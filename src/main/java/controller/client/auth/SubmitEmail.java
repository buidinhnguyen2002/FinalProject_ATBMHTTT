package controller.client.auth;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.AuthDAO;
import entity.Account;
import entity.RSA;
import jdk.jpackage.internal.Log;
import util.SendEmail;
import util.VerifyRecaptchas;

/**
 * Servlet implementation class SubmitEmail
 */
@WebServlet("/SubmitEmail")
public class SubmitEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		Account customer = (Account) session.getAttribute("custemp");
		String email = request.getParameter("email");
		String codeverify = request.getParameter("codeverify");
		boolean checkCustommerExits = AuthDAO.checkAccountExist(customer.getAccountName());
		boolean checkCustommerExitss = AuthDAO.checkAccountExist(customer.getEmail());

		LocalDateTime lastTime = (LocalDateTime) session.getAttribute("timeNow");
		LocalDateTime currentTime = LocalDateTime.now();
		String gRecap = request.getParameter("g-recaptcha-response");
		boolean verify = VerifyRecaptchas.verify(gRecap);
		Duration duration = Duration.between(lastTime, currentTime); // thoi gian gia 2 thoi diem
		if (!verify) {
			request.setAttribute("error", "Chưa nhập Captcha ");
			request.getRequestDispatcher("/client/VerifyEmail.jsp").forward(request, response);
		} else if(duration.getSeconds() > 300) {
			request.setAttribute("timeUp", "Hết thời gian xác thực email!");
			request.getRequestDispatcher("/client/VerifyEmail.jsp").forward(request, response);
		} else if(!codeverify.equals(session.getAttribute("newVerify"))) {
			request.setAttribute("error", "Mã xác thực không chính xác!");
			request.getRequestDispatcher("/client/VerifyEmail.jsp").forward(request, response);
		} else if (!checkCustommerExits && !checkCustommerExitss) {
			RSA rsa = new RSA(2048);
			String publicKey = rsa.exportPublicKey();
			SendEmail.sendMailKey(email, publicKey, rsa.exportPrivateKey());
			AuthDAO.signUp(customer.getAccountName(), customer.getPassword(), customer.getFullName(), customer.getEmail(),
					customer.getAddress(), customer.getPhone(), publicKey);

			request.getRequestDispatcher("/client/Login.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}