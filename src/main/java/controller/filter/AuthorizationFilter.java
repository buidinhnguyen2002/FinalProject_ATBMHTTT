package controller.filter;

import entity.Account;
import entity.Permission;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.StringTokenizer;

@WebFilter(filterName = "AuthorizationFilter", urlPatterns = {"/AuthorizationFilter"})
public class AuthorizationFilter implements Filter {
    private ServletContext context;
    private final String[] ALLOWED_PATHS = {"/IndexControl", "/client", "/Login", "/DetailControl", "/LoginGoogle",
            "/Register", "/SubmitEmail", "/VerifyEmailControl", "/SearchControl", "/ShowProductControl", "/ErrorPageController", "/LogoutControl", "/images", "/sweetalert2" +
            "/@sweetalert2", "/observer","/ForgetPasswordController", "/rating-product", "/Commentcontrol", "/Replycontrol", "/Showmorecontrol", "/Index.jsp", "/HadKeyControl", "/CreateNewKeyControl", ""};

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.context = filterConfig.getServletContext();
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestedResource = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        boolean admin_login = false;
        if (requestedResource.equals("/admin/admin-login.jsp")||requestedResource.equals("/admin/AdminLoginController")) {
            admin_login = true;
        }
        StringTokenizer stringTokenizer = new StringTokenizer(requestedResource, "/");
        if (stringTokenizer.hasMoreTokens()) {
            requestedResource = "/" + stringTokenizer.nextToken();
        } else {
            requestedResource = "";
        }

        for (String allowedPath : ALLOWED_PATHS) {
            if (requestedResource.equals(allowedPath)||admin_login) {
                chain.doFilter(request, response);
                return;
            }
        }
        if (session != null) {
            // session hợp lệ
            Account account = (Account) session.getAttribute("acc");
            if (account == null) {
                request.getRequestDispatcher("/client/Index.jsp").forward(request, response);
            } else {
                boolean resourceName = false;
                for (Permission permission : account.getPermissions()
                ) {
                    if (permission.getAction().equalsIgnoreCase("read") && permission.getResource().getUrl().equalsIgnoreCase(requestedResource)) {
                        resourceName = true;
                    }
                }
                if (resourceName) {
                    chain.doFilter(request, response);
                } else {
                    request.getRequestDispatcher("/client/404.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    public void destroy() {

    }
}
