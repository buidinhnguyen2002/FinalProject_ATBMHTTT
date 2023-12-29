<%@ page import="util.API" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html class="floating-labels">
<head>
    <meta charset="UTF-8">
    <link rel="icon"
          href="https://lh3.googleusercontent.com/pw/AJFCJaXoQYraxnJ5Xb69WqHM1VQGknKZhyfiZbMmB6wyAJiOeVD_C15MO0MebL6Y0uDb0qf16BnhswiDxBoU4CWiObfRtcFdAXDrKN651ub56WgeBV220MOgoxEsdKXwjLUSliRIWVTPaCWaLlX2w7m6lcRb2e8ENo07IehTwKsl2n2wSVICj1Hj7ZmpCko_yHw4eUdPlshXFwmPwVvQY2HQ11NQvVxKDOtL6hxMkaBaIG0QgE4swK5S0IEWyhPf3kUuXDjqo4RiNKVYjTdzi__SxIZ8TsIEcFoiW5V837ODrZmqArfVv--iUhpeOfG-32_GFelpygILotxWz4tPAi_9a5mrjqxKTomZuqtwZt2h9UooAD1nIbQyBs2mwm-qNswhYs_OXFnH6gtCFLm4t-B01KP5caG00vub-x2ulXeuYUCxFky5zuFB7oPhbkXnfwePfgl8Jm__5ENCtTnfAQXTWYWGIRtRmaRAHZFwfP0jERY_VDrjB9SV2SyeBgdjv6CiKQwf8ePaj_eiEvzuh1DSK8mRkX7c6XmDocSYoMMuqYG2v3Yv3BVfJE5npzwElwhimrriPZekxBi5GC4vS1NI-KVqxDBjFWwSA1F3BuOLGX92GfozvEBj1oN9K-G3usx7MsxpGOvGY3Ni0N-5QR3CBWp5xteKjftbQEaJk02glp-saVoih7IFQf6bFQnRkhmQMN7DFNzsObALswIITfB54QwHf0vdZJTemb8d01FFQFLeqZ0GSF86Pa3lbyvzJ2HaP569GLNLSgfzg-jvbNV5R1rqOwWgpW4sd5Q3KaxRd97_X1nD48xnNHqx4aJr4FOcshElIwzKzCRQkYumMnfqLqTDzRE83VDgQJz7KaxRzM2N1qP5GsVmpvFg0FDXGPaTOiC1IK3QnqykTDaJMz-1fXqa6fBP6kIwrytrUYfAdfydwykxC5piNeP9Xkb_LT1cIdnR_08jDI7-rFaIovldG3fCF2ECZg=w80-h80-s-no?authuser=0">

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="HaLoShop - Thanh toán đơn hàng"/>
    <title>Haloshop - Thanh toán đơn hàng</title>
    <link rel="icon" type="image" href="./images/HaLoicon.png"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/fontawesome.min.css"
          integrity="sha384-QYIZto+st3yW+o8+5OHfT6S482Zsvz2WfOzpFSXMF9zqeLcFV0/wlZpMtyFcZALm" crossorigin="anonymous">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/client/assets/css/checkout.vendor.min.css?v=4fcd86c">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/assets/css/checkout.min.css?v=17ca415">
    <script src="//bizweb.dktcdn.net/assets/themes_support/libphonenumber-v3.2.30.min.js?1564585558451"></script>
    <script src="${pageContext.request.contextPath}/client/assets/js/checkout.vendor.min.js?v=11006c9"></script>
    <script src="${pageContext.request.contextPath}/client/assets/js/checkout.min.js?v=ee358d5"></script>
    <script src="https://www.paypal.com/sdk/js?client-id=AbenXsywXYlbMw4GpzHDSdiXPx7hKY7adwNFIjsSlY7HfsmSRD6DOzeswhhcBtKiqC46A2kiwzyk_Wf7&currency=USD"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>
    <style>
        .field__input-wrapper {
            position: relative;
        }

        .field__input-wrapper .clear-btn {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            border: none;
            background: none;
            cursor: pointer;
        }
    </style>
    <script>
        var Bizweb = Bizweb || {};
        Bizweb.id = '117632';
        Bizweb.store = 'Haloshop-1.mysapo.net';

        Bizweb.template = 'checkout';
        Bizweb.Checkout = Bizweb.Checkout || {};

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
                <a href="${pageContext.request.contextPath}/IndexControl">Halo's Shop</a>
            </h1>

        </div>
    </div>
</header>
<aside>
    <button class="order-summary-toggle" data-toggle="#order-summary" data-toggle-class="order-summary--is-collapsed">
			<span class="wrap">
				<span class="order-summary-toggle__inner">
					<span class="order-summary-toggle__text expandable">
						Đơn hàng (${totalQuantity} sản phẩm)
					</span>
				</span>
			</span>
    </button>
</aside>


<div data-tg-refresh="checkout" id="checkout" class="content">
    <form method="post"
          action="${pageContext.request.contextPath}/cart/AddBillControl" id="form_submit">
        <input type="hidden" name="_method" value="patch"/>
        <div class="wrap">
            <main class="main">
                <header class="main__header">
                    <div class="logo logo--left">

                        <h1 class="shop__name">
                            <a href="${pageContext.request.contextPath}/IndexControl">Halo's Shop</a>
                        </h1>

                    </div>
                </header>
                <div class="main__content">
                    <article class="animate-floating-labels row">
                        <div class="col col--two">
                            <section class="section">
                                <div class="section__header">
                                    <div class="layout-flex">
                                        <h2 class="section__title layout-flex__item layout-flex__item--stretch">
                                            Thông tin nhận hàng

                                        </h2>

                                    </div>
                                </div>
                                <div class="section__content">
                                    <div class="fieldset">


                                        <div class="field " data-bind-class="{'field--show-floating-label': email}">
                                            <div class="field__input-wrapper">
                                                <label for="email" class="field__label">
                                                    Email
                                                </label>
                                                <input name="email" id="email"
                                                       type="email" class="field__input" required
                                                       data-bind="email" value="${sessionScope.acc.email}">
                                            </div>

                                        </div>


                                        <div class="field "
                                             data-bind-class="{'field--show-floating-label': billing.name}">
                                            <div class="field__input-wrapper">
                                                <label for="billingName" class="field__label">Họ và tên</label>
                                                <input name="billingName" id="billingName"
                                                       type="text" class="field__input" required
                                                       data-bind="billing.name" value="${sessionScope.acc.fullName}">
                                            </div>

                                        </div>

                                        <div class="field "
                                             data-bind-class="{'field--show-floating-label': billing.phone}">
                                            <div class="field__input-wrapper field__input-wrapper--connected"
                                                 data-define="{phoneInput: new InputPhone(this)}">
                                                <label for="billingPhone" class="field__label">
                                                    Số điện thoại (tùy chọn)
                                                </label>
                                                <input name="billingPhone" id="billingPhone"
                                                       type="tel" class="field__input" REQUIRED
                                                       data-bind="billing.phone" value="${sessionScope.acc.phone}">

                                            </div>

                                        </div>


                                        <div class="field "
                                             data-bind-class="{'field--show-floating-label': billing.address}">
                                            <div class="field__input-wrapper">
                                                <label for="billingAddress" class="field__label">
                                                    Địa chỉ (tùy chọn)
                                                </label>
                                                <input name="billingAddress" id="billingAddress"
                                                       type="text" class="field__input" required
                                                       data-bind="billing.address" value="${sessionScope.acc.address }">
                                            </div>

                                        </div>


                                        <div class="field field--show-floating-label ">
                                            <div class="field__input-wrapper field__input-wrapper--select2">
                                                <label for="billingProvince" class="field__label">Tỉnh thành</label>
                                                <select name="calc_shipping_provinces" id="billingProvince"
                                                        size="1"
                                                        class="field__input field__input--select"
                                                        required="">
                                                    <option value="" selected>Tỉnh / Thành phố</option>
                                                </select>
                                            </div>

                                        </div>

                                        <div class="field field--show-floating-label ">
                                            <div class="field__input-wrapper field__input-wrapper--select2">
                                                <label for="billingDistrict" class="field__label">
                                                    Quận huyện (tùy chọn)
                                                </label>
                                                <select name="calc_shipping_district"
                                                        id="billingDistrict"
                                                        size="1"
                                                        class="field__input field__input--select"
                                                        required="">
                                                    <option value="">Huyện / Quận</option>

                                                </select>
                                            </div>
                                        </div>
                                        <div class="field field--show-floating-label ">
                                            <div class="field__input-wrapper field__input-wrapper--select2">
                                                <label for="billingWard" class="field__label">
                                                    Xã / Phường
                                                </label>
                                                <select name="calc_shipping_ward"
                                                        id="billingWard"
                                                        size="1"
                                                        class="field__input field__input--select"
                                                        required="">

                                                    <option value="">Xã / Thị trấn</option>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <div class="fieldset">
                                <h3 class="visually-hidden">Ghi chú</h3>
                                <div class="field " data-bind-class="{'field--show-floating-label': note}">
                                    <div class="field__input-wrapper">
                                        <label for="note" class="field__label">
                                            Ghi chú (tùy chọn)
                                        </label>
                                        <textarea name="note" id="note"
                                                  class="field__input"
                                                  data-bind="note"></textarea>
                                    </div>

                                </div>
                            </div>

                        </div>
                        <div class="col col--two">


                            <section class="section" data-define="{shippingMethod: '137136_0,40.000 VND'}">
                                <div class="section__header">
                                    <div class="layout-flex">
                                        <h2 class="section__title layout-flex__item layout-flex__item--stretch">
                                            Vận chuyển
                                        </h2>
                                    </div>
                                </div>
                                <div class="section__content" data-tg-refresh="refreshShipping" id="shippingMethodList"
                                     data-define="{isAddressSelecting: false, shippingMethods: []}">
                                    <div class="alert alert--loader spinner spinner--active"
                                         data-bind-show="isLoadingShippingMethod">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="spinner-loader">
                                            <use href="#spinner"></use>
                                        </svg>
                                    </div>


                                    <div class="alert alert-retry alert--danger hide"
                                         data-bind-event-click="handleShippingMethodErrorRetry()"
                                         data-bind-show="!isLoadingShippingMethod && !isAddressSelecting && isLoadingShippingError">
                                        <span data-bind="loadingShippingErrorMessage"></span>
                                    </div>


                                    <div class="content-box"
                                         data-bind-show="!isLoadingShippingMethod && !isAddressSelecting && !isLoadingShippingError">
                                        <div class="content-box__row"
                                             data-define-array="{shippingMethods: {name: '137136_0,40.000 VND', textPrice: '40.000₫', textDiscountPrice: '-', subtotalPriceWithShippingFee: '990.000₫'}}">
                                            <div class="radio-wrapper">
                                                <div class="radio__input">
                                                    <input type="radio" class="input-radio"
                                                           name="shippingMethod" id="shippingMethod-137136_0"
                                                           value="137136_0,40.000 VND"
                                                           data-bind="shippingMethod">
                                                </div>
                                                <label for="shippingMethod-137136_0" class="radio__label">
														<span class="radio__label__primary">
															<span>Giao hàng tận nơi</span>

														</span>
                                                    <span class="radio__label__accessory">

															<span id="spanShipId" class="content-box__emphasis price">
																Đang tính
															</span>
														</span>
                                                </label>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="alert alert--info hide"
                                         data-bind-show="!isLoadingShippingMethod && isAddressSelecting">
                                        Vui lòng nhập thông tin giao hàng
                                    </div>
                                </div>
                            </section>

                            <section class="section">
                                <div class="section__header">
                                    <div class="layout-flex">
                                        <h2 class="section__title layout-flex__item layout-flex__item--stretch">
                                            Thanh toán
                                        </h2>
                                    </div>
                                </div>
                                <div class="section__content">

                                    <div class="content-box" data-define="{paymentMethod: undefined}">
                                        <div class="content-box__row">
                                            <div class="radio-wrapper">
                                                <div class="radio__input">
                                                    <input name="paymentMethod" id="paymentMethod-120771"
                                                           type="radio" class="input-radio"
                                                           data-bind="paymentMethod"
                                                           value="120771" required
                                                    >
                                                </div>
                                                <label for="paymentMethod-120771" class="radio__label">
                                                    <span class="radio__label__primary">Thanh toán khi giao hàng (COD)</span>
                                                    <span class="radio__label__accessory">
														</span>
                                                </label>
                                            </div>
                                            <div class="content-box__row__desc"
                                                 data-bind-show="paymentMethod == 120771">
                                                <p>COD</p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </article>
                    <div class="field__input-btn-wrapper field__input-btn-wrapper--vertical hide-on-desktop">
                        <button id="submitBtnMobile" type="submit" class="btn btn-checkout spinner">
                            <span class="spinner-label">ĐẶT HÀNG</span>
                            <svg xmlns="http://www.w3.org/2000/svg" class="spinner-loader">
                                <use href="#spinner"></use>
                            </svg>
                        </button>

                        <a href="${pageContext.request.contextPath}/cart/CartControl" class="previous-link">
                            <span class="previous-link__content">Quay về giỏ hàng</span>
                        </a>
                    </div>

                    <div id="common-alert" data-tg-refresh="refreshError">


                        <div class="alert alert--danger hide-on-desktop"
                             data-bind-show="!isSubmitingCheckout && isSubmitingCheckoutError"
                             data-bind="submitingCheckoutErrorMessage">
                        </div>
                    </div>
                </div>

            </main>
            <aside class="sidebar">
                <div class="sidebar__header">
                    <h2 class="sidebar__title">
                        Đơn hàng (${totalQuantity} sản phẩm)
                    </h2>
                </div>
                <div class="sidebar__content">
                    <div id="order-summary" class="order-summary order-summary--is-collapsed">
                        <div class="order-summary__sections">
                            <div class="order-summary__section order-summary__section--product-list order-summary__section--is-scrollable order-summary--collapse-element">
                                <table class="product-table">
                                    <caption class="visually-hidden">Chi tiết đơn hàng</caption>
                                    <thead class="product-table__header">
                                    <tr>
                                        <th>
                                            <span class="visually-hidden">Ảnh sản phẩm</span>
                                        </th>
                                        <th>
                                            <span class="visually-hidden">Mô tả</span>
                                        </th>
                                        <th>
                                            <span class="visually-hidden">Sổ lượng</span>
                                        </th>
                                        <th>
                                            <span class="visually-hidden">Đơn giá</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${sessionScope.cart.entrySet()}" var="entry">
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
                                                <td class="product__price priceSystas">
                                                        ${o.price * o.quantity}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="order-summary__section order-summary__section--discount-code"
                                 data-tg-refresh="refreshDiscount" id="discountCode">
                                <h3 class="visually-hidden">Mã khuyến mại</h3>
                                <div class="edit_checkout animate-floating-labels">
                                    <div class="fieldset">
                                        <div class="field ">
                                            <div class="field__input-btn-wrapper">
                                                <div class="field__input-wrapper">
                                                    <label for="reductionCode" class="field__label">Nhập mã giảm
                                                        giá</label>
                                                    <input name="reductionCode" id="reductionCode"
                                                           type="text" class="field__input">
                                                </div>
                                                <button onclick="appDiscount()" class="field__input-btn btn spinner"
                                                        type="button">
                                                    <span class="spinner-label">Áp dụng</span>
                                                </button>
                                            </div>

                                            <p class="field__message field__message--error field__message--error-always-show"
                                               data-bind-show="!isLoadingReductionCode && isLoadingReductionCodeError"
                                               data-bind="loadingReductionCodeErrorMessage">
                                            </p>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="order-summary__section order-summary__section--total-lines order-summary--collapse-element"
                                 data-define="{subTotalPriceText: '950.000₫'}"
                                 data-tg-refresh="refreshOrderTotalPrice" id="orderSummary">
                                <table class="total-line-table">
                                    <caption class="visually-hidden">Tổng giá trị</caption>
                                    <thead>
                                    <tr>
                                        <td><span class="visually-hidden">Mô tả</span></td>
                                        <td><span class="visually-hidden priceSystas">Giá tiền</span></td>
                                    </tr>
                                    </thead>
                                    <tbody class="total-line-table__tbody">
                                    <tr class="total-line total-line--subtotal">
                                        <th class="total-line__name">
                                            Tạm tính
                                        </th>
                                        <td id="provisional" class="total-line__price priceSystas">${total}</td>
                                    </tr>

                                    <tr class="total-line total-line--shipping-fee">
                                        <th class="total-line__name">
                                            Phí vận chuyển
                                        </th>
                                        <td id="feeShipId" class="total-line__price"> Đang tính
                                            <input type="hidden" name="shipFee" value=""/>
                                        </td>
                                    </tr>

                                    </tbody>
                                    <tfoot class="total-line-table__footer">
                                    <tr class="total-line payment-due">
                                        <th class="total-line__name">
													<span class="payment-due__label-total">
														Tổng cộng
													</span>
                                        </th>
                                        <td class="total-line__price">
                                            <span id="totalId" class="payment-due__price priceSystas">${total} </span>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>
                                <div class="field " style="margin-top: 10px; padding: unset">
                                    <div class="field__input-btn-wrapper">
                                        <div class="field__input-wrapper">
                                            <label for="privateKey" class="field__label" style="transition: all .2s ease-out;
    -webkit-transition: all .2s ease-out;">Nhập private key</label>
                                            <input name="privateKey" id="privateKey"
                                                   type="text" class="field__input" required style="padding-right: 25px">
                                            <button class="clear-btn" onclick="clearInput()"><i class="bi bi-x-circle"></i></button>
                                        </div>
                                    </div>
                                    <p id="error-key" style="color: red"></p>
                                    <p class="field__message field__message--error field__message--error-always-show"
                                       data-bind-show="!isLoadingReductionCode && isLoadingReductionCodeError"
                                       data-bind="loadingReductionCodeErrorMessage">
                                    </p>
                                </div>
                            </div>
                            <div class="order-summary__nav field__input-btn-wrapper hide-on-mobile layout-flex--row-reverse">
                                <%--                                <button id="submitBtn" type="submit" class="btn btn-checkout spinner">--%>
                                <%--                                    <span class="spinner-label">ĐẶT HÀNG</span>--%>
                                <%--                                </button>--%>
                                <button id="submitBtn" type="button" class="btn btn-checkout spinner">
                                    <span class="spinner-label">ĐẶT HÀNG</span>
                                </button>
                                <a href="${pageContext.request.contextPath}/cart/CartControl" class="previous-link">
                                    <span class="previous-link__content">Quay về giỏ hàng</span>
                                </a>
                            </div>
                            <div style="margin-top: 10px" class="section__header">
                                <div class="layout-flex">
                                    <h2 class="section__title layout-flex__item layout-flex__item--stretch">
                                        Thanh toán Online
                                    </h2>
                                </div>
                            </div>
                            <div style="margin-top: 10px" id="paypal-button-container"></div>
                            <div id="common-alert-sidebar" data-tg-refresh="refreshError">


                                <div class="alert alert--danger hide-on-mobile hide"
                                     data-bind-show="!isSubmitingCheckout && isSubmitingCheckoutError"
                                     data-bind="submitingCheckoutErrorMessage">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </aside>
        </div>
    </form>

    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="spinner">
            <svg viewBox="0 0 30 30">
                <circle stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-dasharray="85%"
                        cx="50%" cy="50%" r="40%">
                    <animateTransform attributeName="transform"
                                      type="rotate"
                                      from="0 15 15"
                                      to="360 15 15"
                                      dur="0.7s"
                                      repeatCount="indefinite"/>
                </circle>
            </svg>
        </symbol>
    </svg>
</div>
<%
    API api = new API();
%>
<script>
    function appDiscount() {
        // Lấy giá trị mã giảm giá từ ô input
        var reductionCode = $('#reductionCode').val();

        // Kiểm tra nếu mã giảm giá không rỗng
        if (reductionCode !== '') {
            $.ajax({
                url: '${pageContext.request.contextPath}/cart/DiscountControl',
                method: 'POST',
                data: {reductionCode: reductionCode}, // Gửi mã giảm giá lên máy chủ
                success: function (data) {
                    let isSuc = JSON.parse(data).isSuc;
                    if (isSuc > 0) {
                        alert('Mã giảm giá hợp lệ!');
                        // Lấy giá trị gốc từ các thẻ <td>
                        let originalPriceTotal = parseFloat($('#spanShipId').text().replace('$', '')); // Phí ship
                        let originalPrice = ${total}; // Phí tạm thời
                        let total = ""; // Tổng chi phí
                        let newPriceDiscount = originalPrice - originalPrice * (isSuc / 100);
                        if (!isNaN(originalPriceTotal)) {
                            total = newPriceDiscount + originalPriceTotal;
                        } else {
                            total = newPriceDiscount;
                        }

                        $('#provisional').text(newPriceDiscount.toFixed(1));
                        $('#totalId').text(total.toFixed(1));
                    } else {
                        alert('Mã giảm giá không hợp lệ!');
                        let originalPriceTotal = parseFloat($('#spanShipId').text().replace('$', ''));
                        let total = "";
                        if (!isNaN(originalPriceTotal)) {
                            total = ${total} +originalPriceTotal;
                        } else {
                            total =${total}; // Phí tạm thời;
                        }

                        $('#provisional').text('${total}');
                        $('#totalId').text(total.toFixed(1));
                    }


                },
                error: function () {
                    // Xử lý lỗi trong quá trình gửi yêu cầu Ajax
                    alert('Đã xảy ra lỗi!');
                    isProcessing = false; // Đánh dấu rằng xử lý sự kiện đã hoàn thành
                }
            });
        } else {
            // Hiển thị thông báo nếu ô input rỗng
            alert('Vui lòng nhập mã giảm giá!');
            isProcessing = false; // Đánh dấu rằng xử lý sự kiện đã hoàn thành
        }
    }


    let token = '<%= api.getToken() %>';
    let selectProvinceElement = document.getElementById('billingProvince');
    let selectDistrictElement = document.getElementById('billingDistrict');
    let selectWardElement = document.getElementById('billingWard');
    let provinceId = -1;
    let districtId = -1;
    let wardId = -1
    // Lấy danh sách các tỉnh

    fetch(`https://provinces.open-api.vn/api/`, {
        method: 'GET',
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`Network response was not ok: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            // Xử lý dữ liệu ở đây
            data.forEach(province => {
                const option = document.createElement('option');
                option.value = province.code;
                option.text = province.name;
                selectProvinceElement.appendChild(option);
            });
        })
        .catch(error => {
            // Xử lý lỗi ở đây
            console.error(error);
        });


    // Lấy danh sách các huyện khi chọn tỉnh
    selectProvinceElement.addEventListener('change', (event) => {
        const provinceId = event.target.value;
        fetch(`https://provinces.open-api.vn/api/p/` + provinceId + `?depth=2`, {
            method: 'GET',
        })
            .then(response => response.json())
            .then(data => {
                // Xử lý dữ liệu ở đây
                selectDistrictElement.innerHTML = '<option value="" selected>Huyện / Quận</option>';
                selectWardElement.innerHTML = '<option value="" selected>Xã / Phường</option>';
                data.districts.forEach(district => {
                    const option = document.createElement('option');
                    option.value = district.code;  // Assuming this is the correct property name in your JSON
                    option.text = district.name;   // Assuming this is the correct property name in your JSON
                    selectDistrictElement.appendChild(option);
                });
            })
            .catch(error => {
                // Xử lý lỗi ở đây
                console.error(error);
            });
    });


    // Lấy danh sách các xã khi chọn huyện
    selectDistrictElement.addEventListener('change', (event) => {
        districtId = event.target.value;
        console.log(`https://provinces.open-api.vn/api/d/` + districtId + `?depth=2`);
        fetch(`https://provinces.open-api.vn/api/d/` + districtId + `?depth=2`, {
            method: 'GET',
        })
            .then(response => response.json())
            .then(data => {
                // Xử lý dữ liệu ở đây
                selectWardElement.innerHTML = '<option value="" selected>Xã / Phường</option>';

                if (data && data.wards) {
                    data.wards.forEach(ward => {
                        const option = document.createElement('option');
                        option.value = ward.code;  // Assuming this is the correct property name in your JSON
                        option.text = ward.name;   // Assuming this is the correct property name in your JSON
                        selectWardElement.appendChild(option);
                    });
                } else {
                    console.error("Data or wards array is undefined");
                }
            })
            .catch(error => {
                // Xử lý lỗi ở đây
                console.error(error);
            });
    });

    selectWardElement.addEventListener('change', (event) => {
        wardId = event.target.value;
        document.getElementById("submitBtn").disabled = true; // Disable the submit button
        $.ajax({
            url: "${pageContext.request.contextPath}/cart/AddBillControl",
            type: "get",
            data: {
                wardId: wardId,
                districtId: districtId,
                provinceId: provinceId,
            },
            success: function (data) {
                let feeShip = JSON.parse(data).ship; // API
                let serviceFee;
                try {
                    serviceFee = JSON.parse(feeShip).data[0].service_fee;
                } catch (error) {
                    serviceFee = 40000; // Giá trị mặc định
                }
                <%--let total = ${total};--%>
                let total = ${total};
                total += serviceFee;
                document.getElementById("feeShipId").innerHTML = ` <td id="feeShipId" class="total-line__price">   ` + serviceFee + `
                                        <input type="hidden" name="shipFee" value="` + serviceFee + `"/></td>`;
                document.getElementById("spanShipId").innerHTML = ` <span id="spanShipId"  class="content-box__emphasis price priceSystas">
                                                                 ` + serviceFee + `
                                                            </span>`;
                document.getElementById("totalId").innerHTML = ` <span id="totalId" class="payment-due__price priceSystas">` + total + `</span> `;
                document.getElementById("submitBtn").disabled = false; // Enable the submit button
            },
            error: function (data) {
                console.log(data);
                document.getElementById("submitBtn").disabled = false; // Enable the submit button
            }
        });
    });
</script>
<script>
    let currency = 0;

    async function convertCurrency() {
        let totalId = parseFloat($('#totalId').text().replace('$', '')); // Phí ship
        const url = `https://api.apilayer.com/exchangerates_data/convert?to=USD&from=VND&amount=` + totalId;

        try {
            const response = await fetch(url, {
                headers: {
                    "apikey": "ql75lcTRsSTM4fOXovHfVOHWK6NcYPB4"
                }
            });

            if (response.ok) {
                const data = await response.json();
                const convertedAmount = data.result.toFixed(2);
                currency = convertedAmount;
                console.log(currency);
            } else {
                // Xử lý lỗi nếu cần thiết
            }
        } catch (error) {
            // Xử lý lỗi nếu có
        }
    }

    paypal.Buttons({
        async createOrder() {
            if (!isFormValid()) {
                // Hiển thị thông báo lỗi và không tạo đơn hàng
                Swal.fire({
                    title: 'Vui lòng điền đầy đủ thông tin',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
                return false;
            }
            await convertCurrency();
            let selectedValue = currency;
            console.log(selectedValue);
            return fetch("${pageContext.request.contextPath}/cart/PayPalCheckOut", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    denominations: selectedValue,
                }),
            })
                .then((response) => response.json())
                .then((order) => order.id);
        },
        onApprove(data) {
            let selectedValue = currency;
            console.log(data)
            console.log(selectedValue)
            return fetch("${pageContext.request.contextPath}/cart/CheckRecharge", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    balance: selectedValue,
                    orderID: data.orderID
                })
            })
                .then((response) => response.json())
                .then((orderData) => {
                    console.log(orderData)
                    console.log(orderData.purchaseUnits[0].payments.captures[0])
                    console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                    const transaction = orderData.purchaseUnits[0].payments.captures[0];
                    Swal.fire({
                        title: 'Thanh toán thành công',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        // location.reload();
                        let paymentMethod = document.getElementById("paymentMethod-120771");
                        paymentMethod.removeAttribute("required");
                        let submitBtn = document.getElementById("submitBtn");
                        submitBtn.click();
                    });

                });
        }
    }).render('#paypal-button-container')

    function isFormValid() {
        const email = document.getElementById('email').value;
        const billingName = document.getElementById('billingName').value;
        const billingPhone = document.getElementById('billingPhone').value;
        const billingAddress = document.getElementById('billingAddress').value;
        const billingProvince = document.getElementById('billingProvince').value;
        const billingDistrict = document.getElementById('billingDistrict').value;
        const billingWard = document.getElementById('billingWard').value;
        const billSignature = document.getElementById('privateKey').value;
        if (
            email === '' ||
            billingName === '' ||
            billingPhone === '' ||
            billingAddress === '' ||
            billingProvince === '' ||
            billingDistrict === '' ||
            billingWard === ''
        ) {
            return Promise.resolve(false);
        }else{
            return checkSignature(billSignature);
        }
    }

    function checkSignature(key) {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: "${pageContext.request.contextPath}/cart/CheckKeyControl",
                type: "POST",
                data: {
                    key: key,
                },
                success: function (data) {
                    let isVerify = JSON.parse(data).verify;
                    let element = document.getElementById('error-key');
                    if (isVerify) {
                        element.innerText = '';
                        resolve(true);
                    } else {
                        element.innerText = 'Private key không hợp lệ. Vui lòng kiểm tra lại!';
                        resolve(false);
                    }
                },
                error: function (data) {
                    console.log(data);
                    reject(data);
                }
            });
        });
    }

    document.getElementById('submitBtn').addEventListener('click', function (event) {
        event.preventDefault();
        isFormValid().then(isValid => {
            if (!isValid) {
            } else {
                document.getElementById('form_submit').submit();
            }
        });
    });
</script>
<script>
    function formatPriceElements() {
        const priceElements = document.getElementsByClassName('priceSystas');

        for (let i = 0; i < priceElements.length; i++) {
            const priceString = priceElements[i].innerText;
            const formattedPrice = formatNumberWithCommas(priceString).replace(/,/g, '.') + ' đ';
            priceElements[i].innerText = formattedPrice;
        }
    }
    function clearInput() {
        document.getElementById('privateKey').value = '';
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
</body>
</html>