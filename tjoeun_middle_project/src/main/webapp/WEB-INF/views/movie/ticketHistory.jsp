<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-04
  Time: 오후 2:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>예약내역 확인</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container mt-5">
    <h1 style="text-align: center">나의 예매 내역</h1>
</div>
<div class="container mt-5">
    <div class="row">
        <div class="col-6">
            예매 내역
        </div>
        <div class="col-6">
            예매 값
        </div>
    </div>
</div>
<c:forEach var="history" items="${historyList}">
    ${history.id}<br>
    ${history.titleInfo}<br>
    ${history.timeInfo}<br>
    ${history.hallInfo}<br>
    ${history.seats}<br>
    ${history.dayInfo}<br>
</c:forEach>

<%@include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>
