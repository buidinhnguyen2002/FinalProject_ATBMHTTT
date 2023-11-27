
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>
<script>
    const socket = new WebSocket("ws://haloshop.site/observer");
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
                    typeAction : 'delete',
                },
                success : function(data) {
                    Swal.fire({
                        title: 'Tài khoản của bạn đã bị khóa!',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then(()=>{
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
                    typeAction : 'edit',
                },
                success : function(data) {
                    Swal.fire('Tài khoản của bạn có một số thay đổi ', '', 'success')
                },
                error : function(data) {
                    console.log("error")
                }
            });
        }
    });
</script>
