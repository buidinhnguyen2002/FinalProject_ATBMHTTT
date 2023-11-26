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
    <title>Danh sách mã giảm giá | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách mã giảm giá</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">

                            <button onclick="addDiscount()" class="btn btn-add btn-sm" title="Thêm"><i
                                    class="fas fa-plus"></i>
                                Tạo mã giảm giá mới
                            </button>
                        </div>
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
                            <th>ID mã giảm giá</th>
                            <th>Tên</th>
                            <th>Mô tả</th>
                            <th>Mã</th>
                            <th>Phần trăm giảm</th>
                            <th>Số lượng</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.listDiscount}" var="o" varStatus="stt">
                            <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>#${o.id}</td>
                                <td>${o.nameDiscount}</td>
                                <td>${o.description}</td>
                                <td>${o.codeDiscount}</td>
                                <td>${o.percentage}</td>
                                <td>${o.quantity}</td>
                                <td>${o.startTime}</td>
                                <td>${o.endTime}</td>
                                <c:if test="${o.status==1}">
                                    <td style="color: green">Có thể sử dụng</td>
                                </c:if>
                                <c:if test="${o.status==0}">
                                    <td style="color: red">Không thể sử dụng</td>
                                </c:if>
                                <td>
                                    <div class="button-container">
                                        <button class="btn btn-primary btn-sm trash"
                                                onclick="deleteDiscount(${o.id},this)" type="button" title="Xóa"><i
                                                class="fas fa-trash-alt"></i></button>
                                        <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                                onclick="editDiscount(${o.id})" id="show-emp-discount-${o.id}"
                                        ><i class="fas fa-edit"></i>
                                        </button>
                                    </div>
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
<div id="showAdd"></div>

<!-- Essential javascripts for application to work-->
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script>
    function closeModal() {
        let modal = document.getElementById("showEdit");
        modal.innerHTML = '';
    }

    function closeModalAdd() {
        let modal = document.getElementById("showAdd");
        modal.innerHTML = '';
    }

    function deleteDiscount(id, button) {
        let row = $(button).closest('tr');
        let re = "";
        Swal.fire({
            title: 'Bạn có chắc chắn muốn mã giảm giá này không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-discount/delete",
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
                            Swal.fire('Xóa mã giảm giá thành công', '', 'success');
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
                Swal.fire('Không xóa mã giảm giá', '', 'info');
            }
        })
    }

    function addDiscount() {
        let status = ` <label class="control-label">Trạng thái</label>
                                <select class="form-control" name="status" id="">
                                    <option value="1">Có thể sử dụng</option>
                                    <option selected value="0">Không thể sử dụng</option>
                                </select>`
        let re = `<div class="modal fade show" id="ModalUP" style="display: block">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
       <form id="add" action="${pageContext.request.contextPath}/admin-discount/add" method="post" >
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Tạo giảm giá</h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label">Tên</label>
                        <input class="form-control" name="nameDiscount" id="name" type="text" required >
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Mô tả</label>
                        <input class="form-control" name="description" type="text" required >
                    </div>
                    <div class="form-group  col-md-6">
                        <label class="control-label">Mã</label>
                        <input class="form-control" name="codeDiscount" type="text" required >
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Phần trăm giảm</label>
                        <input class="form-control" name="percentage" type="number" required >
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Số lượng</label>
                       <input class="form-control" name="quantity" type="number" >
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Ngày bắt dầu</label>
                        <input class="form-control" name="startTime" type="date">
                    </div>
                    <div class="form-group col-md-6">
                       <label class="control-label">Ngày kết thúc</label>
                        <input class="form-control" name="endTime" type="date" >
                    </div>
                    <div class="form-group col-md-6">
                        ` + status + `
                    </div>
                </div>
                <BR>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="saveAdd(this)">Lưu lại</button>
                <a class="btn btn-cancel" onclick="closeModalAdd()" href="#">Thoát</a>
                <BR>
            </div>
</form>
            <div class="modal-footer">
            </div>

        </div>
    </div>
</div>`
        document.getElementById("showAdd").innerHTML = re;
        // Lấy thẻ select
    }

    function saveAdd(button, idP) {
        if (!checkFormNotEmpty('add')) return;
        let success = $(button).closest("form");
        let dataform = $(success).serialize();
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-discount/add",
            type: "POST",
            data: dataform,
            success: function (data) {
                let isSuc = JSON.parse(data).isSuc;
                if (isSuc) {
                    closeModal();
                    Swal.fire('Thêm thành công', '', 'success').then(() => {
                        location.reload();
                    });
                } else {
                    Swal.fire('Thêm thất bại do bạn không có đủ quyền', '', 'success')
                }
            },


            error: function (data) {
                console.log("error3");
            }
        });
    }

    function editDiscount(id) {
        let re = "";
        let status = ""
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-discount/update",
            type: "GET",
            data: {
                id: id,
            },
            success: function (data) {
                let discount = JSON.parse(data).discount;
                let isSuc = JSON.parse(data).isSuc;
                if (isSuc) {
                    if (discount.status === 0) {
                        status = ` <label class="control-label">Trạng thái</label>
                                <select class="form-control" name="status" id="">
                                    <option value="1">Có thể sử dụng</option>
                                    <option selected value="0">Không thể sử dụng</option>
                                </select>`
                    } else {
                        status = ` <label class="control-label">Trạng thái</label>
                                <select class="form-control" name="status" id="">
                                    <option selected value="1">Có thể sử dụng</option>
                                    <option value="0">Không thể sử dụng</option>
                                </select>`
                    }
                    re = `<div class="modal fade show" id="ModalUP" style="display: block">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
       <form id="edit" action="${pageContext.request.contextPath}/admin-discount/update" method="post" >
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Chỉnh mã giảm giá</h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label">ID</label>
                        <input class="form-control" name="id" type="text" required value="` + discount.id + `" readonly>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Tên</label>
                        <input class="form-control" name="nameDiscount" id="name" type="text" required value="` + discount.nameDiscount + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Mô tả</label>
                        <input class="form-control" name="description" type="text" required value="` + discount.description + `">
                    </div>
                    <div class="form-group  col-md-6">
                        <label class="control-label">Mã</label>
                        <input class="form-control" name="codeDiscount" type="text" required value="` + discount.codeDiscount + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Phần trăm giảm</label>
                        <input class="form-control" name="percentage" type="number" required value="` + discount.percentage + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Số lượng</label>
                       <input class="form-control" name="quantity" type="number" value="` + discount.quantity + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Ngày bắt dầu</label>
                        <input class="form-control" name="startTime" type="date" value="` + discount.startTime + `">
                    </div>
                    <div class="form-group col-md-6">
                       <label class="control-label">Ngày kết thúc</label>
                        <input class="form-control" name="endTime" type="date" value="` + discount.endTime + `">
                    </div>
                    <div class="form-group col-md-6">
                           ` + status + `
                    </div>
                </div>
                <BR>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="save(this,` + discount.id + `)">Lưu lại</button>
                <a class="btn btn-cancel" onclick="closeModal()" href="#">Thoát</a>
                <BR>
            </div>
</form>
            <div class="modal-footer">
            </div>

        </div>
    </div>
</div>`
                    document.getElementById("showEdit").innerHTML = re;
                    // Lấy thẻ select
                } else {
                    Swal.fire('Bạn không đủ quyền sửa', '', 'info');
                }
            },
            error: function (data) {
                console.log(data)
            }
        });
    }

    function save(button, idP) {
        if (!checkFormNotEmpty('edit')) return;
        let success = $(button).closest("form");
        let dataform = $(success).serialize();
        let newdata = "";
        let status = "";
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-discount/update",
            type: "POST",
            data: dataform,
            success: function (data) {
                let discount = JSON.parse(data).discount;
                if (discount.status === `1`) {
                    status = `<td style="color: green">Có thể sử dụng</td>`
                } else {
                    status = `<td style="color: red">Không thể sử dụng</td>`
                }
                newdata = `<td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>#` + discount.id + `</td>
                                <td>` + discount.nameDiscount + `</td>
                                <td>` + discount.description + `</td>
                                <td>` + discount.codeDiscount + `</td>
                                <td>` + discount.percentage + `</td>
                                <td>` + discount.quantity + `</td>
                                <td>` + discount.startTime + `</td>
                                <td>` + discount.endTime + `</td>
                                    ` + status + `
                                <td>
                                    <div class="button-container">
                                        <button class="btn btn-primary btn-sm trash"
                                                onclick="deleteDiscount(` + discount.id + `,this)" type="button" title="Xóa"><i
                                                class="fas fa-trash-alt"></i></button>
                                        <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                                onclick="editDiscount(` + discount.id + `)" id="show-emp-discount-` + discount.id + `"
                                        ><i class="fas fa-edit"></i>
                                        </button>
                                    </div>
                                </td>`
                let row = $("#show-emp-discount-" + idP).closest('tr').html(newdata);
                closeModal();
                Swal.fire('Chỉnh sửa thành công :))))) ', '', 'success');
            },


            error: function (data) {
                console.log("error3");
            }
        });
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
</script>
<script>
    document.getElementById("admin-discount").classList.add("active");
    $("#exportButton").click(function () {
        var table = $("#sampleTable").DataTable(); // Khởi tạo DataTable từ bảng có id là "sampleTable"
        var data = table.rows().data().toArray(); // Trích xuất toàn bộ dữ liệu từ DataTable thành một mảng

        var filteredData = data.map(function(row) {
            return row.slice(1, -1); // Loại bỏ cột đầu tiên và hai cột cuối cùng
        });

        var workbook = new ExcelJS.Workbook();
        var worksheet = workbook.addWorksheet("Sheet 1");

        // Ghi dữ liệu từ mảng đã lọc vào worksheet
        worksheet.addRows(filteredData);

        // Xuất tệp Excel
        workbook.xlsx.writeBuffer().then(function (buffer) {
            var blob = new Blob([buffer], {type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
            saveAs(blob, "example.xlsx"); // Tải xuống tệp Excel
        });
    });

</script>
</body>

</html>