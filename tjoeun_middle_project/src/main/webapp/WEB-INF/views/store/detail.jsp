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
<div class="container">
  <div class="row">
    <div class="col-6">
      <img src=" ${selectGoods.uploadPath}/${selectGoods.fileName}">
    </div>
  </div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>

