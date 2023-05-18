<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 예약</title>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>

<body>
<%@ include file="../header.jsp" %>

<div class="container mt-5">
    <div class="row row-cols-auto row-cols-sm-auto row-cols-md-auto row-cols-lg-auto mb-3">
        <div class="col col-6 col-sm-6 col-md-6 col-lg-6 d-flex">
            <div class="col col-4 col-sm-4 col-md-4 col-lg-4">
                <img class="w-100" src="${movie.img}">
            </div>
            <div class="col col-8 col-sm-8 col-md-8 col-lg-8" style="margin-left: 20px">
                <input type="text" name="userId" id="userIdInfo" value="${userId}" hidden/>
                <p id="titleInfo" style="font-size: 1.5rem; font-weight: bold">${ticket.titleInfo}</p>
                <p id="ageRating" >${movie.ageRating}</p>
                <p id="hallInfo">${ticket.hallInfo}</p>
                <p id="dayInfo">${ticket.dayInfo}</p>
                <p id="timeInfo">${ticket.timeInfo}</p>
            </div>
        </div>

        <div class="col col-6 col-sm-6 col-md-6 col-lg-6 d-flex gap-3">
            <c:choose>
                <c:when test="${movie.ageRating == '청소년관람불가'}">
                    <div class="col col-6 col-sm-6 col-md-6 col-lg-6" id="onlyAdultNumber">
                        <h3>인원수</h3><br>
                        성인
                        <select class="form-select form-select-sm mb-3" name="numberOfAdult"
                                id="onlyAdult">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col col-6 col-sm-6 col-md-6 col-lg-6" id="selectNumber">
                        <h3>인원수</h3><br>
                        성인
                        <select class="form-select form-select-sm mb-3" name="numberOfAdult"
                                id="numberOfAdult">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                        청소년
                        <select class="form-select form-select-sm" name="numberOfTeen"
                                id="numberOfTeen">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="col col-6 col-sm-6 col-md-6 col-lg-6">
                <h3>선택한 좌석</h3><br>
                <input type="text" size="30" name="seats" id="seatsInput" value=""
                       class="form-control-plaintext mb-3 mt-3" placeholder="좌석을 선택해주세요" readonly/>
                <input type="text" size="15" name="price" id="priceInput" value=""
                       class="form-control-plaintext" style="margin-top: 35px" placeholder="금액"
                       readonly/>
            </div>
        </div>
    </div>
</div>
<h1 style="text-align: center; background-color: grey" class="mb-5 mt-3">스크린</h1>

<div class="container">
    <div class="row row-cols-auto row-cols-sm-auto">
        <%
            for (int i = 65; i < 75; i++) {
        %>
        <div class="col col-2 col-sm-2 md-2 mt-3">
            <button type="button" class="btn btn-outline-secondary btn-block" disabled>
                <%=(char) i%>열
            </button>
        </div>
        <c:forEach var="num" begin="1" end="10">
            <div class="col col-1 col-sm-1 md-1 mt-3 mx-auto" id="num">
                <button type="button" name="<%=(char)i%>${num}" id="<%=(char)i%>${num}"
                        class="btn btn-outline-secondary btn-block">${num}</button>
            </div>
        </c:forEach>
        <%
            }
        %>
    </div>
</div>
<div class="container form-check-reverse mt-3">
    <button type="button" id="btnTicketing" class="btn btn-primary">선택완료</button>
    <a href="<c:url value="javascript:history.back();"/>">
        <button type="button" class="btn btn-primary">뒤로가기</button>
    </a>
</div>
<!-- 세션 지나고 예약하려고 할때 모달띄우기 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginHeader"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="loginHeader">로그인</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form name="loginForm" class="row g-3" action="<c:url value='/user/login'/>"
                      method="post">
                    <div class="row mt-md-3">
                        <div class="col-md-12">
                            <label for="id" class="form-label">아이디</label>
                            <input type="text" id="id" name="id" class="form-control"
                                   value="${cookie.id.value}" placeholder="아이디입력">
                        </div>
                    </div>
                    <div class="row mt-md-3">
                        <div class="col-md-12">
                            <label for="password" class="form-label">비밀번호</label>
                            <input class="form-control" type="password" id="password"
                                   name="password" placeholder="비밀번호입력">
                        </div>
                    </div>
                    <div class="row mt-md-3">
                        <div class="col offset-6">
                            <a href="<c:url value="#"/>"
                               style="text-decoration: none; font-size: 12px">아이디 혹은 비밀번호를
                                잊으셨나요?</a>
                        </div>
                    </div>
                    <div class="row mt-md-4 text-center">
                        <div class="col">
                            <input type="hidden" name="toUrl" value="${param.toUrl}"/>
                            <input type="button" class="btn btn-primary" value="로그인하기"
                                   onclick="checkLogin()">
                        </div>
                        <div class="col">
                            <button type="button" class="btn btn-primary">
                                <a href="<c:url value="/user/join"/>"
                                   style="color:white; text-decoration: none">회원가입</a>
                            </button>
                        </div>
                    </div>
                    <div class="row text-center mt-md-4">
                        <div class="col">
                            <a href="<c:url value="/user/kakaoLogin"/>">
                                <img src="<c:url value="/resources/img/kakao_login_medium_wide.png"/>"
                                     alt="로그인">
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 예약 후 티켓 관련 모달띄우기 -->
<div class="modal fade" id="successTicketModal" aria-labelledby="successTicketHeader"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="successTicketHeader">예약 완료</h1>
            </div>
            <div class="modal-body">
                <form name="successTicketForm" action="<c:url value="/"/>">
                    <div class="container mt-1">
                        예매가 완료 되었습니다.<br><br>
                        <h5>예약 정보</h5><br>
                        <div class="row">
                            <div class="col-4">
                                예매자 성함:
                            </div>
                            <div class="col-8">
                                ${sessionScope.user.name}<br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                영화 제목:
                            </div>
                            <div class="col-8">
                                ${ticket.titleInfo}<br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                영화 관:<br>

                            </div>
                            <div class="col-8">
                                ${ticket.hallInfo}<br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                영화 날짜&시간:
                            </div>
                            <div class="col-8">
                                ${ticket.dayInfo}&${ticket.timeInfo}<br>
                            </div>
                        </div>
                        <div class="row center-block mt-3">
                            <input type="submit" value="홈으로">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="../footer.jsp" %>
<script>
  // 관람등급 색 변경
  let ageRatingTag = $('#ageRating');
  let ageRating = ageRatingTag.text();

  if (ageRating === '15세이상관람가') {
    ageRatingTag.css('color', 'blue');
  } else if (ageRating === '청소년관람불가') {
    ageRatingTag.css('color', 'red');
  } else if (ageRating === '12세이상관람가') {
    ageRatingTag.css('color', 'orange');
  } else if (ageRating === '전체관람가') {
    ageRatingTag.css('color', 'green');
  }

  let seatsList = [];
  $(document).ready(function () {
    <!-- 선택된 좌석 disabled 처리 -->
    <c:forEach var="seatNum" items="${choiceSeats}">
    $('#${seatNum}').attr('disabled', true);
    $('#${seatNum}').removeClass('btn-outline-secondary');
    $('#${seatNum}').addClass('btn-secondary');
    </c:forEach>

    <!-- 각 좌석 버튼에 대한 이벤트 생성 -->
    <%
               for (int i = 65; i < 75; i++) {
           %>
    <c:forEach var="num" begin="1" end="10">
    $("#<%=(char)i%>${num}").on('click', function () {

      let duplicateCheck = seatsList.indexOf('<%=(char)i%>' + $("#<%=(char)i%>${num}").text());
      if (duplicateCheck !== -1) {
        seatsList.splice(duplicateCheck, 1);
      } else {
        if (Number($('#numberOfAdult').val()) + Number($('#numberOfTeen').val()) < seatsList.length
            + 1) {
          alert('인원수를 확인해주세요');
          return;
        }
        seatsList.push('<%=(char)i%>' + $("#<%=(char)i%>${num}").text());
      }
      seatsList.sort();

      if ($("#<%=(char)i%>${num}").hasClass('btn-primary')) {
        $("#<%=(char)i%>${num}").addClass('btn-outline-secondary');
        $("#<%=(char)i%>${num}").removeClass('btn-primary');
      } else {
        $("#<%=(char)i%>${num}").removeClass('btn-outline-secondary');
        $("#<%=(char)i%>${num}").addClass('btn-primary');
      }
      $('#seatsInput').attr('value', seatsList);
      console.log(seatsList);
    });
    </c:forEach>
    <%
                }
            %>

    <!-- 인원수에 대한 가격 표시 -->
    $("#onlyAdult").on('change', function () {
      <%--alert('${sessionScope.user.rank}')--%>
      let onlyAdultPrice = Number($('#onlyAdult').val()) * 14000;
      if (${not empty sessionScope.accessToken}) {
        $('#priceInput').val(onlyAdultPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
        return;
      }
      let sessionRank = ('${sessionScope.user.rank}'.toUpperCase());
      if (sessionRank === 'BRONZE') {
        $('#priceInput').val(onlyAdultPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'SILVER') {
        var silverA = (onlyAdultPrice * 0.95);
        $('#priceInput').val(silverA.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'GOLD') {
        var goldA = (onlyAdultPrice * 0.9);
        $('#priceInput').val(goldA.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'VIP') {
        var vipA = (onlyAdultPrice * 0.85);
        $('#priceInput').val(vipA.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'VVIP') {
        var vvipA = (onlyAdultPrice * 0.8);
        $('#priceInput').val(vvipA.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      }
    });

    $("#numberOfAdult").on('change', function () {
      var priceOfAdult = Number($('#numberOfAdult').val()) * 14000;
      var priceOfTeen = Number($('#numberOfTeen').val()) * 12000;
      if (${not empty sessionScope.accessToken}) {
        $('#priceInput').val((priceOfAdult + priceOfTeen).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
        return;
      }
      var sessionRank = ('${sessionScope.user.rank}'.toUpperCase());
      if (sessionRank === 'bronze'.toUpperCase()) {
        $('#priceInput').val((priceOfAdult + priceOfTeen).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'silver'.toUpperCase()) {
        var silverA = (priceOfAdult * 0.95);
        var silverT = (priceOfTeen * 0.95);
        $('#priceInput').val((silverA + silverT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'gold'.toUpperCase()) {
        var goldA = (priceOfAdult * 0.9);
        var goldT = (priceOfTeen * 0.9);
        $('#priceInput').val((goldA + goldT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'vip'.toUpperCase()) {
        var vipA = (priceOfAdult * 0.85);
        var vipT = (priceOfTeen * 0.85);
        $('#priceInput').val((vipA + vipT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'vvip'.toUpperCase()) {
        var vvipA = (priceOfAdult * 0.8);
        var vvipT = (priceOfTeen * 0.8);
        $('#priceInput').val((vvipA + vvipT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      }
    });

    $("#numberOfTeen").on('change', function () {
      var priceOfAdult = Number($('#numberOfAdult').val()) * 14000;
      var priceOfTeen = Number($('#numberOfTeen').val()) * 12000;
      if (${not empty sessionScope.accessToken}) {
        $('#priceInput').val((priceOfAdult + priceOfTeen).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
        return;
      }
      var sessionRank = ('${sessionScope.user.rank}'.toUpperCase());
      if (sessionRank === 'bronze'.toUpperCase()) {
        $('#priceInput').val((priceOfAdult + priceOfTeen).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'silver'.toUpperCase()) {
        var silverA = (priceOfAdult * 0.95);
        var silverT = (priceOfTeen * 0.95);
        $('#priceInput').val((silverA + silverT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'gold'.toUpperCase()) {
        var goldA = (priceOfAdult * 0.9);
        var goldT = (priceOfTeen * 0.9);
        $('#priceInput').val((goldA + goldT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'vip'.toUpperCase()) {
        var vipA = (priceOfAdult * 0.85);
        var vipT = (priceOfTeen * 0.85);
        $('#priceInput').val((vipA + vipT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      } else if (sessionRank === 'vvip'.toUpperCase()) {
        var vvipA = (priceOfAdult * 0.8);
        var vvipT = (priceOfTeen * 0.8);
        $('#priceInput').val((vvipA + vvipT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
      }
    });

    <!-- 좌석선택 버튼 비동기 통신 -->
    $('#btnTicketing').on('click', function () {
      if ((Number($('#numberOfAdult').val()) + Number($('#numberOfTeen').val())) === 0
          || seatsList.length === 0 || (Number($('#numberOfAdult').val()) + Number(
              $('#numberOfTeen').val())) !== seatsList.length) {
        alert('인원수와 선택한 좌석을 다시 확인해주세요');
        return;
      }
      var IMP = window.IMP;
      IMP.init('imp11028147');
      IMP.request_pay({
        pg: 'kakaopay',
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: '더조은 시네마 - 영화예매',
        amount: $('#priceInput').val().replace(/[^0-9]/g, ""),
        m_redirect_url:'http://43.200.171.39/mobile-ticketing?id='+$('#userIdInfo').val()+'&titleInfo='+$('#titleInfo').text()+"&dayInfo="+$('#dayInfo').text()+
            '&hallInfo='+$('#hallInfo').text()+'&timeInfo='+$('#timeInfo').text()+'&numberOfAdult='+$('#numberOfAdult').val()+'&numberOfTeen='+$('#numberOfTeen').val()+
            '&seats='+$('#seatsInput').val() + ",&price="+$('#priceInput').val().replace(/[^0-9]/g, "")
      }, function (rsp) {
        console.log(rsp);
        if (rsp.success) {
          $.ajax({
            url: '/ticketing',
            type: 'post',
            data: {
              'id': $('#userIdInfo').val(),
              'titleInfo': $('#titleInfo').text(),
              'dayInfo': $('#dayInfo').text(),
              'hallInfo': $('#hallInfo').text(),
              'timeInfo': $('#timeInfo').text(),
              'numberOfAdult': $('#numberOfAdult').val(),
              'numberOfTeen': $('#numberOfTeen').val(),
              'seats': $('#seatsInput').val() + ",",
              'price': $('#priceInput').val().replace(/[^0-9]/g, ""),
              'imp_uid': rsp.imp_uid,
              'paid_amount': rsp.paid_amount
            },
            dataType: 'JSON',
            success: function (result) {
              console.log(result);
              if (result.msg === 'SEATS_DUPLICATE_ERR') {
                alert('이미 선택된 좌석입니다. 좌석을 다시 선택해주세요.');
                location.reload();
              } else if (result.msg === 'success') {
                $('#successTicketModal').modal('show');
              }
            },
            error: function () {
              alert('티켓팅 비동기통신 에러');
            }
          });
          // msg += '고유ID : ' + rsp.imp_uid;
          // msg += '상점 거래ID : ' + rsp.merchant_uid;
          // msg += '결제 금액 : ' + rsp.paid_amount;
        } else {
          alert(rsp.error_msg);
          location.reload();
        }
      });
    });
  });

  <!-- 로그인 ID/PW 널 체크 -->
  var form = document.loginForm;

  function checkLogin() {
    if (form.id.value === "") {
      alert("아이디를 입력해주세요.");
      form.id.select();
      return;
    } else if (form.password.value === "") {
      alert("비밀번호를 입력해주세요.")
      form.password.select();
      return;
    }
    let id = $('#id').val();
    let password = $('#password').val();
    $.ajax({
      type: "post",
      url: "/user/loginModal",
      data: {
        'id': id,
        'password': password
      },
      success: function (result) {
        if (result === 'success') {
          alert("로그인 완료!좌석을 다시 선택해주세요!")
          location.reload();
        } else {
          alert('아이디 혹은 비밀번호가 일치하지 않습니다.');
        }
      },
      error: function () {
        alert('비동기 통신 실패');
      }
    });
  }
</script>
</body>
</html>
