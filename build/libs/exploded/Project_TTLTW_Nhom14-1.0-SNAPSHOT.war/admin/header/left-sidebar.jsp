<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<c:url value="/admin/assets" var="url" />
<div id="sidebar-wrapper" data-simplebar=""
	data-simplebar-auto-hide="true">
	<div class="brand-logo">
		<a href="${pageContext.request.contextPath}/admin-index"> <img src="${url}/images/logotitle.png"
			class="logo-icon" alt="logo icon">
			<h5 class="logo-text">Admin HaLo's Shop</h5>
		</a>
	</div>
	<ul class="sidebar-menu do-nicescrol">
		<li class="sidebar-header">MENU ADMIN</li>
		<li> <a
			href="${pageContext.request.contextPath}/admin-index"> <i
				class="zmdi zmdi-view-dashboard"></i> <span><fmt:message
						key="overview" bundle="${lang}"></fmt:message></span>
		</a></li>
		<li><a
			href="${pageContext.request.contextPath}/admin-user"> <i
				class="zmdi zmdi-accounts"></i> <span><fmt:message
						key="user.management" bundle="${lang}"></fmt:message></span>
		</a></li>
		<li><c:url var="listP" value="/admin-products/ProductListController"></c:url><a
			href="${pageContext.request.contextPath}/admin-products/ProductListController">
				<i class="zmdi zmdi-widgets"></i> <span><fmt:message
						key="list.of.products" bundle="${lang}"></fmt:message></span>
		</a></li>
		<li><c:url var="billA" value="BillListController"></c:url><a
			href="${pageContext.request.contextPath}/${billA}"> <i
				class="zmdi zmdi-shopping-cart"></i> <span><fmt:message
						key="oder" bundle="${lang}"></fmt:message></span>
		</a></li>

		<li><c:url var="billDetail" value="BillProductListController"></c:url><a
			href="${pageContext.request.contextPath}/${billDetail}">
				<i class="zmdi zmdi-shopping-cart"></i> <span><fmt:message
						key="order.details" bundle="${lang}"></fmt:message></span>
		</a></li>

	</ul>
</div>