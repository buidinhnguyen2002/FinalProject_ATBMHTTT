<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html class="thankyou-page">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="Kidshop - Cảm ơn" />
    <title>Kidshop - Cảm ơn</title>

    <script>
        (function () {
            function asyncLoad() {
                var urls = ["//productreviews.sapoapps.vn/assets/js/productreviews.min.js?store=kidshop-1.mysapo.net","//static.zotabox.com/d/c/dc0c0333c1c1589c8067d581ada679a8/widgets.js?store=kidshop-1.mysapo.net","//static.zotabox.com/d/c/dc0c0333c1c1589c8067d581ada679a8/widgets.js?store=kidshop-1.mysapo.net"] || [];
                for (var i = 0; i < urls.length; i++) {
                    var s = document.createElement('script');
                    s.type = 'text/javascript';
                    s.async = true;
                    s.src = urls[i];
                    var x = document.getElementsByTagName('script')[0];
                    x.parentNode.insertBefore(s, x);
                }
            };
            window.attachEvent ? window.attachEvent('onload', asyncLoad) : window.addEventListener('load', asyncLoad, false);
        })();
    </script>
    <link rel="shortcut icon" href="//bizweb.dktcdn.net/assets/sapo_favicon.png" type="image/x-icon" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/assets/css/checkout.vendor.min.css?v=4fcd86c">


    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/assets/css/checkout.min.css?v=17ca415">

    <!-- Begin checkout custom css -->
    <style>
    </style>
    <!-- End checkout custom css -->
    <script src="//bizweb.dktcdn.net/assets/themes_support/libphonenumber-v3.2.30.min.js?1564585558451"></script>
    <script src="${pageContext.request.contextPath}/client/assets/js/checkout.vendor.min.js?v=11006c9"></script>
    <script src="${pageContext.request.contextPath}/client/assets/js/checkout.min.js?v=ee358d5"></script>
    <script>
        var Bizweb = Bizweb || {};
        Bizweb.id = '117632';
        Bizweb.store = 'kidshop-1.mysapo.net';

        Bizweb.template = 'thankyou';

        Bizweb.first_time_accessed = 'true';

        //<![CDATA[
        Bizweb.Checkout = Bizweb.checkout = {"created_on":"2023-03-30T11:26:36","customer_id":14129926,"customer_first_name":"Lê Minh","customer_last_name":"Long","customer_phone":"+84374781482","email":"khangcfff123477asd@gmail.com","order_id":11549347,"phone":"+84374781482","token":"e98e9d571d3b4f4e9c2eeb11333b293f","billing_address":{"address1":"ấp Phú Thuận, xã Châu Hòa, huyện Giồng Trôm, tỉnh Bến Tre","address2":null,"city":"Bến Tre","company":null,"country":"Vietnam","country_code":"VN","province_code":"9","province":"Bến Tre","district_code":"105","district":"Thành phố Bến Tre","ward":null,"ward_code":null,"first_name":"Khang","last_name":"Le Tan","phone":"+84374781482","email":null,"zip":null},"shipping_address":{"address1":"ấp Phú Thuận, xã Châu Hòa, huyện Giồng Trôm, tỉnh Bến Tre","address2":null,"city":"Bến Tre","company":null,"country":"Vietnam","country_code":"VN","province_code":"9","province":"Bến Tre","district_code":"105","district":"Thành phố Bến Tre","ward":null,"ward_code":null,"first_name":"Khang","last_name":"Le Tan","phone":"+84374781482","email":null,"zip":null},"shipping_price":40000.0000,"subtotal_price":1550000.0000,"total_price":1590000.0000,"total_line_items_price":1550000.0000,"order_discounts":[],"requires_shipping":true,"line_items":[{"grams":0,"quantity":1,"price":250000.0000,"price_final":250000.0000,"price_original":250000.0000,"total_discount":0.0000,"title":"Váy liên thân KIDS - KF5","taxable":false,"product_name":"Váy liên thân KIDS - KF5","product_id":3915726,"variant_id":6383609,"variant_title":"XL / Đỏ","sku":"KID-123_16","vendor":"Gap","requires_shipping":true},{"grams":0,"quantity":1,"price":325000.0000,"price_final":325000.0000,"price_original":325000.0000,"total_discount":0.0000,"title":"Kính thời trang Caters - SK","taxable":false,"product_name":"Kính thời trang Caters - SK","product_id":3915578,"variant_id":6383284,"variant_title":"DK40 / Đỏ","sku":"KID-GS23_9","vendor":"Caters","requires_shipping":true},{"grams":0,"quantity":2,"price":325000.0000,"price_final":325000.0000,"price_original":325000.0000,"total_discount":0.0000,"title":"Kính thời trang Gap","taxable":false,"product_name":"Kính thời trang Gap","product_id":3915632,"variant_id":6383351,"variant_title":"DK40 / Đỏ","sku":"KID-GS23_9","vendor":"Caters","requires_shipping":true},{"grams":0,"quantity":1,"price":325000.0000,"price_final":325000.0000,"price_original":325000.0000,"total_discount":0.0000,"title":"Kính thời trang Gap","taxable":false,"product_name":"Kính thời trang Gap","product_id":3915632,"variant_id":6383350,"variant_title":"DK40 / Xanh","sku":"KID-GS23_8","vendor":"Caters","requires_shipping":true}]}
        //]]>

    </script>

    <script>
        window.BizwebAnalytics = window.BizwebAnalytics || {};
        window.BizwebAnalytics.meta = window.BizwebAnalytics.meta || {};
        window.BizwebAnalytics.meta.currency = 'VND';
        window.BizwebAnalytics.tracking_url = '/s';
        var meta = {};


        for (var attr in meta) {
            window.BizwebAnalytics.meta[attr] = meta[attr];
        }
    </script>


    <script src="${pageContext.request.contextPath}/client/assets/js/stats.min.js?v=69e02f0"></script>


</head>

<body data-no-turbolink>

<header class="banner">
    <div class="wrap">
        <div class="logo logo--left">

            <h1 class="shop__name">
                <a href="/">Kidshop</a>
            </h1>

        </div>
    </div>
</header>
<div class="content">
    <form>
        <div class="wrap wrap--mobile-fluid">
            <main class="main main--nosidebar">
                <header class="main__header">
                    <div class="logo logo--left">

                        <h1 class="shop__name">
                            <a href="/">Kidshop</a>
                        </h1>

                    </div>
                </header>
                <div class="main__content">
                    <article class="row">
                        <div class="col col--primary">
                            <section class="section section--icon-heading">
                                <div class="section__icon unprintable">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="72px" height="72px">
                                        <g fill="none" stroke="#8EC343" stroke-width="2">
                                            <circle cx="36" cy="36" r="35" style="stroke-dasharray:240px, 240px; stroke-dashoffset: 480px;"></circle>
                                            <path d="M17.417,37.778l9.93,9.909l25.444-25.393" style="stroke-dasharray:50px, 50px; stroke-dashoffset: 0px;"></path>
                                        </g>
                                    </svg>
                                </div>
                                <div class="thankyou-message-container">
                                    <h2 class="section__title">Cảm ơn bạn đã đặt hàng</h2>

                                    <p class="section__text">
                                        Một email xác nhận đã được gửi tới ${sessionScope.acc.email}. <br/>
                                        Xin vui lòng kiểm tra email của bạn
                                    </p>


                                </div>
                            </section>
                        </div>
                        <div class="col col--secondary">
                            <aside class="order-summary order-summary--bordered order-summary--is-collapsed" id="order-summary">
                                <div class="order-summary__header">
                                    <div class="order-summary__title">
                                        Đơn hàng
                                        <span class="unprintable">(${totalQuantity})</span>
                                    </div>
                                    <div class="order-summary__action hide-on-desktop unprintable">
                                        <a data-toggle="#" data-toggle-class="order-summary--is-collapsed" class="expandable">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                                <div class="order-summary__sections">
                                    <div class="order-summary__section order-summary__section--product-list order-summary__section--is-scrollable order-summary--collapse-element">
                                        <table class="product-table">
                                            <tbody>
                                            <c:forEach items="${requestScope.cart.entrySet()}" var="entry">
                                                <c:forEach items="${entry.getValue()}" var="o">
                                                    <tr class="product">
                                                        <td class="product__image">
                                                            <div class="product-thumbnail">
                                                                <div class="product-thumbnail__wrapper" data-tg-static>
                                                                    <img src="${pageContext.request.contextPath}/images/${o.product.imageProducts.get(0).getImage()}"
                                                                         alt="" class="product-thumbnail__image"/>
                                                                </div>
                                                                <span class="product-thumbnail__quantity">${o.quantity}</span>
                                                            </div>
                                                        </td>
                                                        <th class="product__description">
													<span class="product__description__name">
                                                            ${o.product.nameProduct}
                                                    </span>

                                                            <span class="product__description__property">
														 ${o.productSize}/${o.productColor}
													</span>


                                                        </th>
                                                        <td class="product__quantity visually-hidden"><em>Số
                                                            lượng:</em> ${o.quantity}</td>
                                                        <td class="product__price">
                                                                ${o.price * o.quantity}
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="order-summary__section">
                                        <table class="total-line-table">
                                            <tbody class="total-line-table__tbody">


                                            <tr class="total-line total-line--subtotal">
                                                <th class="total-line__name">Tạm tính</th>
                                                <td class="total-line__price">${requestScope.order.totalPrice-requestScope.ship}₫</td>
                                            </tr>

                                            <tr class="total-line total-line--shipping-fee">
                                                <th class="total-line__name">Phí vận chuyển</th>
                                                <td class="total-line__price">

                                                    ${requestScope.ship}

                                                </td>
                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="order-summary__section">
                                        <table class="total-line-table">
                                            <tbody class="total-line-table__tbody">
                                            <tr class="total-line payment-due">
                                                <th class="total-line__name">
                                                    <span class="payment-due__label-total">Tổng cộng</span>
                                                </th>
                                                <td class="total-line__price">
                                                    <span class="payment-due__price">${requestScope.order.totalPrice}₫</span>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </aside>
                        </div>
                        <div class="col col--primary">
                            <section class="section">
                                <div class="section__content section__content--bordered">

                                    <div class="row">

                                        <div class="col col--md-two">
                                            <h2>Thông tin mua hàng</h2>
                                            <p>${sessionScope.acc.fullName}</p>

                                            <p>${sessionScope.acc.email}</p>


                                            <p>${sessionScope.acc.phone}</p>

                                        </div>

                                        <div class="col col--md-two">
                                            <h2>Địa chỉ nhận hàng</h2>
                                            <p>${sessionScope.acc.fullName}</p>

                                            <p>${sessionScope.acc.address}</p>



                                            <p>${sessionScope.acc.address}</p>


                                            <p>${sessionScope.acc.phone}</p>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col col--md-two">
                                            <h2>Phương thức thanh toán</h2>
                                            <p>Thanh toán khi giao hàng (COD)</p>
                                        </div>
                                        <div class="col col--md-two">
                                            <h2>Phương thức vận chuyển</h2>
                                            <p>Giao hàng tận nơi</p>
                                        </div>
                                    </div>

                                </div>
                            </section>
                            <section class="section unprintable">
                                <div class="field__input-btn-wrapper field__input-btn-wrapper--floating">
                                    <a href="${pageContext.request.contextPath}/IndexControl" class="btn btn--large">Tiếp tục mua hàng</a>
                                    <span class="text-icon-group text-icon-group--large icon-print" onclick="window.print()">
											<span>In </span>
										</span>
                                </div>
                            </section>
                        </div>
                    </article>
                </div>

            </main>
        </div>
    </form>
</div>
</body>
</html>