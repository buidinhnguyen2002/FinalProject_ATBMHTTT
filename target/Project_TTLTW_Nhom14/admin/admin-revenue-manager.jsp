<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url value="/admin/assets" var="url"/>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html lang="en">

<head>
  <title>Danh sách nhân viên | Quản trị Admin</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="./header/link-css.jsp" flush="true"/>
</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<jsp:include page="./header/admin-left-sidebar.jsp" flush="true"/>
<main class="app-content">
  <div class="row">
    <div class="col-md-12">
      <div class="app-title">
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><a href="#"><b>Báo cáo doanh thu tháng ${requestScope.thisMonth}</b></a></li>
        </ul>
        <div id="clock"></div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6 col-lg-3">
      <div class="widget-small primary coloured-icon"><i class='icon  bx bxs-user fa-3x'></i>
        <div class="info">
          <h4>Số khách hàng</h4>
          <p><b>${requestScope.sumAccount} khách hàng</b></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="widget-small info coloured-icon"><i class='icon bx bxs-purchase-tag-alt fa-3x' ></i>
        <div class="info">
          <h4>Tổng sản phẩm</h4>
          <p><b>${requestScope.sumProduct} sản phẩm</b></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="widget-small warning coloured-icon"><i class='icon fa-3x bx bxs-shopping-bag-alt'></i>
        <div class="info">
          <h4>Tổng đơn hàng thành công</h4>
          <p><b>${requestScope.sumOrder} đơn hàng</b></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="widget-small danger coloured-icon"><i class='icon fa-3x bx bxs-info-circle' ></i>
        <div class="info">
          <h4>Sản phẩm chưa bán dươc</h4>
          <p><b>${requestScope.getTotalNoYetOrder} sản phẩm</b></p>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6 col-lg-3">
      <div class="widget-small primary coloured-icon"><i class='icon fa-3x bx bxs-chart' ></i>
        <div class="info">
          <h4>Tổng thu nhập</h4>
          <p><b class="priceSystas">${requestScope.sumPrice} VNĐ</b></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="widget-small info coloured-icon"><i class='icon fa-3x bx bxs-user-badge' ></i>
        <div class="info">
          <h4>Nhân viên mới</h4>
          <p><b>${requestScope.sumNewMembers} nhân viên</b></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="widget-small warning coloured-icon"><i class='icon fa-3x bx bxs-tag-x' ></i>
        <div class="info">
          <h4>Hết hàng</h4>
          <p><b>${requestScope.sumOutOfStock} sản phẩm</b></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="widget-small danger coloured-icon"><i class='icon fa-3x bx bxs-receipt' ></i>
        <div class="info">
          <h4>Đơn hàng hủy</h4>
          <p><b>${requestScope.sumOrderCancel} đơn hàng</b></p>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="tile">
        <div>
          <h3 class="tile-title">SẢN PHẨM BÁN CHẠY</h3>
        </div>
        <div class="tile-body">
          <table class="table table-hover table-bordered" id="sampleTable">
            <thead>
            <tr>
              <th>Mã sản phẩm</th>
              <th>Tên sản phẩm</th>
              <th>Giá tiền</th>
              <th>Danh mục</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.listProduct}" var="o">
              <tr>
                <td>${o.id}</td>
                <td>${o.nameProduct}</td>
                <td class="priceSystas">${o.listPrice} VNĐ</td>
                <td>${o.category.nameCategory}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="tile">
        <div>
          <h3 class="tile-title">ĐƠN HÀNG GIAO THÀNH CÔNG</h3>
        </div>
        <div class="tile-body">
          <table class="table table-hover table-bordered" id="sampleTable2">
            <thead>
            <tr>
              <th>ID đơn hàng</th>
              <th>Khách hàng</th>
              <th>Đơn hàng</th>
              <th>Số lượng</th>
              <th>Tổng tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.listOrders}" var="o" varStatus="stt">
              <c:set var="count" value="0"></c:set>
              <tr>
                <td>${o.id}</td>
                <td>${o.account.accountName}</td>
                <td>
                  <c:forEach var="h" items="${requestScope.products}">
                    <c:if test="${stt.index == h.key}">
                      <c:forEach var="p" items="${h.value}" varStatus="loop">
                        <c:set var="count" value="${count + p.quantity}"/>
                        ${p.product.nameProduct} - ${p.productSize}/${p.productColor} - ${p.quantity}
                        <c:if test="${!loop.last}">,</c:if>
                      </c:forEach>
                    </c:if>
                  </c:forEach>
                </td>
                <td>${count}</td>
                <td class="priceSystas" style="text-align: right;">${o.totalPrice} VNĐ</td>
              </tr>
            </c:forEach>
            </tbody>
            <tr>
              <th colspan="4">Tổng cộng:</th>
              <td class="priceSystas" style="text-align: right;">${requestScope.sumPrice} VNĐ</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="tile">
        <div>
          <h3 class="tile-title">SẢN PHẨM ĐÃ HẾT</h3>
        </div>
        <div class="tile-body">
          <table class="table table-hover table-bordered" id="sampleTable3">
            <thead>
            <tr>
              <th>Mã sản phẩm</th>
              <th>Tên sản phẩm</th>
              <th>Giá tiền</th>
              <th>Danh mục</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.listProductOOS}" var="o">
              <tr>
                <td>${o.id}</td>
                <td>${o.nameProduct}</td>
                <td class="priceSystas">${o.listPrice} VNĐ</td>
                <td>${o.category.nameCategory}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <div class="tile">
        <h3 class="tile-title">SẢN PHẨM BÁN RA HÀNG THÁNG</h3>
        <div>
        <i class="fas fa-square" style="color: rgb(2,50,130,0.65);"></i> Sản phẩm
        </div>
        <div class="embed-responsive embed-responsive-16by9">
          <canvas class="embed-responsive-item" id="lineChart"></canvas>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="tile">
        <h3 class="tile-title">DOANH THU HÀNG THÁNG</h3>
        <div>
          <i class="fas fa-square" style="color: rgb(120,227,184);"></i> Số tiền
        </div>
        <div class="embed-responsive embed-responsive-16by9">
          <canvas class="embed-responsive-item" id="barChart"></canvas>
        </div>
      </div>
    </div>
  </div>

  <div class="text-right" style="font-size: 12px">
    <p><b>Hệ thống quản lý V2.0</b></p>
  </div>
</main>
<!-- Essential javascripts for application to work-->
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript">$('#sampleTable2').DataTable();</script>
<script type="text/javascript">$('#sampleTable3').DataTable();</script>
<script type="text/javascript">$('#sampleTable4').DataTable();</script>

<script type="text/javascript">
  <%--  Map 1 --%>
  let listSumOrderByMonth = ${requestScope.sumOrdersMonth}
  var data = {
    labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
    datasets: [{
      label: 'Sản phẩm',
      fillColor: "rgba(2,50,130,0.65)",
      strokeColor: "rgba(2,50,130,0.65)",
      pointColor: "rgb(220, 64, 59)",
      pointStrokeColor: "#fff",
      pointHighlightFill: "yellow",
      pointHighlightStroke: "yellow",
      data: listSumOrderByMonth
    },
    ]
  };
  // map 2
  let listSumMoneyByMonth = ${requestScope.sumMoneyMonth}
  var data1 = {
    labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
    datasets: [{
      label: "Số tiền",
      fillColor: "rgb(120,227,184)",
      strokeColor: "Green",
      pointColor: "rgb(220, 64, 59)",
      pointStrokeColor: "#fff",
      pointHighlightFill: "yellow",
      pointHighlightStroke: "yellow",
      data: listSumMoneyByMonth
    },
    ]
  };

  // Map 1
  var ctxl = $("#lineChart").get(0).getContext("2d");
  var lineChart = new Chart(ctxl).Line(data);

  // Map 2
  var ctxb = $("#barChart").get(0).getContext("2d");
  var barChart = new Chart(ctxb).Bar(data1);
</script>
<!-- Google analytics script-->
<script type="text/javascript">
  if (document.location.hostname == 'pratikborsadiya.in') {
    (function (i, s, o, g, r, a, m) {
      i['GoogleAnalyticsObject'] = r;
      i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
      }, i[r].l = 1 * new Date();
      a = s.createElement(o),
              m = s.getElementsByTagName(o)[0];
      a.async = 1;
      a.src = g;
      m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
    ga('create', 'UA-72504830-1', 'auto');
    ga('send', 'pageview');
  }
</script>
<script>
  document.getElementById("admin-revenue").classList.add("active");
</script>
<script>
  function formatPriceElements() {
    const priceElements = document.getElementsByClassName('priceSystas');

    for (let i = 0; i < priceElements.length; i++) {
      const priceString = priceElements[i].innerText;
      const formattedPrice = formatNumberWithCommas(priceString).replace(/,/g, '.') + ' đ';
      priceElements[i].innerText = formattedPrice;
    }
  }

  function formatNumberWithCommas(numberString) {
    const number = parseFloat(numberString);

    if (isNaN(number)) {
      return "Invalid number";
    }

    const formattedNumber = number.toLocaleString('en-US');
    return formattedNumber;
  }

  // Gọi hàm để chuyển đổi các thành phần có lớp "price"
  formatPriceElements();
</script>
</body>

</html>