<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-09
  Time: 오전 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Store</title>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container mt-5"><h2>스토어</h2></div>
<div class="container">
    <ul class="nav nav-tabs nav-fill justify-content-center mt-4" id="goods" role="tablist">
        <li class="nav-item active" role="presentation">
            <button class="nav-link" id="setMenu-tab" data-bs-toggle="tab" data-bs-target="#setMenu" type="button"
                    role="tab" aria-controls="setMenu" aria-selected="false">세트메뉴
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="changeInfo-tab" data-bs-toggle="tab" data-bs-target="#changeInfo"
                    type="button" role="tab" aria-controls="changeInfo" aria-selected="false">팝콘만
            </button>
        </li>

        <li class="nav-item" role="presentation">
            <button class="nav-link" id="futureTicket-tab" data-bs-toggle="tab" data-bs-target="#futureTicket"
                    type="button"
                    role="tab" aria-controls="futureTicket" aria-selected="false">음료만
            </button>
        </li>
    </ul>

    <div class="container tab-content justify-content-center">
        <div class="container tab-pane fade  text-center" id="setMenu" role="tabpanel" aria-labelledby="setMenu-tab">
            <div class="container mt-5">
                <div class="row">
                    <%--                    <c:forEach var="past" items="${pastTicketList}">--%>
                    <div class="col-4">
                        <div class="card text-black bg-light mb-3 mt-3" style=" max-width: 18rem;">
                            <div class="card-header"></div>
                            <div class="card-body">
                                <h5 class="card-title">콤보</h5>
                                <hr>
                                <p class="card-text">
                                <div class="row">
                                    <div class="col-6">예약자성함</div>
                                    <div class="col-6">${sessionScope.user.name}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영관</div>
                                    <div class="col-6">asd</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영날짜</div>
                                    <div class="col-6">ㅁㄴㅇ</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영시간</div>
                                    <div class="col-6"> ㅁㄴㅇ</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">좌석</div>
                                    <div class="col-6 mb-3"> ㅁㄴㅇ</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--                    </c:forEach>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>
