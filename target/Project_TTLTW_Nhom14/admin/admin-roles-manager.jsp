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
    <button style="margin-bottom: 10px" class="btn btn-add btn-sm" onclick="addRole()"><i
            class="fas fa-plus"></i>
        Thêm vai trò
    </button>
    <jsp:useBean id="accountDAO" class="dao.admin.AccountDAO"></jsp:useBean>
    <c:forEach items="${requestScope.roles}" var="role">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div>
                        <h3 class="tile-title">Vai trò ${role.name}</h3>
                    </div>
                    <div class="tile-body">
                        <div class="row element-button">
                            <div class="col-sm-2">
                                <button class="btn btn-add btn-sm" onclick="editAccount('${role.id}')"><i
                                        class="fas fa-plus"></i>
                                    Thêm trang truy cập
                                </button>
                                <c:if test="${role.id>4}">
                                    <button class="btn btn-danger btn-sm" onclick="removeRole('${role.id}')"><i
                                            class="fas fa-plus"></i>
                                        Xóa vai trò
                                    </button>
                                </c:if>
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
                            <c:forEach items="${accountDAO.getResourceForRoles(role.id)}" var="o">
                                <tr>
                                    <td>${o.name}</td>
                                    <td>${o.url}</td>
                                    <td>${o.description}</td>
                                    <td>
                                        <c:set var="readChecked" value="false" scope="request"/>
                                        <c:set var="writeChecked" value="false" scope="request"/>
                                        <c:set var="removeChecked" value="false" scope="request"/>

                                        <c:forEach items="${accountDAO.getPermissionForRole(o.id)}" var="p">
                                            <c:choose>
                                                <c:when test="${p.resource.id == o.id && p.idRole == role.id  && p.action == 'read'}">
                                                    <c:set var="readChecked" value="true" scope="request"/>
                                                </c:when>
                                                <c:when test="${p.resource.id == o.id && p.idRole == role.id && p.action == 'write'}">
                                                    <c:set var="writeChecked" value="true" scope="request"/>
                                                </c:when>
                                                <c:when test="${p.resource.id == o.id && p.idRole == role.id && p.action == 'remove'}">
                                                    <c:set var="removeChecked" value="true" scope="request"/>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>

                                        <input type="checkbox" name="access[]" value="read" id="readChecked_${o.id}"
                                               <c:if test="${readChecked}">checked</c:if>
                                               onchange="handleCheckboxChange('read', this.checked, '${o.id}','${role.id}')">
                                        Đọc
                                        (read)<br>
                                        <input type="checkbox" name="access[]" value="write" id="writeChecked_${o.id}"
                                               <c:if test="${writeChecked}">checked</c:if>
                                               onchange="handleCheckboxChange('write', this.checked, '${o.id}','${role.id}')">
                                        Ghi
                                        (write)<br>
                                        <input type="checkbox" name="access[]" value="remove" id="removeChecked_${o.id}"
                                               <c:if test="${removeChecked}">checked</c:if>
                                               onchange="handleCheckboxChange('remove', this.checked, '${o.id}','${role.id}')">
                                        Xóa
                                        (remove)<br>
                                    </td>
                                    <td class="table-td-center">
                                        <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                                onclick="deleteResource('${role.id}',${o.id},this)"><i
                                                class="fas fa-trash-alt"></i>
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
    </c:forEach>
</main>
<div id="showEdit"></div>
<div id="addRole"></div>

<!-- Essential javascripts for application to work-->
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript">$('#sampleTable1').DataTable();</script>
<script type="text/javascript">$('#sampleTable2').DataTable();</script>
<script>

    function removeRole(idRole) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa vai trò này ( Lưu ý nếu bạn chọn xóa thì sẽ xóa tất các các vai trò này trong danh sách tài khoản)?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin-user/role-delete",
                    type: "POST",
                    data: {
                        idRole: idRole
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
                        }else {
                            Swal.fire('Xóa không thành công do bạn không đủ quyền xóa', '', 'info');
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

    function addRole() {
        let re = "";
        re = `<div class="modal fade show" id="ModalUP" style="display: block">
<form id ="addRole" >
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Thêm vai trò mới </h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label">Nhập tên vai trò</label>
                           <input class="form-control" name="nameRole" id="nameRole" type="text" required value="">
                    </div>
                </div>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="submitFormAddRole(this,)">Lưu lại</button>
                <a class="btn btn-cancel" onclick="closeModalAddRole()" href="#">Thoát</a>
                <BR>
            </div>
            <div class="modal-footer">
            </div>
</form>
        </div>
    </div>
</div>`
        document.getElementById("addRole").innerHTML = re;
    }

    function submitFormAddRole(button) {
        if (!checkFormNotEmpty("addRole")) return;
        let re = "";
        let form = $(button).closest("form");
        let nameRole = ""
        let form_data = $(form).serialize(); // lấy thông tin dữ liệu từ form
        let url = "${pageContext.request.contextPath}/admin-user/role-add"; // đường dẫn đến file xử lý
        let reRoles;
        nameRole = document.getElementById('nameRole').value;
        console.log(nameRole)
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
                        data: {nameRole: nameRole},
                        success: function (data) {
                            Swal.fire({
                                title: 'Thêm vai trò thành công',
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

    function editAccount(idRole) {
        let re = "";
        let resource = "";
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-user/PermissionAddController",
            type: "GET",
            data: {},
            success: function (data) {
                let resources = JSON.parse(data).resources;
                for (let i = 0; i < resources.length; i++) {
                    resource += ` <option value="` + resources[i].id + `">` + resources[i].url + ` (` + resources[i].name + `)</option>`;
                }
                re = `<div class="modal fade show" id="ModalUP" style="display: block">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
       <form id="addResource">
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Thêm trang truy cập</h5>
              </span>
                    </div>
                </div>
                <div class="row">
                <input style="display: none" class="form-control" name="idRole" type="text" required value="` + idRole + `">
                    <div class="form-group col-md-6">
                        <label class="control-label">Chọn trang truy cập</label>
                            <select class="form-control" name="resource">
                                    ` + resource + `
                              </select>
                    </div>
                </div>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="submitForm(this,` + idRole + `)">Lưu lại</button>
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

    function submitForm(button, idRole) {
        if (!checkFormNotEmpty('addResource')) return;
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

    function deleteResource(idRole, id, button) {
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
                        idRole: idRole
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
                        }else {
                            Swal.fire('Xóa không thành công do bạn không đủ quyền xóa', '', 'info');
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

    function closeModalAddRole() {
        let modal = document.getElementById("addRole");
        modal.innerHTML = '';
    }

    function handleCheckboxChange(action, isChecked, resourceId, idRole) {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-user/permission",
            type: "POST",
            data: {
                action: action,
                isChecked: isChecked,
                resourceId: resourceId,
                idRole: idRole
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
<script>
    document.getElementById("admin-user").classList.add("active");
</script>
</body>

</html>