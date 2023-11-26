<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>
<!DOCTYPE html>
<html class="floating-labels">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="Kidshop - Thanh toán đơn hàng"/>
    <title>Halo's shop - Thanh toán đơn hàng</title>
    <link rel="icon" type="image" href="./images/HaLoicon.png"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/fontawesome.min.css"
          integrity="sha384-QYIZto+st3yW+o8+5OHfT6S482Zsvz2WfOzpFSXMF9zqeLcFV0/wlZpMtyFcZALm" crossorigin="anonymous">
    <link rel="stylesheet" href="/client/assets/css/checkout.vendor.min.css?v=4fcd86c">
    <link rel="stylesheet" href="/client/assets/css/checkout.min.css?v=17ca415">
    <script src="//bizweb.dktcdn.net/assets/themes_support/libphonenumber-v3.2.30.min.js?1564585558451"></script>
    <script src="/client/assets/js/checkout.vendor.min.js?v=11006c9"></script>
    <script src="/client/assets/js/checkout.min.js?v=ee358d5"></script>
    <script>
        var Bizweb = Bizweb || {};
        Bizweb.id = '117632';
        Bizweb.store = 'kidshop-1.mysapo.net';

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
    <script src="/client/assets/js/stats.min.js?v=69e02f0"></script>
</head>

<body data-no-turbolink>

<header class="banner">
    <div class="wrap">
        <div class="logo logo--left">

            <h1 class="shop__name">
                <a href="/">HaLo's Shop</a>
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
					<span class="order-summary-toggle__total-recap" data-bind="getTextTotalPrice()"></span>
				</span>
			</span>
    </button>
</aside>


<div data-tg-refresh="checkout" id="checkout" class="content">
    <form method="post"
          action="${pageContext.request.contextPath}/AddBillControl"
          >
        <input type="hidden" name="_method" value="patch"/>
        <div class="wrap">
            <main class="main">
                <header class="main__header">
                    <div class="logo logo--left">

                        <h1 class="shop__name">
                            <a href="/">Kidshop</a>
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
                                            <i class="fa fa-id-card-o fa-lg section__title--icon hide-on-desktop"></i>

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
                                                       type="email" class="field__input"
                                                       data-bind="email" value="${sessionScope.acc.email}">
                                            </div>

                                        </div>


                                        <div class="field "
                                             data-bind-class="{'field--show-floating-label': billing.name}">
                                            <div class="field__input-wrapper">
                                                <label for="billingName" class="field__label">Họ và tên</label>
                                                <input name="billingName" id="billingName"
                                                       type="text" class="field__input"
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
                                                       type="tel" class="field__input"
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
                                                       type="text" class="field__input"
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
                                                    <option value="">Tỉnh / Thành phố</option>

                                                </select>
                                            </div>

                                        </div>

                                        <div class="field field--show-floating-label "
                                        >
                                            <div class="field__input-wrapper field__input-wrapper--select2">
                                                <label for="billingDistrict" class="field__label">
                                                    Quận huyện (tùy chọn)
                                                </label>
                                                <select name="calc_shipping_district"
                                                        id="billingDistrict"
                                                        size="1"
                                                        class="field__input field__input--select"
                                                        required="">

                                                    <option value="">Quận / Huyện</option>

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
                                            <i class="fa fa-truck fa-lg section__title--icon hide-on-desktop"></i>
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
                                        <span data-bind="loadingShippingErrorMessage"></span> <i
                                            class="fa fa-refresh"></i>
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

															<span class="content-box__emphasis price">
																40.000₫
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
                                            <i class="fa fa-credit-card fa-lg section__title--icon hide-on-desktop"></i>
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
                                                           value="120771"
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
                        <button type="submit" class="btn btn-checkout spinner"
                                data-bind-class="{'spinner--active': isSubmitingCheckout}"
                                data-bind-disabled="isSubmitingCheckout || isLoadingReductionCode">
                            <span class="spinner-label">ĐẶT HÀNG</span>
                            <svg xmlns="http://www.w3.org/2000/svg" class="spinner-loader">
                                <use href="#spinner"></use>
                            </svg>
                        </button>

                        <a href="/cart" class="previous-link">
                            <i class="previous-link__arrow">❮</i>
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
                                    <c:forEach var="o" items="${sessionScope.cart}">
                                        <tr class="product">
                                            <td class="product__image">
                                                <div class="product-thumbnail">
                                                    <div class="product-thumbnail__wrapper" data-tg-static>
                                                        <img src="./images/${o.value.product.imageProducts.get(0).getImage()}"
                                                             alt="" class="product-thumbnail__image"/>
                                                    </div>
                                                    <span class="product-thumbnail__quantity">${o.value.quantity}</span>
                                                </div>
                                            </td>
                                            <th class="product__description">
													<span class="product__description__name">
                                                            ${o.value.product.nameProduct}
                                                    </span>

                                                <span class="product__description__property">
														456 / Trắng classic
													</span>


                                            </th>
                                            <td class="product__quantity visually-hidden"><em>Số
                                                lượng:</em> ${o.value.quantity}</td>
                                            <td class="product__price">
                                                    ${o.value.product.discountPrice * o.value.quantity}
                                            </td>
                                        </tr>
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
                                                           type="text" class="field__input"
                                                           autocomplete="off"
                                                           data-bind-disabled="isLoadingReductionCode"
                                                           data-bind-event-keypress="handleReductionCodeKeyPress(event)"

                                                           data-define="{reductionCode: null}"

                                                           data-bind="reductionCode">
                                                </div>
                                                <button class="field__input-btn btn spinner" type="button"
                                                        data-bind-disabled="isLoadingReductionCode || !reductionCode"
                                                        data-bind-class="{'spinner--active': isLoadingReductionCode, 'btn--disabled': !reductionCode}"
                                                        data-bind-event-click="applyReductionCode()">
                                                    <span class="spinner-label">Áp dụng</span>
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="spinner-loader">
                                                        <use href="#spinner"></use>
                                                    </svg>
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
                                        <td><span class="visually-hidden">Giá tiền</span></td>
                                    </tr>
                                    </thead>
                                    <tbody class="total-line-table__tbody">
                                    <tr class="total-line total-line--subtotal">
                                        <th class="total-line__name">
                                            Tạm tính
                                        </th>
                                        <td class="total-line__price">${total}</td>
                                    </tr>

                                    <tr class="total-line total-line--shipping-fee">
                                        <th class="total-line__name">
                                            Phí vận chuyển
                                        </th>
                                        <td class="total-line__price"> 40000.0
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
                                            <span class="payment-due__price">${total+40000} </span>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div class="order-summary__nav field__input-btn-wrapper hide-on-mobile layout-flex--row-reverse">
                                <button type="submit" class="btn btn-checkout spinner">
                                    <span class="spinner-label">ĐẶT HÀNG</span>
                                </button>


                                <a href="${pageContext.request.contextPath}/CartControl" class="previous-link">
                                    <i class="previous-link__arrow">❮</i>
                                    <span class="previous-link__content">Quay về giỏ hàng</span>
                                </a>

                            </div>
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
<script src="https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js"></script>
<script>//<![CDATA[
if (address_2 = localStorage.getItem('address_2_saved')) {
    $('select[name="calc_shipping_district"] option').each(function () {
        if ($(this).text() == address_2) {
            $(this).attr('selected', '')
        }
    })
    $('input.billing_address_2').attr('value', address_2)
}
if (district = localStorage.getItem('district')) {
    $('select[name="calc_shipping_district"]').html(district)
    $('select[name="calc_shipping_district"]').on('change', function () {
        var target = $(this).children('option:selected')
        target.attr('selected', '')
        $('select[name="calc_shipping_district"] option').not(target).removeAttr('selected')
        address_2 = target.text()
        $('input.billing_address_2').attr('value', address_2)
        district = $('select[name="calc_shipping_district"]').html()
        localStorage.setItem('district', district)
        localStorage.setItem('address_2_saved', address_2)
    })
}
$('select[name="calc_shipping_provinces"]').each(function () {
    var $this = $(this),
        stc = ''
    c.forEach(function (i, e) {
        e += +1
        stc += '<option value=' + e + '>' + i + '</option>'
        $this.html('<option value="">Tỉnh / Thành phố</option>' + stc)
        if (address_1 = localStorage.getItem('address_1_saved')) {
            $('select[name="calc_shipping_provinces"] option').each(function () {
                if ($(this).text() == address_1) {
                    $(this).attr('selected', '')
                }
            })
            $('input.billing_address_1').attr('value', address_1)
        }
        $this.on('change', function (i) {
            i = $this.children('option:selected').index() - 1
            var str = '',
                r = $this.val()
            if (r != '') {
                arr[i].forEach(function (el) {
                    str += '<option value="' + el + '">' + el + '</option>'
                    $('select[name="calc_shipping_district"]').html('<option value="">Quận / Huyện</option>' + str)
                })
                var address_1 = $this.children('option:selected').text()
                var district = $('select[name="calc_shipping_district"]').html()
                localStorage.setItem('address_1_saved', address_1)
                localStorage.setItem('district', district)
                $('select[name="calc_shipping_district"]').on('change', function () {
                    var target = $(this).children('option:selected')
                    target.attr('selected', '')
                    $('select[name="calc_shipping_district"] option').not(target).removeAttr('selected')
                    var address_2 = target.text()
                    $('input.billing_address_2').attr('value', address_2)
                    district = $('select[name="calc_shipping_district"]').html()
                    localStorage.setItem('district', district)
                    localStorage.setItem('address_2_saved', address_2)
                })
            } else {
                $('select[name="calc_shipping_district"]').html('<option value="">Quận / Huyện</option>')
                district = $('select[name="calc_shipping_district"]').html()
                localStorage.setItem('district', district)
                localStorage.removeItem('address_1_saved', address_1)
            }
        })
    })
})
//]]></script>
</body>
</html>
