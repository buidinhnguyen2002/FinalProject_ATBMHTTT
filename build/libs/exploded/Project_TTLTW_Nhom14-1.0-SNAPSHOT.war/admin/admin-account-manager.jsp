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
    <title>Danh sách khách hàng | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="./header/link-css.jsp" flush="true"/>
    <style>select[name="role"] option:checked {
        background-color: yellow; /* Thay đổi màu sắc tại đây */
    }</style>
</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<jsp:include page="./header/admin-left-sidebar.jsp" flush="true"/>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách tài khoản</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <a class="btn btn-add btn-sm"
                               href="${pageContext.request.contextPath}/admin-user/permission"><i
                                    class="fas fa-plus"></i>
                                Tủy chình quyền tài khoản</a>
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
                            <th width="10"><input type="checkbox" id="all"></th>
                            <th>ID khách hàng</th>
                            <th>Tên tài khoản</th>
                            <th>Họ và tên</th>
                            <th>Ảnh đại diện</th>
                            <th>SĐT</th>
                            <th>Loại tài khoản</th>
                            <th>Địa chỉ</th>
                            <th>Email</th>
                            <th width="80">Tính năng</th>
                        </tr>
                        </thead>
                        <tbody id="renderListAccount">
                        <c:forEach items="${requestScope.accounts}" var="o" varStatus="stt">
                            <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>${o.id}</td>
                                <td>${o.accountName}</td>
                                <td>${o.fullName}</td>
                                <td><img class="img-card-person" src="${url}/images/avatar-admin.png" alt=""></td>
                                <td>${o.phone}</td>
                                <td>
                                    <c:forEach items="${o.roles}" var="role" varStatus="status">
                                        ${role.name}<c:if test="${not status.last}">,</c:if>
                                    </c:forEach>
                                </td>
                                <td>${o.address }</td>
                                <td>${o.email}</td>
                                <td class="table-td-center">
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteUser(${o.id},${stt.index})"><i class="fas fa-trash-alt"></i>
                                    </button>
                                    <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                            onclick="editAccount(${o.id})" id="show-emp"
                                    ><i class="fas fa-edit"></i>
                                    </button>
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

    function submitForm(button) {
        let re = "";
        let form = $(button).closest("form");
        let form_data = $(form).serialize(); // lấy thông tin dữ liệu từ form
        let url = "${pageContext.request.contextPath}/admin-user/UserUpdate"; // đường dẫn đến file xử lý
        let reRoles;
        Swal.fire({
            title: 'Bạn có chắc chắn muốn sửa thông tin tài khoản này không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: url,
                        type: "POST",
                        data: form_data,
                        success: function (data) {
                            let listAcc = JSON.parse(JSON.parse(data).listAccount);
                            let isAdmin = JSON.parse(data).isAdmin;
                            for (let i = 0; i < listAcc.length; i++) {
                                reRoles = "";
                                for (let j = 0; j < listAcc[i].roles.length; j++) {
                                    reRoles += listAcc[i].roles[j].name;
                                    if (j < listAcc[i].roles.length - 1) {
                                        reRoles += ", ";
                                    }
                                }
                                re += ` <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td >` + listAcc[i].id + `</td>
                                <td>` + listAcc[i].accountName + `</td>
                                <td>` + listAcc[i].fullName + `</td>
                                <td><img class="img-card-person" src="${pageContext.request.contextPath}/admin/assets/images/avatar-admin.png" alt=""></td>
                                <td>` + listAcc[i].phone + `</td>
                                <td>
                                        ` + reRoles + `
                                </td>
                                <td>` + listAcc[i].address + `</td>
                                <td>` + listAcc[i].email + `</td>
                                <td class="table-td-center">
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteUser(` + listAcc[i].id + `)"><i class="fas fa-trash-alt"></i>
                                    </button>
                                     <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                            onclick="editAccount(` + listAcc[i].id + `)" id="show-emp"
                                    ><i class="fas fa-edit"></i>
                                    </button>
                                </td>
                            </tr>`
                            }
                            document.getElementById("renderListAccount").innerHTML = re;
                            Swal.fire('Sửa tài khoản thành công', '', 'success');
                        }
                        ,
                        error: function (xhr) {
                            console.log(xhr.statusText);
                        }
                    });
                } else if (result.isDenied) {
                    Swal.fire('Hủy sửa tài khoản', '', 'info');
                }
            }
        )
    }

    //Modal
    function editAccount(id) {
        let uid = id;
        let re = "";
        let roleRe = "";
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-user/UserUpdate",
            type: "GET",
            data: {
                uid: uid,
            },
            success: function (data) {
                let acc = JSON.parse(data).account;
                let roles = JSON.parse(data).roles;
                roleRe = `
  <label class="control-label">Loại tài khoản</label>
  <select class="form-control" style="height: 70px" name="role" multiple>
    <option value="1">Khách hàng</option>
    <option value="2">Nhân viên</option>
    <option value="3">Quản lý</option>
  </select>
`
                re = `<div class="modal fade show" id="ModalUP" style="display: block">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
       <form id"edit" action="${pageContext.request.contextPath}/admin-user/UserUpdate" method="post" >
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Chỉnh sửa thông tin khách hàng cơ bản</h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label">ID khách hàng</label>
                        <input class="form-control" name="uid" type="text" required value="` + acc.id + `" readonly>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Tên tài khoản</label>
                        <input class="form-control" name="user-name" id="name" type="text" required value="` + acc.accountName + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Họ và tên</label>
                        <input class="form-control" name="full-name" type="text" required value="` + acc.fullName + `">
                    </div>
                    <div class="form-group  col-md-6">
                        <label class="control-label">Số điện thoại</label>
                        <input class="form-control" name="user-phone" type="number" required value="` + acc.phone + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Địa chỉ email</label>
                        <input class="form-control" name="user-email" type="text" required value="` + acc.email + `">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Mật khẩu</label>
                       <input class="form-control" name="user-password" type="password" value="` + acc.password + `" readonly>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Đỉa chỉ</label>
                        <input class="form-control" name="user-address" type="text" value="` + acc.address + `">
                    </div>
                    <div class="form-group col-md-6">
                        ` + roleRe + `
                    </div>
                </div>
                <BR>
                <a href="#" style="    float: right;
        font-weight: 600;
        color: #ea0000;">Chỉnh sửa nâng cao</a>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="submitForm(this)">Lưu lại</button>
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
                var select = document.querySelector('select[name="role"]');

                // Đặt thuộc tính selected cho từng tùy chọn dựa trên mảng roles
                roles.forEach(function (role) {
                    var option = select.querySelector('option[value="' + role.id + '"]');
                    if (option) {
                        option.selected = true;
                    }
                });
            },
            error: function (data) {
                console.log(data)
            }
        });
    }

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

    function deleteUser(id, index) {
        let uid = id;
        let re = "";
        let reRoles;
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa tài khoản này không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-user/UserDelete",
                    type: "POST",
                    data: {
                        uid: uid
                    },
                    success: function (data) {
                        var currentPage = oTable.page(); // lưu trang hiện tại
                        oTable.row(index).remove().draw();
                        oTable.page(currentPage).draw(false); // thiết lập lại trang hiện tại sau khi vẽ lại bảng dữ liệu
                        let listAcc = JSON.parse(JSON.parse(data).listAccount);
                        let isAdmin = JSON.parse(data).isAdmin;
                        for (let i = 0; i < listAcc.length; i++) {
                            reRoles = "";
                            for (let j = 0; j < listAcc[i].roles.length; j++) {
                                reRoles += listAcc[i].roles[j].name;
                                if (j < listAcc[i].roles.length - 1) {
                                    reRoles += ", ";
                                }
                            }
                            re += ` <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td >` + listAcc[i].id + `</td>
                                <td>` + listAcc[i].accountName + `</td>
                                <td>` + listAcc[i].fullName + `</td>
                                <td><img class="img-card-person" src="${pageContext.request.contextPath}/admin/assets/images/avatar-admin.png" alt=""></td>
                                <td>` + listAcc[i].phone + `</td>
                                <td>` + reRoles + `</td>
                                <td>` + listAcc[i].address + `</td>
                                <td>` + listAcc[i].email + `</td>
                                <td class="table-td-center">
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteUser(` + listAcc[i].id + `)"><i class="fas fa-trash-alt"></i>
                                    </button>
                                     <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                            onclick="editAccount(` + listAcc[i].id + `)" id="show-emp"
                                    ><i class="fas fa-edit"></i>
                                    </button>
                                </td>
                            </tr>`
                        }
                        document.getElementById("renderListAccount").innerHTML = re;
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
</body>

</html>