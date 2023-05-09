<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-08
  Time: 오후 12:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>profile</title>
    <style>
        ul.rank_ul {
            list-style: none;
        }

        li.rank_li {
            float: left;
            margin-right: 70px;
            color: black;
        }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<div class="container mt-5">
    <div class="row" style="border: 1px black">
        <div class="col-8">
            <div class="row">
                <div class="col">
                    <h5>현재까지 사용 금액: ${sumPrice}</h5><br>
                    <h5>${rank}</h5><br>
                    <h3>${sessionScope.user.name}님 반가워요!</h3><br>
                    <div class="next_rank" style="text-align: center">
                        <c:choose>
                            <c:when test="${nextRank > 0}">
                                <p>NEXT RANK 까지 <span style="font-size: 20px; color: red;">${nextRank}원 </span>남았어요!</p>
                            </c:when>
                            <c:otherwise>
                                <p><span style="font-size: 20px; color: red;">최고 등급 입니다!! </span></p>
                            </c:otherwise>
                        </c:choose>
                    </div>

<%--                    <div class="rank" id="rank_name">--%>
                        <%--                            <span style="width: 20%">Bronze</span>--%>
                        <%--                            <span style="width: 40%">Silver</span>--%>
                        <%--                            <span style="width: 60%">Gold</span>--%>
                        <%--                            <span style="width: 80%">VIP</span>--%>
                        <%--                            <span style="width: 100%">VVIP</span>--%>
<%--                        <ul class="rank_ul">--%>
<%--                            <li class="rank_li">--%>
<%--                                <div style="width: 20%">Bronze</div>--%>
<%--                            </li>--%>
<%--                            <li class="rank_li">--%>
<%--                                <div style="width: 40%">Silver</div>--%>
<%--                            </li>--%>
<%--                            <li class="rank_li">--%>
<%--                                <div style="width: 60%">Gold</div>--%>
<%--                            </li>--%>
<%--                            <li class="rank_li">--%>
<%--                                <div style="width: 80%">VIP</div>--%>
<%--                            </li>--%>
<%--                            <li class="rank_li">--%>
<%--                                <div style="width: 100%">VVIP</div>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
                    <br>
                    <div class="progress" style="height: 30px">
                        <div class="progress-bar progress-bar-striped bg-info" role="progressbar" style="width: ${gage}; height: 30px"
                             aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                            <h5 style="text-align: right; margin-right: 10px; margin-top: 7px; color: black">${rank}</h5>
                            <%--                            <div class="rank">--%>
                            <%--                                <ul>--%>
                            <%--                                    <li>Bronze</li>--%>
                            <%--                                    <li>Silver</li>--%>
                            <%--                                    <li>Gold</li>--%>
                            <%--                                    <li>VIP</li>--%>
                            <%--                                    <li>VVIP</li>--%>
                            <%--                                </ul>--%>
                            <%--                            </div>--%>
                        </div>
                    </div>
                    <br>
                    <%--                        <form>--%>
                    <div class="row">
                        <div class="col-6">
                            <div class="row">
                                <div class="col-3"></div>
                                <div class="col-6"><a class="btn btn-info" role="button"
                                                      href="/user/ticketHistory">예매내역</a></div>
                                <div class="col-3"></div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="row">
                                <div class="col-3"></div>
                                <div class="col-6"><a class="btn btn-info" role="button" href="#">쿠폰함</a></div>
                                <div class="col-3"></div>
                            </div>
                        </div>
                    </div>
                    <%--                        </form>--%>
                </div>
            </div>
        </div>
        <div class="col-4">
            <img style="height: 300px; width: 200px" src="/resources/img/poster.jpg"/>
        </div>
    </div>
</div>
<ul class="nav nav-tabs justify-content-center mt-4" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="myInfo-tab" data-bs-toggle="tab" data-bs-target="#myInfo" type="button"
                role="tab" aria-controls="myInfo" aria-selected="false">회원 정보
        </button>
    </li>
    <li class="nav-item active" role="presentation">
        <button class="nav-link" id="changeInfo-tab" data-bs-toggle="tab" data-bs-target="#changeInfo"
                type="button" role="tab" aria-controls="changeInfo" aria-selected="false">회원정보 변경
        </button>
    </li>

    <li class="nav-item" role="presentation">
        <button class="nav-link" id="futureTicket-tab" data-bs-toggle="tab" data-bs-target="#futureTicket" type="button"
                role="tab" aria-controls="futureTicket" aria-selected="false">결제내역
        </button>
    </li>
</ul>
<c:set var="user" value="${sessionScope.user}"/>
<c:set var="birth" value="${fn:split(sessionScope.user.birth,'-')}"/>
<c:set var="email" value="${fn:split(sessionScope.user.email,'@')}"/>

<div class="container tab-content justify-content-center" id="ticket">
    <div class="container tab-pane fade  text-center" id="myInfo" role="tabpanel" aria-labelledby="myInfo-tab">
        <div class="container mt-5">
            <div class="row">
                <div class="container mt-md-3" style="width: 500px">
                    <div class="row g-3">
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="id" class="form-label">아이디</label>
                                <input type="text" class="form-control" value="${sessionScope.user.id}" disabled>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="name" class="form-label">이름</label>
                                <input class="form-control" type="text" value="${sessionScope.user.name}" disabled>

                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="birth" class="form-label">생년월일</label>
                            </div>
                            <div class="col-md-12">
                                <input class="form-control" type="text" value="${sessionScope.user.birth}" disabled>
                            </div>
                        </div>

                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="gender" class="form-label">성별</label>
                                <input type="text" class="form-control" value="${sessionScope.user.gender}" disabled>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="email">이메일</label>
                            </div>
                            <div class="col-md-12 mt-md-1">
                                <div class="input-group">
                                    <input type="text" class="form-control" value="${sessionScope.user.email}" disabled>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="phone" class="form-label">휴대전화</label>
                                <input type="text" class="form-control" value="${sessionScope.user.phone}" disabled>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container tab-pane fade  text-center" id="changeInfo" role="tabpanel" aria-labelledby="changeInfo-tab">
    <div class="container mt-5">
        <div class="row">
            <div class="container mt-md-3" style="width: 500px">
                <form name="infoForm" id="infoForm" hidden>
                    <div class="row g-3">
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="id" class="form-label">아이디</label>
                                <input type="text" id="id" name="id" class="form-control"
                                       value="${sessionScope.user.id}" disabled>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="password" class="form-label">비밀번호</label>
                                <input class="form-control" type="text" id="password" name="password"
                                       value="${sessionScope.user.password}">
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="name" class="form-label">이름</label>
                                <input class="form-control" type="text" id="name" name="name"
                                       value="${sessionScope.user.name}" disabled>

                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="birth" class="form-label">생년월일</label>
                            </div>
                            <div class="col-md-12">
                                <input class="form-control" type="text" id="birth" name="birth"
                                       value="${sessionScope.user.birth}" disabled>
                            </div>
                        </div>

                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="gender" class="form-label">성별</label>
                                <input type="text" class="form-control" id="gender" name="gender"
                                       value="${sessionScope.user.gender}" disabled>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="email1">이메일</label>
                            </div>
                            <div class="col-md-12 mt-md-1">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="email" id="email1"
                                           name="email1"
                                           value="${email[0]}">
                                    <span class="input-group-text">@</span>
                                    <input type="text" class="form-control" placeholder="ex)naver.com"
                                           aria-label="Server"
                                           name="email2" id="email2" value="${email[1]}">
                                </div>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-md-12">
                                <label for="phone" class="form-label">휴대전화</label>
                                <input type="text" class="form-control" id="phone" name="phone"
                                       value="${sessionScope.user.phone}">
                            </div>
                        </div>
                        <div class="row mt-md-4 text-center">
                            <div class="col-12">
                            <button type="button" class="btn btn-outline-primary" id="editBtn">수정하기</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<%@include file="footer.jsp" %>
<script>
    $('#changeInfo-tab').on('click', function () {
        var pw = prompt("비밀번호를 입력해주세요", '')
        if (pw.trim() !== '${sessionScope.user.password}') {
            alert("비밀번호 불일치")
            return
        }
        $('#infoForm').attr('hidden', false);
    })
    $('#editBtn').on('click', function () {
        var form = document.infoForm;
        var regExpPw = /^[a-zA-Z0-9]{4,}$/;
        var regExpName = /^[가-힣]{2,4}$/;
        var regExpYear = /^[0-9]{4}$/;
        var regExpDay = /^[0-9]{1,2}/;
        var regExpEmail1 = /^[a-zA-Z0-9]([-_]?[a-zA-Z0-9])*$/;
        var regExpEmail2 = /^[0-9a-zA-Z]([-_]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
        var regExpPhone = /^010[0-9]{8}$/;
        var current = new Date();

        if (form.password.value === "") {
            alert("비밀번호를 입력해주세요.");
            form.password.select();
            return;
        } else if (!regExpPw.test(form.password.value)) {
            alert("비밀번호는 4자 이상의 영문 대소문자와 숫자만 사용 가능합니다.");
            form.password.select();
            return;
        }
        if (form.name.value === "") {
            alert("이름을 입력해주세요.");
            return;
        } else if (!regExpName.test(form.name.value)) {
            alert("이름은 2~4자 사이의 한글만 입력해주세요.");
            return;
        }
        if (form.email1.value === "") {
            alert("이메일을 입력해주세요.");
            form.email1.select();
            return;
        } else if (!regExpEmail1.test(form.email1.value)) {
            alert("이메일은 영문 대소문자와 하이픈(-), 언더바(_)만 사용가능합니다.");
            form.email1.select();
            return;
        }
        if (form.email2.value === "") {
            alert("도메인을 입력해주세요.");
            form.email2.select();
            return;
        } else if (!regExpEmail2.test(form.email2.value)) {
            alert("도메인을 다시 확인해주세요.");
            form.email2.select();
            return;
        }
        if (form.phone.value === "") {
            alert("번호를 입력해주세요.");
            form.phone.select();
            return;
        } else if (!regExpPhone.test(form.phone.value)) {
            alert("번호를 다시 확인해주세요.");
            form.phone.select();
            return;
        }

        $('#id').attr('disabled', false);
        $('#password').attr('disabled', false);
        $('#name').attr('disabled', false);
        $('#birth').attr('disabled', false);
        $('#gender').attr('disabled', false);
        $('#email1').attr('disabled', false);
        $('#email2').attr('disabled', false);
        $('#phone').attr('disabled', false);

        $.ajax({
            url: '/user/updateInfo',
            type: 'POST',
            data: {
                'id': $('#id').val(),
                'password': $('#password').val(),
                'name': $('#name').val(),
                'birth': $('#birth').val(),
                'gender': $('#gender').val(),
                'email': $('#email1').val() + '@' + $('#email2').val(),
                'phone': $('#phone').val(),
            },
            success: function (result) {
                if (result === "success") {
                    alert("변경이 완료되었습니다.")
                    location.reload();
                } else {
                    alert("변경 실패")
                    $('#id').attr('disabled', true);
                    $('#name').attr('disabled', true);
                    $('#birth').attr('disabled', true);
                    $('#gender').attr('disabled', true);
                }
            },
            error: function () {
                alert("오류");
            }
        })
    })
</script>
</body>
</html>