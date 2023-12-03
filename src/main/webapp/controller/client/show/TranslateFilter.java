package controller.client.show;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class TranslateFilter  implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private  ServletContext context;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.context = filterConfig.getServletContext();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		request.setCharacterEncoding("UTF-8");

		String lang = request.getParameter("lang");
		String url = req.getRequestURL().toString();

		if (lang != null) {
			req.getSession().setAttribute("LANG", lang);
		} else {
			req.getSession().setAttribute("LANG", "vi");
		}
		chain.doFilter(request, response);
	}


	@Override
	public void destroy() {

	}
}
