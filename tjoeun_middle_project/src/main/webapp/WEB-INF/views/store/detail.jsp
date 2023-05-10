<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-09
  Time: 오전 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 상세보기</title>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container mt-5"><h2>${selectGoods.name}</h2></div>
<div class="container mt-1">${selectGoods.components}
    <hr>
</div>
<div class="container mt-5">
    <div class="row">
        <div class="col-4">
            <img src="${selectGoods.uploadPath}/${selectGoods.fileName}">
        </div>
        <div class="col-8">
            <div class="row">
                <div class="col-6">
                    사용극장<br>
                    유효기간<br>
                    판매수량<br>
                    환불절차<br>
                </div>
                <div class="col-6">
                    (ONLY TJOEUN CINEMA)<br>
                    구매일로부터 92일 이내 사용 가능<br>
                    최대 4개<br>
                    (아래참조)<br>
                </div>
                <div class="container mt-2">
                    <hr>
                    <div class="row">
                        <div class="col-6">
                            수량 / 금액
                            <select id="num" class="form-select-sm" style="width: 50px; margin-left: 10px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>
                        </div>
                    </div>
                    <div class="container mt-5">
                        <div class="d-flex justify-content-center gap-3">
                            <div>
                                <a href="<c:url value="javascript:history.back();"/>">
                                    <button type="button" class="btn btn-primary">
                                        <i class="fa-solid fa-circle-left"></i>
                                        뒤로가기</button>
                                </a>
                            </div>
                            <div>
                                <button type="button" id="btnCart" class="btn btn-primary">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                장바구니
                                </button>
                            </div>
                            <div>
                                <button type="button" id="btnPurchase" class="btn btn-primary"><i class="fa-solid fa-wallet"></i>
                                    구매하기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container mt-3">
    <ul class="nav nav-tabs nav-fill justify-content-center mt-4" id="myTap" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="refund-tab" data-bs-toggle="tab" data-bs-target="#refund"
                    type="button"
                    role="tab" aria-controls="refund" aria-selected="false">
                <h5 style="font-weight: 600; color: black">환불절차</h5>
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="info-tab" data-bs-toggle="tab" data-bs-target="#info"
                    type="button" role="tab" aria-controls="info" aria-selected="false">
                <h5 style="font-weight: 600; color: black">사용안내</h5>
            </button>
        </li>
    </ul>
    <div class="container tab-content justify-content-center" id="myTapRefund">
        <div class="container tab-pane fade text-left" id="refund" role="tabpanel"
             aria-labelledby="refund-tab">
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
        </div>
    </div>
    <div class="container tab-content justify-content-center" id="myTapInfo">
        <div class="container tab-pane fade text-left" id="info" role="tabpanel"
             aria-labelledby="info-tab">
            <div class="container mt-5 text-muted">
                ■ 이용 안내<br>
                본 상품의 사용 기한은 구매일로부터 92일까지입니다.<br>
                - 영화관 매점에서 스토어 쿠폰번호 제시 후 상품으로 교환하실 수 있습니다.<br>
                - 본 상품은 온라인 전용 판매 상품으로 현장 구매는 불가합니다.<br>
                - 구매한 상품은 “PROFILE > 구매내역”에서 확인할 수 있습니다.<br>
                - 팝콘 및 음료의 맛, 크기, 종류 변경 시 추가 금액이 발생할 수 있습니다.<br>
                - 상기 이미지는 실제 제품과 다를 수 있습니다.<br>
                - 본 상품은 포인트 사용분 외 실 결제금액에 한하여 교환권 사용시 적립 가능합니다.<br>
            </div>
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>
<script>
    function sessionCheck(){ //세션이 없으면 컨펌창을 뛰우고 로그인하지 않겠다고 하면 return
        if (${empty sessionScope.user}) {
            let loginChoice = confirm('로그인 후 이용가능한 서비스 입니다. 로그인 하러 가시겠습니까?');
            if (loginChoice) {
                location.href = '/user/login?toUrl=/store/detail?gno=${selectGoods.gno}';
            }
        }
        return '${empty sessionScope.user}';
    }
    var priceInput_value = Number($('#priceInput').val());
    $('#priceInput').attr('value', priceInput_value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");

    $("#num").on('click', function () {
        var sumPrice = Number($('#num').val() * ${selectGoods.price});
        $('#priceInput').attr('value',
            sumPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
    });

    $("#btnPurchase").on('click', function () {
        if(sessionCheck() ==='true'){
            return;
        }
        $.ajax({
            type: 'post',
            url: '/store/cart-add',
            data: {
                'gno':${selectGoods.gno}
            },
            success: function (result) {
                // $('#priceInput').attr('disabled', false);
                if (result === 'quantityError') {
                    alert("4개이상 추가할 수 없습니다.");
                    return;
                }
                    location.href = "/store/cart"
            },
            error: function () {
                alert("카트에 아이템 추가 비통신에러");
            }
        })
    });

    $("#btnCart").on('click', function () {
        if(sessionCheck() ==='true'){
            return;
        }
        $.ajax({
            type: 'post',
            url: '/store/cart-add',
            data: {
                'gno':${selectGoods.gno}
            },
            success: function (result) {
                // $('#priceInput').attr('disabled', false);
                if (result === 'quantityError') {
                    alert("4개이상 추가할 수 없습니다.");
                    return;
                }
                let choice = confirm(`장바구니에 추가되었습니다.확인하시겠습니까?`);
                if (choice) {
                    // alert("구매하기로 가야함")
                    location.href = "/store/cart"
                }
            },
            error: function () {
                alert("카트에 아이템 추가 비통신에러");
            }
        })
    });
</script>
</body>
</html>

