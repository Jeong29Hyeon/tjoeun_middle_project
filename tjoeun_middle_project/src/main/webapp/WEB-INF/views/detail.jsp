<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: lunat
  Date: 2023-05-02
  Time: 오전 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화정보</title>
</head>
<body>
<%@include file="header.jsp" %>
<c:if test="${not empty movie}">
    <div class="container">
        <form action="" method="post">
            <div class="row">
                <!-- 디테일 뷰 -->
                <div class="col-md-2 ">
                    <a href="#"><img src="${movie.img}" class="img-thumbnail rounded mx-auto d-block"
                                     style="width:100%;height: 100%" alt="..."></a>
                </div>
                <div class="col-md-6">
                    <p class="card-title fw-bold mb-0"
                       style="font-size: 12px">${movie.rank}</p>
                    <p class="card-title fw-bold mb-0"
                       style="font-size: 40px">${movie.title}</p>
                    <p class="card-text my-0" style="font-size:10px;"><small
                            class="text-muted">예매율 ${movie.rateInfo}</small></p>
                    <p class="card-text" style="font-size:15px"><small
                            class="text-muted">${movie.openingDate}</small></p>
                        <%--                    영화 연출 정보도 받아와야할거같아요--%>
                </div>
            </div>

            <!-- 서버로 넘길 영화 데이터 input hidden -->
        </form>
    </div>
    <%--    탭 추가 20230504.이제희--%>
    <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="review-tab" data-bs-toggle="tab" data-bs-target="#review" type="button"
                    role="tab" aria-controls="review" aria-selected="false">평점/리뷰
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link " id="story-tab" data-bs-toggle="tab" data-bs-target="#story" type="button"
                    role="tab" aria-controls="story" aria-selected="true">줄거리
            </button>
        </li>

        <li class="nav-item" role="presentation">
            <button class="nav-link" id="trailer-tab" data-bs-toggle="tab" data-bs-target="#trailer" type="button"
                    role="tab" aria-controls="trailer" aria-selected="false">트레일러
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="stillcut-tab" data-bs-toggle="tab" data-bs-target="#stillcut" type="button"
                    role="tab" aria-controls="stillcut" aria-selected="false">스틸컷
            </button>
        </li>
    </ul>
    <div class="container tab-content justify-content-center" id="myTabContent">
        <div class="container tab-pane fade  text-center" id="story" role="tabpanel"
             aria-labelledby="story-tab"><p>${movie.story}</p></div>

        <div class="container tab-pane fade show active text-center" id="review" role="tabpanel" aria-labelledby="review-tab">

            <div class="container mt-md-3">
                <div class="row g-3 d-flex justify-content-center align-items-center">
                    <div id="commentWriter" class="col-md-2 text-center">${sessionScope.user.id}</div>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="commentContent" name="commentContent">
                    </div>
                    <div class="col-md-2 d-grid gap-2">
                        <button class="btn btn-outline-dark" type="button" id="commentWrite">댓글작성
                        </button>
                    </div>
                </div>
                <div class="row">
                    댓글 (${commentCnt})
                </div>
                <c:forEach var="review" items="${reviewList}">
                    <div class="row g-3 my-2">
                        <div hidden>${review.rno}</div>
                        <div class="col-md-2">
                                ${review.id}
                        </div>
                        <div class="col-md-7">
                            <input class="form-control-plaintext pt-0"
                                   type="text" name="commentEditContent"
                                   id="commentEditContent${review.rno}"
                                   value="${review.content}"
                                   readonly>
                        </div>
                        <div class="col-md-1 text-end">
                            <fmt:formatDate value="${review.reg_date}"
                                            type="both"
                                            pattern="MM-dd HH시 mm분"/>
                        </div>
                        <div class="col-md-2 text-end">
                            <div class="btn-group" role="group" aria-label="Basic outlined example">
                                <button type="button" id="commentEdit${review.rno}"
                                        class="btn btn-outline-warning text-decoration-none" ${sessionScope.user.id eq review.id ? '' : 'hidden'}
                                >수정</button>
                                <button type="button" id="commentRemove${review.rno}"
                                        class="btn btn-outline-danger text-decoration-none" ${sessionScope.user.id eq review.id ? '' : 'hidden'}
                                >삭제</button>
                            </div>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="tab-pane fade text-center" id="trailer" role="tabpanel" aria-labelledby="trailer-tab">트레일러 유튜브 링크 딱
        걸면? 딱!
    </div>
    <div class="tab-pane fade text-center" id="stillcut" role="tabpanel" aria-labelledby="stillcut-tab"> 스틸컷 가져와서
        넣자
    </div>

</c:if>
<%@include file="footer.jsp" %>
<script>
    $("#commentWrite").on('click', function () {
        if ($('#commentContent').val() === "") {
            alert("내용을 작성해주세요.");
            $('#commentContent').focus();
            return;
        }
        if (${empty sessionScope.user}) {
            alert("로그인을 먼저 해주세요.");
            return;
        }
        $.ajax({
            url: '<c:url value="/review/write"/>',
            type: 'POST',
            data: {
                'content': $('#commentContent').val(),
                'id': $('#commentWriter').text(),
                'seq':${movie.seq}
            },
            success: function (result) {
                if (result === "success") {
                    location.reload();
                } else {
                    alert("작성 실패");
                    location.reload();
                }
            },
            error: function () {
                alert("통신에러");
            }
        });
    });

    <c:forEach var="review" items="${reviewList}">
    $("#commentEdit${review.rno}").on("click", function () {
        if ($("#commentEdit${review.rno}").text() === "수정") {
            $("#commentEditContent${review.rno}").attr('readonly', false).focus();
            $("#commentEdit${review.rno}").html("등록");
            $("#commentRemove${review.rno}").html("취소");
            return;
        }

        if ($('#commentEditContent${review.rno}').val() === "") {
            alert("댓글을 입력해주세요");
            $('#commentEditContent${review.rno}').select();
            return;
        }
        $.ajax({
            url: "<c:url value="/review/edit"/>",
            type: 'POST',
            data: {
                'content': $('#commentEditContent${review.rno}').val(),
                'rno':${review.rno}
            },
            success: function (result) {
                if (result === "success") {
                    location.reload(); // 로케이션 리로드 하면 페이지 스크롤 상태가 그대로임
                } else {
                    alert("수정에러 발생");
                    location.reload();
                }
            },
            error: function () {
                alert("통신에러");
            }
        });
    });

    $("#commentRemove${review.rno}").on("click", function () {
        if ($("#commentRemove${review.rno}").text() === "취소") {
            location.reload();
        } else {
            if (!confirm("정말로 삭제하시겠습니까?")) return;
            $.ajax({
                url: '<c:url value="/review/delete"/>',
                type: 'POST',
                data: {'rno':${review.rno}},
                success: function (result) {
                    if (result === "success") {
                        location.reload(); // 로케이션 리로드 하면 페이지 스크롤 상태가 그대로임
                    } else {
                        alert("수정에러 발생");
                        location.reload();
                    }
                },
                error: function () {
                    alert("통신에러");
                }
            });
        }
    });
    </c:forEach>
</script>
</body>
</html>
