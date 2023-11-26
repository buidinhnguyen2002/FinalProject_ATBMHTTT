
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script>
    const socket = new WebSocket("ws://localhost:8080/haloshop/observer");
    socket.addEventListener("message", (event) => {
        let data = JSON.parse(event.data);
        let idUser = data.idUser;
        let type = data.type;
        if(type==="remove" && ${sessionScope.acc.id} === idUser){
            $.ajax({
                url : "${pageContext.request.contextPath}/client/NotifyAccount",
                type : "post",
                data : {
                    idUser : idUser,
                },
                success : function(data) {
                    Swal.fire('Tài khoản của bạn đã bị xóa vui lòng liên hệ quản trị viên để biết thêm chi tiết', '', 'success').then(()=>{
                        window.location.href = "${pageContext.request.contextPath}/IndexControl";
                    });
                },
                error : function(data) {
                    console.log("error")
                }
            });
        }
        if(type==="update" && ${sessionScope.acc.id} === idUser){
            $.ajax({
                url : "${pageContext.request.contextPath}/client/NotifyAccount",
                type : "post",
                data : {
                    idUser : idUser,
                },
                success : function(data) {
                    Swal.fire('Tài khoản của bạn có một số thay đổi vui lòng đăng nhập lại ', '', 'success').then(()=>{
                        window.location.href = "${pageContext.request.contextPath}/IndexControl";
                    });
                },
                error : function(data) {
                    console.log("error")
                }
            });
        }
    });
</script>
