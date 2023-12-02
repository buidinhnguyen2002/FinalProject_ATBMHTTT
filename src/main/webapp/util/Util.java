package util;

import entity.Account;
import entity.Permission;
import entity.Role;
import org.apache.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.StringTokenizer;

public class Util {
    public static String getURL(HttpServletRequest httpRequest) {
        String requestedResource = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        StringTokenizer stringTokenizer = new StringTokenizer(requestedResource, "/");
        if (stringTokenizer.hasMoreTokens()) {
            requestedResource = "/" + stringTokenizer.nextToken();
        } else {
            requestedResource = "";
        }
        return requestedResource;
    }

    public static void main(String[] args) {
        // Lấy tệp tin bundle tương ứng với Locale của người dùng
        ResourceBundle bundle = ResourceBundle.getBundle("app", Locale.forLanguageTag("vi_VN"));
        // Lấy giá trị của khóa "Come" từ tệp tin bundle và gán vào biến message
        String message = bundle.getString("Come");
        System.out.println(message);

    }
    // Kiểm tra xem người dùng có quyền truy cập vào tài nguyên hay không

}
