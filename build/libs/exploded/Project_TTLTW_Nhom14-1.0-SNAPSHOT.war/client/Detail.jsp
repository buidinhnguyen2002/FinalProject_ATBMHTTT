<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>${detail.nameProduct}</title>
    <link rel="icon" type="image" href="../images/HaLoicon.png"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="${url}/client/assets/css/style.css">
    <jsp:include page="./link/Link.jsp"></jsp:include>

    <link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/single-product.css?1564585558451" rel="stylesheet"
          type="text/css" media="all"/>
</head>

<body>
<!-- Load page -->
<%--<div id="preloder">--%>
<%--    <div class="loader"></div>--%>
<%--</div>--%>
<div class="page">
    <jsp:include page="./header/Header.jsp"></jsp:include>
    <!-- Main Content -->
    <div class="category-page-layout">
        <div class="container">
            <div class="row">
                <article
                        class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sk-product-detail-content-col">
                    <div class="sk-main-content-head">
                        <div class="breadcrumb-wrap">
                            <ul>
                                <li><a href="IndexControl">Trang chủ</a></li>

                                <li><a href=""><span>/</span> ${detail.category.nameCategory}</a></li>

                                <li class="active"><a href=""><span>/</span> ${detail.nameProduct}</a></li>
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <!-- End .sk-main-content-head -->
                    <div class="row sk-sigle-content product-view"
                         itemtype="http://schema.org/Product">
                        <div class="col-md-6 col-sm-12 col-xs-12">
                            <div class="sk-product-slider-wrap">
                                <div class="product-img-box">
                                    <div id="sync1" class="owl-carousel css_detail_owl">
                                        <c:forEach var="o" items="${detail.imageProducts}">
                                            <div class="item large-image">
                                                <img src="./images/${o.getImage()}" alt="">
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div id="sync2" class="owl-carousel">
                                        <c:forEach var="o" items="${detail.imageProducts}">
                                            <div class="item">
                                                <img src="./images/${o.getImage()}" alt="">
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12">

                            <div class="sk-page-detail-title">
                                <h1 itemprop="name" class="pd-name">${detail.nameProduct}</h1>
                            </div>
                            <div class="sk-price-box clearfix">
                                <div class="pull-left">
                                    <div class="sale">
                                        <span>Giá gốc:</span>
                                        <del class="old-price">
                                            ${detail.listPrice}
                                        </del>
                                    </div>
                                    <span><fmt:message key="price" bundle="${lang}"></fmt:message>:</span>
                                    <span class="price">${detail.discountPrice} VNĐ</span>
                                </div>
                                <div class="stock pull-left">
                                    <c:if test="${detail.inventory.quantity == 0}">
                                        <div class="availability out-stock pull-right">
                                            <span>Hết hàng</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${detail.inventory.quantity != 0}">
                                        <div class="availability in-stock pull-right">
                                            <span><fmt:message key="Stocking" bundle="${lang}"></fmt:message></span>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                            <ul class="sk-product-info-wrap">

                                <li>
                                    <span>Mã sản phẩm:</span>
                                    <span>${detail.supplier.nameSupplier}</span>
                                </li>


                                <li>
                                    <span>Thương hiệu:</span>
                                    <span>${detail.producer.nameProducer}</span>
                                </li>

                            </ul>
                            <p class="pd-description-mini">${requestScope.detail.description}</p>
                            <div class="pd-form">
                                <c:url var="addToCart" value="cart/AddToCartControl"></c:url>
                                <form action="${addToCart}?pid=${requestScope.detail.id}" method="post">
                                    <div class="pd-form-top clearfix">
                                        <div class="selector-wrapper">
                                            <select id="product-select" name="variantId" class="single-option-selector">
                                                <c:forEach var="o" items="${requestScope.detail.colorSizes}">
                                                    <c:if test="${o.quantity==0}">
                                                        <option disabled value="${o.size}/${o.color}" data-quantity="0">HẾT HÀNG - ${o.size}/${o.color}</option>
                                                    </c:if>
                                                    <c:if test="${o.quantity!=0}">
                                                        <option value="${o.size}/${o.color}" data-quantity="${o.quantity}">${o.size}/${o.color} - Còn ${o.quantity} sản phẩm</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="pd-form-bottom clearfix">
                                        <c:set var="found" value="false" />
                                        <c:forEach var="o" items="${requestScope.detail.colorSizes}" varStatus="loop">
                                            <c:if test="${!found && o.quantity!=0}">
                                                <c:set var="quantity" value="${o.quantity}" />
                                                <c:set var="found" value="true" />
                                            </c:if>
                                            <c:if test="${found}">
                                                <c:set var="loop.break" value="true" />
                                            </c:if>
                                        </c:forEach>

                                        <input type="number" class="single-input-selector" value="1" min="1" max="${quantity}" name="quantity">
                                        <button style="padding: 10px 23px; border: 0; background-color: #79bd9a; text-transform: uppercase; font-weight: 700; color: #fff" type="submit" class="button" title="Đặt hàng" type="submit">
                                            <span><fmt:message key="ORDER" bundle="${lang}"></fmt:message></span>
                                        </button>
                                    </div>
                                </form>
                                <script>// Lấy các phần tử cần dùng
                                const select = document.getElementById("product-select");
                                const input = document.querySelector("input[name=quantity]");

                                // Lắng nghe sự kiện onchange trên select
                                select.addEventListener("change", function(event) {
                                    const selectedOption = event.target.selectedOptions[0];
                                    input.max = selectedOption.getAttribute("data-quantity");
                                    input.value = 1; // reset giá trị của input khi select thay đổi
                                });
                                </script>
                                <div class="sk-hotline-block">
										<span><fmt:message key="Call.now.for.buying.advice"
                                                           bundle="${lang}"></fmt:message></span>
                                    <div class="sk-widget-title pink-bg-widget">
                                        <h5>
                                            Hotline: <a href="tel:">0364677119</a>
                                        </h5>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="sk-shipping">
                                    <img
                                            src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/icon-dt.jpg?1564585558451"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </article>
                <article class="col-lg-8 col-md-8 col-sm-12 col-xs-12 sk-product-detail-content-col">
                    <div class="sk-pt-wrap">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs sk-pt-nav" id="sk-pt-nav" role="tablist">

                            <li role="presentation" class="active">
                                <a href="#pd-binh-luan" role="tab" data-toggle="tab" aria-controls="home"
                                   aria-expanded="true">Bình luận sản phẩm</a>
                            </li>

                            <li role="presentation">
                                <a href="#pd-thong-tin" role="tab" data-toggle="tab" aria-controls="profile"
                                   aria-expanded="false">Thông tin sản phẩm</a>
                            </li>

                            <li role="presentation">
                                <a href="#pd-dac-diem" role="tab" data-toggle="tab" aria-controls="profile"
                                   aria-expanded="false">Thông tin thanh toán</a>
                            </li>


                            <li role="presentation">
                                <a href="#pd-danh-gia" role="tab" data-toggle="tab" aria-controls="profile"
                                   aria-expanded="false">Chính sách vận chuyển</a></li>

                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content" id="sk-pt-content">
                            <div role="tabpanel" class="tab-pane active" id="pd-binh-luan">
                                <form id="formcomment">
                                    <c:if test="${sessionScope.acc.fullName !=null}">

                                        <div><textarea name="comment" id="comment"
                                                       placeholder="Nhập nội dung bạn muốn bình luận: " cols="30"
                                                       rows="10" required
                                                       style="width: 698px; height: 111px; resize: none"
                                        ></textarea></div>
                                        <div>
                                            <button type="submit" id="btn-comment" style="width: 6% ;height: 31px">Gửi
                                            </button>
                                        </div>
                                    </c:if>
                                </form>
                                <div id="box">
                                    <div id="mycmt">

                                        <c:forEach items="${list}" var="lists" varStatus="status">
                                            <div class="product-length" id="cmt-box" >
                                                <div>${lists.nameAccount}</div>
                                                <div style="margin-top: 1%;">${lists.gettimeover()}</div>
                                                <div class="cmts"><h5 style="color: #1d2124">Đánh giá sản
                                                    phẩm:</h5>  ${lists.content}</div>
                                                <button type="button" class="reply_btn" style="margin-top: 2%"
                                                        onclick="formContext(this,`show`)">
                                                    Trả lời
                                                </button>
                                                <div class="repuser" id="repcmt">
                                                    <c:forEach items="${lists.listreply}" var="listrep">
                                                        <form id="form-reply">
                                                            <div id="cmt-reply-box" class="cssformcomment">
                                                                <div class="rep">${listrep.nameAccount}</div>
                                                                <div style=" margin-left: 6%; margin-top: 1%;" >${listrep.differencetime}</div>
                                                                <div class="cmtr" style="padding-left: 6%"><h5
                                                                        style="color: #1d2124">Đã bình luận phản
                                                                    hồi:</h5>  ${listrep.content}</div>

                                                            </div>
                                                                <%--                                                        <button type="button" class="updatetext" id="update" onclick="updatecontent()">Chỉnh sửa</button>--%>

                                                        </form>

                                                        <%--                                                    <div id = "like-box" class="likebth">--%>
                                                        <%--                                                        <button type="button" id ="click" onclick="likebutton()"><i class="fa-light fa-heart"></i></button>--%>
                                                        <%--                                                        <span id="number" type="text">0</span>--%>
                                                        <%--                                                    </div>--%>
                                                    </c:forEach>

                                                </div>
                                                <c:if test="${sessionScope.acc.fullName !=null}">
                                                    <form class="reply formReply hiddenForm" id="form-reply">
                                                        <div><textarea name="comment-rep" id="admin-comment"
                                                                       placeholder="Nhập nội dung bạn muốn phản hồi: "
                                                                       cols="30" rows="10" required
                                                                       style="width: 698px; height: 111px; resize: none"
                                                        ></textarea></div>
                                                        <div>
                                                            <button type="button" id="admin-btn-comment"
                                                                    onclick="formContext(this,`submit`)"
                                                                    style="width: 6% ;height: 31px" value="${lists.id}">Gửi
                                                            </button>
                                                        </div>
                                                    </form>
                                                </c:if>

                                            </div>
                                        </c:forEach>

                                    </div>
                                    <button type="button" class="btn-load" id="load" onclick="showmorerep()">Load more</button>
                                </div>
                            </div>
                            <script>


                                $('#formcomment').submit(function (e) {
                                    e.preventDefault();
                                    <c:url var="cmt" value="Commentcontrol"></c:url>;
                                    let content_comment = document.getElementById("comment");
                                    $.ajax({
                                        url: "Commentcontrol",
                                        type: 'POST',
                                        data:{
                                            content: $(content_comment).val(),
                                            pid:${detail.id},
                                        },
                                        success: function (data) {
                                            let datarespone = JSON.parse(data);
                                            let dataafter = JSON.parse(datarespone.comment_user);
                                            var commentHtml = '<div  id="cmt-box" style="border-bottom: 1px #b3b7bb solid; padding-top: 5% ;margin-bottom: 5%">' +
                                                '<div>' + dataafter.nameAccount + '</div>' +
                                                '<div>'+dataafter.differencetime +'</div>' +
                                                '<div class="cmts"><h5 style="color: #1d2124">Đánh giá sản phẩm:</h5> ' + dataafter.content + '</div>'
                                            '</div>';
                                            console.log(dataafter);
                                            $('#cmt-box').prepend(commentHtml);

                                            $('#formcomment')[0].reset();
                                        },
                                        error: function (error) {
                                            // Xử lý lỗi
                                            console.log(error);
                                        }
                                    });
                                })


                                function formContext(button, type) {
                                    let form = $(button).closest("#cmt-box").find(".formReply");
                                    // 2 nút điều tìm tới formReply
                                    form.toggleClass('showForm');
                                    if (type === "submit") {
                                        let content_comment = form.find("#admin-comment");
                                        let formreplynguoidung = $(button).closest("#cmt-box").find(".repuser");
                                        $.ajax({
                                            url: "Replycontrol",
                                            type: "post",
                                            data: {
                                                content: $(content_comment).val(),
                                                pid:${detail.id},
                                                idParent: $(button).val(),
                                            },
                                            success: function (data) {

                                                let responereply = JSON.parse(data);
                                                let afterresponereply = JSON.parse(responereply.comment_reply);
                                                let varreply = '<div class ="cssformcomment">' +
                                                    '<div id="cmt-reply-box" class="rep">' + afterresponereply.nameAccount + '</div>'
                                                    +'<div style=" margin-left: 6%;margin-top: 1%;">'+afterresponereply.differencetime+ '</div>'+
                                                    '<div class="cmtr" style="padding-left: 6%"><h5 style="color: #1d2124">Đã phản hồi bình luận:</h5> ' + afterresponereply.content + '</div>'
                                                '</div>'
                                                $(formreplynguoidung).append(varreply);
                                                $('#form-reply')[0].reset();

                                            },
                                            error: function (error) {
                                                // Xử lý lỗi
                                                console.log(error);
                                            }
                                        });
                                    }
                                }
                                function showmorerep() {
                                    var numincrease = document.getElementsByClassName("product-length").length;

                                    $.ajax({
                                        url: "Showmorecontrol",
                                        type: "post",
                                        data: {
                                            pid:${detail.id},
                                            num: numincrease,
                                        },
                                        success: function (data) {
                                            let respone = JSON.parse(data);
                                            let show = JSON.parse(respone.show);
                                            let test = "";
                                            let reply ="";
                                            let comt = "";
                                            let formrep="";
                                            for (let i = 0; i < show.length; i++) {
                                                comt =show[i].listreply;
                                                reply="";
                                                formrep="";
                                                for (let j = 0; j < comt.length; j++) {
                                                    reply += ` <div class="repuser" id="repcmt">
                                                              <form id="form-reply">
                                                            <div id="cmt-reply-box" class="cssformcomment">
                                                            <div class="rep">` + comt[j].nameAccount + `</div>
                                                            <div style=" margin-left: 6%; margin-top: 1%;" >` + comt[j].differencetime + `</div>
                                                            <div class="cmtr" style="padding-left: 6%"><h5
                                                                    style="color: #1d2124">Đã bình luận phản
                                                                hồi:</h5>` + comt[j].content + `</div>
                                                        </div>
                                                         </form>
                                                        </div> `;
                                                    $('#form-reply')[0].reset();

                                                }
                                                // if(ahihi!=null){
                                                formrep+=` <form class="reply formReply hiddenForm" id="form-reply">
                                                    <div><textarea name="comment-rep" id="admin-comment"
                                                                   placeholder="Nhập nội dung bạn muốn phản hồi: "
                                                                   cols="30" rows="10" required
                                                                   style="width: 698px; height: 111px; resize: none"
                                                    ></textarea></div>
                                                    <div>
                                                        <button type="button" id="admin-btn-comment"
                                                                 onclick="formContext(this,\`submit\`)"
                                                                style="width: 6% ;height: 31px" value="`+show[i].id+`">Gửi
                                                        </button>
                                                    </div>
                                                </form>`
                                                // }

                                                test += '<div  class="product-length" id="cmt-box" style="border-bottom: 1px #b3b7bb solid; padding-top: 5% ;margin-bottom: 5%">' +
                                                    '<div>' + show[i].nameAccount + '</div>' +
                                                    '<div>' + show[i].differencetime + '</div>' +
                                                    '<div class="cmts"><h5 style="color: #1d2124">Đánh giá sản phẩm:</h5> ' + show[i].content + '</div>' +
                                                    ' <button type="button" class="reply_btn" style="margin-top: 2%" onclick="formContext(this,`show`)">' + "Trả lời" +
                                                    '</button>'  +reply+formrep+
                                                    '</div>';

                                            }
                                            if (show.length>0){
                                                $('#mycmt').append(test);

                                            }else {
                                                let buttonshow = document.getElementById("load")
                                                buttonshow.style.display = "none";
                                            }
                                        },

                                        error: function (error) {
                                            // Xử lý lỗi
                                            console.log(error);
                                        }
                                    });
                                }


                            </script>

                            <div role="tabpanel" class="tab-pane " id="pd-thong-tin">
                                <p>Chất liệu vải là tiêu chí đầu tiên khi các bậc làm cha mẹ chọn lựa quần áo cho bé
                                    .</p>

                                <p>Váy thô cho bé gái được làm từ chất liệu cotton mềm, giặt nhiều không sờn, không bạc
                                    màu là sự lựa chọn tối ưu cho bé gái.</p>

                                <p><img src="//bizweb.dktcdn.net/100/117/632/products/aovay11.jpg?v=1473606362390"/></p>

                                <p>Được làm từ chất liệu cotton rất mềm mại cho bé cảm giác thoải mái khi mặc trong
                                    những ngày hè nóng bức.</p>

                                <p>Kiểu dáng váy thời trang, xinh xắn, phù hợp cho bé cả khi dự tiệc</p>

                                <p>ự kết hợp hài hòa giữa gam màu tươi mát với họa tiết thêu nổi cực xinh tạo nên chiếc
                                    váy bé gái 1 - 8 tuổi vô cùng thời trang.Vải mềm, nhẹ, thoáng mát đảm bảo các mẹ ở
                                    xa nhận được hàng sẽ thích mê!</p>

                                <p><strong>ĐIỂM NỔI BẬT:</strong><br/>
                                    - Những sắc màu tươi sáng của chiếc đầm bé gái không chỉ giúp bé trở nên nổi bật mà
                                    còn giúp bé cảm thấy luôn vui vẻ.<br/>
                                    - Bộ váy khiến cho bé yêu trông rực rỡ qua thiết kế thêu nổi khéo léo, đẹp mắt ở
                                    phần chân váy cùng form dáng suông nhẹ nhàng, dễ mặc<br/>
                                    - Đầm suông vải xô, bên trong lót kate được thiết kế ấn tượng, bé sẽ trở nên thật
                                    thu hút và nổi bật khi đi dạo cùng bố mẹ.<br/>
                                    - Hình được chụp từ sản phẩm thật nên đảm bảo mẹ nhận được hàng sẽ ưng ý ngay</p>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="pd-dac-diem">
                                Bước 1: Truy cập website và lựa chọn sản phẩm cần mua để mua hàng
                                Bước 2: Click và sản phẩm muốn mua, màn hình hiển thị ra pop up với các lựa chọn sau
                                Nếu bạn muốn tiếp tục mua hàng: Bấm vào phần tiếp tục mua hàng để lựa chọn thêm sản phẩm
                                vào giỏ hàng
                                Nếu bạn muốn xem giỏ hàng để cập nhật sản phẩm: Bấm vào xem giỏ hàng
                                Nếu bạn muốn đặt hàng và thanh toán cho sản phẩm này vui lòng bấm vào: Đặt hàng và thanh
                                toán
                                Bước 3: Lựa chọn thông tin tài khoản thanh toán
                                Nếu bạn đã có tài khoản vui lòng nhập thông tin tên đăng nhập là email và mật khẩu vào
                                mục đã có tài khoản trên hệ thống
                                Nếu bạn chưa có tài khoản và muốn đăng ký tài khoản vui lòng điền các thông tin cá nhân
                                để tiếp tục đăng ký tài khoản. Khi có tài khoản bạn sẽ dễ dàng theo dõi được đơn hàng
                                của mình
                                Nếu bạn muốn mua hàng mà không cần tài khoản vui lòng nhấp chuột vào mục đặt hàng không
                                cần tài khoản
                                Bước 4: Điền các thông tin của bạn để nhận đơn hàng, lựa chọn hình thức thanh toán và
                                vận chuyển cho đơn hàng của mình
                                Bước 5: Xem lại thông tin đặt hàng, điền chú thích và gửi đơn hàng
                                Sau khi nhận được đơn hàng bạn gửi chúng tôi sẽ liên hệ bằng cách gọi điện lại để xác
                                nhận lại đơn hàng và địa chỉ của bạn.
                                Trân trọng cảm ơn.

                            </div>


                            <div role="tabpanel" class="tab-pane" id="pd-danh-gia">
                                Với mong muốn mang lại sự hài lòng cho quý khách khi mua hàng, chúng tôi có những quy
                                định trong vận chuyển, nhằm đảm bảo rằng những sản phẩm quý khách mua là sản phẩm mà vừa
                                ý nhất.
                                1. Chúng tôi sẽ được thực hiện và chuyển phát dựa trên mẫu khách hàng đã chọn. Trường
                                hợp không có đúng sản phẩm Quý khách yêu cầu chúng tôi sẽ gọi điện xác nhận gửi sản phẩm
                                tương tự thay thế.
                                2. Thời gian chuyển phát tiêu chuẩn cho một đơn hàng là 12 giờ kể từ lúc đặt hàng.
                                Chuyển phát sản phẩm đến các khu vực nội thành thành phố trên toàn quốc từ 4 giờ kể từ
                                khi nhận hàng, chuyển phát ngay trong ngày đến các vùng lân cận (bán kính từ 10km –
                                50km).
                                3. Các đơn hàng gửi đi quốc tế: không đảm bảo thời gian được chính xác như yêu cầu,
                                không đảm bảo thời gian nếu thời điểm chuyển phát trùng với các ngày lễ, tết và chủ nhật
                                tại khu vực nơi đến.
                                4. Trường hợp không liên lạc được với người nhận, người nhận đi vắng:
                                - Nếu chưa rõ địa chỉ chúng tôi sẽ lưu lại trong vòng 6 tiếng và liên lạc lại với người
                                nhận, trong trường hợp ko liên lạc được đơn hàng sẽ bị hủy và không được hoàn lại thanh
                                toán.
                                - Nếu địa chỉ là công ty, văn phòng, nhà ở… Chúng tôi sẽ gửi đồng nghiệp, người thân
                                nhận hộ và ký xác nhận
                                - Để tại một nơi an toàn người nhận dễ nhận thấy tại nhà, văn phòng, công ty… Trường hợp
                                này không có ký nhận.
                                5. Trường hợp người nhận không nhận đơn hàng:
                                - Chúng tôi sẽ hủy bỏ đơn hàng. Trường hợp này sẽ không được hoàn trả thanh toán.
                                6. Trường hợp không đúng địa chỉ, thay đổi địa chỉ:
                                - Không đúng địa chỉ: trường hợp sai địa chỉ chúng tôi sẽ lưu lại 6 tiếng và liên lạc
                                với người gửi và người nhận để thỏa thuận về địa điểm, thời gian, nếu địa chỉ mới không
                                quá 3km sẽ phát miễn phí. Trường hợp địa chỉ mới xa hơn 3km sẽ tính thêm phí theo quy
                                định chuyển phát.
                                7. Trường hợp không tồn tại người nhận tại địa chỉ yêu cầu: đơn hàng sẽ được hủy và
                                không được hoàn lại thanh toán.
                                8. Chúng tôi không vận chuyển sản phẩm đến các địa chỉ trên tàu hỏa, máy bay, tàu thủy,
                                khu vực nguy hiểm, các khu vực cấm…

                            </div>

                        </div>

                    </div>
                    <div class="sk-related-product-list">
                        <div class="product-care-title">
                            <h2>
                                Sản phẩm liên quan
                            </h2>
                        </div>
                        <div class="sk-related-product-listing">
                            <div class="discounts-product-right sk-related-product-item col-md-3 col-sm-6 col-xs-12">

                                <div class="sale-box text-center">
								<span class="price">-
							9% </span>
                                </div>

                                <div class="discounts-product-image">
                                    <a href="/vay-lien-than-kids-02">
                                        <img src="//bizweb.dktcdn.net/100/117/632/products/aovay12.jpg?v=1473606357990"
                                             alt="Váy liên thân KIDS-02" class="img-responsive"/>
                                    </a>
                                    <div class="price-box">
                                        <span class="price">250.000₫</span>

                                        <span class="price-compare">

										275.000₫

									</span>

                                    </div>
                                </div>
                                <div class="discounts-product-info">
                                    <h3 class="item-title">
                                        <a href="/vay-lien-than-kids-02" title="Váy liên thân KIDS-02">Váy liên thân
                                            KIDS-02</a>
                                    </h3>
                                </div>
                                <div class="text-center">

                                    <form action="/cart/add" method="post" class="variants" id="product-actions-3915974"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="variantId" value="6383988"/>
                                        <button class="button btn-cart btn-more product-atc"
                                                onclick="window.location.href='/vay-lien-than-kids-02'"
                                                title="Mua hàng"><span><img
                                                src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/btn-buy.png?1564585558451"
                                                alt=""/></span></button>
                                    </form>

                                </div>
                            </div>

                            <div class="discounts-product-right sk-related-product-item col-md-3 col-sm-6 col-xs-12">
                                <div class="sale-box text-center">
								<span class="price">-
							9% </span>
                                </div>

                                <div class="discounts-product-image">
                                    <a href="/vay-lien-than-kids-09">
                                        <img src="//bizweb.dktcdn.net/100/117/632/products/aovay10-b5526dcd-b7d6-4897-b574-5a975a7d60de.jpg?v=1473603768963"
                                             alt="Váy liền thân KIDS - 09" class="img-responsive"/>
                                    </a>
                                    <div class="price-box">
                                        <span class="price">250.000₫</span>

                                        <span class="price-compare">

										275.000₫

									</span>

                                    </div>
                                </div>
                                <div class="discounts-product-info">
                                    <h3 class="item-title">
                                        <a href="/vay-lien-than-kids-09" title="Váy liền thân KIDS - 09">Váy liền thân
                                            KIDS - 09</a>
                                    </h3>
                                </div>
                                <div class="text-center">

                                    <form action="/cart/add" method="post" class="variants" id="product-actions-3915740"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="variantId" value="6383623"/>
                                        <button class="button btn-cart btn-more product-atc"
                                                onclick="window.location.href='/vay-lien-than-kids-09'"
                                                title="Mua hàng"><span><img
                                                src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/btn-buy.png?1564585558451"
                                                alt=""/></span></button>
                                    </form>

                                </div>
                            </div>

                            <div class="discounts-product-right sk-related-product-item col-md-3 col-sm-6 col-xs-12">
                                <div class="sale-box text-center">
								<span class="price">-
							9% </span>
                                </div>

                                <div class="discounts-product-image">
                                    <a href="/vay-lien-than-kids-kf5">
                                        <img src="//bizweb.dktcdn.net/100/117/632/products/aovay9.jpg?v=1473603722000"
                                             alt="Váy liên thân KIDS - KF5" class="img-responsive"/>
                                    </a>
                                    <div class="price-box">
                                        <span class="price">250.000₫</span>

                                        <span class="price-compare">

										275.000₫

									</span>

                                    </div>
                                </div>
                                <div class="discounts-product-info">
                                    <h3 class="item-title">
                                        <a href="/vay-lien-than-kids-kf5" title="Váy liên thân KIDS - KF5">Váy liên thân
                                            KIDS - KF5</a>
                                    </h3>
                                </div>
                                <div class="text-center">

                                    <form action="/cart/add" method="post" class="variants" id="product-actions-3915726"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="variantId" value="6383594"/>
                                        <button class="button btn-cart btn-more product-atc"
                                                onclick="window.location.href='/vay-lien-than-kids-kf5'"
                                                title="Mua hàng"><span><img
                                                src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/btn-buy.png?1564585558451"
                                                alt=""/></span></button>
                                    </form>

                                </div>
                            </div>

                            <div class="discounts-product-right sk-related-product-item col-md-3 col-sm-6 col-xs-12">

                                <div class="sale-box text-center">
								<span class="price">-
							20% </span>
                                </div>

                                <div class="discounts-product-image">
                                    <a href="/vay-lien-than-kids">
                                        <img src="//bizweb.dktcdn.net/100/117/632/products/aovay1.jpg?v=1473603655000"
                                             alt="Váy liên thân KIDS" class="img-responsive"/>
                                    </a>
                                    <div class="price-box">
                                        <span class="price">220.000₫</span>

                                        <span class="price-compare">

										275.000₫

									</span>

                                    </div>
                                </div>
                                <div class="discounts-product-info">
                                    <h3 class="item-title">
                                        <a href="/vay-lien-than-kids" title="Váy liên thân KIDS">Váy liên thân KIDS</a>
                                    </h3>
                                </div>
                                <div class="text-center">

                                    <form action="/cart/add" method="post" class="variants" id="product-actions-3915724"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="variantId" value="6383573"/>
                                        <button class="button btn-cart btn-more product-atc"
                                                onclick="window.location.href='/vay-lien-than-kids'" title="Mua hàng">
                                            <span><img
                                                    src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/btn-buy.png?1564585558451"
                                                    alt=""/></span></button>
                                    </form>

                                </div>
                            </div>

                        </div>
                    </div><!-- End .sk-related-product-list -->
                </article>

            </div>
        </div>
    </div>
    <!-- End Main Content -->
    <jsp:include page="./footer/Footer.jsp"></jsp:include>
</div>
</body>
</html>