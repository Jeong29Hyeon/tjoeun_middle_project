<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <h5>현재까지 사용 금액: <fmt:formatNumber value="${sumPrice}" pattern="#,###원"/></h5><br>
                    <h5>${rank}</h5><br>
                    <h3>${sessionScope.user.name}님 반가워요!</h3><br>
                    <div class="next_rank" style="text-align: center">
                        <c:choose>
                            <c:when test="${nextRank > 0}">
                                <p>NEXT RANK 까지 <span style="font-size: 20px; color: red;"><fmt:formatNumber value="${nextRank}" pattern="#,###원"/></span>남았어요!</p>

                            </c:when>
                            <c:otherwise>
                                <p><span style="font-size: 20px; color: red;">최고 등급 입니다!! </span></p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <br>
                    <div class="progress" style="height: 30px">
                        <div class="progress-bar progress-bar-striped bg-info" role="progressbar"
                             style="width: ${gage}; height: 30px"
                             aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                            <h5 style="text-align: right; margin-right: 10px; margin-top: 7px; color: black">${rank}</h5>
                        </div>
                    </div>
                    <br>
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
                                <div class="col-6"><a class="btn btn-info" role="button" href="/user/couponRoom">쿠폰함</a></div>
                                <div class="col-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-4">
            <img style="height: 300px; width: 200px" src="/resources/img/poster.jpg"/>
        </div>
    </div>
</div>
<ul class="nav nav-tabs justify-content-center mt-4 nav-fill" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
        <c:if test="${empty sessionScope.accessToken}">
            <button class="nav-link" id="myInfo-tab" data-bs-toggle="tab" data-bs-target="#myInfo" type="button"
                    role="tab" aria-controls="myInfo" aria-selected="false">회원 정보
            </button>
        </c:if>
        <c:if test="${not empty sessionScope.accessToken}">
            <button class="nav-link" id="myInfo-tab" data-bs-toggle="tab" data-bs-target="#myInfo" type="button"
                    role="tab" aria-controls="myInfo" aria-selected="false" disabled>회원 정보
            </button>
        </c:if>

    </li>
    <li class="nav-item active" role="presentation">
        <c:if test="${not empty sessionScope.accessToken}">
        <button class="nav-link" id="changeInfo-tab" data-bs-toggle="tab" data-bs-target="#changeInfo"
                type="button" role="tab" aria-controls="changeInfo" aria-selected="false" disabled>회원정보 변경
        </button>
        </c:if>
        <c:if test="${empty sessionScope.accessToken}">
            <button class="nav-link" id="changeInfo-tab" data-bs-toggle="tab" data-bs-target="#changeInfo"
                    type="button" role="tab" aria-controls="changeInfo" aria-selected="false">회원정보 변경
            </button>
        </c:if>
    </li>

    <li class="nav-item" role="presentation">
        <button class="nav-link" id="payHistory-tab" data-bs-toggle="tab" data-bs-target="#payHistory" type="button"
                role="tab" aria-controls="payHistory" aria-selected="false">결제내역
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
<div class="container tab-content justify-content-center" id="myTapPayHistory">
    <div class="container tab-pane fade text-left" id="payHistory" role="tabpanel" aria-labelledby="payHistory-tab">
        <div class="container mt-3">
            <div class="row">
                <h4>티켓 히스토리 내역</h4>
                <hr>
                <div class="mt-1 d-flex">
                    <p class="col-3 text-center">영화제목
                    <p class="col-3 text-center">가격
                    <p class="col-3 text-center">관람일자
                    <p class="col-3 text-center">관람인원수
                </div>
                <hr>
                <c:forEach var="ticket" items="${ticketHistory}">
                    <div class="col-3 text-left">${ticket.titleInfo}</div>
                    <div class="col-3 text-center"><fmt:formatNumber value="${ticket.price}" pattern="#,###원"/></div>
                    <div class="col-3 text-center">${ticket.dayInfo}</div>
                    <div class="col-3 text-center">성인${ticket.numberOfAdult}/청소년${ticket.numberOfTeen}</div>
                </c:forEach>
            </div>

            <div class="row mt-3">
                <h4>매점 히스토리 내역</h4>
                <hr>
                <div class="mt-1 d-flex">
                <p class="col-3 text-center">상품명
                <p class="col-3 text-center">가격
                <p class="col-3 text-center">구매일
                <p class="col-3 text-center">유효기간
                </div>
                <hr>
                <c:if test="${not empty couponList}">
                <c:forEach var="coupon" items="${couponList}" varStatus="i">
                    <div class="col-3 text-center">${coupon.goods.name}</div>
                    <div class="col-3 text-center"><fmt:formatNumber value="${coupon.goods.price}" pattern="#,###원"/></div>
                    <div class="col-3 text-center"><fmt:formatDate value="${coupon.purchaseDate}" pattern="yyyy-MM-dd"/></div>
                    <div class="col-3 text-center"><fmt:formatDate value="${coupon.expireDate}" pattern="yyyy-MM-dd"/></div>
<%--                    <c:set var="preIndex" value="${i.index-1}"/>--%>
                    <c:if test="${coupon.imp_uid != couponList[i.index+1].imp_uid}">
                        <div class="row">
                            <div class="col-3 offset-9 text-center ms-2">
                                <button id="btnCancel${coupon.imp_uid}" class="btn btn-outline-secondary">결제 취소</button>
                            </div>
                            <hr>
                        </div>
                    </c:if>
                </c:forEach>
                </c:if>
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
        var regExpEmail2 = /^[0-9a-zA-Z]([-_]?[0-9a-zA-Z])*\.[a-zA-Z]([.]?[a-zA-Z]){2,3}$/;
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
                } else if(result ==="LOGIN_ERR"){
                    alert("세션이 만료되어 로그인 페이지로 이동합니다.");
                    location.href="/";
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
    $('#myInfo-tab').on('click', function () {
        $('#infoForm').attr('hidden', true);
    })
    $('#payHistory-tab').on('click', function () {
        $('#infoForm').attr('hidden', true);
    })
<c:if test="${not empty couponList}">
    <c:forEach var="coupon" items="${couponList}" varStatus="i">
    <c:if test="${coupon.imp_uid != couponList[i.index+1].imp_uid}">
    $('#btnCancel${coupon.imp_uid}').on('click',function (){
        let choice = confirm("정말 결제취소 하시겠습니까?");
        if(!choice){
          return;
        }
        $.ajax({
           url: "/user/deleteCoupon",
           type: "post",
           data: {
              "imp_uid":'${coupon.imp_uid}'
           } ,
            success:function (result){
               if(result==='success'){
                   alert("쿠폰이 정상적으로 결제 취소 되었습니다");
                   location.reload();
               }else {
                   alert("다시 시도해주세요");
               }
            },
            error:function (){
               alert("비동기 통신에러")
            }
        });
    });
    </c:if>
    </c:forEach>
    </c:if>
</script>
</body>
</html>
