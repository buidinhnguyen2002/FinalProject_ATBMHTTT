<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="web.lang.resource.app" var="lang"/>
<c:url value="/client/assets" var="url"></c:url>
<!-- CSS -->
<%-- <link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/style.css?1564585558451" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="${url}/css/checkout.css">
<link rel="stylesheet" href="${url}/css/bootstrap.min.css">
<link rel="stylesheet" href="${url}/css/style.css">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="${url}/css/product.css" rel="stylesheet" type="text/css" />
<link href="${url}/css/front-page.css" rel="stylesheet" type="text/css" />
<link href="${url}/css/owl.carousel.css" rel="stylesheet" type="text/css" />
<link href="${url}/css/jquery.fancybox.css" rel="stylesheet"
	type="text/css" />
<link href="${url}/css/responsive.css" rel="stylesheet" type="text/css" />


<!-- Script -->
<script src="${url}/js/jquery.js" type="text/javascript"></script>
<script src="${url}/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${url}/js/owl.carousel.js" type="text/javascript"></script>
<script src="${url}/js/api.jquery.js" type="text/javascript"></script>
<script src="${url}/js/jquery.fancybox.pack.js" type="text/javascript"></script>
<script src="${url}/js/jgrowl.js" type="text/javascript"></script>
<script src="${url}/js/cs.script.js" type="text/javascript"></script>
<script src="${url}/js/home.js" type="text/javascript"></script> --%>
<!-- CSS -->
<%--		<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/bootstrap.min.css?1564585558451" rel="stylesheet" type="text/css" media="all" />--%>
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${url}/css/bootstrap.min.css">

<link rel="canonical" href="https://kidshop-1.mysapo.net/"/>
<link rel="icon" href="https://lh3.googleusercontent.com/pw/AJFCJaXoQYraxnJ5Xb69WqHM1VQGknKZhyfiZbMmB6wyAJiOeVD_C15MO0MebL6Y0uDb0qf16BnhswiDxBoU4CWiObfRtcFdAXDrKN651ub56WgeBV220MOgoxEsdKXwjLUSliRIWVTPaCWaLlX2w7m6lcRb2e8ENo07IehTwKsl2n2wSVICj1Hj7ZmpCko_yHw4eUdPlshXFwmPwVvQY2HQ11NQvVxKDOtL6hxMkaBaIG0QgE4swK5S0IEWyhPf3kUuXDjqo4RiNKVYjTdzi__SxIZ8TsIEcFoiW5V837ODrZmqArfVv--iUhpeOfG-32_GFelpygILotxWz4tPAi_9a5mrjqxKTomZuqtwZt2h9UooAD1nIbQyBs2mwm-qNswhYs_OXFnH6gtCFLm4t-B01KP5caG00vub-x2ulXeuYUCxFky5zuFB7oPhbkXnfwePfgl8Jm__5ENCtTnfAQXTWYWGIRtRmaRAHZFwfP0jERY_VDrjB9SV2SyeBgdjv6CiKQwf8ePaj_eiEvzuh1DSK8mRkX7c6XmDocSYoMMuqYG2v3Yv3BVfJE5npzwElwhimrriPZekxBi5GC4vS1NI-KVqxDBjFWwSA1F3BuOLGX92GfozvEBj1oN9K-G3usx7MsxpGOvGY3Ni0N-5QR3CBWp5xteKjftbQEaJk02glp-saVoih7IFQf6bFQnRkhmQMN7DFNzsObALswIITfB54QwHf0vdZJTemb8d01FFQFLeqZ0GSF86Pa3lbyvzJ2HaP569GLNLSgfzg-jvbNV5R1rqOwWgpW4sd5Q3KaxRd97_X1nD48xnNHqx4aJr4FOcshElIwzKzCRQkYumMnfqLqTDzRE83VDgQJz7KaxRzM2N1qP5GsVmpvFg0FDXGPaTOiC1IK3QnqykTDaJMz-1fXqa6fBP6kIwrytrUYfAdfydwykxC5piNeP9Xkb_LT1cIdnR_08jDI7-rFaIovldG3fCF2ECZg=w80-h80-s-no?authuser=0"
      type="image/x-icon"/>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/style.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/front-page.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/owl.carousel.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/owl.theme.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/jquery.fancybox.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/responsive.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<link href="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/jgrowl.css?1564585558451" rel="stylesheet"
      type="text/css" media="all"/>
<!-- Script -->
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/jquery.min.js?1564585558451"
        type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/bootstrap.min.js?1564585558451"
        type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/owl.carousel.js?1564585558451"
        type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/assets/themes_support/api.jquery.js" type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/jquery.fancybox.pack.js?1564585558451"
        type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/jgrowl.js?1564585558451"
        type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/cs.script.js?1564585558451"
        type="text/javascript"></script>
<script src="//bizweb.dktcdn.net/100/117/632/themes/157694/assets/home.js?1564585558451"
        type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>
<style>html, body {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

body {
    box-sizing: border-box;
    padding-left: 1px;
    padding-right: 1px;
}</style>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-6STGGNT5HH"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-6STGGNT5HH');
</script>
	
