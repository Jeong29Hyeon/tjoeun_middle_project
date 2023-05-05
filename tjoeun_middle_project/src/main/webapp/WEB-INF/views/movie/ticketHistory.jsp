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
        <c:forEach var="history" items="${historyList}">
            <div class="col-4">
                <div class="card text-black bg-info mb-3 mt-3" style=" max-width: 18rem;">
                    <div class="card-header">예약 정보</div>
                    <div class="card-body">
                        <h5 class="card-title">${history.titleInfo}</h5>
                        <hr>
                        <p class="card-text">
                        <div class="row">
                            <div class="col-6">예약자성함</div>
                            <div class="col-6">${sessionScope.user.name}</div>
                        </div>
                        <div class="row">
                            <div class="col-6">상영관</div>
                            <div class="col-6">${history.hallInfo}</div>
                        </div>
                        <div class="row">
                            <div class="col-6">상영날짜</div>
                            <div class="col-6">${history.dayInfo}</div>
                        </div>
                        <div class="row">
                            <div class="col-6">상영시간</div>
                            <div class="col-6"> ${history.timeInfo}</div>
                        </div>
                        <div class="row">
                            <div class="col-6">좌석</div>
                            <div class="col-6 mb-3"> ${history.seats}</div>
                        </div>
                        <form>
                            <div class="container">
                                <input type="hidden" name="hallInfo" value="${history.hallInfo}">
                                <input type="hidden" name="dayInfo" value="${history.dayInfo}">
                                <input type="hidden" name="timeInfo" value="${history.timeInfo}">
                                <input type="hidden" name="seats" value="${history.seats}">
                                <div class="row">
                                    <div class="col-6">
                                        <button class="btn btn-outline-light" style="color: black">예약변경</button>
                                    </div>
                                    <div class="col-6">
                                        <button class="btn btn-outline-light" style="color: black" formaction="/deleteTicket"
                                                formmethod="get">예약취소
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>
