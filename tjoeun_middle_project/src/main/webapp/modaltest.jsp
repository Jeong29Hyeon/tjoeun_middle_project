<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-16
  Time: 오전 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="WEB-INF/views/header.jsp"%>
<button type="button" onclick="btn()">modalTest</button>

<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginHeader"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="loginHeader">WARNNING</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form name="loginForm">
                    <div class="row mt-md-3">
                        <div class="col-md-12">
                          타인의 게시물은 염탐이 불가능합니다.
                        </div>
                    </div>
                    <div class="row mt-md-4 text-center">
                        <div class="col">
                            <button type="button" class="btn btn-primary">
                                <a href="<c:url value="#"/>" style="color:white; text-decoration: none">확인</a>
                            </button>
                            <button type="button" class="btn btn-primary">
                                <a href="<c:url value="#"/>" style="color:white; text-decoration: none">내가 올린 민원 확인하기</a>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="WEB-INF/views/footer.jsp"%>
</body>
<script>
    function btn(){
      $('#loginModal').modal('show');
    }
</script>
</html>