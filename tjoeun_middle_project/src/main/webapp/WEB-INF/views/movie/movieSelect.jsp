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
            <h3>Hall & HallType</h3>
        </div>
        <div class="col">
            <div class="col">
                <h3>MAY</h3>
            </div>
        </div>
        <div class="col">
            <div class="col">
                <h3>Time</h3>
            </div>
        </div>
    </div>
</div>

<div class="container text-center mt-5">
    <div class="row">
        <c:choose>
            <c:when test="${not empty movies}">
                <div class="col">
                    <c:forEach var="movie" items="${movies}">
                        <div class="container" style="text-align: left">
                            <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                               id="movieTag">${movie.title}</a>
<%--                                ${movie.seq}--%>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:when test="${empty movies}">
                <div class="col">
                    <div class="container" style="text-align: left">
                        <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                           id="movieTag${NotNullMovies.seq}">${NotNullMovies.title}</a>
                    </div>
                </div>
            </c:when>
        </c:choose>
        <div class="col">
            <c:forEach var="hall" items="${hallList}">
                <div class="container" style="text-align: left">
                    <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                       id="hallTag${hall.hall_num}">${hall.hall_num}관/ TYPE) ${hall.hall_name}</a>
                </div>
            </c:forEach>
        </div>
        <div class="col">
            <c:forEach var="day" items="${dayList}">
                <a href="#" style="text-decoration-line: none; color: black" class="mt-3"
                   id="dayTag${day}">${day}</a><br>
            </c:forEach>
        </div>
        <div class="col">
            <a href="#" style="text-decoration-line: none; color: black" class="mt-3">10시</a>잔여석<br>
            <a href="#" style="text-decoration-line: none; color: black" class="mt-3">12시</a>잔여석
        </div>
    </div>
</div>
<c:set var="selectMovie" value="${ empty NotNullMovies ? '영화' : NotNullMovies.title}"/>
<form action="/movieRoom" method="post">
    <div class="container text-center mt-5">
        <div class="row">
            <div class="col">
                <div class="col">
                    <input type="text" id="movieInfo" name="movieInfo" value="${selectMovie}">
                </div>
            </div>
            <div class="col">
                <input type="text" id="hallInfo" name="hallInfo" value="관">
            </div>
            <div class="col">
                <div class="col">
                    <input type="text" id="dayInfo" name="dayInfo" value="날짜">
                </div>
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
<%--<script>--%>
<%--    // $(document).ready(function () {--%>
<%--    <c:forEach var="movie" items="${movies}">--%>
<%--    $("#movieTag${movie.seq}").click(function () {--%>
<%--        $("#movieInfo").val("${movie.title}");--%>
<%--    })--%>
<%--    </c:forEach>--%>

<%--    <c:forEach var="hall" items="${hallList}">--%>
<%--    $("#hallTag${hall.hall_num}").click(function () {--%>
<%--        $("#hallInfo").val("${hall.hall_num}관");--%>
<%--    })--%>
<%--    </c:forEach>--%>

<%--    <c:forEach var="day" items="${dayList}">--%>
<%--    $("#dayTag${day}").click(function () {--%>
<%--        $("#dayInfo").val("${day}");--%>
<%--    })--%>
<%--    </c:forEach>--%>

<%--    // });--%>
<%--</script>--%>
<script>
    $(document).ready(function (){
<%--        <c:forEach var="movie" items="movies">--%>
        $('#movieTag').on('click',function (){
            $.ajax({
                type:'post',
                url:'https://www.megabox.co.kr/on/oh/ohc/Brch/schedulePage.do',
                data:{
                    "masterType": "brch",
                    "detailType": "area",
                    "brchNo": "1372",
                    "firstAt": "Y",
                    "brchNo1": "1372",
                    "playDe": "20230503"
                },
                success:function (result){
                    const str = JSON.stringify(result);
                    const obj = JSON.parse(str);
                    console.log(obj);
                    const movieList = obj.megaMap.movieFormList;
                    console.log(movieList);
                    $.each(movieList,function (key,value){
                        if(value.movieNm.trim() ==="클로즈".trim()){
                            console.log("나오삼");
                            console.log(value.playStartTime);
                            console.log(value.playEndTime);
                            console.log(value.theabExpoNm);
                        }
                    })
                }
            });
        });
<%--        </c:forEach>--%>
    });
</script>
</body>
</html>
