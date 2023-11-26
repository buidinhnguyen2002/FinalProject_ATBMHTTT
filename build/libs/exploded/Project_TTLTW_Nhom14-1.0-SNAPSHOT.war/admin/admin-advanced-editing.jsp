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

                            <a class="btn btn-add btn-sm" href="form-add-san-pham.html" title="Thêm"><i
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
                            <th>Hình ảnh</th>
                            <th>Kích thước</th>
                            <th>Màu</th>
                            <th>Số lượng</th>
                            <th>Chức năng</th>
                        </tr>
                        </thead>
                        <tbody id="afterupdate">
                        <c:forEach var="o" items="${rendercolorsize.colorSizes}">
                            <tr>
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                                <td>${o.id}</td>
                                <td>${rendercolorsize.nameProduct}</td>
                                <td><img
                                        src="../images/${rendercolorsize.imageProducts.get(0).getImage()}"
                                        alt="./images/${rendercolorsize.imageProducts.get(0).getImage()}"
                                        class="img-responsive" width="80px"></td>
                                <td>${o.size}</td>
                                <td>${o.color}</td>
                                <td>${o.quantity}</td>


                                <td>
                                    <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"
                                            id="show-emp${o.id}"
                                            data-toggle="modal"
                                            data-target="#ModalUP"
                                            onclick="UpdateProduct(${rendercolorsize.id},${o.id})"><i
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


    function UpdateProduct(idProduct, id) {
        let content = ""
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-products/Editcolor",
            type: "GET",
            data: {
                idproduct: idProduct,
                idsize:id
            },
            success: function (data) {
                let datarepsone = JSON.parse(data);
                let pardata = JSON.parse(datarepsone.products);
                let color =  JSON.parse(datarepsone.colorSize);

                content = `<div class="modal fade show" id="ModalUP" style="display: block">
          <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
       <form id"edit" action="${pageContext.request.contextPath}/admin-products/Editcolor" method="post" >
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Chỉnh sửa thông tin nâng cao</h5>
              </span>
                    </div>
                </div>
       <div class="row">
          <div class="form-group col-md-6">
            <label class="control-label">Mã sản phẩm </label>
            <input class="form-control" type="number" name="idProduct" value="` + pardata.id + `" readonly>
          </div>
          <div class="form-group col-md-6">
            <label class="control-label">Tên sản phẩm</label>
            <input class="form-control" type="text" name="nameProduct" required value="` + pardata.nameProduct + `" readonly>
          </div>
           <div class="form-group col-md-6">
            <label class="control-label">Mã kích thước </label>
         <input class="form-control" type="text" name="idSize" required value="` + id + `" readonly>

          </div>
         <div class="form-group col-md-6">
            <label for="exampleSelect1" class="control-label">Nhập màu bạn muốn thay đổi</label>
          <input class="form-control" type="text" name="color" required value="`+color.color+`">
          </div>
          <div class="form-group col-md-6">
            <label for="exampleSelect1" class="control-label">Số lượng</label>
              <input class="form-control" name="number" type="number" min="1"  required  value= "` + color.quantity + `">

          </div>
                </div>
                <BR>
                <button class="btn btn-save" type="button" onclick="save(this,` +id + `)">Lưu lại</button>
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


    function save(button, idSize) {
        let success = $(button).closest("form");
        let dataform = $(success).serialize();
        let newinvent = "";
        $.ajax({
            url: "${pageContext.request.contextPath}/admin-products/Editcolor",
            type: "POST",
            data: dataform,
            success: function (data) {
                let response = JSON.parse(data);
                let newdata = JSON.parse(response.update);
                let newColor = response.newcolor;
                let newSize = "";
                let newQuantity = response.newquantity;
                let idSizeColor = response.idSizeColor;
                for (let i =0;i<newdata.colorSizes.length;i++){
                    if(newdata.colorSizes[i].id==idSizeColor){
                        newSize = newdata.colorSizes[i].size;

                    }
                }


                newinvent = `
                                <td width="10"><input type="checkbox" name="check1" value="1"></td>
                            <td>` + newdata.id + `</td>
                            <td>` + newdata.nameProduct + `</td>
                          <td><img
                        src="../images/` + newdata.imageProducts[0].image + `"
                        alt="./images/` + newdata.imageProducts[0].image + `"
                        class="img-responsive" width="80px"></td>
                            <td>`+newSize+`</td>
                             <td>`+newColor+`</td>
                              <td>`+newQuantity+`</td>
                            <td>
                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" id="show-emp`+ idSizeColor + `"
                                        data-toggle="modal"
                                        data-target="#ModalUP" onclick="UpdateProduct(` + newdata.id + `,` + idSizeColor + `)"><i
                                    class="fas fa-edit"></i></button>
                            </td>
                       `
                let row = $("#show-emp" + idSizeColor).closest('tr').html(newinvent);
                console.log(newinvent)
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
