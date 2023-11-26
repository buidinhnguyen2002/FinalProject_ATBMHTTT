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
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Thêm quyền</div>
                        <hr>
                        <form action="${pageContext.request.contextPath}/admin-user/SubmitAddPermission" method="post">
                            <div class="form-group">
                                <label for="role">Chọn Role</label>
                                <select id="role" class="form-control valid" name="role" onchange="getResource()">
                                    <c:forEach items="${requestScope.roles}" var="role">
                                        <option value="${role.id}">${role.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="url">Chọn tài nguyên truy cập</label>
                                <select id="url" class="form-control valid" name="resource">
                                    <c:forEach items="${requestScope.resources}" var="resource">
                                        <option value="${resource.id}">${resource.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="account">Thao tác</label>
                                <select id="account" class="form-control valid" name="permission">
                                    <option value="read" selected="selected">read</option>
                                    <option value="create">create</option>
                                    <option value="update">update</option>
                                    <option value="delete">delete</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <a href="${pageContext.request.contextPath}/admin-user">
                                    <button class="btn btn-danger"><fmt:message key="Cancel"
                                                                                bundle="${lang}"></fmt:message></button>
                                </a>
                                <button type="submit" class="btn btn-success"><fmt:message key="update"
                                                                                           bundle="${lang}"></fmt:message></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay toggle-menu"></div>
    </div>
    <script>
        function getResource() {
            let selectedOption = document.getElementById("role").value;
            let re = "";
            $.ajax({
                url: "${pageContext.request.contextPath}/admin-user/UserAddPermission",
                type: "post",
                data: {
                    idRole: selectedOption,
                },
                success: function (data) {
                    let listRe = JSON.parse(JSON.parse(data).listResource);
                    for (let i = 0; i < listRe.length; i++) {
                        re += `<option value="` + listRe[i].id + `">` + listRe[i].name + `</option>`
                    }
                    console.log(re);
                    document.getElementById("url").innerHTML = re;
                },
                error: function (data) {
                    console.log(data)
                }
            });


        }
    </script>
</div>

<jsp:include page="./footer/footer.jsp" flush="true"/>