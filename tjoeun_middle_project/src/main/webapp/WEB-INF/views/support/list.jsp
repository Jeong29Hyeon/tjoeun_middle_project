<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>[더조은시네마] 1:1문의</title>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container">
    <h4 class="display-4">1:1 문의</h4>
    <ul>
        <li style="font-size: 0.8rem">
            더조은 시네마에 문의하실 내용을 '질문하기'를 통해 접수해주세요.
        </li>
        <li style="font-size: 0.8rem">
            접수하신 글은 비밀글로 등록되어 작성자와 관리자만 확인 가능합니다.
        </li>
    </ul>
</div>
<div class="container mb-1">
    <div class="d-flex flex-row-reverse gap-2">
        <a href="/support/write"><button class="btn btn-outline-primary">질문하기</button></a>
        <c:choose>
            <c:when test="${empty myQuestion}">
                <a href="<c:url value="/support/list?writer=${sessionScope.user.id}"/>"><button class="btn btn-outline-primary">내가 쓴 글 확인</button></a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value="/support/list"/>"><button class="btn btn-outline-primary">돌아가기</button></a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<!-- 게시글 목록 -->
<div class="container-md">
    <c:if test="${not empty msg}">
        <div class="alert alert-primary alert-dismissible fade show" role="alert">
                ${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
        </div>
    </c:if>
    <c:choose>
        <c:when test="${not empty list}">
            <table class="table table-responsive-md">
                <thead class="table-light align-middle">
                <tr>
                    <th style="width: 10%">번호</th>
                    <th style="width: 60%">제목</th>
                    <th style="width: 10%">접수상태</th>
                    <th style="width: 10%">등록일</th>
                </tr>
                </thead>
                <tbody class="align-middle table-group-divider">
                <c:forEach var="question" items="${list}">
                    <tr>
                        <td>${question.qno}</td>
                        <td><a id="title${question.qno}" class="text-decoration-none"
                               style="color:black"
                               href="<c:url value="/support/view${ph.getQueryString(ph.page)}&qno=${question.qno}"/>">${question.title}</a>
                        </td>
                        <td>${question.state}</td>
                        <td>
                            <fmt:formatDate value="${question.regDate}" pattern="yy-MM-dd"
                                            type="date"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <h3 class="display-3 my-3">문의글이 존재하지 않습니다</h3>
        </c:otherwise>
    </c:choose>
</div>
<!-- 페이지네이션 -->
<div class="container my-3">
    <div class="row">
        <c:if test="${not empty ph.totalCnt && ph.totalCnt != 0}">
            <nav aria-label="...">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${ph.showPrev ? '' : 'disabled'}">
                        <a class="page-link" href="<c:url value='/support/list${ph.getQueryString(ph.beginPage-1)}'/>">이전</a>
                    </li>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <li class="page-item ${i eq ph.page ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/support/list${ph.getQueryString(i)}'/>">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${ph.showNext ? '' : 'disabled'}">
                        <a class="page-link" href="<c:url value='/support/list${ph.getQueryString(ph.endPage+1)}'/>">다음</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>
