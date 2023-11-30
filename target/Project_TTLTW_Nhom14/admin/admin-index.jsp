<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url value="/admin/assets" var="url"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Trang chủ Admin | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="header/link-css.jsp" flush="true"/>
</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<jsp:include page="./header/admin-left-sidebar.jsp" flush="true"/>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Bảng điều khiển</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
        </div>
    </div>
    <div class="row">
        <!--Left-->
        <div class="col-md-12 col-lg-6">
            <div class="row">
                <!-- col-6 -->
                <div class="col-md-6">
                    <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                        <div class="info">
                            <h4>Tổng khách hàng</h4>
                            <p><b>${requestScope.sumAccount} Khách hàng</b></p>
                            <p class="info-tong">Tổng số khách hàng được quản lý.</p>
                        </div>
                    </div>
                </div>
                <!-- col-6 -->
                <div class="col-md-6">
                    <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                        <div class="info">
                            <h4>Tổng sản phẩm</h4>
                            <p><b>${requestScope.sumProduct} sản phẩm</b></p>
                            <p class="info-tong">Tổng số sản phẩm được quản lý.</p>
                        </div>
                    </div>
                </div>
                <!-- col-6 -->
                <div class="col-md-6">
                    <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                        <div class="info">
                            <h4>Tổng đơn hàng</h4>
                            <p><b>${requestScope.sumBill} đơn hàng</b></p>
                            <p class="info-tong">Tổng số hóa đơn bán hàng trong tháng.</p>
                        </div>
                    </div>
                </div>
                <!-- col-6 -->
                <div class="col-md-6">
                    <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                        <div class="info">
                            <h4>Sắp hết hàng</h4>
                            <p><b>${requestScope.productOuOtOfStock} sản phẩm</b></p>
                            <p class="info-tong">Số sản phẩm cảnh báo hết cần nhập thêm.</p>
                        </div>
                    </div>
                </div>
                <!-- col-12 -->
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tình trạng đơn hàng</h3>
                        <div>
                            <table class="table table-bordered" id="sampleTable2">
                                <thead>
                                <tr>
                                    <th>ID đơn hàng</th>
                                    <th>Tên khách hàng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.orders}" var="o">
                                    <tr>
                                        <td> #${o.id}</td>
                                        <td> ${o.account.accountName}</td>
                                        <td>
                                                ${o.totalPrice} đ
                                        </td>
                                        <td><c:if test="${o.status=='Đang xử lý'}">
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
                                            </c:if></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- / div trống-->
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách sản phẩm sắp hết</h3>
                        <div>
                            <table class="table table-bordered" id="sampleTable">
                                <thead>
                                <tr>
                                    <th>ID sản phẩm</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Danh mục</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.listProductStock}" var="o">
                                    <tr>
                                        <td> #${o.id}</td>
                                        <td> ${o.nameProduct}</td>
                                        <td>${o.inventory.quantity}</td>
                                        <td>${o.category.nameCategory}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- / div trống-->
                    </div>
                </div>
                <!-- / col-12 -->
                <!-- col-12 -->
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Khách hàng mới</h3>
                        <div>
                            <table class="table table-hover" id="sampleTable1">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên khách hàng</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.accounts}" var="o">
                                    <tr>
                                        <td>#${o.id}</td>
                                        <td>${o.fullName}</td>
                                        <td>${o.email}</td>
                                        <td>${o.phone}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
                <!-- / col-12 -->
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Sản phẩm tồn kho</h3>
                        <div>
                            <table class="table table-hover" id="sampleTable3">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Danh mục</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.listProductInventory}" var="o">
                                    <tr>
                                        <td>#${o.id}</td>
                                        <td>${o.nameProduct}</td>
                                        <td>${o.inventory.quantity}</td>
                                        <td>${o.category.nameCategory}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--END left-->
        <!--Right-->
        <div class="col-md-12 col-lg-6">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Dữ liệu đơn tổng đơn hàng và số đơn hàng thành công 6 tháng</h3>
                        <div>
                            <i class="fas fa-square" style="color: rgb(255, 212, 59);"></i> Tổng đơn hàng
                        </div>
                        <div>
                            <i class="fas fa-square" style="color: rgb(9, 109, 239);"></i> Các đơn hàng thành công
                        </div>
                        <div class="embed-responsive embed-responsive-16by9">
                            <canvas class="embed-responsive-item" id="lineChartDemo"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Dữ liệu đơn tổng đơn hàng và số đơn hàng thành công 6 tháng</h3>
                        <div>
                            <i class="fas fa-square" style="color: rgb(255, 212, 59);"></i> Tổng đơn hàng
                        </div>
                        <div>
                            <i class="fas fa-square" style="color: rgb(9, 109, 239);"></i> Các đơn hàng thành công
                        </div>
                        <div class="embed-responsive embed-responsive-16by9">
                            <canvas class="embed-responsive-item" id="barChartDemo"></canvas>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
        <!--END right-->
    </div>


    <div class="text-center" style="font-size: 13px">
        <p><b>Copyright
            <script type="text/javascript">
                document.write(new Date().getFullYear());
            </script>
            Phần mềm quản lý bán hàng | Dev By Nhóm 14
        </b></p>
    </div>
</main>
<jsp:include page="header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript">$('#sampleTable1').DataTable();</script>
<script type="text/javascript">$('#sampleTable2').DataTable();</script>
<script type="text/javascript">$('#sampleTable3').DataTable();</script>

<script type="text/javascript">
    oTable = $('#sampleTable').DataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });
    oTable = $('#sampleTable1').DataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });
    oTable = $('#sampleTable2').DataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });
    oTable = $('#sampleTable3').DataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });
    let listSumOrderByMonth = ${requestScope.sumOrdersMonth};
    let listSumAllOrdersMonth = ${requestScope.allOrdersMonth};
    var data = {
        labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"],
        datasets: [{
            label: "Tổng đơn hàng",
            fillColor: "rgba(255, 213, 59, 0.767), 212, 59)",
            strokeColor: "rgb(255, 212, 59)",
            pointColor: "rgb(255, 212, 59)",
            pointStrokeColor: "rgb(255, 212, 59)",
            pointHighlightFill: "rgb(255, 212, 59)",
            pointHighlightStroke: "rgb(255, 212, 59)",
            data: listSumAllOrdersMonth
        },
            {
                label: "Các đơn hàng thành công",
                fillColor: "rgba(9, 109, 239, 0.651)  ",
                pointColor: "rgb(9, 109, 239)",
                strokeColor: "rgb(9, 109, 239)",
                pointStrokeColor: "rgb(9, 109, 239)",
                pointHighlightFill: "rgb(9, 109, 239)",
                pointHighlightStroke: "rgb(9, 109, 239)",
                data: listSumOrderByMonth
            }
        ]
    };
    var ctxl = $("#lineChartDemo").get(0).getContext("2d");
    var lineChart = new Chart(ctxl).Line(data);

    var ctxb = $("#barChartDemo").get(0).getContext("2d");
    var barChart = new Chart(ctxb).Bar(data);
</script>
<script type="text/javascript">
    //Thời Gian
    function time() {
        var today = new Date();
        var weekday = new Array(7);
        weekday[0] = "Chủ Nhật";
        weekday[1] = "Thứ Hai";
        weekday[2] = "Thứ Ba";
        weekday[3] = "Thứ Tư";
        weekday[4] = "Thứ Năm";
        weekday[5] = "Thứ Sáu";
        weekday[6] = "Thứ Bảy";
        var day = weekday[today.getDay()];
        var dd = today.getDate();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        nowTime = h + " giờ " + m + " phút " + s + " giây";
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        today = day + ', ' + dd + '/' + mm + '/' + yyyy;
        tmp = '<span class="date"> ' + today + ' - ' + nowTime +
            '</span>';
        document.getElementById("clock").innerHTML = tmp;
        clocktime = setTimeout("time()", "1000", "Javascript");

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }
    }
</script>
<script>
    document.getElementById("admin-index").classList.add("active");
</script>
</body>

</html>