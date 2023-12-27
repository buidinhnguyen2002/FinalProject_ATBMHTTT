package util;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.payments.CapturesRefundRequest;
import com.paypal.payments.Refund;
import java.io.IOException;

public class PayPalRefundExample {

    public static void main(String[] args) {
        // Set your PayPal environment (sandbox or live)
        PayPalEnvironment environment = new PayPalEnvironment.Sandbox(
                "Abo90Wztq8vanhzw0EO5zMhum7b1O6aI_1x4BTA8v7jqNIOGdthWxF-ZZpjhtEGg6CW0VWRdgg_hjdlb",
                "EEpPKUqIRD0gJPVKHVai84Yi0lauKUq3brqUN2AYkeIq1GHGbBJy_fA_q3bvj8Ha7cFZByFGKRvYyzro");

        // Create a PayPal HTTP client
        PayPalHttpClient client = new PayPalHttpClient(environment);

        // Specify the capture ID you want to refund
        String captureId = "72N79273JF674132A";

        // Refund the capture
        refundCapture(client, captureId);
    }

    private static void refundCapture(PayPalHttpClient client, String captureId) {
        CapturesRefundRequest refundRequest = new CapturesRefundRequest(captureId);

        try {
            HttpResponse<Refund> refundResponse = client.execute(refundRequest);
            if (refundResponse.statusCode() == 201) {
                System.out.println("Refund successful");
            } else {
                System.out.println("Refund failed. Status Code: " + refundResponse.statusCode());
                System.out.println("Error Response: " + refundResponse.result());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}