<%--
  Created by IntelliJ IDEA.
  User: lunat
  Date: 2023-05-02
  Time: 오전 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화정보</title>
</head>
<body>
<%@include file="header.jsp" %>
일단 띄우자
<c:if test="${not empty poster}">
        <div class="col">
            <form action="" method="post">
                <div class="card mb-3">
                    <!-- 디테일 뷰 -->
                    <a href="#"><img src="${poster.img}" class="card-img-top" alt="..."></a>
                    <div class="card-body text-center">
                        <p class="card-title fw-bold mb-0"
                           style="font-size: 12px">${poster.rank}</p>
                        <p class="card-title fw-bold mb-0"
                           style="font-size: 12px">${poster.title}</p>
                        <p class="card-text my-0" style="font-size:10px;"><small
                                class="text-muted">예매율 ${poster.rateInfo}</small></p>
                        <p class="card-text" style="font-size:10px"><small
                                class="text-muted">${poster.openingDate}</small></p>
                        <p>${poster.story}</p>
                        <button id="btnReserve" class="btn btn-outline-primary btn-sm">예매하기</button>
                    </div>
                </div>
                <!-- 서버로 넘길 영화 데이터 input hidden -->
            </form>
        </div>
</c:if>
</body>
</html>
