<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url value="/admin/assets" var="url"/>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>

<!-- Main CSS-->
<link rel="icon" href="https://lh3.googleusercontent.com/pw/AJFCJaXoQYraxnJ5Xb69WqHM1VQGknKZhyfiZbMmB6wyAJiOeVD_C15MO0MebL6Y0uDb0qf16BnhswiDxBoU4CWiObfRtcFdAXDrKN651ub56WgeBV220MOgoxEsdKXwjLUSliRIWVTPaCWaLlX2w7m6lcRb2e8ENo07IehTwKsl2n2wSVICj1Hj7ZmpCko_yHw4eUdPlshXFwmPwVvQY2HQ11NQvVxKDOtL6hxMkaBaIG0QgE4swK5S0IEWyhPf3kUuXDjqo4RiNKVYjTdzi__SxIZ8TsIEcFoiW5V837ODrZmqArfVv--iUhpeOfG-32_GFelpygILotxWz4tPAi_9a5mrjqxKTomZuqtwZt2h9UooAD1nIbQyBs2mwm-qNswhYs_OXFnH6gtCFLm4t-B01KP5caG00vub-x2ulXeuYUCxFky5zuFB7oPhbkXnfwePfgl8Jm__5ENCtTnfAQXTWYWGIRtRmaRAHZFwfP0jERY_VDrjB9SV2SyeBgdjv6CiKQwf8ePaj_eiEvzuh1DSK8mRkX7c6XmDocSYoMMuqYG2v3Yv3BVfJE5npzwElwhimrriPZekxBi5GC4vS1NI-KVqxDBjFWwSA1F3BuOLGX92GfozvEBj1oN9K-G3usx7MsxpGOvGY3Ni0N-5QR3CBWp5xteKjftbQEaJk02glp-saVoih7IFQf6bFQnRkhmQMN7DFNzsObALswIITfB54QwHf0vdZJTemb8d01FFQFLeqZ0GSF86Pa3lbyvzJ2HaP569GLNLSgfzg-jvbNV5R1rqOwWgpW4sd5Q3KaxRd97_X1nD48xnNHqx4aJr4FOcshElIwzKzCRQkYumMnfqLqTDzRE83VDgQJz7KaxRzM2N1qP5GsVmpvFg0FDXGPaTOiC1IK3QnqykTDaJMz-1fXqa6fBP6kIwrytrUYfAdfydwykxC5piNeP9Xkb_LT1cIdnR_08jDI7-rFaIovldG3fCF2ECZg=w80-h80-s-no?authuser=0"
      type="image/x-icon"/>
<link rel="stylesheet" type="text/css" href="${url}/css/main.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
<!-- or -->
<link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>