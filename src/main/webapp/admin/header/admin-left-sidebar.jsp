<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<c:url value="/admin/assets" var="url"/>
<header class="app-header">
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <!-- User Menu-->
        <li><a class="app-nav__item" href="${pageContext.request.contextPath}/admin/admin-logout"><i
                class='bx bx-log-out bx-rotate-180'></i> </a>

        </li>
    </ul>
</header>

<jsp:useBean id="securityDAO" class="dao.AuthDAO.SecurityDAO"></jsp:useBean>
<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="${url}/images/avatar-admin.png"
                                        width="50px"
                                        alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b>${sessionScope.admin.fullName}</b></p>
            <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
        </div>
    </div>
    <hr>
    <ul class="app-menu">
        <li><a class="app-menu__item haha" href="#"><i class='app-menu__icon bx bx-cart-alt'></i>
            <span class="app-menu__label">POS Bán Hàng</span></a></li>
        <c:if test="${securityDAO.hasPermission('7',sessionScope.admin.accountName,'read')}">
        <li><a id="admin-index" class="app-menu__item " href="${pageContext.request.contextPath}/admin-index"><i
                class='app-menu__icon bx bx-tachometer'></i><span
                class="app-menu__label">Bảng điều khiển</span></a></li>
        </c:if>
        <c:if test="${securityDAO.hasPermission('8',sessionScope.admin.accountName,'read')}">
            <li><a id="admin-user" class="app-menu__item" href="${pageContext.request.contextPath}/admin-user"><i
                    class='app-menu__icon bx bx-user-voice'></i><span
                    class="app-menu__label">Quản lý tài khoản</span></a></li>
        </c:if>
        <c:if test="${securityDAO.hasPermission('5',sessionScope.admin.accountName,'read')}">
        <li><a id="admin-products" class="app-menu__item"
               href="${pageContext.request.contextPath}/admin-products/ProductListController"><i
                class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
        </li>
        </c:if>
        <c:if test="${securityDAO.hasPermission('12',sessionScope.admin.accountName,'read')}">
        <li><a id="admin-discount" class="app-menu__item"
               href="${pageContext.request.contextPath}/admin-discount/discount"><i
                class='app-menu__icon bx bxs-discount'></i><span class="app-menu__label">Quản lý mã giảm giá</span></a>
        </li>
        </c:if>
        <c:if test="${securityDAO.hasPermission('9',sessionScope.admin.accountName,'read')}">
        <li><a id="admin-bill" class="app-menu__item"
               href="${pageContext.request.contextPath}/admin-bill/BillProductListController"><i
                class='app-menu__icon bx bx-task'></i><span
                class="app-menu__label">Quản lý đơn hàng</span></a></li>
        </c:if>
        <c:if test="${securityDAO.hasPermission('5',sessionScope.admin.accountName,'read')}">
        <li><a id="admin-revenue" class="app-menu__item"
               href="${pageContext.request.contextPath}/admin-products/RevenueShowController"><i
                class='app-menu__icon bx bx-pie-chart-alt-2'></i><span class="app-menu__label">Báo cáo doanh thu</span></a>
        </li>
        </c:if>
        <c:if test="${securityDAO.hasPermission('10',sessionScope.admin.accountName,'read')}">
        <li><a id="admin-log" class="app-menu__item" href="${pageContext.request.contextPath}/admin-log/show-log"><i
                class='app-menu__icon fas fa-book'></i>
            <span class="app-menu__label">Quản lý log</span></a>
        </li>
        </c:if>
        <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-cog'></i><span class="app-menu__label">Cài
            đặt hệ thống</span></a></li>
    </ul>
</aside>