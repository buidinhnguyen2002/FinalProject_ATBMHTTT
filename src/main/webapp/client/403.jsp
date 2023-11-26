<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${sessionScope.LANG}" />
<fmt:setBundle basename="app" var="lang" />
<html lang="vi">
<head>
  <title>Error 404</title>
  <link rel="icon" type="image" href="../images/HaLoicon.png" />
  <jsp:include page="./link/Link.jsp"></jsp:include>
  <style>
    .aa-error-area {
      text-align: center;
    }

    .aa-error-area h2 {
      font-size: 10rem;
      font-weight: bold;
      color: #e74c3c;
      margin-bottom: 30px;
    }

    .aa-error-area span {
      font-size: 3rem;
      color: #555;
      display: block;
      margin-bottom: 30px;
    }

    .aa-error-area a {
      font-size: 2rem;
      color: #fff;
      background-color: #3498db;
      padding: 15px 30px;
      border-radius: 5px;
      text-decoration: none;
      transition: background-color 0.3s ease-in-out;
    }

    .aa-error-area a:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>
<!-- Load page -->
<div id="preloder">
  <div class="loader"></div>
</div>
<jsp:include page="./header/Header.jsp"></jsp:include>
<section style="margin: 15% 0 15% 0" id="aa-error">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="aa-error-area">
          <h2>403</h2>
          <span>Yêu cầu không hợp lệ</span>
          <c:url value="IndexControl" var="indexP"></c:url>
          <a href="${pageContext.request.contextPath}/${indexP}"><fmt:message
                  key="Back.to.HOME" bundle="${lang}"></fmt:message></a>
        </div>
      </div>
    </div>
  </div>
</section>
<jsp:include page="./footer/Footer.jsp"></jsp:include>
</body>
</html>
