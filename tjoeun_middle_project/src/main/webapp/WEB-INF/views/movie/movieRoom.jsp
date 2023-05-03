<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-01
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 예약</title>
</head>

<body>
<%@ include file="../header.jsp" %>

<h1 style="text-align: center; background-color: grey" class="mb-5 mt-3">스크린</h1>

<form>
    <div class="form-group">
        <div class="container">
            <div class="row mb-3">
                <div class="col-md-2">
                    <button type="button" class="btn btn-outline-secondary btn-block" disabled>A열</button>
                </div>
                <c:forEach var="a" begin="1" end="10">
                    <div class="col-md-1">
                        <button type="button" class="btn btn-outline-secondary btn-block" value="${a}">${a}</button>
                    </div>
                </c:forEach>
            </div>
            <div class="row mb-3">
                <div class="col-md-2">
                    <button type="button" class="btn btn-outline-secondary btn-block" disabled>B열</button>
                </div>
                <c:forEach var="a" begin="1" end="10">
                    <div class="col-md-1">
                        <button type="button" class="btn btn-outline-secondary btn-block" value="${a}">${a}</button>
                    </div>
                </c:forEach>
            </div>
            <div class="row mb-3">
                <div class="col-md-2">
                    <button type="button" class="btn btn-outline-secondary btn-block" disabled>C열</button>
                </div>
                <c:forEach var="a" begin="1" end="10">
                    <div class="col-md-1">
                        <button type="button" class="btn btn-outline-secondary btn-block" value="${a}">${a}</button>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <button type="submit" class="btn btn-primary">선택완료</button>
    <a href="<c:url value="javascript:history.back();"/>">
    <button type="button" class="btn btn-primary">뒤로가기</button></a>
</form>
<%@ include file="../footer.jsp" %>
</body>
</html>
