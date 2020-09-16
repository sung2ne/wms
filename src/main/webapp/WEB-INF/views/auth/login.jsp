<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/onepage/top.jsp" %>

<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <b>WMS</b>
    </div>

    <c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible">
        ${error}
    </div>
    </c:if>

    <div class="login-box-body">
        <form name="loginForm" method="post">
            <div class="form-group has-feedback">
                <input type="text" name="userId" class="form-control" placeholder="아이디" required>
            </div>
            <div class="form-group has-feedback">
                <input type="password" name="password" class="form-control" placeholder="비밀번호" required>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">로그인</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@include file="../layout/contents/script.jsp" %>

<script>

</script>
</body>
</html>
