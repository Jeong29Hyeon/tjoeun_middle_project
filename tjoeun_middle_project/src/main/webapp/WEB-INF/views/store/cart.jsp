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
<div class="container w-75 my-4">
    <hr>
    <div class="row text-center">
        <div class="col" style="color:#ff544a">
            <p>step0
            <p>
            <h1>장바구니</h1>
        </div>
        <div class="col d-flex align-items-center justify-content-center">
            <i class="fa-solid fa-circle-arrow-right fa-2xl"></i>
        </div>
        <div class="col text-muted">
            <p>step1
            <p>
            <h1>구매하기</h1>

        </div>
        <div class="col d-flex align-items-center justify-content-center">
            <i class="fa-solid fa-circle-arrow-right fa-2xl"></i>
        </div>
        <div class="col text-muted">
            <p>step2
            <p>
            <h1>결제완료</h1>
        </div>
    </div>
    <hr>
</div>
<c:if test="${not empty sessionScope.cart}">
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
</c:if>
<div class="container w-75 text-center">
    <ul class="container-fluid" style="list-style: none">
        <c:if test="${not empty sessionScope.cart}">
            <c:forEach var="goods" items="${sessionScope.cart}">
                <li class="row my-4">
                    <div class="col-2 col-lg-2 col-md-2 col-sm-2">
                        <img src="${goods.value.uploadPath}/${goods.value.fileName}"
                             alt="" class=" rounded mx-auto d-block img-fluid">
                    </div>
                    <div class="col-2 col-lg-2 col-md-2 col-sm-2 d-flex justify-content-center align-items-center text-sm text-lg text-md">
                            ${goods.value.name}
                    </div>
                    <div id="salePrice${goods.value.gno}"
                         class="col-2 col-lg-2 col-md-2 col-sm-2 d-flex justify-content-center align-items-center text-sm text-lg text-md">
                            ${goods.value.price}원
                    </div>
                    <div class="col-2 col-lg-2 col-md-2 col-sm-2 d-flex justify-content-center align-items-center text-sm text-lg text-md">
                        <select id="selectNum${goods.value.gno}" class="form-select-sm"
                                style="width: 50px; margin-left: 10px">
                            <option ${goods.value.quantity == 1 ? 'selected':''}>1</option>
                            <option ${goods.value.quantity == 2 ? 'selected':''}>2</option>
                            <option ${goods.value.quantity == 3 ? 'selected':''}>3</option>
                            <option ${goods.value.quantity == 4 ? 'selected':''}>4</option>
                        </select>
                    </div>
                    <div class="col-2 col-lg-2 col-md-2 col-sm-2 d-flex justify-content-center align-items-center">
                        <input type="text" class="form-control-plaintext mx-auto" style="width:78px"
                               id="eachPrice${goods.value.gno}"
                               value="${goods.value.price * goods.value.quantity}원">
                    </div>
                    <div class="col-2 col-lg-2 col-md-2 col-sm-2 d-flex justify-content-center align-items-center">
                        <button class="btn btn-default" id="btnDelete${goods.value.gno}">
                            <i class="fa-regular fa-circle-xmark fa-2xl"></i>
                        </button>
                    </div>
                </li>
                <hr/>
            </c:forEach>
        </c:if>
        <div>
            <c:choose>
                <c:when test="${empty sessionScope.cart}">
                    <h2 class="display-2 mb-5">장바구니에 상품이 없습니다.</h2>
                    <a href="<c:url value="/store/display"/>">
                        <button type="button" class="btn btn-primary">스토어 가기</button>
                    </a>
                </c:when>
                <c:otherwise>
                    <button type="button" id="purchase" class="btn btn-primary me-2">구매하기</button>
                    <a href="<c:url value="/store/display"/>">
                        <button type="button" class="btn btn-primary">쇼핑 계속하기</button>
                    </a>
                </c:otherwise>

            </c:choose>
        </div>
    </ul>
</div>
<script>
  $(document).ready(function () {
    <c:if test="${not empty sessionScope.cart}">
    <c:forEach var="goods" items="${sessionScope.cart}">
    $('#salePrice${goods.value.gno}').text(
        '${goods.value.price}'.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
    var price = ${goods.value.price};
    var quantity = Number($("#selectNum${goods.value.gno}").val());
    $('#eachPrice${goods.value.gno}').attr('value',
        (price * quantity).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
    $("#selectNum${goods.value.gno}").on('click', function () {
      var price = ${goods.value.price};
      var quantity = Number($("#selectNum${goods.value.gno}").val());
      $('#eachPrice${goods.value.gno}').attr('value',
          (price * quantity).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
    });

    $('#selectNum${goods.value.gno}').on('change', function () {
      $.ajax({
        type: 'post',
        url: '/store/cart-quantity-change',
        data: {
          'gno':${goods.value.gno},
          'quantity': $('#selectNum${goods.value.gno}').val()
        },
        success: function (result) {
          if (result === "LOGIN_ERR") {
            alert("세션이 만료되어 로그인 화면으로 이동합니다.");
            location.href = '/user/login';
            return;
          }
          location.reload();
        },
        error: function () {
          alert("카트에 수량 변경 비통신에러");
        }
      })
    })
    $('#btnDelete${goods.value.gno}').on('click', function () {
      $.ajax({
        type: 'post',
        url: '/store/delete',
        data: {
          'gno':${goods.value.gno},
        },
        success: function (result) {
          if (result === 'LOGIN_ERR') {
            alert("세션이 만료되어 로그인 화면으로 이동합니다.");
            location.href = '/user/login';
            return;
          }
          location.reload();
        },
        error: function () {
          alert("카트에 품목 삭제 비통신에러");
        }
      })
    })
    </c:forEach>
    </c:if>
    $("#purchase").on('click', function () {
      location.href = "/store/purchase"
    });
  });
</script>
<%@include file="../footer.jsp" %>
</body>
</html>
