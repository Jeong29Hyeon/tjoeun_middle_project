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
<div class="container mt-5">
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
            <c:forEach var="movie" items="${posters}">
                <div class="container" style="text-align: left">
                    <a href="#" style="text-decoration-line: none; color: black" class="mt-3">${movie.title}</a>
                </div>
<%--                <input type="hidden" id="title${poster.rank}" value="${poster.title}">--%>

            </c:forEach>
        </div>
        <div class="col">
            <c:forEach var="hall" items="${hallMapper}">
                <div class="container" style="text-align: left">
                    <a href="#" style="text-decoration-line: none; color: black" class="mt-3">${hall.hall_num}관/
                        TYPE) ${hall.hall_name}</a>
                </div>
            </c:forEach>
        </div>
        <div class="col">
            <%--            <c:forEach var="cinema" items="${cinemaList}">--%>
            <a href="#" style="text-decoration-line: none; color: black" class="mt-3">10시</a>100석<br>
            <a href="#" style="text-decoration-line: none; color: black" class="mt-3">12시</a>100석
            <%--            </c:forEach>--%>
        </div>
    </div>
</div>
<div class="container text-center mt-5">
    <div class="row">
        <div class="col"></div>
        <div class="col">
            <input type="text" id="info" value="들어갈고임">
        </div>
        <div class="col"></div>
    </div>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
    $(document).ready(function () {
        <c:forEach var="poster" items="posters">
        $("#titleTag").click(function () {
            <%--var value = $("#title${poster.rank}").val();--%>
            $("#info").val("qwe");
        })
        </c:forEach>
    });
</script>
</body>
</html>
