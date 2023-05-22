<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품추가</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<form id="fileForm" action="<c:url value='/store/insert-goods'/>" method="post" enctype="multipart/form-data" class="container mt-5">
    <div class="row d-flex">
        <div class="d-flex justify-content-center mb-3">
            <img style="width: 200px; height: 200px" class="form-control" src="/getImage?fileName=${categoryImg.get(1).fileName}">
        </div>
    </div>
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
        상품 카테고리( 세트 1 / 팝콘 2 / 음료 3 / 쿠폰 4 )
        <input type="text" class="form-control" name="category">

    </div>
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
        상품 이름
        <input type="text" class="form-control" name="name">
    </div>
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
        상품 설명
        <input type="text" class="form-control" name="goodsInfo">
    </div>
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
        상품 구성
        <input type="text" class="form-control" name="components">
    </div>
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
        가격
        <input type="text" class="form-control" name="price">
    </div>
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
        <input class="form-control" type="file" name="image">
    </div>
    <div class="row d-flex">
    <div class="col-5"></div>
    <div class="col-2">
        <button type="button" class="btn btn-primary" id="submitBtn">굿즈 등록</button>
        <input type="reset" class="btn btn-primary" value="리 &nbsp; 셋">
    </div>
    <div class="col-5"></div>
    </div>

</form>
<%@include file="/WEB-INF/views/footer.jsp" %>
<script>
    $('#submitBtn').on('click',function (){
      let formData = new FormData($('#fileForm')[0]);
      $.ajax({
        url:'/store/insert-goods',
        type:'post',
        enctype:'multipart/form-data',
        data:formData,
        processData: false,
        contentType: false,
        dataType:'JSON',
        success:function (result){
          alert(result.msg);
        },
        error:function (jqXHR){
          console.log(jqXHR);
          alert(jqXHR.responseJSON.errorMsg);
        }
      })
    });
</script>
</body>
</html>
