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
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
        <div class="col"style="color:#ff544a">
            <p>step1
            <p><h1>구매하기</h1>

        </div>
        <div class="col d-flex align-items-center justify-content-center">
            <i class="fa-solid fa-circle-arrow-right fa-2xl"></i>
        </div>
        <div class="col text-muted">
            <p>step2
            <p><h1>결제완료</h1>
        </div>
    </div>
    <hr>
</div>
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
        <c:forEach var="goods" items="${sessionScope.cart}">
            <li class="row my-4">
                <div class="col-2">
                    <img src="${goods.value.uploadPath}/${goods.value.fileName}"
                         alt="" class=" rounded mx-auto d-block" style="height: 170px">
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                        ${goods.value.name}
                </div>
                <div id="salePrice${goods.value.gno}"
                     class="col-2 d-flex justify-content-center align-items-center">
                        ${goods.value.price}원
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                        <p id="quantity${goods.value.gno}" >${goods.value.quantity}
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <input type="text" class="form-control-plaintext mx-auto" style="width:78px"
                           id="eachPrice${goods.value.gno}"
                           value="${goods.value.price * goods.value.quantity}원">
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                </div>
            </li>
            <hr/>
        </c:forEach>
        <div class="d-flex justify-content-center gap-3">
            <h4 class="display-4">총 결제 예정금액 : <span id="totalAmount">300</span></h4>
        </div>
        <div>
            <button id="btnPurchase" class="btn btn-primary">결제하기</button>
        </div>
    </ul>
</div>
<%@include file="../footer.jsp" %>
<script>
    let totalPrice = 0;
    <c:forEach var="goods" items="${sessionScope.cart}">
        totalPrice += ${goods.value.price * goods.value.quantity};
            $('#salePrice${goods.value.gno}').text('${goods.value.price}'.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
            var price = ${goods.value.price};
            var quantity = Number($("#quantity${goods.value.gno}").text());
            $('#eachPrice${goods.value.gno}').attr('value',
            (price * quantity).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
            $("#selectNum${goods.value.gno}").on('click', function () {
            var price = ${goods.value.price};
            var quantity = Number($("#quantity${goods.value.gno}").text());
            $('#eachPrice${goods.value.gno}').attr('value',
            (price * quantity).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
            });
    </c:forEach>
    $('#totalAmount').text(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+'원');

    $('#btnPurchase').on('click',function (){
        if(sessionCheck() ==='true'){
            return;
        }
        var IMP = window.IMP;
        IMP.init('imp11028147');
        IMP.request_pay({
            pg: 'kakaopay',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '더조은 시네마 - 매점결제',
            amount: totalPrice,
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                $.ajax({
                    type:'post',
                    url:'/store/purchase',
                    data:{
                      'imp_uid':rsp.imp_uid,
                      'paid_amount':rsp.paid_amount
                    },
                    success:function (result){
                      if(result ==='fail') {
                        alert("쿠폰 생성 or 결제내역 생성 DB에러");
                        return;
                      }
                        alert("결제완료");
                        location.href = "/store/purchase-complete";
                    },
                    error:function (){
                      alert("쿠폰 생성 비동기 통신 에러");
                    }
                });
                // msg += '고유ID : ' + rsp.imp_uid;
                // msg += '상점 거래ID : ' + rsp.merchant_uid;
                // msg += '결제 금액 : ' + rsp.paid_amount;
            } else {
                alert(rsp.error_msg);
                location.reload();
            }
        });
    });
    function sessionCheck(){ //세션이 없으면 컨펌창을 뛰우고 로그인하지 않겠다고 하면 return
        if (${empty sessionScope.user}) {
            let loginChoice = confirm('로그인 후 이용가능한 서비스 입니다. 로그인 하러 가시겠습니까?');
            if (loginChoice) {
                location.href = '/user/login?toUrl=/store/display';
            }
        }
        return '${empty sessionScope.user}';
    }
</script>
</body>
</html>
