<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html lang="vi">
<%
    response.setHeader("Cache-control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session.getAttribute("acc") == null) {
        response.sendRedirect(request.getContextPath() + "/client/Login.jsp");
    }
%>
<head>
    <meta charset="UTF-8"/>
    <title><fmt:message key="Cart" bundle="${lang}"></fmt:message></title>
    <link rel="icon" type="image" href="../images/HaLoicon.png"/>
    <jsp:include page="./link/Link.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>


<body>
<div class="page">
    <jsp:include page="./header/Header.jsp"></jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container" id="containerId">
            <div class="row cart cart_table">

                <h4>
                    <fmt:message key="Cart" bundle="${lang}"></fmt:message>
                </h4>
                <div class="col-md-12">
                    <div class="table-responsive">
                        <c:if test="${!empty sessionScope.cart}">
                            <table class="table table-bordered cart-table">
                                <thead>
                                <tr>
                                    <th class="text-center"><fmt:message key="PICTURE"
                                                                         bundle="${lang}"></fmt:message></th>
                                    <th class="text-center"><fmt:message
                                            key="PRODUCT'S.NAME" bundle="${lang}"></fmt:message></th>
                                    <th class="text-center"><fmt:message key="UNITPRICE"
                                                                         bundle="${lang}"></fmt:message></th>
                                    <th class="text-center"><fmt:message key="AMOUNT"
                                                                         bundle="${lang}"></fmt:message></th>
                                    <th class="text-center"><fmt:message key="INTO.MONEY"
                                                                         bundle="${lang}"></fmt:message></th>
                                    <th class="text-center"><fmt:message key="ERASE"
                                                                         bundle="${lang}"></fmt:message></th>
                                </tr>
                                </thead>
                                <c:forEach items="${sessionScope.cart.entrySet()}" var="entry">
                                    <c:forEach items="${entry.getValue()}" var="o">
                                        <tbody>
                                        <tr>
                                            <td class="text-center"><a
                                                    href="${pageContext.request.contextPath}/DetailControl?pid=${o.product.id}">
                                                <img
                                                        style="width: 73px; height: auto;"
                                                        src="${pageContext.request.contextPath}/images/${o.product.imageProducts.get(0).getImage()}">
                                            </a></td>
                                            <td class="text-center" valign="middle">
                                                <p class="">
                                                    <a href="${pageContext.request.contextPath}/DetailControl?pid=${o.product.id}">
                                                            ${o.product.nameProduct}</a>
                                                    <br>${o.productSize}/${o.productColor}
                                                </p>
                                            </td>
                                            <td class="text-center">

                                                <p class="">${o.price }
                                                    <fmt:message key="$" bundle="${lang}"></fmt:message>
                                                </p>
                                            </td>
                                            <td class="text-center"><a
                                                    href="${pageContext.request.contextPath}/cart/MinusBillProductControl?key=${entry.key}&size=${o.productSize}&color=${o.productColor}">
                                                <button style="border-radius: 50%;background-color: white" name="minus"
                                                        value="minus" type="button">-
                                                </button>
                                            </a><input style="margin-left: 5px" type="text"
                                                       class="item-quantity" value="${o.quantity} "
                                                       name="Lines" id="updates_6383545" min="1" readonly>
                                                <a
                                                        href="${pageContext.request.contextPath}/cart/AddBillProductControl?key=${entry.key}&size=${o.productSize}&color=${o.productColor}">
                                                    <button style="border-radius: 50%;background-color: white"
                                                            name="add"
                                                            value="add" type="button">+
                                                    </button>
                                                </a></td>
                                            <td class="text-center"><p class="l">
                                                <c:set var="sumALl"
                                                       value="	${o.quantity * o.price}"></c:set>
                                                    ${o.quantity * o.price}
                                            </p></td>

                                            <td class="text-center"><a
                                                    class="fa fa-trash-o item-remove"
                                                    href="${pageContext.request.contextPath}/cart/DeleteBillControl?key=${entry.key}&size=${o.productSize}&color=${o.productColor}"></a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </c:forEach>
                                </c:forEach>
                            </table>
                        </c:if>
                    </div>
                </div>
                <c:if test="${!empty sessionScope.cart }">
                    <div class="col-md-9 col-xs-12">

                        <a href="${pageContext.request.contextPath}/IndexControl" class="btn-cart next"> <fmt:message
                                key="BUY.MORE" bundle="${lang}"></fmt:message></a>
                    </div>
                    <div class="col-md-3 col-xs-12">
                        <table class="table table-bordered total-table">
                            <tr>
                                <td class="text-right"><fmt:message key="Total.amount"
                                                                    bundle="${lang}"></fmt:message></td>
                                <td class="text-right">${total}<fmt:message key="$"
                                                                            bundle="${lang}"></fmt:message></td>
                            </tr>
                        </table>
                        <c:url var="payment" value="Payment.jsp"></c:url>
                        <a href="${pageContext.request.contextPath}/${payment}"
                           class="btn-cart pull-right"><fmt:message
                                key="payment.methods" bundle="${lang}"></fmt:message></a>
                        <c:url var="order" value="cart/OrderBillControl"></c:url>
                        <a href="${pageContext.request.contextPath}/${order}?total=${total}"
                           class="btn-cart pull-right"><fmt:message
                                key="pay" bundle="${lang}"></fmt:message></a>
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.cart }">
                    <p>
                        <fmt:message key="There.are.no.products.in.the.cart"
                                     bundle="${lang}"></fmt:message>
                    </p>
                </c:if>
                <h4>
                    <fmt:message key="Purchase.history" bundle="${lang}"></fmt:message>
                </h4>
                <div class="col-md-12" style="border: 1px solid #ddd;">
                    <c:if test="${empty listOrders}"><p>Lịch sử rổng </p></c:if>
                    <div class="table-responsive" style=" margin-top: 20px;">
                        <c:if test="${!empty listOrders}">
                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0"
                                   cellspacing="0"
                                   border="0"
                                   id="sampleTable" style="font-family: Arial, sans-serif;
  font-size: 12px;">
                                <thead>
                                <tr>
                                    <th>ID đơn hàng</th>
                                    <th>Đanh sách đơn hàng</th>
                                    <th>Số lượng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái thanh toán</th>
                                    <th>Trạng thái vận chuyển</th>
                                    <th>Tính năng</th>
                                </tr>
                                </thead>
                                <tbody id="renderListAccount">
                                <c:forEach items="${requestScope.listOrders}" var="o" varStatus="stt">
                                    <c:set var="count" value="0"/>
                                    <tr>
                                        <td>#${o.id}</td>
                                        <td>
                                            <c:forEach var="h" items="${requestScope.products}">
                                                <c:if test="${stt.index == h.key}">
                                                    <c:forEach var="p" items="${h.value}" varStatus="loop">
                                                        <c:set var="count" value="${count + 1}"/>
                                                        ${p.product.nameProduct} - ${p.productSize}/${p.productColor}
                                                        <c:if test="${!loop.last}">,</c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${count}</td>
                                        <td style="text-align: right;">${o.totalPrice}</td>
                                        <td>${o.statusPay}</td>
                                        <td>
                                            <c:if test="${o.status=='Đang xử lý'}">
                                                <span class="badge bg-warning">${o.status}</span>
                                            </c:if>
                                            <c:if test="${o.status=='Đã xác nhận'}">
                                                <span class="badge bg-primary">${o.status}</span>
                                            </c:if>
                                            <c:if test="${o.status=='Đang vận chuyển'}">
                                                <span class="badge bg-info">${o.status}</span>
                                            </c:if>
                                            <c:if test="${o.status=='Đã hủy'}">
                                                <span class="badge bg-danger">${o.status}</span>
                                            </c:if>
                                            <c:if test="${o.status=='Hoàn thành'}">
                                                <span class="badge bg-success">${o.status}</span>
                                            </c:if>
                                        </td>
                                        <td class="text-center" valign="middle"><a
                                                style="color: green; text-decoration: underline;"
                                                href="${pageContext.request.contextPath}/cart/DetailBill?id=${o.id}">
                                            <fmt:message
                                                    key="click.to.view" bundle="${lang}"></fmt:message></a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../admin/header/link-js.jsp" flush="true"/>
    <!-- End Main Content -->
    <jsp:include page="./footer/Footer.jsp"></jsp:include>
    <script type="text/javascript">
        $('#sampleTable').DataTable({
            order: [[0, 'desc']],
        });
        let error =`${requestScope.sorry}`;
        console.log(error);
        if (error !== ``) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: error,
            });
        }
    </script>

</div>
</body>

</html>