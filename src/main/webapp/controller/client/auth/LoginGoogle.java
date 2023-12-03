package controller.client.auth;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.client.AuthDAO;
import entity.Account;
import entity.Google;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import util.Constants;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class LoginGoogle
 */
@WebServlet("/LoginGoogle")
public class LoginGoogle extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginGoogle() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        Google user = getUserInfo(accessToken);
        String pid = request.getParameter("pid");
        HttpSession session = request.getSession();
        Account cus = AuthDAO.loginGG(user.getId());
        if (cus == null) {
            AuthDAO.signUpGoogle(user.getId(), user.getName(), user.getEmail(), user.getPicture());
            cus = AuthDAO.loginGG(user.getId());
        }
        cus.setRoles(AuthDAO.getRoles(cus.getId()));
        cus.setResources(AuthDAO.getResources(cus.getId()));
//        cus.setPermissions(AuthDAO.getPermissions(cus.getId()));
        session.setAttribute("acc", cus);
        session.setMaxInactiveInterval(1800);
        if (pid == null) {
            response.sendRedirect("IndexControl");
        } else {
            response.sendRedirect("DetailControl?pid=" + pid);
        }
    }

    public static String getToken(String code) {
        try {
            String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                    .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                            .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                            .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                            .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                    .execute().returnContent().asString();
            JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
            String accessToken;
            accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
            return accessToken;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    static Google getUserInfo(String accessToken) throws IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, Google.class);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        doGet(request, response);
    }

}