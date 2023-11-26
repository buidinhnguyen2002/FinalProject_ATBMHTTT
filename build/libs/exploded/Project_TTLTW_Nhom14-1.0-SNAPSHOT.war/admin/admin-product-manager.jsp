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
        <title>Danh sách sản phẩm | Quản trị Admin</title>
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
                <li class="breadcrumb-item active"><a href="#"><b>Danh sách sản phẩm</b></a></li>
            </ul>
            <div id="clock"></div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="row element-button">
                            <div class="col-sm-2">

                                <a class="btn btn-add btn-sm" href="${pageContext.request.contextPath}/admin-products/ProductAddController" title="Thêm"><i
                                        class="fas fa-plus"></i>
                                    Tạo mới sản phẩm</a>
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
                                <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất
                                    Excel</a>
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"
                                   onclick="myFunction(this)"><i
                                        class="fas fa-file-pdf"></i> Xuất PDF</a>
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-delete btn-sm" type="button" title="Xóa" onclick="myFunction(this)"><i
                                        class="fas fa-trash-alt"></i> Xóa tất cả </a>
                            </div>
                        </div>
                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                            <tr>
                                <th width="10"><input type="checkbox" id="all"></th>
                                <th>Mã sản phẩm</th>
                                <th>Tên sản phẩm</th>
                                <th>Ảnh</th>
                                <th>Tình trạng</th>
                                <th>Nhà sản xuất</th>
                                <th>Giá tiền</th>
                                <th>Giảm giá (%)</th>
                                <th>Danh mục</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <tbody id="afterupdate">
                            <c:forEach var="list" items="${renderproduct}" varStatus="stt">
                                <tr>

                                    <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                    <td>${list.id}</td>
                                    <td>${list.nameProduct}</td>

                                    <td><img
                                            src="../images/${list.imageProducts.get(0).getImage()}"
                                            alt="./images/${list.imageProducts.get(0).getImage()}"
                                            class="img-responsive" width="80px"></td>


                                    <c:if test="${list.status == 'Còn hàng'}">
                                        <td><span class="badge bg-success">${list.status}</span></td>
                                    </c:if>
                                    <c:if test="${list.status == 'Hết hàng'}">
                                            <td><span class="badge bg-danger">${list.status}</span></td>
                                    </c:if>
                                    <c:if test="${list.status == 'Đang nhập hàng'}">
                                        <td><span class="badge bg-warning">${list.status}</span></td>
                                    </c:if>
                                    <td>${list.producer}</td>
                                    <td>${list.listPrice}</td>
                                    <td>${list.discount}</td>
                                    <td>${list.category}</td>
                                    <td>
                                        <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                                onclick="deleteProduct(${list.id} ,this)"><i class="fas fa-trash-alt"></i>
                                        </button>
                                        <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                                id="show-emp${list.id}"
                                                data-toggle="modal"
                                                data-target="#ModalUP" onclick="UpdateProduct(${list.id})"><i
                                                class="fas fa-edit"></i></button>
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
    <div id="showproduct"></div>
    <!--
    MODAL
    -->

    <!-- Essential javascripts for application to work-->
    <jsp:include page="./header/link-js.jsp" flush="true"/>
    <script type="text/javascript">$('#sampleTable').DataTable();</script>
    <script type="text/javascript">
        oTable = $('#sampleTable').DataTable();
        $('#all').click(function (e) {
            $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
            e.stopImmediatePropagation();
        });
        $('#sampleTable').DataTable();

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
        function deleteProduct(id, button) {
            let row = $(button).closest('tr');
            let idproduct = id;
            let text = "";
            Swal.fire({
                title: 'Bạn có muốn xóa sản phẩm này không?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'No',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin-products/ProductListController",
                        type: "POST",
                        data: {
                            idproduct: idproduct
                        },
                        success: function (data) {
                            let isdelete = JSON.parse(data).isDel;
                            if (isdelete) {
                                var currentPage = oTable.page(); // lưu trang hiện tại
                                oTable.row(row).remove().draw();
                                oTable.page(currentPage).draw(false); // thiết lập lại trang hiện tại sau khi vẽ lại bảng dữ liệu
                            }
                            Swal.fire('Xóa sản phẩm thành công', '', 'success');
                        },
                        error: function (data) {
                            console.log(data)
                        }
                    });
                } else if (result.isDenied) {
                    Swal.fire('Không xóa sản phẩm ', '', 'info');
                }
            })
        }

        function UpdateProduct(id) {
            let idproduct = id;
            let content = ""
            $.ajax({
                url: "${pageContext.request.contextPath}/admin-products/ProductEditController",
                type: "GET",
                data: {
                    idproduct: idproduct,
                },
                success: function (data) {
                    let datarepsone = JSON.parse(data);
                    let pardata = JSON.parse(datarepsone.products)
                    let categories = JSON.parse(datarepsone.listcate);
                    let option = "";
                    for (let i = 0; i < categories.length; i++) {
                        option += `<option value="` + categories[i].id + `"  >` + categories[i].nameCategory + ` </option>`
                    }

                    content = `<div class="modal fade show" id="ModalUP" style="display: block">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
           <form id"edit" action="${pageContext.request.contextPath}/admin-products/ProductEditController" method="post" >
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group  col-md-12">
                  <span class="thong-tin-thanh-toan">
                    <h5>Chỉnh sửa thông tin sản phẩm cơ bản</h5>
                  </span>
                        </div>
                    </div>
           <div class="row">
              <div class="form-group col-md-6">
                <label class="control-label">Mã sản phẩm </label>
                <input class="form-control" type="number" name="idproducts" value="` + pardata.id + `" readonly>
              </div>
              <div class="form-group col-md-6">
                <label class="control-label">Tên sản phẩm</label>
                <input class="form-control" type="text" name="nameproducts" required value="` + pardata.nameProduct + `">
              </div>


              <div class="form-group col-md-6 ">
                <label for="exampleSelect1" class="control-label">Tình trạng sản phẩm</label>
                <select class="form-control" name="status" id="exampleSelect1">
                  <option>Còn hàng</option>
                  <option>Hết hàng</option>
                  <option>Đang nhập hàng</option>
                </select>
              </div>
              <div class="form-group col-md-6">
                <label class="control-label">Giá bán</label>
                <input class="form-control" name="cost" type="number" min ="30000" max="400000" required  value="` + pardata.listPrice + `">
              </div>
               <div class="form-group col-md-6">
                <label class="control-label">%Giảm giá</label>
                <input class="form-control" name="discount" type="number" min="0" max="100" required value="` + pardata.discount + `">
              </div>
              <div class="form-group col-md-6">
                <label for="exampleSelect1" class="control-label">Danh mục</label>

                <select class="form-control" name="idcate" id="idcate"  >
                  ` + option + `
                </select>
              </div>
                    </div>
                    <BR>
                    <a href="${pageContext.request.contextPath}/admin-products/Edit?id=`+id+`" style="    float: right;
            font-weight: 600;
            color: #ea0000;">Chỉnh sửa nâng cao</a>
                    <BR>
                    <BR>
                    <button class="btn btn-save" type="button" onclick="save(this,` + id + `)">Lưu lại</button>
                    <a class="btn btn-cancel" onclick="closeModal()" href="#">Hủy bỏ</a>
                    <BR>
                </div>
    </form>
                <div class="modal-footer">
                </div>

            </div>
        </div>
    </div>`
                    document.getElementById("showproduct").innerHTML = content;
                },
                error: function (data) {
                    console.log("error");
                }
            });
        }

        function closeModal() {
            let modal = document.getElementById("showproduct");
            modal.innerHTML = '';
        }


        function save(button, idP) {
            let success = $(button).closest("form");
            let dataform = $(success).serialize();
            let newdata = "";
            var selectElement = document.getElementById("idcate");
            var selectedOption = selectElement.options[selectElement.selectedIndex];

            var selectedText = selectedOption.innerText;
            $.ajax({
                url: "${pageContext.request.contextPath}/admin-products/ProductEditController",
                type: "POST",
                data: dataform,

                success: function (data) {
                    let response = JSON.parse(data);
                    let product = JSON.parse(response.product);
                    let listsize =product.colorSizes;
                    let size="";
                    for (let i =0;i<listsize.length;i++){
                        size+=`
                         <option value="`+listsize[i].id+`" onclick="changesize()">`+listsize[i].size+`</option> `
                    }

                    let tt = "";

                        if (product.status === 'Còn hàng') {
                            tt = '<span class="badge bg-success">' + product.status + '</span>';
                        } else if (product.status === 'Hết hàng') {
                            tt = '<span class="badge bg-danger">' + product.status + '</span>';
                        } else if (product.status === 'Đang nhập hàng') {
                            tt = '<span class="badge bg-warning">' + product.status + '</span>';
                        }


                        newdata = `
                                    <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>` + product.id + `</td>
                                <td>` + product.nameProduct + `</td>

                                <td><img
                            src="../images/` + product.imageProducts[0].image + `"
                            alt="./images/` + product.imageProducts[0].image + `"
                            class="img-responsive" width="80px"></td>



                                <td>` + tt + `</td>

                                <td>` + product.producer.nameProducer + `</td>

                                 <td>` + product.listPrice + `</td>
                                  <td>` + product.discount + `</td>
                                <td>` +selectedText+`</td>
                                <td>
                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                            onclick="deleteProduct( )"><i class="fas fa-trash-alt"></i>
                                    </button>
                                    <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" id="show-emp` + product.id + `"
                                            data-toggle="modal"
                                            data-target="#ModalUP" onclick="UpdateProduct(` + product.id + `)"><i
                                        class="fas fa-edit"></i></button>
                                </td>
                           `
                        let row = $("#show-emp" + idP).closest('tr').html(newdata);
                        closeModal();
                        Swal.fire('Chỉnh sửa thành công :))))) ', '', 'success');


                    },


                error: function (data) {
                    console.log("error3");
                }
            });
        }
    </script>
    </body>

    </html>