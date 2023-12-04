package util;

import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.payments.CapturesRefundRequest;
import com.paypal.payments.Refund;

import java.io.IOException;

public class PayPalRefundExample {
    public static boolean refundPayPal(String transactionId){
        try {
            // Set your PayPal environment (sandbox or live)
            PayPalEnvironment environment = new PayPalEnvironment.Sandbox(
                    "Abo90Wztq8vanhzw0EO5zMhum7b1O6aI_1x4BTA8v7jqNIOGdthWxF-ZZpjhtEGg6CW0VWRdgg_hjdlb",
                    "EEpPKUqIRD0gJPVKHVai84Yi0lauKUq3brqUN2AYkeIq1GHGbBJy_fA_q3bvj8Ha7cFZByFGKRvYyzro");

            // Create a PayPal HTTP client
            PayPalHttpClient client = new PayPalHttpClient(environment);

            // Refund the capture
            refundCapture(client, transactionId);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
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
    public static void main(String[] args) {
        System.out.println(refundPayPal("3LF4637600885772A"));;
    }
}
