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
                <div class="col-md-2 ">
                        <a href="#"><img src="${movie.img}" class="img-thumbnail rounded mx-auto d-block" style="width:100%;height: 100%" alt="..."></a>
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
                    감독 : 신카이 마코토,이제희<br>
                    주연 : 스즈메, 소타
<%--                    영화 연출 정보도 받아와야할거같아요--%>
                </div>
            </div>

            <!-- 서버로 넘길 영화 데이터 input hidden -->
        </form>
    </div>
<%--    탭 추가 20230504.이제희--%>
    <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="story-tab" data-bs-toggle="tab" data-bs-target="#story" type="button" role="tab" aria-controls="story" aria-selected="true">줄거리</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="review-tab" data-bs-toggle="tab" data-bs-target="#review" type="button" role="tab" aria-controls="review" aria-selected="false">평점/리뷰</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="trailer-tab" data-bs-toggle="tab" data-bs-target="#trailer" type="button" role="tab" aria-controls="trailer" aria-selected="false">트레일러</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="stillcut-tab" data-bs-toggle="tab" data-bs-target="#stillcut" type="button" role="tab" aria-controls="stillcut" aria-selected="false">스틸컷</button>
        </li>
    </ul>
    <div class="tab-content justify-content-center" id="myTabContent">
        <div class="container tab-pane fade show active text-center" id="story" role="tabpanel" aria-labelledby="story-tab"> <p>${movie.story}</p></div>
        <div class="tab-pane fade text-center" id="review" role="tabpanel" aria-labelledby="review-tab">다이진이 귀여우요^^ 별정 5개 드립니다 ★★★★★★</div>
        <div class="tab-pane fade text-center" id="trailer" role="tabpanel" aria-labelledby="trailer-tab">트레일러 유튜브 링크 딱 걸면? 딱!</div>
        <div class="tab-pane fade text-center" id="stillcut" role="tabpanel" aria-labelledby="stillcut-tab"> 스틸컷 가져와서 넣자</div>
    </div>

</c:if>
<%@include file="footer.jsp" %>
</body>
</html>
