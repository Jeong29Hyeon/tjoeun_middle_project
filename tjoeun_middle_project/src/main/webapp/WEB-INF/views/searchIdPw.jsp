<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>아이디/비밀번호 찾기</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container mt-md-3" style="width: 500px">
    <div class="row g-3">
        <div class="col-md-12 position-relative bg-primary rounded text-center fs-1" style="height: 100px; color:white;">
            <span class="position-absolute top-50 start-50 translate-middle">ID/PW찾기</span>
        </div>
        <div id="msg">
            <c:if test="${not empty msg}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        ${msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>
        <c:set var="searchId" value="${empty user ? '이름' : 'ID'}"/>
        <c:set var="searchPw" value="${empty user ? '생년월일' : 'PW'}"/>
        <form name="searchForm" class="row g-3" action="<c:url value="/user/searchIdPw"/>" method="post">
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="name" class="form-label">${searchId}</label>
                    <c:choose>
                        <c:when test="${empty user}">
                            <input type="text" id="name" name="name" class="form-control" placeholder="이름입력">
                        </c:when>
                        <c:when test="${not empty user}">
                            <input type="text" class="form-control" value="${user.id}" disabled>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="birth" class="form-label">${searchPw}</label>
                    <c:choose>
                        <c:when test="${empty user}">
                            <input class="form-control" type="text" id="birth" name="birth" placeholder="생년월일(YYYY-MM-DD) 입력">
                        </c:when>
                        <c:when test="${not empty user}">
                            <input type="text" class="form-control" value="${user.password}" disabled>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <c:choose>
                <c:when test="${empty user}">
                    <div class="row mt-md-4 text-center">
                        <div class="d-grid gap-2">
                            <input type="button" class="btn btn-primary fluid" value="찾기" onclick="checkSearch()">
                        </div>
                    </div>
                </c:when>
                <c:when test="${not empty user}">
                    <div class="row mt-md-4 text-center">
                        <div class="d-grid gap-2">
                            <input type="submit" class="btn btn-primary fluid"
                                   value="로그인하기" formaction="/user/login" formmethod="get">
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </form>
    </div>
    <jsp:include page="footer.jsp"/>
    <script>
        var form = document.searchForm;
        function checkSearch(){
            if(form.name.value===""){
                alert("이름을 입력해주세요.");
                form.name.select();
                return;
            }else if(form.birth.value===""){
                alert("생년월일(YYYY-MM-DD)을 입력해주세요.")
                form.birth.select();
                return;
            }
            form.submit();
        }
    </script>
</body>
</html>
