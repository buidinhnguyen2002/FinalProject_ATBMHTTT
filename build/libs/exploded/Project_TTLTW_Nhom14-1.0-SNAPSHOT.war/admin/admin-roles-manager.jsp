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
    <title>Tùy chỉnh quyền | Quản trị Admin</title>
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
            <li class="breadcrumb-item active"><a href="#"><b>Quản lý quyền truy cập</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">Quyền khách hàng</h3>
                </div>
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <button class="btn btn-add btn-sm" onclick="editAccount('1')"><i
                                    class="fas fa-plus"></i>
                                Thêm trang truy cập
                            </button>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered" id="sampleTable">
                        <thead>
                        <tr>
                            <th>Trang</th>
                            <th>URL</th>
                            <th>Mô tả</th>
                            <th>Quyền truy cập</th>
                            <th width="40px">Tính năng</th>
                        </tr>
                        </thead>
                        <tbody id="renderRolesAccountCustomer">
                        <c:forEach items="${requestScope.resourcesCustomer}" var="o">
                            <tr>
                                <td>${o.name}</td>
                                <td>${o.url}</td>
                                <td>${o.description}</td>
                                <td>
                                    <c:set var="readChecked" value="false" scope="request"/>
                                    <c:set var="writeChecked" value="false" scope="request"/>
                                    <c:set var="removeChecked" value="false" scope="request"/>

                                    <c:forEach items="${requestScope.permissionCustomer}" var="p">
                                        <c:choose>
                                            <c:when test="${p.resource.id == o.id && p.action == 'read'}">
                                                <c:set var="readChecked" value="true" scope="request"/>
                                            </c:when>
                                            <c:when test="${p.resource.id == o.id && p.action == 'write'}">
                                                <c:set var="writeChecked" value="true" scope="request"/>
                                            </c:when>
                                            <c:when test="${p.resource.id == o.id && p.action == 'remove'}">
                                                <c:set var="removeChecked" value="true" scope="request"/>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>

                                    <input type="checkbox" name="access[]" value="read" id="readChecked_${o.id}"
                                           <c:if test="${readChecked}">checked</c:if>
                                           onchange="handleCheckboxChange('read', this.checked, '${o.id}')"> Đọc
                                    (read)<br>
                                    <input type="checkbox" name="access[]" value="write" id="writeChecked_${o.id}"
                                           <c:if test="${writeChecked}">checked</c:if>
                                           onchange="handleCheckboxChange('write', this.checked, '${o.id}')"> Ghi
                                    (write)<br>
                                    <input type="checkbox" name="access[]" value="remove" id="removeChecked_${o.id}"
                                           <c:if test="${removeChecked}">checked</c:if>
                                           onchange="handleCheckboxChange('remove', this.checked, '${o.id}')"> Xóa
                                    (remove)<br>
                                </td>
                                <td class="table-td-center">
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteResource('1',${o.id},this)"><i class="fas fa-trash-alt"></i>
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
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">Quyền nhân viên</h3>
                </div>
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <button class="btn btn-add btn-sm" onclick="editAccount('2')"><i
                                    class="fas fa-plus"></i>
                                Thêm trang truy cập
                            </button>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered" id="sampleTable1">
                        <thead>
                        <tr>
                            <th>Trang</th>
                            <th>URL</th>
                            <th>Mô tả</th>
                            <th>Quyền truy cập</th>
                            <th width="40px">Tính năng</th>
                        </tr>
                        </thead>
                        <tbody id="renderRolesAccountEmployee">
                        <c:forEach items="${requestScope.resourcesEmployee}" var="o">
                            <tr>
                                <td>${o.name}</td>
                                <td>${o.url}</td>
                                <td>${o.description}</td>
                                <td>
                                    <c:set var="readCheckedEmployee" value="false" scope="request"/>
                                    <c:set var="writeCheckedEmployee" value="false" scope="request"/>
                                    <c:set var="removeCheckedEmployee" value="false" scope="request"/>

                                    <c:forEach items="${requestScope.permissionEmployee}" var="p">
                                        <c:choose>
                                            <c:when test="${p.resource.id == o.id && p.action == 'read'}">
                                                <c:set var="readCheckedEmployee" value="true" scope="request"/>
                                            </c:when>
                                            <c:when test="${p.resource.id == o.id && p.action == 'write'}">
                                                <c:set var="writeCheckedEmployee" value="true" scope="request"/>
                                            </c:when>
                                            <c:when test="${p.resource.id == o.id && p.action == 'remove'}">
                                                <c:set var="removeCheckedEmployee" value="true" scope="request"/>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                    <input type="checkbox" name="access[]" value="read" id="readCheckedEmployee_${o.id}"
                                           <c:if test="${readCheckedEmployee}">checked</c:if>
                                           onchange="handleCheckboxChange('read', this.checked, '${o.id}')"> Đọc
                                    (read)<br>
                                    <input type="checkbox" name="access[]" value="write"
                                           id="writeCheckedEmployee_${o.id}"
                                           <c:if test="${writeCheckedEmployee}">checked</c:if>
                                           onchange="handleCheckboxChange('write', this.checked, '${o.id}')"> Ghi
                                    (write)<br>
                                    <input type="checkbox" name="access[]" value="remove"
                                           id="removeCheckedEmployee_${o.id}"
                                           <c:if test="${removeCheckedEmployee}">checked</c:if>
                                           onchange="handleCheckboxChange('remove', this.checked, '${o.id}')"> Xóa
                                    (remove)<br>
                                </td>
                                <td class="table-td-center">
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteResource('2',${o.id},this)"><i class="fas fa-trash-alt"></i>
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
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">Quyền Quản lý</h3>
                </div>
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <button class="btn btn-add btn-sm" onclick="editAccount('3')"><i
                                    class="fas fa-plus"></i>
                                Thêm trang truy cập
                            </button>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered" id="sampleTable2">
                        <thead>
                        <tr>
                            <th>Trang</th>
                            <th>URL</th>
                            <th>Mô tả</th>
                            <th>Quyền truy cập</th>
                            <th width="40px">Tính năng</th>
                        </tr>
                        </thead>
                        <tbody id="renderRolesAccountMod">
                        <c:forEach items="${requestScope.resourcesMod}" var="o">
                            <tr>
                                <td>${o.name}</td>
                                <td>${o.url}</td>
                                <td>${o.description}</td>
                                <td>
                                    <c:set var="readCheckedMod" value="false" scope="request"/>
                                    <c:set var="writeCheckedMod" value="false" scope="request"/>
                                    <c:set var="removeCheckedMod" value="false" scope="request"/>

                                    <c:forEach items="${requestScope.permissionMod}" var="p">
                                        <c:choose>
                                            <c:when test="${p.resource.id == o.id && p.action == 'read'}">
                                                <c:set var="readCheckedMod" value="true" scope="request"/>
                                            </c:when>
                                            <c:when test="${p.resource.id == o.id && p.action == 'write'}">
                                                <c:set var="writeCheckedMod" value="true" scope="request"/>
                                            </c:when>
                                            <c:when test="${p.resource.id == o.id && p.action == 'remove'}">
                                                <c:set var="removeCheckedMod" value="true" scope="request"/>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                    <input type="checkbox" name="access[]" value="read" id="readCheckboxMod_${o.id}"
                                           <c:if test="${readCheckedMod}">checked</c:if>
                                           onchange="handleCheckboxChange('read', this.checked, '${o.id}')"> Đọc
                                    (read)<br>
                                    <input type="checkbox" name="access[]" value="write" id="writeCheckboxMod_${o.id}"
                                           <c:if test="${writeCheckedMod}">checked</c:if>
                                           onchange="handleCheckboxChange('write', this.checked, '${o.id}')"> Ghi
                                    (write)<br>
                                    <input type="checkbox" name="access[]" value="remove" id="removeCheckboxMod_${o.id}"
                                           <c:if test="${removeCheckedMod}">checked</c:if>
                                           onchange="handleCheckboxChange('remove', this.checked, '${o.id}')"> Xóa
                                    (remove)<br>
                                </td>
                                <td class="table-td-center">
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteResource('3',${o.id},this)"><i class="fas fa-trash-alt"></i>
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
<div id="showEdit"></div>
<!-- Essential javascripts for application to work-->
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript">$('#sampleTable1').DataTable();</script>
<script type="text/javascript">$('#sampleTable2').DataTable();</script>
<script>
    function editAccount(type) {
        let re = "";
        let resource = "";
        let typeString = "";
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-user/PermissionAddController",
            type: "GET",
            data: {},
            success: function (data) {
                let resources = JSON.parse(data).resources;
                for (let i = 0; i < resources.length; i++) {
                    resource += ` <option value="` + resources[i].id + `">` + resources[i].url + ` (` + resources[i].name + `)</option>`;
                }
                if (type === '1') {
                    typeString = 'Khách hàng'
                }
                if (type === '2') {
                    typeString = 'Nhân viên'
                }
                if (type === '3') {
                    typeString = 'Quản lý'
                }

                re = `<div class="modal fade show" id="ModalUP" style="display: block">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
       <form id"edit" action="${pageContext.request.contextPath}/admin-user/UserUpdate" method="post" >
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Thêm trang truy cập cho `+typeString+` </h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <input style="display: none" type="text" name="type" value="` + type + `">
                    <div class="form-group col-md-6">
                        <label class="control-label">Chọn trang truy cập</label>
                            <select class="form-control" name="resource">
                                    ` + resource + `
                              </select>
                    </div>
                </div>
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
            },
            error: function (data) {
                console.log(data)
            }
        });
    }

    function submitForm(button) {
        let re = "";
        let form = $(button).closest("form");
        let form_data = $(form).serialize(); // lấy thông tin dữ liệu từ form
        let url = "${pageContext.request.contextPath}/admin-user/PermissionAddController"; // đường dẫn đến file xử lý
        let reRoles;
        Swal.fire({
            title: 'Bạn có chắc chắn muốn thêm trang truy cập không?',
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
                            Swal.fire({
                                title: 'Thêm trang truy thành công',
                                icon: 'success',
                                showCancelButton: false,
                                confirmButtonText: 'OK'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.reload(); // Load lại trang
                                }
                            });
                        }
                        ,
                        error: function (xhr) {
                            console.log(xhr.statusText);
                        }
                    });
                } else if (result.isDenied) {
                    Swal.fire('Hủy thêm trang truy cập', '', 'info');
                }
            }
        )
    }
    function deleteResource(idRole,id,button) {
        let row = $(button).closest('tr');
        let re = "";
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa trang truy cập này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-user/PermissionDeleteController",
                    type: "GET",
                    data: {
                        id: id,
                        idRole:idRole
                    },
                    success: function (data) {
                        let isSuc = JSON.parse(data).isSuc;
                        if (isSuc) {
                            Swal.fire({
                                title: 'Xóa thành công',
                                icon: 'success',
                                showCancelButton: false,
                                confirmButtonText: 'OK'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.reload(); // Load lại trang
                                }
                            });
                        }
                    },
                    error: function (data) {
                        console.log(data)
                    }
                });


            } else if (result.isDenied) {
                // Nếu người dùng chọn "No"
                // Hiển thị thông báo không xóa user bằng SweetAlert2
                Swal.fire('Không xóa', '', 'info');
            }
        })
    }
    function closeModal() {
        let modal = document.getElementById("showEdit");
        modal.innerHTML = '';
    }

    function handleCheckboxChange(action, isChecked, resourceId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-user/permission",
            type: "POST",
            data: {
                action: action,
                isChecked: isChecked,
                resourceId: resourceId
            },
            success: function (response) {
                Swal.fire({
                    title: 'Chỉnh sửa quyền thành công',
                    icon: 'success',
                    showCancelButton: false,
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload(); // Load lại trang
                    }
                });
            },
            error: function (xhr, status, error) {
                // Xử lý lỗi nếu có
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