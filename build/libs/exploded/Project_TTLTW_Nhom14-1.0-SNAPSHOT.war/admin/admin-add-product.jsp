<%--
  Created by IntelliJ IDEA.
  User: RynVi
  Date: 14/06/2023
  Time: 2:41 PM
  To change this template use File | Settings | File Templates.
--%>
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
  <title>Thêm sản phẩm | Quản trị Admin</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="./header/link-css.jsp" flush="true"/>
  <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
  <style>
    #uploadFile,
    #uploadFileMain {
      display: none; /* Ẩn phần input file mặc định */
    }

    .custom-upload,
    .custom-upload-main {
      display: inline-block;
      padding: 8px 12px;
      background-color: #e0e0e0;
      border-radius: 4px;
      cursor: pointer;
    }

    .custom-upload:hover,
    .custom-upload-main:hover {
      background-color: #d0d0d0;
    }

    .custom-upload-label,
    .custom-upload-label-main {
      font-size: 14px;
      color: #333;
    }

    .custom-upload-input,
    .custom-upload-input-main {
      display: none;
    }

    #imageContainer {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      grid-gap: 10px;
      position: relative;
    }

    #imageContainerMain {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      grid-gap: 10px;
      position: relative;
    }
    .thumbnail-image-main{
      position: relative;
      width: 250%;
      height: auto;
    }

    .thumbnail-image {
      position: relative;
      width: 100%;
      height: 150px; /* Chiều cao cố định, thay đổi giá trị tùy ý */
      overflow: hidden;
    }

    .thumbnail-image img {
      width: 100%;
      height: auto;
      object-fit: cover;
    }

    .thumbnail-image:before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      box-sizing: border-box;
      border: 5px solid black; /* Màu viền đen, thay đổi giá trị tùy ý */
      z-index: 1;
    }

    .avatar-text {
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      text-align: center;
      background-color: rgba(0, 0, 0, 0.7);
      color: #fff;
      padding: 5px;
      font-size: 12px;
    }
  </style>
</head>

<body class="app sidebar-mini rtl">
<!-- Navbar-->
<jsp:include page="./header/admin-left-sidebar.jsp" flush="true"/>
<main class="app-content">
  <div class="app-title">
    <ul class="app-breadcrumb breadcrumb">
      <li class="breadcrumb-item">Danh sách sản phẩm</li>
      <li class="breadcrumb-item"><a href="#">Thêm sản phẩm</a></li>
    </ul>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="tile">
        <h3 class="tile-title">Tạo mới sản phẩm</h3>
        <div class="tile-body">
          <div class="row element-button">
            <div class="col-sm-2">
              <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#exampleModalCenter"><i
                      class="fas fa-folder-plus"></i> Thêm nhà cung cấp</a>
            </div>
            <div class="col-sm-2">
              <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#adddanhmuc"><i
                      class="fas fa-folder-plus"></i> Thêm danh mục</a>
            </div>
          </div>
          <form class="row" enctype="multipart/form-data" method="post"
                action="${pageContext.request.contextPath}/admin-products/ProductAddController">
            <div class="form-group col-md-3">
              <label class="control-label">Tên sản phẩm</label>
              <input class="form-control" type="text">
            </div>
            <div class="form-group  col-md-3">
              <label class="control-label">Số lượng</label>
              <input class="form-control" type="number">
            </div>
            <div class="form-group col-md-3">
              <label for="exampleSelect2" class="control-label">Danh mục</label>
              <select class="form-control" id="exampleSelect2">
                <option>-- Chọn danh mục --</option>
                <option>Bàn ăn</option>
                <option>Bàn thông minh</option>
                <option>Tủ</option>
                <option>Ghế gỗ</option>
                <option>Ghế sắt</option>
                <option>Giường người lớn</option>
                <option>Giường trẻ em</option>
                <option>Bàn trang điểm</option>
                <option>Giá đỡ</option>
              </select>
            </div>
            <div class="form-group col-md-3 ">
              <label for="exampleSelect3" class="control-label">Nhà cung cấp</label>
              <select class="form-control" id="exampleSelect3">
                <option>-- Chọn nhà cung cấp --</option>
                <option>Phong vũ</option>
                <option>Thế giới di động</option>
                <option>FPT</option>
                <option>Võ Trường</option>
              </select>
            </div>
            <div class="form-group col-md-3">
              <label class="control-label">Giá bán</label>
              <input class="form-control" type="text">
            </div>
            <div class="form-group col-md-3">
              <label class="control-label">Giá vốn</label>
              <input class="form-control" type="text">
            </div>
            <div class="form-group col-md-12">
              <label class="control-label">Ảnh đại diện sản phẩm</label> <br>
              <label for="uploadFileMain" class="custom-upload-main">
                <span class="custom-upload-label-main">Chọn tệp tin</span>
                <input type="file" id="uploadFileMain" name="mainImage" onchange="readURLMain(this);" class="custom-upload-input-main">
              </label>
              <div id="imageContainerMain"></div>
              <label class="control-label">Ảnh mô tả sản phẩm</label> <br>
              <label for="uploadFile" class="custom-upload">
                <span class="custom-upload-label">Chọn tệp tin</span>
                <input type="file" id="uploadFile" name="descriptionImages" onchange="readURL(this);" multiple class="custom-upload-input">
              </label>
              <div id="imageContainer"></div>
              <br>
            </div>
            <div class="form-group col-md-12">
              <label class="control-label">Mô tả sản phẩm</label>
              <textarea class="form-control" name="mota" id="mota"></textarea>
            </div>
            <div class="form-group col-md-12">
              <button class="btn btn-save" type="submit">Lưu lại</button>
              <a class="btn btn-cancel" href="#">Hủy bỏ</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</main>
<jsp:include page="./header/link-js.jsp" flush="true"/>
<script>
  function readURL(input) {
    if (input.files && input.files.length > 0) {
      let imageContainer = document.getElementById("imageContainer");
      let inputImage = document.getElementById("uploadFile");
      imageContainer.innerHTML = "";

      // Kiểm tra số lượng hình ảnh nằm trong khoảng giới hạn cho phép
      if (input.files.length < 4 || input.files.length > 5) {
        Swal.fire("Vui lòng chọn từ 4 đến 5 hình ảnh.", "", "error");
        inputImage.value = "";
        return;
      }
      for (let i = 0; i < input.files.length; i++) {
        let reader = new FileReader();
        let file = input.files[i];
        reader.readAsDataURL(file);
        reader.onload = function (e) {
          let imgElement = document.createElement("img");
          imgElement.src = e.target.result;
          imgElement.classList.add("thumbnail-image");
          imageContainer.appendChild(imgElement);
        };
      }
    }
  }
  function readURLMain(input) {
    if (input.files && input.files[0]) {
      let imageContainer = document.getElementById("imageContainerMain");
      let inputImage = document.getElementById("uploadFileMain");
      imageContainer.innerHTML = "";

      let reader = new FileReader();
      let file = input.files[0];
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        let imgElement = document.createElement("img");
        imgElement.src = e.target.result;
        imgElement.classList.add("thumbnail-image-main");
        imageContainer.appendChild(imgElement);
      };
    }
  }

</script>
</body>
</html>