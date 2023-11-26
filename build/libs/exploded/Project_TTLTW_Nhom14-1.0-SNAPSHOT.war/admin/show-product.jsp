<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<%
    response.setHeader("Cache-control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
    }
%>
<!-- Start header section -->
<jsp:include page="./header/header.jsp" flush="true"/>
<div class="content-wrapper">
    <div class="container-fluid">

        <div class="row mt-3">
            <div class="col-lg-12">
                <c:url value="ProductAddController" var="addP"></c:url>
                <a href="${pageContext.request.contextPath}/${addP}">
                    <button class="add-catalog">
                        <fmt:message key="Add.products" bundle="${lang}"></fmt:message>
                    </button>
                </a>
            </div>
            <div class="col-lg-12" style="  position: relative;">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <fmt:message key="list.of.products" bundle="${lang}"></fmt:message>
                        </h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th scope="col"><fmt:message key="number"
                                                                 bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="PRODUCT'S.NAME"
                                                                 bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="PICTURE"
                                                                 bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="CATEGORY.ID"
                                                                 bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="price" bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="status"
                                                                 bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="sale" bundle="${lang}"></fmt:message></th>
                                    <th scope="col"><fmt:message key="act" bundle="${lang}"></fmt:message></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.productlist}" var="product">
                                    <tr>
                                        <th scope="row">${product.id}</th>
                                        <td>${product.nameProduct }</td>
                                        <td><img
                                                style="width: 110px; height: 67px; object-fit: cover; border: 1px solid #fff;"
                                                src="../images/${product.imageProducts.get(0).image}" alt=""
                                                class="img-responsive"></td>
                                        <td>${product.category.nameCategory}</td>
                                        <td>${product.listPrice}</td>
                                        <td><c:choose>
                                            <c:when
                                                    test="${product.inventory.quantity!=0}">
                                                <c:out value="${product.inventory.quantity}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="Hết hàng"/>
                                            </c:otherwise>
                                        </c:choose></td>
                                        <td>${product.discount}%</td>
                                        <td><c:url var="deletePA"
                                                   value="ProductDeleteController"></c:url> <a
                                                href="${pageContext.request.contextPath}/${deletePA}?id=${product.id}">
                                            <button
                                                    class="btn btn-danger">
                                                <fmt:message key="delete" bundle="${lang}"></fmt:message>
                                            </button>
                                        </a> <c:url var="editPA" value="ProductEditController"></c:url>
                                            <a
                                                    href="${pageContext.request.contextPath}/${editPA}?id=${product.id}">
                                                <button class="btn btn-success">
                                                    <fmt:message key="edit" bundle="${lang}"></fmt:message>
                                                </button>
                                            </a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <c:url var="ShowProduct" value="/admin-products/ProductListController"></c:url>
                <div class="sk-category-paging-wrap" style="  position: absolute; left: 50%;
  transform: translate(-50%, -50%);">
                    <div class="pull-right">
                        <ul class="pagination">
                            <c:if test="${requestScope.tag>1 }">
                                <li class="page-item active"><a
                                        href="${requestScope.ShowProduct}?index=${tag-1}"
                                        aria-label="Previus"> <span class="fa fa-caret-left"></span>
                                </a></li>
                            </c:if>
                            <c:forEach begin="1" end="${requestScope.endPage}" var="i">
                                <c:if test="${i == requestScope.tag}">
                                    <li class="page-item active">
                                        <a href="${ShowProduct}?index=${i}"
                                           class="page-link">${i}</a>
                                    </li>
                                </c:if>
                                <c:if test="${i != requestScope.tag}">
                                    <li class="page-item">
                                        <a href="${ShowProduct}?index=${i}"
                                           class="page-link">${i}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${requestScope.tag< requestScope.endPage}">
                                <li class="page-item active"><a
                                        href="${ShowProduct}?index=${requestScope.tag+1}"
                                        aria-label="Next"> <span class="fa fa-caret-right"></span>
                                </a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay toggle-menu"></div>
    </div>
</div>


<jsp:include page="./footer/footer.jsp" flush="true"/>