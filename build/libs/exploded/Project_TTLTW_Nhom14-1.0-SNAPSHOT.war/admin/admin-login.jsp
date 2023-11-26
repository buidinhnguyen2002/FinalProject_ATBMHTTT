<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url value="/admin/assets" var="url"/>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng nhập quản trị | Website quản trị v2.0</title>
    <meta charset="UTF-8">
    <link rel="icon" href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/favicon.png?1564585558451"
          type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${url}/css/login.css">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
    <script src="${url}/js/jquery.min.js"></script>
    <script src="${url}/js/bootstrap.min.js"></script>
    <script src="${url}/js/select2.min.js"></script>
    <script>
        function RegexEmail(emailInputBox) {
            var emailStr = document.getElementById(emailInputBox).value;
            var emailRegexStr = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            var isvalid = emailRegexStr.test(emailStr);
            if (!isvalid) {
                swal({
                    title: "",
                    text: "Bạn vui lòng nhập đúng định dạng email...",
                    icon: "error",
                    close: true,
                    button: "Thử lại",
                });

                emailInputBox.focus;
            } else {
                swal({
                    title: "",
                    text: "Chúng tôi vừa gửi cho bạn email hướng dẫn đặt lại mật khẩu vào địa chỉ cho bạn",
                    icon: "success",
                    close: true,
                    button: "Đóng",
                });
                emailInputBox.focus;
                window.location = "#";
            }
        }
    </script>
</head>

<body>
<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <div class="login100-pic js-tilt" data-tilt>
                <img src="${url}/images/team.jpg" alt="IMG">
            </div>
            <!--=====TIÊU ĐỀ======-->
            <form
                    action="${pageContext.request.contextPath}/admin/AdminLoginController"
                    method="post">
                    <span class="login100-form-title">
                        <b>ĐĂNG NHẬP HỆ THỐNG POS</b>
                    </span>
                <!--=====FORM INPUT TÀI KHOẢN VÀ PASSWORD======-->
                <form action="">
                    <div class="wrap-input100 validate-input">
                        <input class="input100" type="text" placeholder="Tài khoản quản trị" name="admin-username"
                               id="username">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                                <i class='bx bx-user'></i>
                            </span>
                    </div>
                    <div class="wrap-input100 validate-input">
                        <input autocomplete="off" class="input100" type="password" placeholder="Mật khẩu"
                               name="admin-password" id="password-field">
                        <span toggle="#password-field" class="bx fa-fw bx-hide field-icon click-eye"></span>
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                                <i class='bx bx-key'></i>
                            </span>
                    </div>

                    <!--=====ĐĂNG NHẬP======-->
                    <div class="container-login100-form-btn">
                        <input type="submit" value="Đăng nhập" id="submit"/>
                    </div>
                    <b> <span style="color: red"> ${errorMessage}</span></b>
                    <!--=====LINK TÌM MẬT KHẨU======-->
                    <div class="text-right p-t-12">
                        <a class="txt2" href="${pageContext.request.contextPath}/admin/admin-fogot.jsp">
                            Bạn quên mật khẩu?
                        </a>
                    </div>
                    <!--=====FOOTER======-->
                    <div class="text-center p-t-70 txt2">
                        Phần mềm quản lý bán hàng <i class="far fa-copyright" aria-hidden="true"></i>
                        <script type="text/javascript">document.write(new Date().getFullYear());</script>
                        <a
                                class="txt2" href="https://www.facebook.com/truongvo.vd1503/"> Code bởi Long </a>
                    </div>
                </form>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    //show - hide mật khẩu
    function myFunction() {
        var x = document.getElementById("myInput");
        if (x.type === "password") {
            x.type = "text"
        } else {
            x.type = "password";
        }
    }

    $(".click-eye").click(function () {
        $(this).toggleClass("bx-show bx-hide");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });
</script>
</body>

</html>
