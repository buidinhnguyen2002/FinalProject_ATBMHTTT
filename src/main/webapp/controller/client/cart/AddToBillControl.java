package controller.client.cart;

import java.io.IOException;
import java.security.Signature;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.client.OrderDAO;
import entity.*;
import util.API;

@WebServlet("/cart/AddBillControl")
public class AddToBillControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String provinceId = request.getParameter("provinceId");
        String districtId = request.getParameter("districtId");
        String wardId = request.getParameter("wardId");
        String feeShip = API.feeShip("1540", "440505", districtId, wardId, "20", "20", "20", "100");
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("ship", feeShip);
        response.getWriter().println(jsonObject);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            Object obj = session.getAttribute("cart");// luu tam vao session
            String ship = request.getParameter("shipFee");
            String districtId = request.getParameter("calc_shipping_district");
            String wardId = request.getParameter("calc_shipping_ward");
            String reductionCode = request.getParameter("reductionCode");
            boolean isSuc = false;
            int idProductSizeColor;
            int quantitySizeColor;
            int newQuantitySizeColor = 0;
            int totalQuantity = 0;
            if (obj != null) {// KIEM TRA XEM CO SP TRONG GIO HANG KO?
                Map<String, List<OrderDetail>> map = (Map<String, List<OrderDetail>>) obj;
//			 TAO HOA DON TRUOC, DE LAY DUOC ID BILL
                Order order = new Order();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Account account = (Account) session.getAttribute("acc");
                order.setAccount(account);
                order.setStatus("Đang xử lý");
                int idOrder = OrderDAO.createOrder(order.getAccount().getId());
                order.setId(idOrder);
                String statusPay = (String) session.getAttribute("isPay");
                if (statusPay == null) {
                    order.setStatusPay("Chưa thanh toán");
                } else {
                    if (session.getAttribute("isPay").equals("Payed")) {
                        order.setStatusPay("Đã thanh toán");
                    }
                }
                String address = request.getParameter("billingAddress");
                if (address != null || !address.isEmpty()) {
                    order.setAddress(address);
                } else {
                    order.setAddress(account.getAddress());
                }

                float total = 0;// tinh tong gia
                for (Map.Entry<String, List<OrderDetail>> entry : map.entrySet()) {
                    List<OrderDetail> orderDetails = entry.getValue();
                    for (OrderDetail orderDetail : orderDetails) {
                        orderDetail.setIdOrder(order.getId());// set bill id vao day
                        // cap nhat so luong cua tung san pham
                        idProductSizeColor = OrderDAO.getIdSizeColor(orderDetail.getProduct().getId(), orderDetail.getProductSize(), orderDetail.getProductColor());
                        quantitySizeColor = OrderDAO.getQuantitySizeColor(orderDetail.getProduct().getId(), idProductSizeColor);
                        newQuantitySizeColor = quantitySizeColor - orderDetail.getQuantity();
                        if (newQuantitySizeColor >= 0) {
                            // luu lai cac mat hang
                            OrderDAO.createOrderDetail(orderDetail);
                            OrderDAO.updateInventoryProduct(String.valueOf(orderDetail.getProduct().getId()), newQuantitySizeColor, idProductSizeColor);
                        } else {
                            OrderDAO.deleteOrder(idOrder);
                            request.setAttribute("sorry", "Xin lỗi chúng tôi không đủ số lượng sản phẩm này");
                            request.getRequestDispatcher("CartControl").forward(request, response);
                            return;
                        }
                        // tinh tong gia
                        total += orderDetail.getQuantity() * orderDetail.getPrice();
                        totalQuantity += orderDetail.getQuantity();
                        //Thêm phieu giam vào
                        int discount = OrderDAO.checkDiscount(reductionCode);
                        if (discount > 0) {
                            total = total - (total * ((float) discount / 100));
                        }
                    }
                }
                /// cap nhat lai bill de co tong gia tien
                if (ship != null && !ship.isEmpty()) {
                    order.setTotalPrice(total + Integer.parseInt(ship)); // vi du cua phi van chyen
                }
                order.setNote(request.getParameter("note"));
                order.setWardId(wardId);
                order.setDistrictId(districtId);
                String orderInfo  = order.orderInfo();
                String hashOrder = SHA.hashText(orderInfo);
                String signature = ElectronicSignature.doSignature("MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEi0knDTIzYRxzyWZ/sXwMcYc3++k9AhuAiTBf3NfdmJOF/tzRfKPxB+M/nR4PuDPJLnTQv9ptmUoDP35xZ2jhPZQPab1MIMS54d8XyPbIH2oN7h+7UuF2dh6l4fSzbynJhJklS43FMkWgWwLuPgsIztnDOHYGahZXEVGwrYfVbsgjlmoqZeDM0xn4iPKhTGEXW2ZSvRv/2AhArGh36DrfCirtZDaKV84Ddanrn4elPvzY0LCjPzaOUWuhvBjdd84vn97cLMGheC5KDjZHvVa9IbSuOX+09qtatxR+jvHlmFvqxfxIG192b6p1kfyyXl/XNYebxA2FBFMX1AUqSFbjAgMBAAECggEAFXcW0q6ExIq/FkAxMxH5t8wwVeNryi9wPH3/LAENDFUNC43VpQVlTD4tyfVJYrMd6MNrm57QZrbel/M3xn/iOvNEN9i3BVjw01JBULIwjZOsu/+9NHKtUAg/eaNvW6dw22LhbOrO/XHrm8NE0yswflJFAyan8TRl4zVvhAm3s434R4v5cl/byE8c3Nj2fTpC8s0CeqYKIBsPktt2i7Dkd7K1gH6UL/1y3MRi97aQLdY8FI3M9SKZ8lEHm1qIh2ueZ3R34x1UUQWL8Z4/ex80sQzfBxFs6aMpKL3mhCGsb2O3ELhAzI3TrVpE4Z4V/RDSnJOfY7k+yYoWYvg2G6LyFQKBgQDmKz7yuPpzgRXJmhhWvO6IcHRH2uqT7bx6FWV7SswBYEVwc+4AeO3660u3Xy7obADNH9TxmYLHc33iBPypSf20ZtnNECuL9CXKvWykyVPOiwQe7EUtgPIwigD8tQfgS1RViANhD6vg1X5HzmWNrvHwEDQzXexYYkCyOQTRGGKP9QKBgQDamf97FCo8jsmzcauzi37Miu9MsNoIYOUcry7poTqe32LGMtr+xTCRQhLQ3uYejnpd56nEw1PHHJRpf3xS6SaXgGLypCKQh5xbB+4NRN/2T+zCvIT/fZGtDZWEpFdjr1OxPttfw+c3H+qijeNAUIaBEvut3Ei/bSnRAqBPfZI8dwKBgFy8Tddzqg0BlGquuGGyK5UzYdZVoK/LWGYD2uhrAXkIddHSE7GDB7dSOCaApiCk60m6KozRIf0ETlLTWY1Hr32Q9u4FNtZjnxppaa2XJDoSjq162oBz9KCT6cPnmG3JTAhODbZ8nu6udfuucAI+22Gy1aVgkUonBBQKnyMz5PpFAoGBAL93hvgMj3n/LteHRna6RdNuFW88r5wLEmHvZs2nNCsXSfKDdKEVohZ4ovZjZXd6H9/EG0SGOQj7FVraGNCd+flUsFYKQWQKA38QEQd6PhgFpUBj0rHdEA1dCorlTs23MTzb61WTxx7XS7IZSOR6I3VGZT7A5M8WFDxHapZ1S/K9AoGBANXOdAhsHuva7IQiQ+oKgMKwElDY/75CLyAJQVbCyAeYNmP4eCJaQiG0FpE9E0CjDDJG6KmEQ2md4QmmMV3ybVaWpTY27C3wz3BjvpiNLxUmIPhlWqlFXkgreogUIMXtV+PSHy9oAKpls0u8cmLHQLUMhl/cEmEee8V4hjHhMLS8", orderInfo);
                order.setSignature(signature);
                OrderDAO.updateOrder(order);
                request.setAttribute("order", order);
                request.setAttribute("ship", ship);
                request.setAttribute("cart", obj);
                session.removeAttribute("cart");
                session.removeAttribute("isPay");
                request.getRequestDispatcher("/client/CheckOut.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("CartControl").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
