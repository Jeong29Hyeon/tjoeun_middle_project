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
            <input type="text" class="form-control-plaintext" name="titleInfo" id="titleInfo"
                   value="${ticket.titleInfo}" disabled>
            <input type="text" class="form-control-plaintext" name="hallInfo" id="hallInfo"
                   value="${ticket.hallInfo}" disabled>
            <input type="text" class="form-control-plaintext" name="dayInfo" id="dayInfo"
                   value="${ticket.dayInfo}" disabled>
            <input type="text" class="form-control-plaintext" name="timeInfo" id="timeInfo"
                   value="${ticket.timeInfo}" disabled>
        </div>
        <div class="col-4">
            <h3>인원수</h3><br>
            성인
            <select class="form-select form-select-sm" name="numberOfAdult" id="numberOfAdult">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            청소년
            <select class="form-select form-select-sm" name="numberOfTeen" id="numberOfTeen">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
        </div>
        <div class="col-4">
            <h3>선택한 좌석</h3><br>
            <input type="text" size="8" name="seats" id="seatsInput" value=""
                   class="input-group-text mb-1"/>
            PRICE:
        </div>
    </div>
</div>
<h1 style="text-align: center; background-color: grey" class="mb-5 mt-3">스크린</h1>

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
            <div class="col-md-1 mt-3 mx-auto" id="num">
                <button type="button" name="<%=(char)i%>${num}" id="<%=(char)i%>${num}"
                        class="btn btn-outline-secondary btn-block">${num}</button>
            </div>
        </c:forEach>
        <%
            }
        %>
    </div>
</div>
<div class="container form-check-reverse">
    <button id="btnSelect" class="btn btn-primary">선택완료</button>
    <a href="<c:url value="javascript:history.back();"/>">
        <button type="button" class="btn btn-primary">뒤로가기</button>
    </a>
</div>
</form>
<%@ include file="../footer.jsp" %>
<script>
  let seatsList = [];
  $(document).ready(function () {
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

    $('#btnSelect').on('click', function () {
      if (Number($('#numberOfAdult').val()) + Number($('#numberOfTeen').val()) === 0 || seatsList.length === 0) {
        alert('인원수와 선택한 좌석을 확인해주세요');
        return;
      }
      $.ajax({
        url:'/ticketing',
        type:'post',
        data:{
          'titleInfo':$('#titleInfo').val(),
          'dayInfo':$('#dayInfo').val(),
          'hallInfo':$('#hallInfo').val(),
          'timeInfo':$('#timeInfo').val(),
          'numberOfAdult':$('#numberOfAdult').val(),
          'numberOfTeen':$('#numberOfTeen').val(),
          'seats':$('#seatsInput').val()
        },
        success:function (result){
          
        },
        error:function (){
          alert('비동기통신 에러');
        }
      })
    })
  });
</script>
</body>
</html>
