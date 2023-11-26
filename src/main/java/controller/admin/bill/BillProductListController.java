package controller.admin.bill;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import context.DB;
import dao.AuthDAO.SecurityDAO;
import dao.admin.BillAdminDAO;
import dao.client.OrderDAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import bean.Log;
@WebServlet("/admin-bill/BillProductListController")
public class BillProductListController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Account account = (Account) request.getSession().getAttribute("admin");
			if (account==null){
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
				return;
			}
			if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-bill"), account.getAccountName(), "read")) {
				List<Order> listOrders = BillAdminDAO.getListOrder();
				Map<Integer, List<OrderDetail>> map = new HashMap<>();
				for (int i = 0; i < listOrders.size(); i++) {
					List<OrderDetail> listProducts = OrderDAO.getOrderDetailByBid(String.valueOf(listOrders.get(i).getId()));
					map.put(i, listProducts);
				}
				request.setAttribute("products", map);
				request.setAttribute("listOrders", listOrders);
				request.getRequestDispatcher("/admin/admin-bill-manager.jsp").forward(request, response);
			}else {
				request.getRequestDispatcher("/client/403.jsp").forward(request, response);
			}
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
