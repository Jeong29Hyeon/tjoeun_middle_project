<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>header</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://kit.fontawesome.com/5a1cb9332c.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Nanum Gothic', sans-serif;
        }
    </style>
</head>
<body>
<nav class="navbar bg-light">
    <div class="container-fluid">
        <a class="navbar-brand mx-auto" href="<c:url value="/"/>"><i class="fa-solid fa-hurricane"></i>TJOEUN CINEMA</a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="offcanvas"
                data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <i class="fa-solid fa-bounce fa-house"></i>
                </c:when>
                <c:when test="${not empty sessionScope.user}">
                    <i class="fa-solid fa-house"></i>
                </c:when>
            </c:choose>
        </button>
        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasNavbarLabel">메뉴</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
                </button>
            </div>
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 mb-auto">
                    <li class="nav-item dropdown mb-3">
                        <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#reserveTap" aria-controls="reserveTap" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span>예매</span>
                        </button>
                        <div class="navbar-collapse collapse show" id="reserveTap" style="">
                            <ul class="navbar-nav me-auto mb-2">
                                <li class="nav-item">
                                    <a class="nav-link" href="/movieSelect">예매하기</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">상영시간표</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item dropdown mb-3">
                        <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#storeTap" aria-controls="storeTap" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span>스토어</span>
                        </button>
                        <div class="navbar-collapse collapse show" id="storeTap" style="">
                            <ul class="navbar-nav me-auto mb-2">
                                <li class="nav-item">
                                    <a class="nav-link" href="/store/main">매점</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">기프티콘</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <c:set var="joinOrNotLink" value="${sessionScope.user.id==null ? '/user/join' : ''}"/>
            <c:set var="logInOrOutLink" value="${sessionScope.user.id==null ? '/user/login' : '/user/logout'}"/>
            <c:set var="logInOrOut" value="${sessionScope.user.id==null ? 'Sign In' : 'Sign Out'}"/>
            <c:set var="joinOrId" value="${sessionScope.user.id==null ? '회원가입' : ''}"/>
            <c:set var="logInOrName" value="${sessionScope.user.id==null ? '로그인후 이용해주세요' : sessionScope.user.name}"/>
            <c:set var="profileLink" value="${sessionScope.user.id==null ? '' : '/user/profile'}"/>
            <c:set var="profile" value="${sessionScope.user.id==null ? '' : 'Profile'}"/>
            <c:set var="Reservation" value="${sessionScope.user.id==null ? '' : '/user/ticketHistory'}"/>
            <c:set var="ReservationInfo" value="${sessionScope.user.id==null ? '' : 'Reservation'}"/>
            <c:set var="searchIdPwLink" value="${sessionScope.user.id==null ? '/user/searchIdPw' : ''}"/>
            <c:set var="searchIdPw" value="${sessionScope.user.id==null ? 'SEARCH ID&PW' : ''}"/>

            <div class="dropup ms-3 mb-3">
                <a href="#" class="d-flex align-items-center text-black text-decoration-none dropdown-toggle"
                   data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-solid fa-circle-user fa-xl me-2"></i>
                    <strong>${logInOrName}</strong>
                </a>
                <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li><a class="dropdown-item" href="${joinOrNotLink}">${joinOrId}</a></li>
                            <li><a class="dropdown-item" href="${searchIdPwLink}">${searchIdPw}</a></li>
                        </c:when>
                        <c:when test="${not empty sessionScope.user}">
                            <li><a class="dropdown-item" href="${profileLink}">${profile}</a></li>
                            <li><a class="dropdown-item" href="${Reservation}">${ReservationInfo}</a></li>
                        </c:when>
                    </c:choose>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item" href="${logInOrOutLink}">${logInOrOut}</a></li>
                </ul>
            </div>
        </div>
    </div>

</nav>


</body>
</html>
