<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <title>영화정보</title>
</head>
<body>
<%@include file="header.jsp" %>
<c:if test="${not empty movie}">
    <div class="container">
        <form action="" method="post">
            <div class="row">
                <!-- 디테일 뷰 -->
                <div class="col-md-3 ">
                    <a href="#"><img src="${movie.img}" class="img-thumbnail rounded mx-auto d-block" alt="..."></a>
                </div>
                <div class="col-md-4">
                    <p class="card-title fw-bold mb-0"
                       style="font-size: 40px">${movie.title}</p>
                    <p class="card-title fw-bold mb-0"
                       style="font-size: 12px">${movie.rank}위</p>
                    <p class="card-text my-0" style="font-size:10px;"><small
                            class="text-muted">예매율 ${movie.rateInfo}%</small></p>
                    <p>누적관객 ${movie.cumulativeUser}명
                    <p class="card-text" style="font-size:15px"><small
                            class="text-muted">${movie.detailInfo}</small></p>
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

        <div class="container tab-pane fade show active text-center" id="review" role="tabpanel"
             aria-labelledby="review-tab">

            <div class="container mt-md-3">
                <div class="row g-3 d-flex justify-content-center align-items-center">
                    <div id="reviewWriter"
                         class="col-md-2 text-center">${not empty sessionScope.user.id ? sessionScope.user.id : '로그인 후 이용해주세요'}</div>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="reviewContent" name="reviewContent">
                    </div>
                    <div class="col-md-2 d-grid gap-2">
                        <button class="btn btn-outline-dark" type="button" id="reviewWrite">댓글작성
                        </button>
                    </div>
                </div>
                <div class="row">
                    리뷰 (${reviewList.size()})
                </div>
                <c:forEach var="review" items="${reviewList}" varStatus="status">
                    <div class="row g-3 my-2">
                        <div hidden>${review.rno}</div>
                        <div class="col-md-2">
                                ${review.id}
                        </div>
                        <div class="col-md-7">
                            <input class="form-control-plaintext pt-0"
                                   type="text" name="reviewEditContent"
                                   id="reviewEditContent${review.rno}"
                                   value="${review.content}"
                                   readonly>
                        </div>
                        <div class="col-md-1 text-end" style="font-size: 71%">
                            <fmt:formatDate value="${review.reg_date}"
                                            type="both"
                                            pattern="MM-dd HH시 mm분"/>
                        </div>
                        <div class="col-md-2 text-center">
                            <div class="btn-group" role="group" aria-label="Basic outlined example">
                                <button type="button" id="reviewEdit${review.rno}"
                                        class="btn btn-outline-warning text-decoration-none" ${sessionScope.user.id eq review.id ? '' : 'hidden'}
                                >수정
                                </button>
                                <button type="button" id="reviewRemove${review.rno}"
                                        class="btn btn-outline-danger text-decoration-none" ${sessionScope.user.id eq review.id ? '' : 'hidden'}
                                >삭제
                                </button>
                            </div>
                            <button type="button" id="likebtn${review.rno}"
                                    class="btn btn-outline-danger border-0"${sessionScope.user.id eq review.id ||sessionScope.user ==null ? 'disabled' : ''} >
                                <i id="i${review.rno}" class="fa-regular fa-heart"><p style="font-size: 10px"
                                                                                      id="likeCount${review.rno}">${review.likeCount}</p>
                                </i></button>
                            <input type="hidden" id="likecheck${review.rno}" value="${review.likeCount}">
                        </div>

                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="tab-pane fade text-center" id="trailer" role="tabpanel" aria-labelledby="trailer-tab">트레일러 유튜브 링크 딱
        걸면? 딱!
    </div>
    <div class="tab-pane fade text-center" id="stillcut" role="tabpanel" aria-labelledby="stillcut-tab">
        <div class="container">
            <div class="row">
                <c:forEach begin="0" end="${fn:length(movie.stillCut)}" var="i">
                    <div class="col-4 mt-3">
                        <img src="${movie.stillCut[i]}" alt="">
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

</c:if>
<%@include file="footer.jsp" %>
<script>
    $(document).ready(function () {
        <c:forEach var="like" items="${likeList}">
        $('#i${like.rno}').removeClass("fa-regular");
        $('#i${like.rno}').addClass("fa-solid");
        </c:forEach>
    });

    $("#reviewWrite").on('click', function () {
        if ($('#reviewContent').val() === "") {
            alert("내용을 작성해주세요.");
            $('#reviewContent').focus();
            return;
        }
        if (sessionCheck() === 'true') {
            return;
        }

        $.ajax({
            url: '<c:url value="/review/write"/>',
            type: 'POST',
            data: {
                'content': $('#reviewContent').val(),
                'id': $('#reviewWriter').text(),
                'seq':${movie.seq}
            },
            success: function (result) {
                if (result === "success") {
                    location.reload();
                } else if (result === "LOGIN_ERR") {
                    alert("세션이 만료되어 로그인 페이지로 이동합니다.");
                    location.href = "/";
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
    $("#reviewEdit${review.rno}").on("click", function () {
        if ($("#reviewEdit${review.rno}").text() === "수정") {
            $("#reviewEditContent${review.rno}").attr('readonly', false).focus();
            $("#reviewEdit${review.rno}").html("등록");
            $("#reviewRemove${review.rno}").html("취소");
            return;
        }

        if ($('#reviewEditContent${review.rno}').val() === "") {
            alert("댓글을 입력해주세요");
            $('#reviewEditContent${review.rno}').select();
            return;
        }
        $.ajax({
            url: "<c:url value="/review/edit"/>",
            type: 'POST',
            data: {
                'content': $('#reviewEditContent${review.rno}').val(),
                'rno':${review.rno}
            },
            success: function (result) {
                if (result === "success") {
                    location.reload(); // 로케이션 리로드 하면 페이지 스크롤 상태가 그대로임
                } else if (result === "LOGIN_ERR") {
                    alert("세션이 만료되어 로그인 페이지로 이동합니다.");
                    location.href = "/";
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

    $("#reviewRemove${review.rno}").on("click", function () {
        if ($("#reviewRemove${review.rno}").text() === "취소") {
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
                    } else if (result === "LOGIN_ERR") {
                        alert("세션이 만료되어 로그인 페이지로 이동합니다.");
                        location.href = "/";
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

    <c:forEach var="review" items="${reviewList}" varStatus="status">


    $('#likebtn${review.rno}').click(function () {
        if (sessionCheck() == 'true') {
            return;
        }
        $.ajax({
            url: '<c:url value="/review/update"/>',
            type: 'POST',
            data: {
                'rno': ${review.rno},
                'id': '${sessionScope.user.id}',
                'seq': '${review.seq}'
            },
            success: function (result) {
                if (result === 1) {
                    $('#i${review.rno}').removeClass("fa-regular");
                    $('#i${review.rno}').addClass("fa-solid");

                } else if (result === "LOGIN_ERR") {
                    alert("세션이 만료되어 로그인 페이지로 이동합니다.");
                    location.href = "/";
                    return;
                } else {
                    $('#i${review.rno}').removeClass("fa-solid");
                    $('#i${review.rno}').addClass("fa-regular");
                }
                $('#likeCount${review.rno}').load(location.href + " #likeCount${review.rno}")

            }, error: function (result) {
                console.log("에러" + result.result)
            }

        });

    });

    </c:forEach>

    function sessionCheck() { //세션이 없으면 컨펌창을 뛰우고 로그인하지 않겠다고 하면 return
        if (${empty sessionScope.user}) {
            let loginChoice = confirm('로그인 후 이용가능한 서비스 입니다. 로그인 하러 가시겠습니까?');
            if (loginChoice) {
                location.href = '/user/login?toUrl=/movies/detail-view?seq=${movie.seq}';
            }
        }
        return '${empty sessionScope.user}';
    }
</script>
</body>
</html>
