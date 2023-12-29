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
    <title>Danh sách đơn hàng | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <jsp:include page="./header/link-css.jsp" flush="true"/>
    <style>.button-container {
        display: flex;
        justify-content: space-between;
    }</style>
</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<jsp:include page="./header/admin-left-sidebar.jsp" flush="true"/>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách đơn hàng</b></a></li>
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
                            <a class="btn btn-delete btn-sm print-file js-textareacopybtn" id="textareacopybtn"
                               type="button" title="Sao chép"><i
                                    class="fas fa-copy"></i> Sao chép</a>
                        </div>

                        <div class="col-sm-2">
                            <button class="btn btn-excel btn-sm" href="" title="In" id="exportButton"><i
                                    class="fas fa-file-excel"></i> Xuất Excel
                            </button>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"
                               onclick="myFunction(this)"><i
                                    class="fas fa-file-pdf"></i> Xuất PDF</a>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered" id="sampleTable">
                        <thead>
                        <tr>
                            <th width="10"><input type="checkbox" id="all"></th>
                            <th>ID đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Đơn hàng</th>
                            <th>Ngày đặt</th>
                            <th>Ngày giao</th>
                            <th>Số lượng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái thanh toán</th>
                            <th>Tình trạng</th>
                            <th>Tác vụ</th>
                            <th>Xóa</th>
                            <th>Xác thực</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.listOrders}" var="o" varStatus="stt">
                            <c:set var="count" value="0"/>
                            <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>#${o.id}</td>
                                <td>${o.account.accountName}</td>
                                <td>
                                    <c:forEach var="h" items="${requestScope.products}">
                                        <c:if test="${stt.index == h.key}">
                                            <c:forEach var="p" items="${h.value}" varStatus="loop">
                                                <c:set var="count" value="${count + 1}"/>
                                                ${p.product.nameProduct} - ${p.productSize}/${p.productColor}
                                                <c:if test="${!loop.last}">,</c:if>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${o.createAt}</td>
                                <c:if test="${o.deliveryAt == null}">
                                    <td>Chưa giao</td>
                                </c:if>
                                <c:if test="${o.deliveryAt != null}">
                                    <td>${o.deliveryAt}</td>
                                </c:if>
                                <td>${count}</td>
                                <td class="priceSystas" style="text-align: right;">${o.totalPrice}</td>
                                <c:if test="${o.statusPay=='Đã thanh toán'}">
                                    <td style="color: green">${o.statusPay}</td>
                                </c:if>
                                <c:if test="${o.statusPay=='Chưa thanh toán'}">
                                    <td style="color: red">${o.statusPay}</td>
                                </c:if>
                                <c:if test="${o.statusPay=='Đã hoàn tiền'}">
                                    <td style="color: yellow">${o.statusPay}</td>
                                </c:if>
                                <td>
                                    <c:if test="${o.status=='Đang xử lý'}">
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
                                    </c:if>
                                    <c:if test="${o.status=='Yêu cầu hoàn tiền'}">
                                        <span class="badge bg-warning">${o.status}</span>
                                    </c:if>
                                </td>
                                <td>
                                    <div class="button-container">
                                        <c:if test="${o.status=='Đang xử lý'}">
                                            <button class="btn btn-primary btn-sm approve" type="button"
                                                    onclick="browse(${o.id},this)" title="Duyệt đơn hàng"><i
                                                    class="fa fa-check"></i></button>
                                        </c:if>
                                        <c:if test="${o.status=='Đã xác nhận'}">
                                            <button class="btn btn-primary btn-sm register" type="button"
                                                    onclick="transport(${o.id},this)" title="Đăng ký vận chuyển"><i
                                                    class="fa fa-truck"></i></button>
                                        </c:if>
                                        <c:if test="${o.status=='Đang vận chuyển'}">
                                            <button class="btn btn-primary btn-sm cancel" type="button"
                                                    onclick="success(${o.id},this)"
                                                    title="Hoàn thành đơn hàng"><i class="fas fa-check-double"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${o.status!='Hoàn thành'&& o.status!='Đã hủy'}">
                                            <button class="btn btn-primary btn-sm cancel" type="button"
                                                    onclick="deny(${o.id},this)"
                                                    title="Hủy đơn hàng"><i class="fas fa-times"></i></button>
                                        </c:if>
                                        <c:if test="${o.status=='Yêu cầu hoàn tiền'}">
                                            <button class="btn btn-primary btn-sm cancel" type="button"
                                                    onclick="refund(${o.id},this)"
                                                    title="Hoàn tiền đơn hàng"><i class="fa fa-repeat"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <div class="button-container">
                                        <button class="btn btn-primary btn-sm trash"
                                                onclick="deleteOrder(${o.id},this)" type="button" title="Xóa"><i
                                                class="fas fa-trash-alt"></i></button>
                                        <button class="btn btn-primary btn-sm edit" onclick="detailOrder(${o.id})"
                                                type="button" title="Sửa"><i
                                                class="fa fa-edit"></i></button>
                                    </div>
                                </td>
                                <td class="text-center" style="display: flex; flex-direction: row; justify-content: center;align-items: center">
                                    <button class="btn btn-success" style="border-radius: 10px; font-size: 12px;" onfocus="this.style.outline='none'" onclick="checkSignature(${o.id})">Verify</button>
                                    <span id="verify-${o.id}"></span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
<div id="showEdit"></div>
<!-- Essential javascripts for application to work-->
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script>
    function closeModal() {
        let modal = document.getElementById("showEdit");
        modal.innerHTML = '';
    }
    function detailOrder(id) {
        let re = "";
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-bill/ShowOrderDetail",
            type: "GET",
            data: {
                id: id,
            },
            success: function (data) {
                console.log(data)
                let order = JSON.parse(JSON.parse(data).order);
                let account = JSON.parse(JSON.parse(data).account);
                    re = `<div class="modal fade show" id="ModalUP" style="display: block">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Chi tiết đơn đặt hàng</h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label">ID Đơn hàng</label>
                        <input class="form-control" name="id" type="text" required value="` + order.id + `" readonly>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Tên khách hàng</label>
                        <input class="form-control" name="nameDiscount" id="name" type="text" readonly required value="` + account.fullName+ `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Địa chỉ</label>
                        <input class="form-control" name="description" type="text" readonly required value="` + order.address + `">
                    </div>
                    <div class="form-group  col-md-6">
                        <label class="control-label">Số điện thoại</label>
                        <input class="form-control" name="codeDiscount" type="text"  readonly required value="` + account.phone + `">
                    </div>
                </div>
                <BR>
                <BR>
                <BR>
                <a class="btn btn-cancel" onclick="closeModal()" href="#">Thoát</a>
                <BR>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>`
                    document.getElementById("showEdit").innerHTML = re;
                    // Lấy thẻ select
            },
            error: function (data) {
                console.log(data)
            }
        });
    }

    function browse(orderId, button) {
        let tr = $(button).closest("tr");
        let tdArray = $(tr).find("td");
        let parent = $(button).closest(".button-container");
        Swal.fire({
            title: 'Bạn có chắc chắn duyệt đơn hàng này không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-bill/BillManagerController",
                    type: "post",
                    data: {
                        orderId: orderId,
                        type: 'browse'
                    },
                    success: function (data) {
                        let isSuc = JSON.parse(data).isSuc;
                        if (isSuc) {
                            $(tdArray[9]).html('<span class="badge bg-primary"">Đã xác nhận</span>');
                            $(parent).html('<button class="btn btn-primary btn-sm register" type="button"  onclick="transport(' + orderId + ',this)" title="Đăng ký vận chuyển"><i class="fa fa-truck"></i></button>' +
                                ' <button class="btn btn-primary btn-sm cancel" onclick="deny(' + orderId + ',this)" type="button" title="Hủy đơn hàng"><i class="fas fa-times"></i></button>')
                        }
                        Swal.fire('Duyệt đơn hàng thành công', '', 'success');
                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Hủy duyệt đơn hàng', '', 'info');
            }
        })
    }

    function transport(orderId, button) {
        let tr = $(button).closest("tr");
        let tdArray = $(tr).find("td");
        let parent = $(button).closest(".button-container");
        Swal.fire({
            title: 'Bạn có chắc chắn muốn đăng ký vận chuyển đơn hàng này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-bill/BillManagerController",
                    type: "post",
                    data: {
                        orderId: orderId,
                        type: 'transport'
                    },
                    success: function (data) {
                        console.log(data)
                        let isSuc = JSON.parse(data).isSuc;
                        if (isSuc) {
                            $(tdArray[9]).html('<span class="badge bg-info"">Đang vận chuyển</span>');
                            $(parent).html(' <button class="btn btn-primary btn-sm cancel" type="button" onclick="success(' + orderId + ',this)" title="Hoàn thành đơn hàng"><i class="fas fa-check-double"></i></button>' + ' <button class="btn btn-primary btn-sm cancel" onclick="deny(' + orderId + ',this)" type="button" title="Hủy đơn hàng"><i class="fas fa-times"></i></button>'
                            )
                        }
                        Swal.fire('Đăng ký vận chuyển đơn hàng thành công', '', 'success');
                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Đã hủy đăng ký vận chuyển', '', 'info');
            }
        })
    }

    function deny(orderId, button) {
        let tr = $(button).closest("tr");
        let tdArray = $(tr).find("td");
        let parent = $(button).closest(".button-container");
        Swal.fire({
            title: 'Bạn có chắc chắn muốn hủy đơn hàng này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-bill/BillManagerController",
                    type: "post",
                    data: {
                        orderId: orderId,
                        type: 'deny'
                    },
                    success: function (data) {
                        let isSuc = JSON.parse(data).isSuc;
                        if (isSuc) {
                            $(tdArray[9]).html('<span class="badge bg-danger"">Đã hủy</span>');
                            $(parent).html('');
                        }
                        Swal.fire('Hủy đơn hàng thành công', '', 'success');
                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Không hủy đơn hàng', '', 'info');
            }
        })
    }
    function refund(orderId, button) {
        let tr = $(button).closest("tr");
        let tdArray = $(tr).find("td");
        let parent = $(button).closest(".button-container");
        Swal.fire({
            title: 'Bạn có chắc chắn muốn hoàn tiền cho đơn hàng này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-bill/BillManagerController",
                    type: "post",
                    data: {
                        orderId: orderId,
                        type: 'refund'
                    },
                    success: function (data) {
                        let isSuc = JSON.parse(data).isSuc;
                        if (isSuc) {
                            $(tdArray[9]).html('<span class="badge bg-danger"">Đã hủy</span>');
                            $(parent).html('');
                        }
                        Swal.fire('Hoàn tiền thành công', '', 'success');
                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Không khôi phục đơn hàng', '', 'info');
            }
        })
    }
    function success(orderId, button) {
        let tr = $(button).closest("tr");
        let tdArray = $(tr).find("td");
        let parent = $(button).closest(".button-container");
        Swal.fire({
            title: 'Bạn có chắc chắn hoàn thành đơn hàng này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-bill/BillManagerController",
                    type: "post",
                    data: {
                        orderId: orderId,
                        type: 'success'
                    },
                    success: function (data) {
                        let isSuc = JSON.parse(data).isSuc;
                        let order = JSON.parse(data).order;
                        let deliveryAt = JSON.parse(order).deliveryAt
                        if (isSuc) {
                            $(tdArray[9]).html('<span class="badge bg-success"">Hoàn thành</span>');
                            $(tdArray[8]).html('Đã thanh toán').css('color', 'green');
                            $(tdArray[5]).html(deliveryAt);
                            $(parent).html('')
                        }
                        Swal.fire('Hoàn thành đơn hàng thành công', '', 'success');
                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Không hoàn thành đơn hàng', '', 'info');
            }
        })
    }

    function deleteOrder(id, button) {
        let row = $(button).closest('tr');
        let re = "";
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa đơn hàng này không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-bill/BillDeleteController",
                    type: "POST",
                    data: {
                        id: id
                    },
                    success: function (data) {
                        let isSuc = JSON.parse(data).isSuc;
                        if (isSuc) {
                            var currentPage = oTable.page(); // lưu trang hiện tại
                            oTable.row(row).remove().draw();
                            oTable.page(currentPage).draw(false); // thiết lập lại trang hiện tại sau khi vẽ lại bảng dữ liệu
                            Swal.fire('Xóa đơn hàng thành công', '', 'success');
                        } else {
                            Swal.fire('Xóa đơn hàng không thành công do bạn không đủ quyền xóa', '', 'info');
                        }

                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Không xóa đơn hàng', '', 'info');
            }
        })
    }

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
    //Modal
    $("#show-emp").on("click", function () {
        $("#ModalUP").modal({backdrop: false, keyboard: false})
    });
    function checkSignature(id){
        $.ajax({
            url: "${pageContext.request.contextPath}/cart/SignatureController",
            type: "POST",
            data: {
                id: id,
            },
            success: function (data) {
                let isVerify = JSON.parse(data).verify;
                // Thay đổi
                // let elementId = "verify";
                let elementId = "verify-"+id;
                let verifyElement = document.getElementById(elementId);
                if (isVerify) {
                    // verifyElement.innerText = "Chữ ký hợp lệ";
                    verifyElement.innerHTML = '<i style="color: #0aa60f; font-size: 20px" class="bi bi-check-lg"></i>';
                } else {
                    verifyElement.innerHTML = '<i style="color: red; font-size: 16px" class="bi bi-x-lg"></i>';
                }
            },
            error: function (data) {
                console.log(data);
            }
        });
    }
</script>
<script>
    document.getElementById("admin-bill").classList.add("active");
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
    // xuất file excel
    $("#exportButton").click(function () {
        var table = $("#sampleTable").DataTable(); // Khởi tạo DataTable từ bảng có id là "sampleTable"
        var data = table.data().toArray(); // Trích xuất toàn bộ dữ liệu trong DataTable thành một mảng

        var workbook = new ExcelJS.Workbook();
        var worksheet = workbook.addWorksheet("Sheet 1");

        // Ghi dữ liệu từ mảng vào worksheet
        worksheet.addRows(data);

        // Xuất tệp Excel
        workbook.xlsx.writeBuffer().then(function (buffer) {
            var blob = new Blob([buffer], {type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
            saveAs(blob, "example.xlsx"); // Tải xuống tệp Excel
        });
    });
</script>
</body>

</html>