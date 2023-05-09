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
    <title>Store</title>
    <style>
        a {
            text-decoration-line: none;
            color: black;
        }
    </style>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container mt-5"><h2>스토어</h2></div>
<div class="container">
    <ul class="nav nav-tabs nav-fill justify-content-center mt-4" id="myTap" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="setMenu-tab" data-bs-toggle="tab" data-bs-target="#setMenu"
                    type="button"
                    role="tab" aria-controls="setMenu" aria-selected="false">세트메뉴
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="popcorn-tab" data-bs-toggle="tab" data-bs-target="#popcorn"
                    type="button" role="tab" aria-controls="popcorn" aria-selected="false">팝콘만
            </button>
        </li>

        <li class="nav-item" role="presentation">
            <button class="nav-link" id="drink-tab" data-bs-toggle="tab" data-bs-target="#drink"
                    type="button"
                    role="tab" aria-controls="drink" aria-selected="false">음료만
            </button>
        </li>
    </ul>
    <div class="container tab-content justify-content-center" id="myTapSetMenu">
        <div class="container tab-pane fade show active text-center" id="setMenu" role="tabpanel"
             aria-labelledby="setMenu-tab">
            <div class="container mt-5">
                <c:forEach var="setMenu" items="${setMenuList}">
                    <div class="row">       <!-- 로우 하나에 상품 3개씩-->
                        <div class="col-4"> <!-- a태그 네임 추가 -->
                                <span id="imgWrap${setMenu.gno}" class="position-relative rounded-2">
                                    <a href="/store/detail?gno=${setMenu.gno}" style="text-decoration-line: none; color: black">
                                    <img id="menuImage${setMenu.gno}" src="${setMenu.uploadPath}/${setMenu.fileName}"
                                     alt="">
                                        </a>
                                    <span id="btnWrap${setMenu.gno}"
                                          class="position-absolute top-50 start-50 translate-middle text-center" hidden>
                                    <a href="#">
                                    <button id="btnCart${setMenu.gno}" type="button"
                                            class="btn btn-sm btn-light mb-md-2">장바구니</button></a>
                                    <a href="#">
                                    <button id="btnBuy${setMenu.gno}" type="button"
                                            class="btn btn-sm btn-danger">구매하기</button></a>
                                    </span>
                                </span>
                                <h5>${setMenu.name}</h5>
                                <hr>
                                <p>${setMenu.goodsInfo}
                                <p>${setMenu.components}
                                <p>${setMenu.price}원
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="container tab-content justify-content-center" id="myTapPopcorn">
        <div class="container tab-pane fade text-center" id="popcorn" role="tabpanel" aria-labelledby="popcorn-tab">
            <div class="container mt-5">
                <input type="hidden" id="popcorn_hidden" value="팝콘">
                <c:forEach var="popcorn" items="${popcornList}">
                    <div class="row">       <!-- 로우 하나에 상품 3개씩-->
                        <div id="popcorn${popcorn.gno}" class="col-4">
                            <span id="imgWrap${popcorn.gno}" class="position-relative rounded-2">
                                    <a href="/store/detail?gno=${popcorn.gno}" style="text-decoration-line: none; color: black">
                                         <img id="menuImage${popcorn.gno}" src="${popcorn.uploadPath}/${popcorn.fileName}" alt="">
                                        </a>
                                    <span id="btnWrap${popcorn.gno}"
                                          class="position-absolute top-50 start-50 translate-middle text-center" hidden>
                                    <a href="#">
                                    <button id="btnCart${popcorn.gno}" type="button"
                                            class="btn btn-sm btn-light mb-md-2">장바구니</button></a>
                                    <a href="#">
                                    <button id="btnBuy${popcorn.gno}" type="button"
                                            class="btn btn-sm btn-danger">구매하기</button></a>
                                    </span>
                                </span>
                            <a href="/store/detail?gno=${popcorn.gno}" style="text-decoration-line: none; color: black">

                                <h5>${popcorn.name}</h5>
                                <hr>
                                <p>${popcorn.goodsInfo}
                                <p>${popcorn.components}
                                <p>${popcorn.price}원 <= <span
                                        style=" text-decoration: line-through; margin-left: 5px">6,000원</span>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="container tab-content justify-content-center" id="myTapDrink">
        <div class="container tab-pane fade text-center" id="drink" role="tabpanel" aria-labelledby="drink-tab">
            <div class="container mt-5">
                <c:forEach var="drink" items="${drinkList}">
                    <div class="row">       <!-- 로우 하나에 상품 3개씩-->
                        <div id="drink${drink.gno}" class="col-4">
                             <span id="imgWrap${drink.gno}" class="position-relative rounded-2">
                                    <a href="/store/detail?gno=${drink.gno}" style="text-decoration-line: none; color: black">
                                        <img id="menuImage${drink.gno}" src="${drink.uploadPath}/${drink.fileName}"/>
                                        </a>
                                    <span id="btnWrap${drink.gno}"
                                          class="position-absolute top-50 start-50 translate-middle text-center" hidden>
                                    <a href="/store/cart">
                                    <button id="btnCart${drink.gno}" type="button"
                                            class="btn btn-sm btn-light mb-md-2">장바구니</button></a>
                                    <a href="#">
                                    <button id="btnBuy${drink.gno}" type="button"
                                            class="btn btn-sm btn-danger">구매하기</button></a>
                                    </span>
                                </span>
                            <a href="/store/detail?gno=${drink.gno}" style="text-decoration-line: none; color: black">

                                <h5>${drink.name}</h5>
                                <hr>
                                <p>${drink.goodsInfo}
                                <p>${drink.components}
                                <p>${drink.price}원
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>
<script>
    $(document).ready(function () {
        <c:forEach var="setMenu" items="${setMenuList}">
        $('#imgWrap${setMenu.gno}').on('mouseover', function () {
            <%--$('#imgWrap${setMenu.gno}').css('background', 'rgba(0,0,0,0.8)');--%>
            $('#menuImage${setMenu.gno}').css('opacity', '0.5');
            $('#menuImage${setMenu.gno}').css('transition', 'opacity 0.25s ease-in-out');
            $('#btnWrap${setMenu.gno}').attr('hidden', false);
        });

        $('#imgWrap${setMenu.gno}').on('mouseout', function () {
            $('#menuImage${setMenu.gno}').css('opacity', '1');
            $('#btnWrap${setMenu.gno}').attr('hidden', true);
        });

        $('#btnCart${setMenu.gno}').on('click',function (){
           $.ajax({
               type:'post',
               url:'/store/cart-add',
               data:{
                   'gno':${setMenu.gno}
               },
               error:function (){
                   alert("카트에 아이템 추가 비통신에러");
               }
           })
        });


        </c:forEach>
    });

    $(document).ready(function () {
        <c:forEach var="popcorn" items="${popcornList}">
        $('#imgWrap${popcorn.gno}').on('mouseover', function () {
            <%--$('#imgWrap${setMenu.gno}').css('background', 'rgba(0,0,0,0.8)');--%>
            $('#menuImage${popcorn.gno}').css('opacity', '0.5');
            $('#menuImage${popcorn.gno}').css('transition', 'opacity 0.25s ease-in-out');
            $('#btnWrap${popcorn.gno}').attr('hidden', false);
        });

        $('#imgWrap${popcorn.gno}').on('mouseout', function () {
            $('#menuImage${popcorn.gno}').css('opacity', '1');
            $('#btnWrap${popcorn.gno}').attr('hidden', true);
        });
        </c:forEach>
    });

    $(document).ready(function () {
        <c:forEach var="drink" items="${drinkList}">
        $('#imgWrap${drink.gno}').on('mouseover', function () {
            <%--$('#imgWrap${setMenu.gno}').css('background', 'rgba(0,0,0,0.8)');--%>
            $('#menuImage${drink.gno}').css('opacity', '0.5');
            $('#menuImage${drink.gno}').css('transition', 'opacity 0.25s ease-in-out');
            $('#btnWrap${drink.gno}').attr('hidden', false);
        });

        $('#imgWrap${drink.gno}').on('mouseout', function () {
            $('#menuImage${drink.gno}').css('opacity', '1');
            $('#btnWrap${drink.gno}').attr('hidden', true);
        });
        </c:forEach>
    });
</script>
</body>
</html>