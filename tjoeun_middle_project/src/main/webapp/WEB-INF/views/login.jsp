<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-04-10
  Time: 오후 4:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container mt-md-3" style="width: 500px">
    <div class="row g-3">
        <div class="col-md-12 position-relative bg-primary rounded text-center fs-1"
             style="height: 100px; color:white;">
            <span class="position-absolute top-50 start-50 translate-middle">로그인</span>
        </div>
        <div id="msg">
            <c:choose>
                <c:when test="${not empty msg}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                             class="bi bi-emoji-frown" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                            <path d="M4.285 12.433a.5.5 0 0 0 .683-.183A3.498 3.498 0 0 1 8 10.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.498 4.498 0 0 0 8 9.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/>
                        </svg> ${msg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:when>
                <c:when test="${not empty searchMsg}">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/>
                            </svg> ${searchMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                </c:when>
            </c:choose>
        </div>
        <form name="loginForm" class="row g-3" action="<c:url value='/login'/>" method="post">
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="id" class="form-label">아이디</label>
                    <input type="text" id="id" name="id" class="form-control" value="${cookie.id.value}" placeholder="아이디입력">
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="passwd" class="form-label">비밀번호</label>
                    <input class="form-control" type="password" id="passwd" name="passwd" placeholder="비밀번호입력">
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <input type="checkbox" name="saveId" ${empty cookie.id ? '':'checked'}>아이디 저장
                </div>
            </div>
            <div class="row mt-md-4 text-center">
                <div class="col-md-6">
                    <input type="hidden" name="toUrl" value="${param.toUrl}"/>
                    <input type="button" class="btn btn-primary fluid" value="로그인하기" onclick="checkLogin()">
                </div>
                <div class="col-md-6">
                    <button type="button" class="btn btn-primary">
                        <a href="<c:url value="/searchIdPw"/>" style="color:white; text-decoration: none">ID/PW찾기</a>
                    </button>
                </div>
            </div>
        </form>
    </div>

    <script>
      var form = document.loginForm;
      function checkLogin(){
        if(form.id.value===""){
          alert("아이디를 입력해주세요.");
          form.id.select();
          return;
        }else if(form.passwd.value===""){
          alert("비밀번호를 입력해주세요.")
          form.passwd.select();
          return;
        }
        form.submit();
      }
    </script>
    <jsp:include page="footer.jsp"/>
</body>
</html>
