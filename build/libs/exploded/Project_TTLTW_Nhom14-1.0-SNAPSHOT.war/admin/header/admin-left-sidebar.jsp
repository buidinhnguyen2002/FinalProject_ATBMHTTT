<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<c:url value="/admin/assets" var="url" />
<header class="app-header">
  <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                  aria-label="Hide Sidebar"></a>
  <!-- Navbar Right Menu-->
  <ul class="app-nav">
    <!-- User Menu-->
    <li><a class="app-nav__item" href="${pageContext.request.contextPath}/admin/admin-logout"><i class='bx bx-log-out bx-rotate-180'></i> </a>

    </li>
  </ul>
</header>
<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
  <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="${url}/images/avatar-admin.png" width="50px"
                                      alt="User Image">
    <div>
      <p class="app-sidebar__user-name"><b>Long đẹp trai</b></p>
      <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
    </div>
  </div>
  <hr>
  <ul class="app-menu">
    <li><a class="app-menu__item haha" href="${pageContext.request.contextPath}/admin/admin-pos-page.jsp"><i class='app-menu__icon bx bx-cart-alt'></i>
      <span class="app-menu__label">POS Bán Hàng</span></a></li>
    <li><a class="app-menu__item " href="${pageContext.request.contextPath}/admin-index"><i class='app-menu__icon bx bx-tachometer'></i><span
            class="app-menu__label">Bảng điều khiển</span></a></li>
    <li><a class="app-menu__item" href="${pageContext.request.contextPath}/admin-user"><i class='app-menu__icon bx bx-user-voice'></i><span
            class="app-menu__label">Quản lý tài khoản</span></a></li>
    <li><a class="app-menu__item" href="${pageContext.request.contextPath}/admin-products/ProductListController"><i
            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
    </li>
    <li><a class="app-menu__item" href="${pageContext.request.contextPath}/admin-bill/BillProductListController"><i class='app-menu__icon bx bx-task'></i><span
            class="app-menu__label">Quản lý đơn hàng</span></a></li>
    <li><a class="app-menu__item" href="${pageContext.request.contextPath}/admin-products/RevenueShowController"><i
            class='app-menu__icon bx bx-pie-chart-alt-2'></i><span class="app-menu__label">Báo cáo doanh thu</span></a>
    </li>
    <li><a class="app-menu__item" href="${pageContext.request.contextPath}/admin-log/show-log"><i class='app-menu__icon fas fa-book'></i>
      <span class="app-menu__label">Quản lý log</span></a>
    </li>
    <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-cog'></i><span class="app-menu__label">Cài
            đặt hệ thống</span></a></li>
  </ul>
</aside>