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
                <a href="${pageContext.request.contextPath}/admin-user/UserAddPermission">
                    <button class="add-catalog">
                        Thêm quyền
                    </button>
                </a>
            </div>
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            Quản lý quyền người dùng
                        </h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th scope="col"><fmt:message key="number"
                                                                 bundle="${lang}"></fmt:message></th>
                                    <th scope="col">Tên Quyền</th>
                                    <th scope="col">Tên tài nguyên</th>
                                    <th scope="col">Url Pattern</th>
                                    <th scope="col">Thao tác</th>
                                    <c:set var="isDisplayed" value="false"/>
                                    <c:forEach var="o" items="${sessionScope.admin.roles}">
                                        <c:if test="${o.name.equals('admin')}">
                                            <c:if test="${!isDisplayed}">
                                                <th scope="col">
                                                    <fmt:message key="act" bundle="${lang}"/>
                                                </th>
                                                <c:set var="isDisplayed" value="true"/>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </tr>
                                </thead>
                                <tbody id="render-list-permission">
                                <c:forEach items="${requestScope.permissions_customer}" var="o" varStatus="stt">
                                    <tr>
                                        <td scope="row">${stt.index+1}</td>
                                        <td>${o.role.name }</td>
                                        <td>${o.resource.name }</td>
                                        <td>${o.resource.url }</td>
                                        <td>${o.action}</td>
                                        <td>
                                            <c:set var="isDisplayed1" value="false"/>
                                            <c:forEach var="role" items="${sessionScope.admin.roles}">
                                                <c:if test="${role.name.equals('admin')}">
                                                    <c:if test="${!isDisplayed1}">
                                                        <button class="btn btn-danger"
                                                                onclick="deleteAccountPermission(${o.id})">
                                                            <fmt:message key="delete"
                                                                         bundle="${lang}"></fmt:message>
                                                        </button>
                                                        <c:set var="isDisplayed1" value="true"/>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                Quản lý quyền nhân viên
                            </h5>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th scope="col"><fmt:message key="number"
                                                                     bundle="${lang}"></fmt:message></th>
                                        <th scope="col">Tên Quyền</th>
                                        <th scope="col">Tên tài nguyên</th>
                                        <th scope="col">Url Pattern</th>
                                        <th scope="col">Thao tác</th>
                                        <c:set var="isDisplayed" value="false"/>
                                        <c:forEach var="o" items="${sessionScope.admin.roles}">
                                            <c:if test="${o.name.equals('admin')}">
                                                <c:if test="${!isDisplayed}">
                                                    <th scope="col">
                                                        <fmt:message key="act" bundle="${lang}"/>
                                                    </th>
                                                    <c:set var="isDisplayed" value="true"/>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </tr>
                                    </thead>
                                    <tbody id="render-list-permission-employee">
                                    <c:forEach items="${requestScope.permissions_employee}" var="o" varStatus="stt">
                                        <tr>
                                            <td scope="row">${stt.index+1}</td>
                                            <td>${o.role.name }</td>
                                            <td>${o.resource.name }</td>
                                            <td>${o.resource.url }</td>
                                            <td>${o.action}</td>
                                            <td>
                                                <c:set var="isDisplayed1" value="false"/>
                                                <c:forEach var="role" items="${sessionScope.admin.roles}">
                                                    <c:if test="${role.name.equals('admin')}">
                                                        <c:if test="${!isDisplayed1}">
                                                            <button class="btn btn-danger"
                                                                    onclick="deleteAccountPermission(${o.id})">
                                                                <fmt:message key="delete"
                                                                             bundle="${lang}"></fmt:message>
                                                            </button>
                                                            <c:set var="isDisplayed1" value="true"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                Quản lý quyền điều hành
                            </h5>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th scope="col"><fmt:message key="number"
                                                                     bundle="${lang}"></fmt:message></th>
                                        <th scope="col">Tên Quyền</th>
                                        <th scope="col">Tên tài nguyên</th>
                                        <th scope="col">Url Pattern</th>
                                        <th scope="col">Thao tác</th>
                                        <c:set var="isDisplayed" value="false"/>
                                        <c:forEach var="o" items="${sessionScope.admin.roles}">
                                            <c:if test="${o.name.equals('admin')}">
                                                <c:if test="${!isDisplayed}">
                                                    <th scope="col">
                                                        <fmt:message key="act" bundle="${lang}"/>
                                                    </th>
                                                    <c:set var="isDisplayed" value="true"/>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </tr>
                                    </thead>
                                    <tbody id="render-list-permission-mod">
                                    <c:forEach items="${requestScope.permissions_mod}" var="o" varStatus="stt">
                                        <tr>
                                            <td scope="row">${stt.index+1}</td>
                                            <td>${o.role.name }</td>
                                            <td>${o.resource.name }</td>
                                            <td>${o.resource.url }</td>
                                            <td>${o.action}</td>
                                            <td>
                                                <c:set var="isDisplayed1" value="false"/>
                                                <c:forEach var="role" items="${sessionScope.admin.roles}">
                                                    <c:if test="${role.name.equals('admin')}">
                                                        <c:if test="${!isDisplayed1}">
                                                            <button class="btn btn-danger"
                                                                    onclick="deleteAccountPermission(${o.id})">
                                                                <fmt:message key="delete"
                                                                             bundle="${lang}"></fmt:message>
                                                            </button>
                                                            <c:set var="isDisplayed1" value="true"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                <script>
                    function deleteAccountPermission(id) {
                        let pid = id;
                        let re = "";
                        Swal.fire({
                            title: 'Bạn có chắc chắn muốn xóa user này không?',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonText: 'Yes',
                            cancelButtonText: 'No'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $.ajax({
                                    url: "${pageContext.request.contextPath}/admin-user/UserDeletePermissionsShow",
                                    type: "POST",
                                    data: {
                                        pid: pid,
                                    },
                                    success: function (data) {
                                        let listAcc = JSON.parse(data).permissions_customer;
                                        let listEmployee = JSON.parse(data).permissions_employee;
                                        let listMod = JSON.parse(data).permissions_mod;
                                        console.log(listAcc)
                                        let isAdmin = JSON.parse(data).isAdmin;
                                        for (let i = 0; i < listAcc.length; i++) {
                                            let edit = '';
                                            if (isAdmin === true) {
                                                edit = ` <button class="btn btn-danger" onclick="deleteAccountPermission(` + listAcc[i].id + `)">
                                                            <fmt:message key="delete"
                                                                         bundle="${lang}"></fmt:message>
                                                        </button>`
                                            }
                                            re += ` <tr>
                                        <td >` + i + `</td>
                                        <td>` + listAcc[i].role.name + `</td>
                                        <td>` + listAcc[i].resource.name + `</td>
                                        <td>` + listAcc[i].resource.url + `</td>
                                        <td>` + listAcc[i].action + `</td>
                                        <td>` + edit + `</td>
                                    </tr>`
                                        }
                                        document.getElementById("render-list-permission").innerHTML = re;
                                        // console.log(result)
                                        Swal.fire('Xóa user thành công', '', 'success');
                                    },
                                    error: function (data) {
                                        console.log(data)
                                    }
                                });


                            } else if (result.isDenied) {
                                // Nếu người dùng chọn "No"
                                // Hiển thị thông báo không xóa user bằng SweetAlert2
                                Swal.fire('Không xóa user', '', 'info');
                            }
                        })
                    }
                </script>
            </div>
        </div>
        <div class="overlay toggle-menu"></div>
    </div>
</div>
<jsp:include page="./footer/footer.jsp" flush="true"/>