<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html class="thankyou-page">
<head>
    <meta charset="utf-8"/>
    <link rel="icon"
          href="https://lh3.googleusercontent.com/pw/AJFCJaXoQYraxnJ5Xb69WqHM1VQGknKZhyfiZbMmB6wyAJiOeVD_C15MO0MebL6Y0uDb0qf16BnhswiDxBoU4CWiObfRtcFdAXDrKN651ub56WgeBV220MOgoxEsdKXwjLUSliRIWVTPaCWaLlX2w7m6lcRb2e8ENo07IehTwKsl2n2wSVICj1Hj7ZmpCko_yHw4eUdPlshXFwmPwVvQY2HQ11NQvVxKDOtL6hxMkaBaIG0QgE4swK5S0IEWyhPf3kUuXDjqo4RiNKVYjTdzi__SxIZ8TsIEcFoiW5V837ODrZmqArfVv--iUhpeOfG-32_GFelpygILotxWz4tPAi_9a5mrjqxKTomZuqtwZt2h9UooAD1nIbQyBs2mwm-qNswhYs_OXFnH6gtCFLm4t-B01KP5caG00vub-x2ulXeuYUCxFky5zuFB7oPhbkXnfwePfgl8Jm__5ENCtTnfAQXTWYWGIRtRmaRAHZFwfP0jERY_VDrjB9SV2SyeBgdjv6CiKQwf8ePaj_eiEvzuh1DSK8mRkX7c6XmDocSYoMMuqYG2v3Yv3BVfJE5npzwElwhimrriPZekxBi5GC4vS1NI-KVqxDBjFWwSA1F3BuOLGX92GfozvEBj1oN9K-G3usx7MsxpGOvGY3Ni0N-5QR3CBWp5xteKjftbQEaJk02glp-saVoih7IFQf6bFQnRkhmQMN7DFNzsObALswIITfB54QwHf0vdZJTemb8d01FFQFLeqZ0GSF86Pa3lbyvzJ2HaP569GLNLSgfzg-jvbNV5R1rqOwWgpW4sd5Q3KaxRd97_X1nD48xnNHqx4aJr4FOcshElIwzKzCRQkYumMnfqLqTDzRE83VDgQJz7KaxRzM2N1qP5GsVmpvFg0FDXGPaTOiC1IK3QnqykTDaJMz-1fXqa6fBP6kIwrytrUYfAdfydwykxC5piNeP9Xkb_LT1cIdnR_08jDI7-rFaIovldG3fCF2ECZg=w80-h80-s-no?authuser=0">

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="Kidshop - Cảm ơn"/>
    <title>Halo's Shop - Cảm ơn</title>

    <script>
        (function () {
            function asyncLoad() {
                var urls = ["//productreviews.sapoapps.vn/assets/js/productreviews.min.js?store=kidshop-1.mysapo.net", "//static.zotabox.com/d/c/dc0c0333c1c1589c8067d581ada679a8/widgets.js?store=kidshop-1.mysapo.net", "//static.zotabox.com/d/c/dc0c0333c1c1589c8067d581ada679a8/widgets.js?store=kidshop-1.mysapo.net"] || [];
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/client/assets/css/checkout.vendor.min.css?v=4fcd86c">


    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/assets/css/checkout.min.css?v=17ca415">

    <!-- Begin checkout custom css -->
    <style>
    </style>
    <!-- End checkout custom css -->
    <script src="//bizweb.dktcdn.net/assets/themes_support/libphonenumber-v3.2.30.min.js?1564585558451"></script>
    <script src=${pageContext.request.contextPath}/client/assets/js/checkout.vendor.min.js?v=11006c9"></script>
    <script src="${pageContext.request.contextPath}/client/assets/js/checkout.min.js?v=ee358d5"></script>
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
                <a href="${pageContext.request.contextPath}/IndexControl">Halo's Shop</a>
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
                            <a href="${pageContext.request.contextPath}/IndexControl">Halo's Shop</a>
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
                                            <circle cx="36" cy="36" r="35"
                                                    style="stroke-dasharray:240px, 240px; stroke-dashoffset: 480px;"></circle>
                                            <path d="M17.417,37.778l9.93,9.909l25.444-25.393"
                                                  style="stroke-dasharray:50px, 50px; stroke-dashoffset: 0px;"></path>
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
                            <aside class="order-summary order-summary--bordered order-summary--is-collapsed"
                                   id="order-summary">
                                <div class="order-summary__header">
                                    <div class="order-summary__title">
                                        Đơn hàng
                                        <span class="unprintable">(${billProducts.size()})</span>
                                    </div>
                                    <div class="order-summary__action hide-on-desktop unprintable">
                                        <a data-toggle="#" data-toggle-class="order-summary--is-collapsed"
                                           class="expandable">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                                <div class="order-summary__sections">
                                    <div class="order-summary__section order-summary__section--product-list order-summary__section--is-scrollable order-summary--collapse-element">
                                        <table class="product-table">
                                            <tbody>
                                            <c:forEach items="${requestScope.billProducts}" var="o">
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
                                                    <td class="product__price priceSystas">
                                                            ${o.price * o.quantity}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="order-summary__section">
                                        <table class="total-line-table">
                                            <tbody class="total-line-table__tbody">

                                            <tr class="total-line total-line--shipping-fee">
                                                <th class="total-line__name">Phí vận chuyển</th>
                                                <td class="total-line__price">
                                                    40.000₫
                                                </td>
                                            </tr>
                                            <tr class="total-line total-line--subtotal">
                                                <th class="total-line__name">Tạm tính</th>
                                                <td class="total-line__price priceSystas">${requestScope.bill.totalPrice}₫</td>
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
                                                    <span class="payment-due__price priceSystas">${requestScope.bill.totalPrice}₫</span>
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
                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <div class="field__input-btn-wrapper field__input-btn-wrapper--floating">
                                    <c:if test="${bill.status=='Đang xử lý'&& bill.statusPay !='Đã thanh toán'}"> <a
                                            href="${pageContext.request.contextPath}/cart/CancelBill?id=${bill.id}&status=UnPay"
                                            id="cancelLink"
                                            style="background-color: red; margin-right: 10px" class="btn btn--large">Hủy
                                        đơn hàng</a>
                                        <script>
                                            document.getElementById("cancelLink").onclick = function () {
                                                Swal.fire({
                                                    title: 'Bạn có chắc chắn muốn hủy đơn hàng?',
                                                    icon: 'warning',
                                                    showCancelButton: true,
                                                    confirmButtonText: 'Yes',
                                                    cancelButtonText: 'No'
                                                }).then((result) => {
                                                    if (result.isConfirmed) {
                                                        Swal.fire(
                                                            'Đơn hàng của bạn đã được hủy','',
                                                            'success'
                                                        ).then(() => {
                                                            // Perform the cancellation logic or redirect if needed
                                                            window.location.href = this.href;
                                                        });
                                                    }
                                                });
                                                return false;
                                            };
                                        </script>
                                    </c:if>
                                    <!-- Your existing code -->
                                    <c:if test="${bill.status == 'Đang xử lý' && bill.statusPay == 'Đã thanh toán'}">
                                        <a href="${pageContext.request.contextPath}/cart/CancelBill?id=${bill.id}&status=Payed"
                                           id="cancelLink"
                                           style="background-color: red; margin-right: 10px" class="btn btn--large">Hủy đơn hàng</a>
                                        <script>
                                            document.getElementById("cancelLink").onclick = function () {
                                                Swal.fire({
                                                    title: 'Bạn có chắc chắn muốn hủy đơn hàng?',
                                                    icon: 'warning',
                                                    showCancelButton: true,
                                                    confirmButtonText: 'Yes',
                                                    cancelButtonText: 'No'
                                                }).then((result) => {
                                                    if (result.isConfirmed) {
                                                        Swal.fire(
                                                            'Đơn hàng của bạn đã được thanh toán trước đó',
                                                            'Chúng tôi sẽ tiến hành hoàn tiền trong vòng 24h',
                                                            'success'
                                                        ).then(() => {
                                                            // Perform the cancellation logic or redirect if needed
                                                            window.location.href = this.href;
                                                        });
                                                    }
                                                });
                                                return false;
                                            };
                                        </script>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/IndexControl" class="btn btn--large">Tiếp
                                        tục mua hàng</a>
                                    <span class="text-icon-group text-icon-group--large icon-print"
                                          onclick="window.print()">
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
    </script>
</div>
</body>
</html>