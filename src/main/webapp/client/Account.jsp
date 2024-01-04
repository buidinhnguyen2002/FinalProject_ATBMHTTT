<%@ page import="dao.client.AuthDAO" %>
<%@ page import="entity.Account" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/><%
    response.setHeader("Cache-control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session.getAttribute("acc") == null) {
        response.sendRedirect(request.getContextPath() + "/client/Login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title><fmt:message key="account.information" bundle="${lang}"></fmt:message></title>
    <link rel="icon" type="image" href="../images/HaLoicon.png"/>
    <jsp:include page="./link/Link.jsp"></jsp:include>

    <style>
        #loadingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.7); /* Màu nền với độ mờ */
            z-index: 9999; /* Đảm bảo nó ở trên cùng */
            display: flex;
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        #loadingOverlay img {
            max-width: 50%; /* Đảm bảo tập tin GIF không vượt quá kích thước màn hình */
            max-height: 50%; /* Đảm bảo tập tin GIF không vượt quá kích thước màn hình */
        }
    </style>
</head>
<body>
<!-- Load page -->
<div id="preloder">
    <div class="loader"></div>
</div>
<div class="page">
    <jsp:include page="./header/Header.jsp"></jsp:include>
    <div id="add_succes" style="display: none;">
        <p>
            <i class="fa fa-check fa-2x"></i>
            <fmt:message key="successfully.added.the.product" bundle="${lang}"></fmt:message>
        </p>
    </div>

    <!-- Main Breadcrumb -->
    <div class="main-breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ol class="breadcrumb">
                        <li><a href="#"> <fmt:message key="Home"
                                                      bundle="${lang}"></fmt:message></a></li>
                        <li class="active"><fmt:message key="account"
                                                        bundle="${lang}"></fmt:message></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- End Main Breadcrumb -->
    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <div class="col-sm-3">
                <h3>
                    <fmt:message key="account.information" bundle="${lang}"></fmt:message>
                </h3>
                <div class="">
                    <form action="${pageContext.request.contextPath}/account/EditControl?editInfo"
                          method="post">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <td><fmt:message key="Full.name" bundle="${lang}"></fmt:message>:</td>
                                <td class="colum-account"><label for="input-account-name"></label><input
                                        class="input-account"
                                        id="input-account-name" type="text"
                                        value="${sessionScope.acc.fullName}" name="name" size="70"
                                        readonly/></td>
                                <div class="row">
                                    <p style="color: red; display: none;" class="col-md-11"
                                       id="errorName"></p>
                                </div>
                            </tr>

                            <tr>
                                <td class="colum-account"><fmt:message key="Email"
                                                                       bundle="${lang}"></fmt:message>:
                                </td>
                                <td><label for="input-account-email"></label><input class="input-account"
                                                                                    id="input-account-email"
                                                                                    type="text"
                                                                                    value="${sessionScope.acc.email}"
                                                                                    name="email"
                                                                                    readonly size="70"/></td>
                            </tr>

                            <tr>
                                <td class="colum-account"><fmt:message key="Address"
                                                                       bundle="${lang}"></fmt:message>:
                                </td>
                                <td><label for="input-account-address"></label><textarea name="address"
                                                                                         id="input-account-address"
                                                                                         rows="9" cols="70"
                                                                                         class="textarea-account"
                                                                                         readonly> ${sessionScope.acc.address}
                                </textarea></td>
                                <div class="row">
                                    <p style="color: red; display: none;" class="col-md-11"
                                       id="errorAddress"></p>
                                </div>
                            </tr>

                            <tr>
                                <td class="colum-account"><fmt:message key="Phone.number"
                                                                       bundle="${lang}"></fmt:message>:
                                </td>
                                <td><label for="input-account-phoneNumber"></label><input class="input-account"
                                                                                          type="text"
                                                                                          id="input-account-phoneNumber"
                                                                                          value="${sessionScope.acc.phone}"
                                                                                          size="70"
                                                                                          name="phoneNumber" readonly/>
                                </td>
                                <div class="row">
                                    <p style="color: red; display: none;" class="col-md-11"
                                       id="errorNumberPhone"></p>
                                </div>
                            </tr>
                            <tr>
                                <td class="colum-account"><fmt:message key="Status.key"
                                                                       bundle="${lang}"></fmt:message>:
                                </td>
                                <td><label for="input-account-phoneNumber"></label>
                                    <%
                                        Account account = (Account) session.getAttribute("acc");
                                        boolean checkKey = AuthDAO.isCheckHaveKey(account.getId());
                                    %>
                                    <c:if test="<%= checkKey %>">
                                        <p id="status-key" size="60" style="color: #2ba02b" readonly>
                                            <fmt:message key="Key.actived"
                                                         bundle="${lang}"></fmt:message>
                                        </p>
                                    </c:if>
                                    <c:if test="<%= !checkKey %>">
                                        <p  id="status-key" size="60" style="color: firebrick" readonly>
                                            <fmt:message key="Key.do.not.active"
                                                         bundle="${lang}"></fmt:message>
                                        </p>
                                    </c:if>
                                </td>
                            </tr>
                            </tbody>
                            <div class="row">
                                <p style="color: green;">${sucinfo}</p>
                            </div>
                        </table>
                        <ul class="checkout">
                            <li>
                                <button id="btn-change-info" type="button" class="btn-cart"
                                        title="Thay đổi thông tin">
										<span><fmt:message key="Change.information"
                                                           bundle="${lang}"></fmt:message></span>
                                </button>
                            </li>
                            <li>
                                <button type="button" id="btn-change-pass" class="btn-cart"
                                        title="Thay đổi Mật khẩu">
										<span><fmt:message key="Change.the.password"
                                                           bundle="${lang}"></fmt:message></span>
                                </button>

                            </li>
                            <li>
                                <button type="button" id="btn-change-report" class="btn-cart"
                                        title="Kch hoạt/Tạo key">
										<span><fmt:message key="Report.key"
                                                           bundle="${lang}"></fmt:message></span>
                                </button>

                                <div id="dialog-confirm" title="Tạo key mới" style="display:none;">
                                    <p>Thông báo: Bạn có muốn tạo key mới không?</p>
                                </div>

                                <div id="dialog-confirm1" title="Thông báo" style="display:none;">
                                    <p>Key đã được gửi vào email của bạn. Xin hãy check email!</p>
                                </div>

                                <div id="dialog-inputs" title="Nhập key" style="display:none;">
                                    <form id="keyForm" action="${pageContext.request.contextPath}/auth/HadKeyControl"
                                          method="post">
                                        <input type="text" name="input" id="input" placeholder="Public key"
                                               style="width: 500px; height: 30px;">
                                        <div id="dialog-warning" title="Cảnh báo" style="display:none;">
                                            <p id="warning-message"></p>
                                        </div>
                                    </form>
                                </div>


                            </li>

                            <li>
                                <button type="submit" id="btn-confirm1" style="display: none;"
                                        class="btn-cart" title="Cập nhật">
                                    <span><fmt:message key="update" bundle="${lang}"></fmt:message></span>
                                </button>
                            </li>
                        </ul>
                    </form>
                    <form
                            action="${pageContext.request.contextPath}/account/EditControl?editPassword"
                            method="post">
                        <table id="table-pass" style="display: none;"
                               class="table table-bordered">
                            <tbody>
                            <tr>
                                <td class="colum-account"><fmt:message key="old.password"
                                                                       bundle="${lang}"></fmt:message>:
                                </td>
                                <td><label>
                                    <input class="input-account" type="password" value=""
                                           name="oldpass" required="required" size="70"/>
                                </label></td>
                            </tr>

                            <tr>
                                <td class="colum-account"><fmt:message key="new.password"
                                                                       bundle="${lang}"></fmt:message>:
                                </td>
                                <td><input class="input-account" type="password"
                                           size="70" value="" id="newpass" name="newpass" required="required"/></td>
                            </tr>
                            <tr>
                                <td class="colum-account"><fmt:message
                                        key="enter.new.password" bundle="${lang}"></fmt:message>:
                                </td>
                                <td class="colum-account"><input size="70"
                                                                 class="input-account" type="password" value=""
                                                                 name="renewpass" id="renewpass" required="required"/>
                                </td>
                            </tr>
                            <div class="row">
                                <p style="color: red; display: none;" class="col-md-11"
                                   id="errorPass"></p>
                            </div>
                            <div class="row">
                                <p style="color: red;" class="col-md-11" id="errorpass2">${errorpass}</p>
                            </div>
                            <div class="row">
                                <p style="color: red;">${error}</p>
                            </div>
                            <div class="row">
                                <p style="color: green;">${suc}</p>
                            </div>
                            </tbody>
                        </table>
                        <button type="submit" id="btn-confirm" style="display: none;"
                                class="btn-cart" title="Cập nhật">
                            <span><fmt:message key="update" bundle="${lang}"></fmt:message></span>
                        </button>
                    </form>
                </div>
                <!--inner-->
            </div>
        </div>
    </div>
</div>
<!-- Tập tin GIF sẽ được hiển thị ở đây -->
<div id="loadingOverlay" style="display:none;">
    <img src="../images/loading.gif" alt="Loading..."/>
</div>
<!-- End Main Content -->
<jsp:include page="./footer/Footer.jsp"></jsp:include>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- jQuery UI -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
    $("#btn-change-pass").click(function () {
        $("#table-pass").css("display", "table");
        $("#btn-change-pass").css("display", "none");
        $("#btn-confirm").css("display", "block");
    });
    $("#btn-change-info").click(function () {
        $("#btn-confirm1").css("display", "block");
        $("#btn-change-info").css("display", "none");
        $("#input-account-name").attr('readonly', false);
        $("#input-account-address").attr('readonly', false);
        $("#input-account-phoneNumber").attr('readonly', false);
    });
    $(document)
        .ready(
            function () {
                $('#input-account-name')
                    .blur(
                        function () {
                            var name = $('#input-account-name').val();
                            if (name != '') {
                                if (name.length < 5) {
                                    $('#errorName')
                                        .text(
                                            "<fmt:message key="Please.enter.your.full.name" bundle="${lang}"></fmt:message>");
                                    $('#errorName').css(
                                        "display",
                                        "block");
                                } else {
                                    $('#errorName')
                                        .text("");
                                    $('#errorName').css(
                                        "display",
                                        "none");
                                }
                            } else {
                                $('#errorName')
                                    .text(
                                        "<fmt:message key="Please.enter.full.information" bundle="${lang}"></fmt:message>");
                                $('#errorName').css(
                                    "display", "block");
                            }
                        });
                $('#input-account-email')
                    .blur(
                        function () {
                            var email = $('#input-account-email').val();
                            var vnf_regex = /^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                            if (email != '') {
                                if (vnf_regex.test(email) == false) {
                                    $('#errorEmail')
                                        .text(
                                            "<fmt:message key="Please.enter.the.correct.email.format.abc@def.jhi" bundle="${lang}"></fmt:message>");
                                    $('#errorEmail').css(
                                        "display",
                                        "block");
                                    $('#erroremail').text("");
                                    $('#erroremail').hide();
                                } else {
                                    $('#errorEmail').text(
                                        "");
                                    $('#errorEmail').css(
                                        "display",
                                        "none");
                                    $('#erroremail').text("");
                                    $('#erroremail').hide();
                                }
                            } else {
                                $('#errorEmail')
                                    .text(
                                        "<fmt:message key="Please.enter.full.information" bundle="${lang}"></fmt:message>");
                                $('#errorEmail').css(
                                    "display", "block");

                                $('#erroremail').text("");
                                $('#erroremail').hide();

                            }
                        });
                $('#input-account-address')
                    .blur(
                        function () {
                            var address = $('#input-account-address')
                                .val();
                            if (address != '') {
                                if (address.length < 25) {
                                    $('#errorAddress')
                                        .text(
                                            "<fmt:message key="Please.enter.the.full.address.house.number,.street.name,.ward,.city,.province" bundle="${lang}"></fmt:message>");
                                    $('#errorAddress').css(
                                        "display",
                                        "block");
                                } else {
                                    $('#errorAddress')
                                        .text("");
                                    $('#errorAddress').css(
                                        "display",
                                        "none");
                                }
                            } else {
                                $('#errorAddress')
                                    .text(
                                        "<fmt:message key="Please.enter.full.information" bundle="${lang}"></fmt:message>");
                                $('#errorAddress').css(
                                    "display", "block");
                            }
                        });
                $('#input-account-phoneNumber')
                    .blur(
                        function () {
                            var mobile = $('#input-account-phoneNumber').val();
                            var vnf_regex = /((09|03|07|08|05)+([0-9]{8})\b)/g;
                            if (mobile != '') {
                                if (vnf_regex.test(mobile) == false
                                    || mobile.length > 10) {
                                    $('#errorNumberPhone')
                                        .text(
                                            "<fmt:message key="Please.enter.the.correct.phone.number.format" bundle="${lang}"></fmt:message>");
                                    $('#errorNumberPhone')
                                        .css("display",
                                            "block");
                                } else {
                                    $('#errorNumberPhone')
                                        .text("");
                                    $('#errorNumberPhone')
                                        .css("display",
                                            "none");
                                }
                            } else {
                                $('#errorNumberPhone')
                                    .text(
                                        "<fmt:message key="Please.enter.full.information" bundle="${lang}"></fmt:message>");
                                $('#errorNumberPhone').css(
                                    "display", "block");
                            }
                        });
                $('#newpass')
                    .blur(
                        function () {
                            var pass = $('#newpass').val();
                            var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+[\]{};':"\\|,.<>\/?])[A-Za-z\d!@#$%^&*()_+[\]{};':"\\|,.<>\/?]{8,}$/;
                            if (pass != '') {
                                if (regex.test(pass) == false
                                    || pass.length < 8) {
                                    $('#errorPass')
                                        .text(
                                            "<fmt:message key="Please.enter.a.password.with.at.least.1.uppercase.and.1.numeric.character" bundle="${lang}"></fmt:message>");
                                    $('#errorPass').show();

                                } else {
                                    $('#errorPass')
                                        .text("");
                                    $('#errorPass').hide();

                                }
                            } else {
                                $('#errorPass')
                                    .text(
                                        "<fmt:message key="Please.enter.full.information" bundle="${lang}"></fmt:message>");
                                $('#errorPass').show();

                                $('#errorpass2').text("");
                                $('#errorpass2').hide();
                            }
                        });
                $('#renewpass')
                    .blur(
                        function () {
                            var repass = $('#renewpass').val();
                            var pass = $('#pass').val();
                            if (repass != '') {
                                if (repass != pass) {
                                    $('#errorRepass')
                                        .text(
                                            "<fmt:message key="Please.enter.the.matching.password" bundle="${lang}"></fmt:message>");
                                    $('#errorRepass').css(
                                        "display",
                                        "block");
                                } else {
                                    $('#errorRepass').text(
                                        "");
                                    $('#errorRepass').css(
                                        "display",
                                        "none");
                                }
                            } else {
                                $('#errorRepass')
                                    .text(
                                        "<fmt:message key="Please.enter.full.information" bundle="${lang}"></fmt:message>");
                                $('#errorRepass').css(
                                    "display", "block");
                            }
                        });
            });
</script>
<script>
    $(document).ready(function () {
        // Xử lý sự kiện click cho nút
        $("#btn-change-report").click(function () {
            // Hiển thị dialog
            $("#dialog-confirm").dialog({
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "Nhập key": function () {
                        $(this).dialog("close");
                        let previousDialog = $("#dialog-confirm");
                        previousDialog.dialog("open");

                        $("#dialog-warning").dialog({
                            autoOpen: false,  // Khởi tạo dialog ở trạng thái đóng
                            modal: true,
                            buttons: {
                                OK: function () {
                                    $(this).dialog("close");
                                }
                            }
                        });

                        $("#dialog-inputs").dialog({
                            resizable: false,
                            height: "auto",
                            width: 550,
                            modal: true,
                            buttons: {
                                "OK": function () {
                                    // Lấy giá trị từ trường input
                                    let inputValue = $("#input").val();
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/HadKeyControl",  // URL của servlet
                                        type: "POST",
                                        data: {input: inputValue},  // Truyền giá trị từ trường input
                                        success: function (data) {
                                            let isSuc = JSON.parse(data).isSuc;
                                            console.log(data);
                                            console.log(isSuc)
                                            if (!isSuc) {
                                                $("#input").val("");  // Xóa giá trị trong input
                                                $("#dialog-inputs").dialog("open");
                                                $("#dialog-warning").text("Key không hợp lệ").dialog("open");
                                            } else {
                                                $("#dialog-warning").text("Cập nhật thành công!").dialog("open");
                                                $("#status-key").html('<fmt:message key="Key.actived" bundle="${lang}"></fmt:message>').css("color", "#2ba02b");
                                                $("#input").val("");
                                            }
                                            console.log("Account (Đã có key): Dữ liệu đã được gửi đến servlet.");
                                        },
                                        error: function (data) {
                                            console.log("Account (Đã có key): Đã xảy ra lỗi khi gửi dữ liệu đến servlet.");
                                        }
                                    });
                                    // Đóng dialog
                                    $(this).dialog("close");
                                    previousDialog.dialog("close");
                                },
                                "Hủy": function () {
                                    $(this).dialog("close");
                                    if ($("#dialog-confirm")) {
                                        $("#dialog-confirm").dialog("open");
                                    }
                                }
                            }
                        });
                    },

                    "Tạo key": function () {
                        $(this).dialog("close");

                        function showLoading() {
                            document.getElementById('loadingOverlay').style.display = 'flex';
                        }

                        function hideLoading() {
                            document.getElementById('loadingOverlay').style.display = 'none';
                        }

                        showLoading();
                        $.ajax({
                            url: "${pageContext.request.contextPath}/CreateNewKeyControl",  // URL của servlet
                            type: "POST",
                            success: function () {
                                console.log("Account (Tạo key): Dữ liệu đã được gửi đến servlet.");

                                hideLoading();

                                $("#dialog-confirm1").dialog({
                                    resizable: false,
                                    height: "auto",
                                    width: 500,
                                    modal: true,
                                    buttons: {
                                        "OK": function () {
                                            $("#status-key").html('<fmt:message key="Key.actived" bundle="${lang}"></fmt:message>').css("color", "#2ba02b");
                                            $(this).dialog("close");
                                        }
                                    }
                                });
                            },
                            error: function () {
                                console.log("Account (Tạo key): Đã xảy ra lỗi khi gửi dữ liệu đến servlet.");
                            }
                        });
                    },
                    "Hủy": function () {
                        $(this).dialog("close");
                    }
                }
            });
        });
    });
</script>
</body>
</html>