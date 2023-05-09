<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-09
  Time: 오전 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>display</title>
</head>
<body>
    <c:forEach var="goods" items="${goodsList}">
        <img src="<c:url value="${goods.uploadPath}"/>/${goods.fileName}" alt="...">
    </c:forEach>
</body>
</html>
