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
<%--<head>--%>
<%--    <title>인원/좌석 선택</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<h1 style="text-align: center">스크린</h1>--%>
<%--<div class="container">--%>
<%--<table >--%>
<%--    <tr>--%>
<%--        <td width="4%">A열</td>--%>
<%--        <td width="5%"></td>--%>
<%--        <c:forEach var="a" begin="1" end="10">--%>
<%--            <td width="8%">--%>
<%--                <button value="${a}"></button>--%>
<%--            </td>--%>
<%--        </c:forEach>--%>
<%--    </tr>--%>
<%--    <tr>--%>
<%--        <td>B열</td>--%>
<%--        <td></td>--%>
<%--        <c:forEach var="a" begin="1" end="10">--%>
<%--            <td width="10%">${a}</td>--%>
<%--        </c:forEach>--%>
<%--    </tr>--%>
<%--    <tr>--%>
<%--        <td>C열</td>--%>
<%--        <td></td>--%>
<%--        <c:forEach var="a" begin="1" end="10">--%>
<%--            <td width="10%">${a}</td>--%>
<%--        </c:forEach>--%>
<%--    </tr>--%>
<%--</table>--%>
<%--</div>--%>
<%--</body>--%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 예약</title>
</head>

<body>
<%@ include file="WEB-INF/views/header.jsp"%>

<h1 style="text-align: center; background-color: grey" class="mb-5 mt-3">스크린</h1>
<form>
    <div class="form-check-reverse mb-5">
        성인
        <select class="form-select-sm">
            <option>1</option>
            <option>2</option>
            <option>3</option>
        </select>
        아동
        <select class="form-select-sm">
            <option>1</option>
            <option>2</option>
            <option>3</option>
        </select>
    </div>
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
</form>
<%@ include file="WEB-INF/views/footer.jsp"%>
</body>
</html>
