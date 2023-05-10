<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>더조은 시네마</title>
    <style>
      .card-title {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 123px;
        height: 18px;
      }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<!-- msg 창 -->
<div class="container">
    <c:if test="${not empty msg}">
        <div class="alert alert-primary alert-dismissible fade show" role="alert">
                ${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
        </div>
    </c:if>
</div>
<!-- 영화 캐러셀 -->
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://caching2.lottecinema.co.kr/lotte_image/2023/MOON/0427/MOON_1920774.jpg"
                 class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
            <img src="https://caching2.lottecinema.co.kr/lotte_image/2023/JJANGU/0427/JJANGU_1920774.jpg"
                 class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
            <img src="https://caching2.lottecinema.co.kr/lotte_image/2023/SS/SS_1920774.jpg"
                 class="d-block w-100" alt="...">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
            data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
            data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<!-- 영화 목록 -->
<div class="container my-4">
    <div class="row row-cols-md-4 row-cols-sm-2 row-cols-lg-5">
        <c:if test="${not empty movies}">
            <c:forEach var="movie" items="${movies}">
                <div class="col">
                    <form action="" method="post">
                        <div class="card mb-3">
                            <!-- 디테일 뷰 -->
                            <span id="imgWrap${movie.seq}" class="position-relative rounded-2">
                                    <img id="posterImg${movie.seq}" src="${movie.img}"
                                         class="card-img-top" alt="..." style="height:290px">
                                <span id="btnWrap${movie.seq}"
                                      class="position-absolute top-50 start-50 translate-middle text-center" hidden>
                                    <a href="<c:url value="/movies/detail-view?seq=${movie.seq}"/>">
                                    <button id="btnDetail${movie.seq}" type="button" class="btn btn-sm btn-light mb-md-2">상세보기</button></a>
                                    <a href="<c:url value="/movieSelect?seq=${movie.seq}&title=${movie.title}"/>">
                                    <button id="btnReserve${movie.seq}" type="button" class="btn btn-sm btn-danger">예매하기</button></a>
<%--                                    수정예정--%>
                                </span>
                            </span>
                            <div class="card-body mx-auto">
                                <p class="card-title fw-bold mb-0 mx-auto"
                                   style="font-size: 12px">${movie.rank}</p>
                                <p class="card-title fw-bold mb-0 mx-auto"
                                   style="font-size: 12px">${movie.title}</p>
                                <p class="card-text my-0" style="font-size:10px;"><small
                                        class="text-muted">예매율 ${movie.rateInfo}%</small></p>
                                <p class="card-text" style="font-size:10px"><small
                                        class="text-muted">${movie.openingDate}</small></p>
                            </div>
                        </div>
                        <!-- 서버로 넘길 영화 데이터 input hidden -->
                    </form>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>

<%@include file="footer.jsp" %>
<script>
    $(document).ready(function () {
        <c:forEach var="movie" items="${movies}">
        $('#imgWrap${movie.seq}').on('mouseover', function () {
            $('#imgWrap${movie.seq}').css('background', 'rgba(0,0,0,0.8)');
            $('#posterImg${movie.seq}').css('opacity', '0.5');
            $('#posterImg${movie.seq}').css('transition', 'opacity 0.25s ease-in-out');
            $('#btnWrap${movie.seq}').attr('hidden', false);
        });

        $('#imgWrap${movie.seq}').on('mouseout', function () {
            $('#posterImg${movie.seq}').css('opacity', '1');
            $('#btnWrap${movie.seq}').attr('hidden', true);
        });
        </c:forEach>
    });
</script>
</body>
</html>