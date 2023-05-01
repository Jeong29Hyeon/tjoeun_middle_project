<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>header</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/5a1cb9332c.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Nanum Gothic', sans-serif;
        }
    </style>
</head>
<body>
<c:set var="joinOrNotLink" value="${sessionScope.user.id==null ? '/user/join' : ''}"/>
<c:set var="logInOrOutLink" value="${sessionScope.user.id==null ? '/user/login' : '/user/logout'}"/>
<c:set var="joinOrId" value="${sessionScope.user.id==null ? '회원가입' : sessionScope.user.name}"/>
<c:set var="logInOrOut" value="${sessionScope.user.id==null ? '로그인' : '로그아웃'}"/>
<c:set var="myPageLink" value="${sessionScope.user.id==null ? '' : '#'}"/>
<c:set var="myPage" value="${sessionScope.user.id==null ? '' : 'MyPage'}"/>
<nav class="navbar bg-light">
    <div class="container-fluid">
        <a class="navbar-brand mx-auto" href="/"><i class="fa-solid fa-hurricane"></i>TJOEUN CINEMA</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasNavbarLabel">메뉴</h5>
                <h5 class="offcanvas-title"><a href="<c:url value="${myPageLink}"/> " style="color: black; text-decoration-line: none">${myPage}</a></h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">홈</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="${joinOrNotLink}"/> ">${joinOrId}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="${logInOrOutLink}"/>">${logInOrOut}</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            예매
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">예매하기</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#">상영시간표</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            영화
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">현재상영작</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#">상영예정작</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

</body>
</html>