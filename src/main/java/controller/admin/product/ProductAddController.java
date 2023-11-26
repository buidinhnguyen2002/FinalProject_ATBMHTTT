package controller.admin.product;

import dao.AuthDAO.SecurityDAO;
import dao.admin.*;
import entity.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, //2MB
        maxFileSize = 1024 * 1024 * 10, //10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet("/admin-products/ProductAddController")
public class ProductAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "upload"; // file save image

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> listCategory = ProductAdminDAO.getListCategory();
        request.setAttribute("listCategory", listCategory);

        List<Producer> listProducer = ProductAdminDAO.getListProducer();
        request.setAttribute("listProducer", listProducer);

        List<Supplier> listSupplier = ProductAdminDAO.getListSupplier();
        request.setAttribute("listSupplier", listSupplier);

        request.getRequestDispatcher("/admin/admin-add-product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Account account = (Account) request.getSession().getAttribute("admin");
            if (account == null) {
                RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-login.jsp");
                return;
            }
            if (SecurityDAO.hasPermission(SecurityDAO.getIdResource("/admin-products"), account.getAccountName(), "write")) {
                //Get imformation from form
                String nameProduct = request.getParameter("nameProduct");
                String category = request.getParameter("category");
                String producer = request.getParameter("producer");
                String price = request.getParameter("price");
                String sell = request.getParameter("sell");
                String description = request.getParameter("description");
                String supplier = request.getParameter("supplier");
                if (ProductAdminDAO.checkNameProductEq(nameProduct)) {
                    request.getSession().setAttribute("eqname", "Tên sản phẩm không được trùng nhau");
                    response.sendRedirect(request.getContextPath() + "/admin-products/ProductAddController");
                    return;
                }
                //Save informmation in CSDL
                int idCategory = ProductAdminDAO.getIdCategory(category);
                int idProducer = ProductAdminDAO.getIdProducer(producer);
                int idSupplier = ProductAdminDAO.getIdSupplier(supplier);
                int newProduct = ProductAdminDAO.insertProduct(nameProduct, idSupplier, idCategory, idProducer, description);
                int idProduct = ProductAdminDAO.getIdProduct(nameProduct);
                //get information from product table
                Enumeration<String> parameterNames = request.getParameterNames();

                while (parameterNames.hasMoreElements()) {
                    String paramName = parameterNames.nextElement();
                    if (paramName.startsWith("size")) {
                        SizeColorProduct sizeColorProduct = new SizeColorProduct(); // Tạo đối tượng mới trong mỗi vòng lặp
                        sizeColorProduct.setIdProduct(idProduct);
                        String size = request.getParameter(paramName);
                        sizeColorProduct.setSize(size);
                        // Xử lý các tham số "color" và "quantity" cho đối tượng hiện tại
                        String colorParamName = paramName.replace("size", "color");
                        String quantityParamName = paramName.replace("size", "quantity");
                        String color = request.getParameter(colorParamName);
                        sizeColorProduct.setColor(color);
                        String quantity = request.getParameter(quantityParamName);
                        sizeColorProduct.setQuantity(Integer.parseInt(quantity));
                        int setSizeColor = ProductAdminDAO.insertSizeColor(sizeColorProduct);
                        int setQuantity = ProductAdminDAO.insertQuantity(setSizeColor, sizeColorProduct);
                    }
                }
                int addPriceAndSell = ProductAdminDAO.insertPriceAndSell(idProduct, nameProduct, price, sell);

                //Save images
                String uploadPath = getServletContext().getRealPath("/images");
//                String uploadPath = "C:\\Users\\Admin\\OneDrive\\Documents\\GitHub\\TTLTW\\src\\main\\webapp\\images";
                System.out.println(uploadPath);
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                //Save main image
                Part mainImagePart = request.getPart(("mainImage"));
                String mainImageFileName = "main_" + System.currentTimeMillis() + "_" + getFileName(mainImagePart);
                mainImagePart.write(uploadPath + File.separator + mainImageFileName);
                int mainImage = ProductAdminDAO.getImage(idProduct, mainImageFileName);

                //Save description of product
                Collection<Part> descriptionImageParts = request.getParts();
                for (Part part : descriptionImageParts) {
                    if (part.getName().equals("descriptionImages")) {
                        String descriptionImageFileName = System.currentTimeMillis() + "_" + getFileName(part);
                        part.write(uploadPath + File.separator + descriptionImageFileName);
                        int childImage = ProductAdminDAO.getChildImage(idProduct, descriptionImageFileName);
                    }
                }
                request.getSession().removeAttribute("eqname");
                //Send redirect when save success
                response.sendRedirect(request.getContextPath() + "/admin-products/ProductListController");
            } else {
                request.getRequestDispatcher("/client/403.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

}