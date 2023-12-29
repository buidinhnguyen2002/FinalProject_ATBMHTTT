package controller.client.cart;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.OrderDAO;
import entity.*;

@WebServlet("/cart/DetailBill")
public class DetailBillCotrol extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		try{
			String id = request.getParameter("id");
			Order order = OrderDAO.getOrderByBid(id);
			HttpSession session = request.getSession();
			Account account = (Account) session.getAttribute("acc");
			int idAccount = account.getId();
			List<OrderDetail> orderDetails = OrderDAO.getOrderDetailByBid(id);
			List<PublicKeyUser> publicKeyUsers = OrderDAO.getPublicKeyById(order.getIdAccount(), order.getCreateAt());
			order.setOrderDetails(OrderDAO.getOrderDetailByBid(id));
			String signature = OrderDAO.getSignatureById(Integer.parseInt(id));
			String data = order.orderInfo();
			boolean result = false;
			for(PublicKeyUser publicKeyUser: publicKeyUsers){
				try {
					result = ElectronicSignature.checkSignature(publicKeyUser.getPublicKey(), data, signature);
					if(result) break;
				} catch (InvalidKeySpecException e) {
					throw new RuntimeException(e);
				} catch (NoSuchAlgorithmException e) {
					throw new RuntimeException(e);
				} catch (InvalidKeyException e) {
					throw new RuntimeException(e);
				} catch (SignatureException e) {
					throw new RuntimeException(e);
				}
			}
			request.setAttribute("check", result);
			request.setAttribute("bill", order);
			request.setAttribute("billProducts", orderDetails);
			request.getRequestDispatcher("/client/BillDetail.jsp").forward(request, response);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
