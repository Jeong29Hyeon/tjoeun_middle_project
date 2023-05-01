<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>더조은 시네마</title>
</head>
<body>
<%@include file="header.jsp"%>
<!-- 영화 캐러셀 -->
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://caching2.lottecinema.co.kr/lotte_image/2023/MOON/0427/MOON_1920774.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
            <img src="https://caching2.lottecinema.co.kr/lotte_image/2023/JJANGU/0427/JJANGU_1920774.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
            <img src="https://caching2.lottecinema.co.kr/lotte_image/2023/SS/SS_1920774.jpg" class="d-block w-100" alt="...">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<div class="container my-4">
    <div class="row">
        <div class="col-md">
            <div class="card mb-3">
                <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202305/19168_103_1.jpg" class="card-img-top" alt="...">
                <div class="card-body text-center">
                    <p class="card-title fw-bold" style="font-size: 12px">슈퍼마리오 브라더스</p>
                    <p class="card-text" style="font-size:10px;"><small class="text-muted">예매율 36.4% | <i class="fa-solid fa-star"></i>9.2 </small></p>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card mb-3">
                <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202305/19168_103_1.jpg" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Card title</h5>
                    <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card mb-3">
                <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202305/19168_103_1.jpg" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Card title</h5>
                    <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card mb-3">
                <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202305/19168_103_1.jpg" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Card title</h5>
                    <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card mb-3">
                <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202305/19168_103_1.jpg" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Card title</h5>
                    <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>
</body>
</html>