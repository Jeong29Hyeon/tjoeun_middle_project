<%--
  Created by IntelliJ IDEA.
  User: lunat
  Date: 2023-05-10
  Time: 오전 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="../header.jsp" %>
결제창 테스트
<div class="container w-75 text-center mb-4">
    <div class="row">
        <p class="col-2">
        <p class="col-2">상품명
        <p class="col-2">판매금액
        <p class="col-2">수량
        <p class="col-2">구매금액
        <p class="col-2">
    </div>
</div>
<div class="container w-75 text-center">
    <ul class="container-fluid" style="list-style: none">
        <c:forEach var="goodsList" items="${sessionScope.cart}">
            <li class="row my-4">
                <div class="col-2">
                    <img src="${goodsList.value.uploadPath}/${goodsList.value.fileName}"
                         alt="" class=" rounded mx-auto d-block" style="height: 170px">
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                        ${goodsList.value.name}
                </div>
                <div id="salePrice${goodsList.value.gno}"
                     class="col-2 d-flex justify-content-center align-items-center">
                        ${goodsList.value.price}원
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                        ${goodsList.value.quantity}
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <input type="text" class="form-control-plaintext mx-auto" style="width:78px"
                           id="eachPrice${goodsList.value.gno}"
                           value="${goodsList.value.price * goodsList.value.quantity}원">
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                </div>
            </li>
            <hr/>
        </c:forEach>
        <div>
            총 결제 예정금액
        </div>
    </ul>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>
