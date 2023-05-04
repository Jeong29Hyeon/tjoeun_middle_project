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
<c:if test="${not empty movie}">
    <div class="container">
        <form action="" method="post">
            <div class="row">
                <!-- 디테일 뷰 -->
                <div class="col-md-5">
                        <a href="#"><img src="${movie.img}" class="img-thumbnail" style="width:50%;height: 100%" alt="..."></a>
                </div>
                <div class="col-md-6">
                    <p class="card-title fw-bold mb-0"
                       style="font-size: 12px">${movie.rank}</p>
                    <p class="card-title fw-bold mb-0"
                       style="font-size: 40px">${movie.title}</p>
                    <p class="card-text my-0" style="font-size:10px;"><small
                            class="text-muted">예매율 ${movie.rateInfo}</small></p>
                    <p class="card-text" style="font-size:10px"><small
                            class="text-muted">${movie.openingDate}</small></p>
                    <p>${movie.story}</p>
                </div>
            </div>
            <div class="row">
                <p>test</p>
            </div>
            <!-- 서버로 넘길 영화 데이터 input hidden -->
        </form>
    </div>

    <div class="container">
        여기다가 뭐 주요 정보 트레일러 평점/리뷰 탭 만들어주고
    </div>
    <div class="container">
        요기에는 각ㄱㄱ 탭에 맞는 정보를 보여준다면?
    </div>
</c:if>
<%@include file="footer.jsp" %>
</body>
</html>
