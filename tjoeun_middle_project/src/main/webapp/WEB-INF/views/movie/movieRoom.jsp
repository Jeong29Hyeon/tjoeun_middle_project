<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-01
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 예약</title>
</head>

<body>
<%@ include file="../header.jsp" %>
<div class="container mt-5">
    <div class="row mb-3">
        <div class="col-4">
            <h3>선택하신 영화 정보</h3><br>
            결제할때 disable 풀어줘야댐
            <input type="text" class="form-control-plaintext" name="titleInfo" value="${ticket.titleInfo}" disabled>
            <input type="text" class="form-control-plaintext" name="hallInfo" value="${ticket.hallInfo}" disabled>
            <input type="text" class="form-control-plaintext" name="dayInfo" value="${ticket.dayInfo}" disabled>
            <input type="text" class="form-control-plaintext" name="timeInfo" value="${ticket.timeInfo}" disabled>
        </div>
        <div class="col-4">
            <h3>인원수</h3><br>
            성인
            <select class="select">
                <option>0</option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
            </select>
            청소년
            <select>
                <option>0</option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
            </select>
        </div>
        <div class="col-4">
            <h3>선택한 좌석</h3><br>
            <input type="text" size="8" name="seat1" id="seat1" value="seat1" class="input-group-text mb-1">
            <input type="text" size="8" name="seat2" id="seat2" value="seat2" class="input-group-text mb-3"><br>
            PRICE:
        </div>
    </div>
</div>
<h1 style="text-align: center; background-color: grey" class="mb-5 mt-3">스크린</h1>

<form>
    <div class="form-group">
        <div class="container">
            <div class="row mb-3">
                <%
                    for (int i = 65; i < 75; i++) {
                %>
                <div class="col-md-2 mt-3">
                    <button type="button" class="btn btn-outline-secondary btn-block" disabled>
                        <%=(char) i%>열
                    </button>
                </div>
                <c:forEach var="num" begin="1" end="10">
                    <div class="col-md-1 mt-3" id="num">
                        <button type="button" name="<%=(char)i%>${num}" id="<%=(char)i%>${num}" class="btn btn-outline-secondary btn-block"
                                value="${num}">${num}</button>
                    </div>
                </c:forEach>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <div class="container form-check-reverse">
        <button type="submit" class="btn btn-primary">선택완료</button>
        <a href="<c:url value="javascript:history.back();"/>">
            <button type="button" class="btn btn-primary">뒤로가기</button>
        </a>
    </div>
</form>
<%@ include file="../footer.jsp" %>
<script>
    $(document).ready(function () {
        <%--        <c:forEach var="num" begin="1" end="10">--%>
        <%--        $("#A${num}").click(function () {--%>
        <%--            $("#seat1").val("A${num}");--%>
        <%--        });--%>
        <%--        </c:forEach>--%>
        // $(document).ready(function() {
        <%
                   for (int i = 65; i < 75; i++) {
               %>
        <c:forEach var="num" begin="1" end="10">
        $("#<%=(char)i%>${num}").click(function () {
            $("#seat1").val("<%=(char)i%>${num}").append();
            console.log(<%=(char)i%>)
        });
        </c:forEach>
        <%
                    }
                %>

        <%
                   for (int i = 65; i < 75; i++) {
               %>
        <c:forEach var="num" begin="1" end="10">
        $("#<%=(char)i%>${num}").click(function () {
            $("#seat2").val("<%=(char)i%>${num}");
            console.log(<%=(char)i%>)
        });
        </c:forEach>
        <%
                    }
                %>
    });
</script>
</body>
</html>
