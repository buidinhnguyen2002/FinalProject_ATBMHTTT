package controller.client.products;

import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.ProductDAO;
import dao.client.AccessDAO;
import entity.Product;

@WebServlet("/ShowProductControl")
public class ShowProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		try {
			String sort = "";
			sort = request.getParameter("sort");
			if (sort == null) {
				sort = "id-asc";
			}

			int cid = 0; //id loại sản phẩm
			if (request.getParameter("cid") != null) {
				cid = Integer.parseInt(request.getParameter("cid"));
			}
			String indexPage = request.getParameter("index");
			if (indexPage == null) {
				indexPage = "1";
			}
			int index = Integer.parseInt(indexPage);
			String search = request.getParameter("search");
			if (search != null && !search.isEmpty()) {
				int count = AccessDAO.getTotalProductSearch(search);
				int endPage = count / 12;
				if (count % 12 != 0) {
					endPage++;
				}

				StringTokenizer s = new StringTokenizer(sort, "-");
				String sortName = s.nextToken();
				String sortType = s.nextToken();
				List<Product> list = AccessDAO.pagingProductSearch(index, search, sortName, sortType);
				System.out.println(list);
				request.setAttribute("sort", sort);
				request.setAttribute("listProduct", list);
				request.setAttribute("endPage", endPage);
				request.setAttribute("tag", index);
				request.setAttribute("search", search);
				request.setAttribute("cid", cid);
			} else {
				int count = ProductDAO.getTotalProduct(cid);
				int endPage = count / 12;
				if (count % 12 != 0) {
					endPage++;
				}
				StringTokenizer s = new StringTokenizer(sort, "-");
				String sortName = s.nextToken();
				String sortType = s.nextToken();
				List<Product> list = ProductDAO.pagingProduct(index, cid, sortName, sortType);
				request.setAttribute("listProduct", list);
				request.setAttribute("endPage", endPage);
				request.setAttribute("tag", index);
				request.setAttribute("cid", cid);
				request.setAttribute("search", search);
				request.setAttribute("sort", sort);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.getRequestDispatcher("/client/ListProduct.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
