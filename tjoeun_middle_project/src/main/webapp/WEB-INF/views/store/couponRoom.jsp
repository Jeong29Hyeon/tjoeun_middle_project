<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-10
  Time: 오후 2:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>coupon</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container mt-5">
    <h1 style="text-align: center">쿠폰함</h1>
</div>
<ul class="nav nav-tabs justify-content-center mt-4" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="useCoupon-tab" data-bs-toggle="tab" data-bs-target="#useCoupon" type="button"
                role="tab" aria-controls="useCoupon" aria-selected="false">사용 쿠폰
        </button>
    </li>
    <li class="nav-item active" role="presentation">
        <button class="nav-link active" id="coupon-tab" data-bs-toggle="tab" data-bs-target="#coupon"
                type="button" role="tab" aria-controls="coupon" aria-selected="true">사용 가능 쿠폰
        </button>
    </li>
</ul>
<div class="container tab-content justify-content-center" id="myCoupon">
    <div class="container tab-pane fade  text-center" id="useCoupon" role="tabpanel" aria-labelledby="useCoupon-tab">
        <div class="container mt-5">
            <div class="row row-cols-auto row-cols-sm-auto row-cols-md-auto row-cols-lg-auto">
                <c:forEach var="coupon" items="${trueCoupon}">
                    <div class="col-6 col-sm-6 col-md-4 col-lg-4">
                        <div class="card text-black bg-light mb-3 mt-3" style=" max-width: 18rem;">
                            <div class="card-header">쿠폰 정보</div>
                            <div class="card-body">
                                <h5 class="card-title">${coupon.goods.name}</h5>
                                <hr>
                                <p class="card-text">
                                        <c:set var="components" value="${fn:split(coupon.goods.components,' ')}"/>
                                    <c:forEach var="component" items="${components}" varStatus="i">
                                <div class="row">
                                    <div class="col-6"><c:if test="${i.count == 1}">상품</c:if></div>
                                    <div class="col-6">
                                            ${component}
                                    </div>
                                </div>
                                </c:forEach>
                                <div class="row">
                                    <div class="col-6">사용가능 관</div>
                                    <div class="col-6">TJOUEN CINEMA</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">유효기간</div>
                                    <div class="col-6">
                                        ~<fmt:formatDate value="${coupon.expireDate}" pattern="yyyy-MM-dd"/>
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <div class="col-6" style="font-weight: bold; font-size: 25px; margin-top: 30px">사용만료</div>
                                    <img class="col-6" src="/getImage?fileName=${coupon.goods.fileName}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="container tab-pane fade show active text-center" id="coupon" role="tabpanel"
         aria-labelledby="coupon-tab"><p>
        <div class="container mt-5">
        <div class="row row-cols-auto row-cols-sm-auto row-cols-md-auto row-cols-lg-auto">
                <c:forEach var="coupon" items="${falseCoupon}">
                    <div class="col-6 col-sm-6 col-md-4 col-lg-4">
                        <div class="card text-black bg-light mb-3 mt-3" style=" max-width: 18rem;">
                            <div class="card-header">쿠폰 정보</div>
                            <div class="card-body">
                                <h5 class="card-title">${coupon.goods.name}</h5>
                                <hr>
                                <p class="card-text">
                                    <c:set var="components" value="${fn:split(coupon.goods.components,' ')}"/>
                                    <c:forEach var="component" items="${components}" varStatus="i">
                                <div class="row">
                                    <div class="col-6"><c:if test="${i.count == 1}">상품</c:if></div>
                                    <div class="col-6">
                                            ${component}
                                    </div>
                                </div>
                                </c:forEach>
                                <div class="row mt-2">
                                    <div class="col-6">사용가능 관</div>
                                    <div class="col-6">TJOUEN CINEMA</div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-6">유효기간</div>
                                    <div class="col-6">~
                                        <fmt:formatDate value="${coupon.expireDate}" pattern="yyyy-MM-dd"/>
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <img class="col-6" src="/getImage?fileName=5c974982ed854707a0d2bd3149308132.jpg"/>
                                    <img class="col-6" src="/getImage?fileName=${coupon.goods.fileName}"/>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <button class="btn btn-outline-warning" id="delete${coupon.cno}"
                                                style="color: black">쿠폰 환불
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/views/footer.jsp" %>
<script>
    $('#useCoupon-tab').on('click', function () {

    })
    <c:forEach var="coupon" items="${falseCoupon}">
    $('#delete${coupon.cno}').on('click',function (){
      let choice = confirm("정말 환불처리 하시겠습니까?");
      if (!choice){
        return;
      }
      $.ajax({
        url: "/user/deleteCoupon",
        type: "post",
        data: {
          "cno": '${coupon.cno}',
          "price":'${coupon.goods.price}',
          "imp_uid":'${coupon.imp_uid}'
        },
        success:function (result){
          if(result==='success'){
            alert('쿠폰 환불이 완료되었습니다.')
            location.reload();
          }else{
            alert('환불실패')
          }
        },
        error:function (){
          alert('통신에러')
        }
      });
    });
    </c:forEach>
</script>
</body>
</html>
