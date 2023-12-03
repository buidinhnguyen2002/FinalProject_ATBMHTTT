package controller.admin.show;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.admin.AccountDAO;
import dao.admin.AdminDAO;
import dao.admin.BillAdminDAO;
import dao.admin.ProductAdminDAO;
import entity.Account;
import entity.Order;
import entity.Product;

@WebServlet("/admin-index")
public class IndexAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		// tất cả tài khoản
		int sumAccount = AccountDAO.getTotalAccount();
		request.setAttribute("sumAccount", sumAccount);
		// tất cả sản phẩm
		int sumProduct = ProductAdminDAO.getTotalActiveProduct();
		request.setAttribute("sumProduct", sumProduct);
		// số hóa đơn trong tháng
		Calendar calendar = Calendar.getInstance();
		int month = calendar.get(Calendar.MONTH) + 1;
		int sumBill = BillAdminDAO.sumBillInMonth(month);
		request.setAttribute("sumBill", sumBill);
		//Sản phẩm hết hàng
		int productOuOtOfStock = ProductAdminDAO.getTotalProductOuOtOfStock();
		request.setAttribute("productOuOtOfStock", productOuOtOfStock);
		// Danh sách đơn hàng
		List<Order> orders = BillAdminDAO.getListOrderLimit();
		request.setAttribute("orders", orders);
		// Danh sách khách hàng
		List<Account> accounts = AccountDAO.getListNewAccount();
		request.setAttribute("accounts", accounts);
		// Danh sách san pham gan het
		List<Product> listProductStock = ProductAdminDAO.getListProductOuOtOfStock();
		request.setAttribute("listProductStock", listProductStock);

		// Danh sách san pham tồn kho
		List<Product> listProductInventory = ProductAdminDAO.getListProductInventory();
		request.setAttribute("listProductInventory", listProductInventory);

		//Take sum orders every month
		List<Integer> ordersMonth = new ArrayList<>();
		for(int i = 1; i <= 6; i++ ){
			int sumOrdersMonth = BillAdminDAO.sumBillInMonth(i);
			ordersMonth.add(sumOrdersMonth);
		}
		request.setAttribute("sumOrdersMonth", ordersMonth);
		List<Integer> allOrdersMonth = new ArrayList<>();
		for(int i = 1; i <= 6; i++ ){
			int sumOrdersMonth = BillAdminDAO.sumAllBillInMonth(i);
			allOrdersMonth.add(sumOrdersMonth);
		}
		request.setAttribute("allOrdersMonth", allOrdersMonth);
		request.getRequestDispatcher("/admin/admin-index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
