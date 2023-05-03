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
<div class="container mt-5 form-check-reverse">
    인원수>>
    성인
    <select>
        <option>1</option>
        <option>2</option>
        <option>3</option>
    </select>
    아동
    <select>
        <option>1</option>
        <option>2</option>
        <option>3</option>
    </select>
</div>
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
                            <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                               id="selectTitle${movie.seq}">${movie.title}</a>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:when test="${empty movies}">
                <div class="col">
                    <div class="container mb-2" style="text-align: left">
                        <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                           id="selectTitle${NotNullMovies.seq}">${NotNullMovies.title}</a>
                    </div>
                </div>
            </c:when>
        </c:choose>
        <div class="col">
            <div id="dayWrap" hidden>
                <c:forEach var="day" items="${dayList}">
                    <div class="container mb-4">
                    <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                       id="selectDay${day}" onclick="dayClick(this)">${day}</a>
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
<c:set var="selectMovie" value="${ not empty movie ? '영화' : movie.title}"/>
<form action="/movieRoom" method="post">
    <div class="container text-center mt-5">
        <div class="row">
            <div class="col">
                <div class="col">
                    <input type="text" id="titleInfo" name="titleInfo" value="${selectMovie}">
                </div>
            </div>
            <div class="col">
                <div class="col">
                    <input type="text" id="dayInfo" name="dayInfo" value="날짜">
                </div>
            </div>
            <div class="col">
                <input type="text" id="hallInfo" name="hallInfo" value="관">
            </div>

            <div class="col">
                <div class="col">
                    <input type="text" id="timeInfo" name="timeInfo" value="시간">
                </div>
            </div>
        </div>
    </div>
    <div class="container mt-5">
        <button class="container btn-close-white" type="submit">좌석 확인 하러가기</button>
    </div>
</form>
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
        $('#timeWrap').attr('hidden',false);
        $('#timeWrap').html("");
        $('#timeInfo').val("");
        var links = document.querySelectorAll('#hall a');
        links.forEach(function(link) {
            link.addEventListener('click', function() {
                links.forEach(function(link) {
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
        let dateFormat = date.getFullYear() + "" + ((date.getMonth() + 1) <= 9 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1)) + "" + ((selectedDay) <= 9 ? "0" + (selectedDay) : (selectedDay));
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
                    if (value.movieNm.substring(0, 2).trim() === $('#titleInfo').val().substring(0, 2).trim() && $('#hallInfo').val().trim() === value.theabExpoNm.trim()) {
                        console.log(value.playStartTime + "~" + value.playEndTime);
                        $('#timeWrap').append('<a onclick="timeClick(this)" id="selectTime'+value.playStartTime+'" href="#" style="text-decoration-line: none; color: black" class="mt-3">' + value.playStartTime +"~"+ value.playEndTime + '</a><br>');
                    }
                });
                if ($('#timeWrap').html().trim() === '') {
                }
            }
        });
    }

    function dayClick(selectedDay){
        $('#dayInfo').val(selectedDay.text);
        $('#hall').html("");
        $('#hallInfo').val("");
        $('#timeInfo').val("");
        $('#timeWrap').html("");
        var links = document.querySelectorAll('#dayWrap a');
        links.forEach(function(link) {
            link.addEventListener('click', function() {
                // 모든 링크의 색상을 초기화합니다.
                links.forEach(function(link) {
                    link.style.color = 'black';
                    link.style.fontSize = '14px';
                });
                // 선택된 링크의 색상을 변경합니다.
                this.style.color = 'blue';
                this.style.fontSize = '18px';
            });
        });
    }

    function timeClick(selectedTime){
        $('#timeInfo').val(selectedTime.text);
        var links = document.querySelectorAll('#timeWrap a');
        links.forEach(function(link) {
            link.addEventListener('click', function() {
                // 모든 링크의 색상을 초기화합니다.
                links.forEach(function(link) {
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
        });
        </c:forEach>
        var links = document.querySelectorAll('#titleWrap a');
        links.forEach(function(link) {
            link.addEventListener('click', function() {
                // 모든 링크의 색상을 초기화합니다.
                links.forEach(function(link) {
                    link.style.color = 'black';
                    link.style.fontSize = '14px';
                });
                // 선택된 링크의 색상을 변경합니다.
                this.style.color = 'blue';
                this.style.fontSize = '18px';
            });
        });


        <c:forEach var="day" items="${dayList}">
        $('#selectDay${day}').on('click', function () {
            $('#hall').html("");
            let selectedDay = $('#selectDay${day}').text().replace(/[^0-9]/g, "");
            let date = new Date();
            let dateFormat = date.getFullYear() + "" + ((date.getMonth() + 1) <= 9 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1)) + "" + ((selectedDay) <= 9 ? "0" + (selectedDay) : (selectedDay));
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
                        if (value.movieNm.substring(0, 2).trim() === $('#titleInfo').val().substring(0,2).trim()) {
                            console.log(value.playStartTime +"~"+ value.playEndTime);
                            if (addedTheabExpoNm.indexOf(value.theabExpoNm) === -1) {
                                $('#hall').append('<a onclick="hallClick(this)" id="hall' + value.theabNo + '" href="#" style="text-decoration-line: none; color: black" class="mt-3">' + value.theabExpoNm + '</a><br>');
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
</script>
</body>
</html>
