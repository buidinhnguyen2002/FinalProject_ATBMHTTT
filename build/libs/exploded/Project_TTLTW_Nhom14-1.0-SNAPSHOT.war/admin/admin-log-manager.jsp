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
    <title>Danh sách nhật ký | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="./header/link-css.jsp" flush="true"/>
</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<jsp:include page="./header/admin-left-sidebar.jsp" flush="true"/>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách nhật ký</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">

                    <div class="row element-button">
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm nhap-tu-file" type="button" title="Nhập"
                               onclick="myFunction(this)"><i
                                    class="fas fa-file-upload"></i> Tải từ file</a>
                        </div>

                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm print-file" type="button" title="In"
                               onclick="myApp.printTable()"><i
                                    class="fas fa-print"></i> In dữ liệu</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm print-file js-textareacopybtn" type="button"
                               title="Sao chép"><i
                                    class="fas fa-copy"></i> Sao chép</a>
                        </div>

                        <div class="col-sm-2">
                            <button class="btn btn-excel btn-sm" href="" title="In" id="exportButton"><i
                                    class="fas fa-file-excel"></i> Xuất Excel
                            </button>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"
                               onclick="myApp.printTable()"><i
                                    class="fas fa-file-pdf"></i> Xuất PDF</a>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="sampleTable" style="font-family: Arial, sans-serif;
  font-size: 12px;">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="all"></th>
                            <th>id</th>
                            <th>Time</th>
                            <th>Ip</th>
                            <th>Level</th>
                            <th>Id Account</th>
                            <th>Source</th>
                            <th>Content</th>
                        </tr>
                        </thead>
                        <tbody id="renderListAccount">
                        <c:forEach items="${requestScope.logs}" var="o" varStatus="stt">
                            <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>${o.id}</td>
                                <td>${o.createAt}</td>
                                <td><b>${o.ip}</b></td>
                                <td>
                                    <c:if test="${o.level==0}"> <span class="badge bg-info">INFO</span></c:if>
                                    <c:if test="${o.level==1}"><span class="badge bg-primary">ALERT</span></c:if>
                                    <c:if test="${o.level==2}"><span class="badge bg-warning">WARNING</span></c:if>
                                    <c:if test="${o.level==3}"><span class="badge bg-danger">DANGER</span></c:if>
                                </td>
                                <td>
                                    <c:if test="${o.idAccount==0}">NULL</c:if>
                                    <c:if test="${o.idAccount!=0}">${o.idAccount}</c:if>
                                </td>
                                <td>${o.src}</td>
                                <td>${o.content }</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
<!--
MODAL
-->
<div id="showEdit"></div>

<!--
MODAL
-->
<!-- Essential javascripts for application to work-->
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script>
    oTable = $('#sampleTable').DataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

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

    //In dữ liệu
    var myApp = new function () {
        this.printTable = function () {
            var tab = document.getElementById('sampleTable');
            var win = window.open('', '', 'height=700,width=700');
            win.document.write(tab.outerHTML);
            win.document.close();
            win.print();
        }
    }
    //Sao chép dữ liệu
    var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

    copyTextareaBtn.addEventListener('click', function (event) {
        var copyTextarea = document.querySelector('.js-copytextarea');
        copyTextarea.focus();
        copyTextarea.select();

        try {
            var successful = document.execCommand('copy');
            var msg = successful ? 'successful' : 'unsuccessful';
            console.log('Copying text command was ' + msg);
        } catch (err) {
            console.log('Oops, unable to copy');
        }
    });


    function closeModal() {
        let modal = document.getElementById("showEdit");
        modal.innerHTML = '';
    }

    // xuất file excel
    $("#exportButton").click(function () {
        $("#sampleTable").table2excel({
            exclude: ".noExl", // Loại bỏ các phần tử có class "noExl" khỏi file Excel
            name: "Sheet 1", // Tên sheet trong file Excel
            filename: "example.xlsx" // Tên file Excel xuất ra
        });
    });

</script>
</body>

</html>