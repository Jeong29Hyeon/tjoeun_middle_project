<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-02
  Time: 오전 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>예매</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<%--<div class="container-sm text-center mt-5">--%>
<%--    <div class="row row-cols-2 row-cols-sm-2 row-cols-md-4 row-cols-lg-4">--%>


<%--       --%>
<%--    </div>--%>
<%--</div>--%>

<div class="container text-center mt-3">
    <div class="row row-cols-2 row-cols-sm-2 row-cols-md-4 row-cols-lg-4">
        <c:choose>
            <c:when test="${not empty movies}">
                <div class="col">
                    <h3>Movie</h3>
                    <c:forEach var="movie" items="${movies}">
                        <div id="titleWrap" class="mb-2" style="text-align: left">
                            <a href="#" style="text-decoration-line: none; color: black;"
                               class="mt-3"
                               id="selectTitle${movie.seq}">${movie.title}</a>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p>상영중인 영화가 없습니다.</p>
            </c:otherwise>
        </c:choose>
        <div class="col">
            <h3>DAY</h3>
            <div id="dayWrap" hidden>
                <c:forEach var="day" items="${dayList}" varStatus="i">
                    <div class="container mb-4">
                        <a href="#" style="text-decoration-line: none;color:black" class="mt-3" id="selectDay${i.index}">${day}</a>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="col" id="hall">
            <h3>Hall & HallType</h3>
            <div id="hallWrap" class="container mb-2">
            </div>
        </div>
        <div class="col" id="time">
            <h3>Time</h3>
            <div id="timeWrap" class="container mb-2">
            </div>
        </div>
    </div>
</div>
<form action="<c:url value="/movieRoom"/>" method="post" id="movieSelectForm">
    <div class="container text-center mt-5">
        <input type="text" id="userIdInfo" name="userId"
               value="${empty sessionScope.user?'': sessionScope.user.id}" hidden>
        <input type="text" id="titleInfo" name="titleInfo" value="" hidden>
        <input type="text" id="dayInfo" name="noFormattingDayInfo" hidden>
        <!--/movieRoom 으로 보내는 실제 dayInfo -->
        <input type="text" id="formattingDayInfo" name="dayInfo" hidden>
        <input type="text" id="hallInfo" name="hallInfo" value="" hidden>
        <input type="text" id="timeInfo" name="timeInfo" value="" hidden>
        <input type="text" id="ageInfo" name="ageInfo" value="" hidden>
        <input type="text" id="movieSeq" name="movieSeq" value="" hidden>
    </div>
    <div class="container-sm mt-5">
        <%--        <c:forEach var="movie" items="${movies}">--%>
        <button class="container-sm btn-close-white" id="" type="button" onclick="click_btn()">
            좌석 확인 하러가기
        </button>
        <%--        </c:forEach>--%>
    </div>
</form>
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginHeader"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="loginHeader">로그인</h1>
            </div>
            <div class="modal-body">
                <form name="loginForm">
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


<%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
  function hallClick(selectedHall) {
    $('#hallInfo').val(selectedHall.text);
    $('#timeWrap').attr('hidden', false);
    $('#timeWrap').html("");
    $('#timeInfo').val("");
    selectedHall.style.color = 'blue';
    selectedHall.style.fontSize = '18px';
    var links = document.querySelectorAll('#hall a');
    links.forEach(function (link) {
      link.addEventListener('click', function () {
        links.forEach(function (link) {
          link.style.color = 'black';
          link.style.fontSize = '14px';
        });
        this.style.color = 'blue';
        this.style.fontSize = '18px';
      });
    });
    selectedHall.style.color = "blue";
    let selectedDay = $('#dayInfo').val().replace(/[^0-9]/g, "");
    let date = new Date();
    let dateFormat = date.getFullYear() + "" + ((date.getMonth() + 1) <= 9 ? "0" + (date.getMonth()
        + 1) : (date.getMonth() + 1)) + "" + ((selectedDay) <= 9 ? "0" + (selectedDay)
        : (selectedDay));
    $.ajax({
      type: 'post',
      url: 'https://www.megabox.co.kr/on/oh/ohc/Brch/schedulePage.do',
      data: {
        "masterType": "brch",
        "detailType": "area",
        "brchNo": "1351",
        "firstAt": "Y",
        "brchNo1": "1351",
        "playDe": dateFormat
      },
      success: function (result) {
        const str = JSON.stringify(result);
        const obj = JSON.parse(str);
        const movieList = obj.megaMap.movieFormList;
        console.log(movieList);
        $.each(movieList, function (key, value) {
          if (value.movieNm === $('#titleInfo').val()
              && $('#hallInfo').val() === value.theabExpoNm) {
            console.log(value.playStartTime + "~" + value.playEndTime);
            $('#timeWrap').append(
                '<a onclick="timeClick(this)" id="selectTime' + value.playStartTime
                + '" href="#" style="text-decoration-line: none; color: black" class="mt-3">'
                + value.playStartTime + "~" + value.playEndTime + '</a><br>');
          }
        });
      }
    });
  }

  function timeClick(selectedTime) {
    $('#timeInfo').val(selectedTime.text);
    selectedTime.style.color = 'blue';
    selectedTime.style.fontSize = '18px';
    var links = document.querySelectorAll('#timeWrap a');
    links.forEach(function (link) {
      link.addEventListener('click', function () {
        // 모든 링크의 색상을 초기화합니다.
        links.forEach(function (link) {
          link.style.color = 'black';
          link.style.fontSize = '14px';
        });
        // 선택된 링크의 색상을 변경합니다.
        this.style.color = 'blue';
        this.style.fontSize = '18px';
      });
    });
  }

  $(document).ready(function () {
    <c:forEach var="movie" items="${movies}">
    $('#selectTitle${movie.seq}').on('click', function () {
      $('#dayWrap').attr('hidden', false);
      $('#hallWrap').html("")
      $('#titleInfo').val("${movie.title}")
      $('#timeWrap').html('');
      $('#timeInfo').val("");
      $('#dayInfo').val("");
      $('#hallInfo').val("");
      this.style.color = 'blue';
      this.style.fontSize = '18px';
      var links = document.querySelectorAll('#titleWrap a');
      links.forEach(function (link) {
        link.addEventListener('click', function () {
          // 모든 링크의 색상을 초기화합니다.
          links.forEach(function (link) {
            link.style.color = 'black';
            link.style.fontSize = '14px';
          });
          // 선택된 링크의 색상을 변경합니다.
          this.style.color = 'blue';
          this.style.fontSize = '18px';
        });
      });
    });
    </c:forEach>


    <c:forEach var="day" items="${dayList}" varStatus="i">
    $('#selectDay${i.index}').on('click', function () {
      $('#dayInfo').val($('#selectDay${i.index}').text());
      $('#hallWrap').html("");
      $('#hallInfo').val("");
      $('#timeInfo').val("");
      $('#timeWrap').html("");
      this.style.color = 'blue';
      this.style.fontSize = '18px';
      var links = document.querySelectorAll('#dayWrap a');
      links.forEach(function (link) {
        link.addEventListener('click', function () {
          // 모든 링크의 색상을 초기화합니다.
          links.forEach(function (link) {
            link.style.color = 'black';
            link.style.fontSize = '14px';
          });
          // 선택된 링크의 색상을 변경합니다.
          this.style.color = 'blue';
          this.style.fontSize = '18px';
        });
      });
      let selectedDay = $('#selectDay${i.index}').text().replace(/[^0-9]/g, "");
      let date = new Date();
      let dateFormat = date.getFullYear() + "" + ((date.getMonth() + 1) <= 9 ? "0"
          + (date.getMonth() + 1) : (date.getMonth() + 1)) + "" + ((selectedDay) <= 9 ? "0"
          + (selectedDay) : (selectedDay));
      $.ajax({
        type: 'post',
        url: 'https://www.megabox.co.kr/on/oh/ohc/Brch/schedulePage.do',
        data: {
          "masterType": "brch",
          "detailType": "area",
          "brchNo": "1351",
          "firstAt": "Y",
          "brchNo1": "1351",
          "playDe": dateFormat
        },
        success: function (result) {
          var addedTheabExpoNm = [];
          const str = JSON.stringify(result);
          const obj = JSON.parse(str);
          const movieList = obj.megaMap.movieFormList;
          $.each(movieList, function (key, value) {
            if (value.movieNm === $('#titleInfo').val()) {
              console.log(value.playStartTime + "~" + value.playEndTime);
              if (addedTheabExpoNm.indexOf(value.theabExpoNm) === -1) {
                $('#hallWrap').append('<a onclick="hallClick(this)" id="hall' + value.theabNo
                    + '" href="#" style="text-decoration-line: none; color: black" class="mt-3">'
                    + value.theabExpoNm + '</a><br>');
                addedTheabExpoNm.push(value.theabExpoNm); // 추가된 theabExpoNm을 배열에 저장
              }
            }
          });
          if ($('#hallWrap').html().trim() === '') {
            $('#hallWrap').append("다른 날을 선택해주세요")
          }
        }
      });
    });
    </c:forEach>
  });

  function click_btn() {
    if ($('#titleInfo').val() === '') {
      alert('영화를 선택해주세요!');
      return;
    } else if ($('#dayInfo').val() === '') {
      alert('날짜를 선택해주세요!')
      return;
    } else if ($('#hallInfo').val() === '') {
      alert('상영관을 선택해주세요!')
      return;
    } else if ($('#timeInfo').val() === '') {
      alert('시간을 선택해주세요!')
      return;
    }
    if ($('#userIdInfo').val() === '') {
      $('#loginModal').modal('show');
    } else {
      let selectedDay = $('#dayInfo').val().replace(/[^0-9]/g, "");
      let date = new Date();
      let dateFormat = date.getFullYear() + "-" + ((date.getMonth() + 1) <= 9 ? "0"
          + (date.getMonth()
              + 1) : (date.getMonth() + 1)) + "-" + ((selectedDay) <= 9 ? "0" + (selectedDay)
          : (selectedDay));
      $('#formattingDayInfo').val(dateFormat);

      <c:forEach var="movie" items="${movies}">
      if ($('#titleInfo').val() === '${movie.title}') {
        $('#movieSeq').val('${movie.seq}')
      }
      </c:forEach>
      document.getElementById('movieSelectForm').submit();
    }
  }

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
    let saveId = $('#saveId').val();
    $.ajax({
      type: "post",
      url: "/user/loginModal",
      data: {
        'id': id,
        'password': password
      },
      success: function (result) {
        if (result === 'success') {
          let selectedDay = $('#dayInfo').val().replace(/[^0-9]/g, "");
          let date = new Date();
          let dateFormat = date.getFullYear() + "-" + ((date.getMonth() + 1) <= 9 ? "0"
              + (date.getMonth()
                  + 1) : (date.getMonth() + 1)) + "-" + ((selectedDay) <= 9 ? "0" + (selectedDay)
              : (selectedDay));
          $('#formattingDayInfo').val(dateFormat);
          $('#userIdInfo').val(id);
          <c:forEach var="movie" items="${movies}">
          if ($('#titleInfo').val() === '${movie.title}') {
            $('#movieSeq').val('${movie.seq}')
          }
          </c:forEach>
          document.getElementById('movieSelectForm').submit();
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
