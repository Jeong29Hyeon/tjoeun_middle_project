<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-09
  Time: 오전 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>insertTest</title>
</head>
<body>
<form action="<c:url value='/store/insert-goods'/>" method="post" enctype="multipart/form-data">
  <div class="mb-3" style="width: 50%; margin: 0 auto;">
    카테고리
    <input type="text" class="form-control"  name="category">
  </div>
  <div class="mb-3" style="width: 50%; margin: 0 auto;">
    굿즈 이름
    <input type="text" class="form-control"  name="name">
  </div>
  <div class="mb-3" style="width: 50%; margin: 0 auto;">
    굿즈 설명
    <input type="text" class="form-control"  name="goodsInfo">
  </div>
  <div class="mb-3" style="width: 50%; margin: 0 auto;">
    가격
    <input type="text" class="form-control" name="price">
  </div>
  <div class="mb-3" style="width: 50%; margin: 0 auto;">
    <input class="form-control" type="file" name="image">
  </div>
  <button type="submit" class="btn btn-primary">굿즈 등록</button>
  <button type="button" class="btn btn-primary">취 &nbsp; 소</button>
</form>
</body>
</html>
