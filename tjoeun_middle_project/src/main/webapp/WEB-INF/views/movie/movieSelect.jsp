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

<div class="container text-center mt-5">
    <div class="row">
        <div class="col">
            <div class="col">
                <h3>Movie</h3>
            </div>
        </div>
        <div class="col">
            <div class="col">
                <h3>DAY</h3>
            </div>
        </div>
        <div class="col">
            <h3>Hall & HallType</h3>
        </div>
        <div class="col">
            <div class="col">
                <h3>Time</h3>
            </div>
        </div>
    </div>
</div>

<div class="container text-center mt-3">
    <div class="row">
        <c:choose>
            <c:when test="${not empty movies}">
                <div class="col">
                    <c:forEach var="movie" items="${movies}">
                        <div id="titleWrap" class="container mb-2" style="text-align: left">
                            <a href="#" style="text-decoration-line: none; color: black"
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
            <div id="dayWrap" hidden>
                <c:forEach var="day" items="${dayList}">
                    <div class="container mb-4">
                        <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                           id="selectDay${day}">${day}</a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div id="hall" class="col">

        </div>
        <div id="time" class="col">
            <div id="timeWrap" class="container mb-2">

            </div>
        </div>
    </div>
</div>
<form action="<c:url value="/movieRoom"/>" method="post" id="movieSelectForm">
    <div class="container text-center mt-5">
        <div class="row">
            <div class="col">
                <input type="text" id="titleInfo" name="titleInfo" value="" hidden>
            </div>
            <div class="col">
                <input type="text" id="dayInfo" name="dayInfo" hidden>
            </div>
            <div class="col">
                <input type="text" id="hallInfo" name="hallInfo" value="" hidden>
            </div>
            <div class="col">
                <input type="text" id="timeInfo" name="timeInfo" value="" hidden>
            </div>
        </div>
    </div>
    <div class="container mt-5">
        <button class="container btn-close-white" type="button" onclick="click_btn()">
            좌석 확인 하러가기
        </button>
    </div>
</form>
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
                </form>
            </div>
        </div>
    </div>
</div>

<br>
서버로 인원수 영화제목 관 시간 넘겨서 좌석보여주기<br>
정현 요구사항 - > 인풋텍스트 히든 처리하고 자바스크립트로 선택한거 강조되게 처리하고 <br>
시간 디비처리 해서 샤샤샥<br>
날짜 처음에 1일(요일) 로 하였으나 ( 특수문자를 받아드리지 못하여 _로 수정함 할거면 디티오 만들어서 불러내는 방식? 을써야할듯<br>

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
        "brchNo": "1372",
        "firstAt": "Y",
        "brchNo1": "1372",
        "playDe": dateFormat
      },
      success: function (result) {
        const str = JSON.stringify(result);
        const obj = JSON.parse(str);
        const movieList = obj.megaMap.movieFormList;
        $.each(movieList, function (key, value) {
          if (value.movieNm.substring(0, 2).trim() === $('#titleInfo').val().substring(0, 2).trim()
              && $('#hallInfo').val().trim() === value.theabExpoNm.trim()) {
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
      $('#hall').html("")
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


    <c:forEach var="day" items="${dayList}">
    $('#selectDay${day}').on('click', function () {
      $('#dayInfo').val($('#selectDay${day}').text());
      $('#hall').html("");
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
      let selectedDay = $('#selectDay${day}').text().replace(/[^0-9]/g, "");
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
          "brchNo": "1372",
          "firstAt": "Y",
          "brchNo1": "1372",
          "playDe": dateFormat
        },
        success: function (result) {
          var addedTheabExpoNm = [];
          const str = JSON.stringify(result);
          const obj = JSON.parse(str);
          const movieList = obj.megaMap.movieFormList;
          $.each(movieList, function (key, value) {
            if (value.movieNm.substring(0, 2).trim() === $('#titleInfo').val().substring(0,
                2).trim()) {
              console.log(value.playStartTime + "~" + value.playEndTime);
              if (addedTheabExpoNm.indexOf(value.theabExpoNm) === -1) {
                $('#hall').append('<a onclick="hallClick(this)" id="hall' + value.theabNo
                    + '" href="#" style="text-decoration-line: none; color: black" class="mt-3">'
                    + value.theabExpoNm + '</a><br>');
                addedTheabExpoNm.push(value.theabExpoNm); // 추가된 theabExpoNm을 배열에 저장
              }
            }
          });
          if ($('#hall').html().trim() === '') {
            $('#hall').append("다른 날을 선택해주세요")
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
      alert('상영관를 선택해주세요!')
      return;
    } else if ($('#timeInfo').val() === '') {
      alert('시간을 선택해주세요!')
      return;
    }
    if (${empty sessionScope.user}) {
      $('#loginModal').modal('show');
    } else {
      let selectedDay = $('#dayInfo').val().replace(/[^0-9]/g, "");
      let date = new Date();
      let dateFormat = date.getFullYear() + "-" + ((date.getMonth() + 1) <= 9 ? "0"
          + (date.getMonth()
              + 1) : (date.getMonth() + 1)) + "-" + ((selectedDay) <= 9 ? "0" + (selectedDay)
          : (selectedDay));
      $('#dayInfo').val(dateFormat);
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
          $('#dayInfo').val(dateFormat);
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
