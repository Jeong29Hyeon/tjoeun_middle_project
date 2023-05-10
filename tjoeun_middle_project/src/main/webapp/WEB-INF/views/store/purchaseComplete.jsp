<%--
  Created by IntelliJ IDEA.
  User: lunat
  Date: 2023-05-10
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>결제완료</title>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container w-75 my-4">
  <hr>
  <div class="row text-center">
    <div class="col  text-muted " >
      <p>step0
      <p><h1>장바구니</h1>
    </div>
    <div class="col d-flex align-items-center justify-content-center">
      <i class="fa-solid fa-circle-arrow-right fa-2xl"></i>
    </div>
    <div class="col text-muted">
      <p>step1
      <p><h1>구매하기</h1>

    </div>
    <div class="col d-flex align-items-center justify-content-center">
      <i class="fa-solid fa-circle-arrow-right fa-2xl"></i>
    </div>
    <div class="col " style="color:#ff544a">
      <p>step2
      <p><h1>결제완료</h1>
    </div>
  </div>
  <hr>
  <div class="row text-center mt-5">
        <%--  추가정보   --%>
      <h1 class="display-2">결제가 완료 되었습니다</h1>
  </div>
  <div class="container mt-5 text-muted">
    ■ 연장/취소/환불 안내<br>
    본 상품은 구매일로부터 10일 이내에 취소 가능합니다.<br>
    - 유효기간은 본 상품의 유효기간 내에서 연장 신청이 가능하며, 1회 연장 시 3개월(92일) 단위로 연장됩니다.<br>
    - 구매일로부터 5년까지 유효기간 연장이 가능합니다.<br>
    - 최초 유효기간 만료 후에는 결제금액의 90%에 대해 환불 요청 가능하며, 환불 처리에 7일 이상의 시간이 소요될 수 있습니다. (접수처: 꼬우면 전화해)<br>
    - 구매 취소 및 환불 요청은 미사용 상품에 한해 가능하며, 사용한 상품에 대해서는 불가합니다.<br>
    - 본 상품은 현금으로 환불이 불가합니다.<br>
    - 환불 요청한 포인트 중 소멸 포인트가 포함되어있다면 환불 요청한 월의 말일까지 사용 가능한 포인트로 돌아가지않습니다.<br>
  </div>
  <div class="row text-center mt-5">
        <a href="<c:url value="/"/>"> <button class="btn btn-primary btn-lg">홈으로</button></a>
  </div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>
