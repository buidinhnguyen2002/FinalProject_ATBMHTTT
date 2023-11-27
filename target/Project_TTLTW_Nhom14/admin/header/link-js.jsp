<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url value="/admin/assets" var="url"/>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app" var="lang"/>

<script src="${url}/js/jquery.min.js"></script>
<script src="${url}/js/popper.min.js"></script>
<script src="${url}/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-table2excel/dist/jquery.table2excel.min.js"></script>
<script src="${url}/js/main.js"></script>
<!-- The javascript plugin to display page loading on top-->
<script src="${url}/js/plugins/pace.min.js"></script>
<!-- Page specific javascripts-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- Data table plugin-->
<script type="text/javascript" src="${url}/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${url}/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="${url}/js/plugins/chart.js"></script>
<script src="https://unpkg.com/exceljs/dist/exceljs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
<script>
    function checkFormNotEmpty(formId) {
        let form = document.getElementById(formId); // Lấy element form dựa trên id

        if (!form) {
            console.error("Form not found!");
            return false;
        }
        let inputs = form.querySelectorAll('input'); // Chọn tất cả các trường input trong form chỉ định
        for (let i = 0; i < inputs.length; i++) {
            if (inputs[i].value === '') {
                Swal.fire('Không được để trống', '', 'warning');
                return false; // Nếu có một trường rỗng, trả về false
            }
        }
        return true; // Nếu tất cả các trường không rỗng, trả về true
    }
</script>
<jsp:include page="/admin/websocket.jsp"></jsp:include>

