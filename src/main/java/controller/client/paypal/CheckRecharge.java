package controller.client.paypal;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.orders.Order;
import com.paypal.orders.OrdersCaptureRequest;
import entity.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@WebServlet("/cart/CheckRecharge")
public class CheckRecharge extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        reader.close();

        String jsonString = jsonBuilder.toString();
        Gson gson = new Gson();
        JsonObject data = gson.fromJson(jsonString, JsonObject.class);
        double selectedValue = data.get("balance").getAsDouble();
        String orderID = data.get("orderID").getAsString();

        PayPalEnvironment environment = new PayPalEnvironment.Sandbox(
                "Abo90Wztq8vanhzw0EO5zMhum7b1O6aI_1x4BTA8v7jqNIOGdthWxF-ZZpjhtEGg6CW0VWRdgg_hjdlb",
                "EEpPKUqIRD0gJPVKHVai84Yi0lauKUq3brqUN2AYkeIq1GHGbBJy_fA_q3bvj8Ha7cFZByFGKRvYyzro");
        PayPalHttpClient client = new PayPalHttpClient(environment);
        OrdersCaptureRequest request1 = new OrdersCaptureRequest(orderID);

        try {
            HttpResponse<Order> response1 = client.execute(request1);
            if (response1.statusCode() == 201) {
                Order capturedOrder = response1.result();
                // Extract Transaction ID from the captured order
                String transactionId = capturedOrder.purchaseUnits().get(0).payments().captures().get(0).id();
                System.out.println("Transaction ID: " + transactionId);
                HttpSession session = request.getSession();
                Account user = (Account) session.getAttribute("acc");
                session.setAttribute("isPay","Payed");
                session.setAttribute("transactionId",transactionId);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(new Gson().toJson(capturedOrder));
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
