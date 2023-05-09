<%--
  Created by IntelliJ IDEA.
  User: lunat
  Date: 2023-05-09
  Time: 오후 2:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>장바구니</title>
</head>
<body>
<%@include file="../header.jsp" %>
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
                <div id="salePrice${goodsList.value.gno}" class="col-2 d-flex justify-content-center align-items-center">
                        ${goodsList.value.price}원
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <select id="selectNum${goodsList.value.gno}" class="form-select-sm" style="width: 50px; margin-left: 10px" >
                        <option ${goodsList.value.quantity == 1 ? 'selected':''}>1</option>
                        <option ${goodsList.value.quantity == 2 ? 'selected':''}>2</option>
                        <option ${goodsList.value.quantity == 3 ? 'selected':''}>3</option>
                        <option ${goodsList.value.quantity == 4 ? 'selected':''}>4</option>
                    </select>
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <input type="text" class="form-control-plaintext mx-auto" style="width:78px" id="eachPrice${goodsList.value.gno}"
                           value="${goodsList.value.price * goodsList.value.quantity}원">
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <button class="btn btn-sm btn-outline-secondary">X</button>
                </div>
            </li>
            <hr/>
        </c:forEach>
    </ul>
</div>
<script>
    $(document).ready(function (){
        <c:forEach var="goodsList" items="${sessionScope.cart}">
        $('#salePrice${goodsList.value.gno}').text('${goodsList.value.price}'.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");

        var price = ${goodsList.value.price};
        var quantity = Number($("#selectNum${goodsList.value.gno}").val());
        $('#eachPrice${goodsList.value.gno}').attr('value',
            (price * quantity).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
        $("#selectNum${goodsList.value.gno}").on('click', function () {

            var price = ${goodsList.value.price};
            var quantity = Number($("#selectNum${goodsList.value.gno}").val());
            $('#eachPrice${goodsList.value.gno}').attr('value',
                (price * quantity).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
        });
        </c:forEach>
    });
</script>
<%@include file="../footer.jsp" %>
</body>
</html>
