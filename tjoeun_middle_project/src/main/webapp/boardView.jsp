<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "Noto Sans KR", sans-serif;
      }

      .container {
        width: 50%;
        margin: auto;
      }

      .writing-header {
        position: relative;
        margin: 20px 0 0 0;
        padding-bottom: 10px;
        border-bottom: 1px solid #323232;
      }

      input {
        width: 100%;
        height: 35px;
        margin: 5px 0px 10px 0px;
        border: 1px solid #e9e8e8;
        padding: 8px;
        background: #f8f8f8;
        outline-color: #e6e6e6;
      }

      textarea {
        width: 100%;
        background: #f8f8f8;
        margin: 5px 0px 10px 0px;
        border: 1px solid #e9e8e8;
        resize: none;
        padding: 8px;
        outline-color: #e6e6e6;
      }

      .frm {
        width: 100%;
      }

      .btn {
        background-color: rgb(236, 236, 236); /* Blue background */
        border: none; /* Remove borders */
        color: black; /* White text */
        padding: 6px 12px; /* Some padding */
        font-size: 16px; /* Set a font size */
        cursor: pointer; /* Mouse pointer on hover */
        border-radius: 5px;
      }

      .btn:hover {
        text-decoration: underline;
      }
    </style>
</head>
<body>
<c:set var="board" value="${boardWithComments}"/>
<c:set var="comments" value="${boardWithComments.comments}"/>
<jsp:include page="../header.jsp"/>
<div class="container">
    <h2 class="writing-header">게시글 읽기</h2>
    <c:if test="${not empty msg}">
        <div class="alert alert-primary alert-dismissible fade show" role="alert">
                ${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="bno" value="${board.bno}">
        <input name="title" type="text" value="${board.title}" placeholder="  제목을 입력해 주세요."
               readonly='readonly'><br>
        <textarea aria-disabled="true" name="content" rows="20" placeholder=" 내용을 입력해 주세요."
                  readonly='readonly'>${board.content}</textarea><br>
        <c:if test="${board.writer eq sessionScope.userDto.id}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i>수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i>삭제</button>
            <button type="button" id="cancelBtn" class="btn btn-cancel" onclick="location.href='<c:url value="/board/view${sc.queryString}&bno=${board.bno}"/>'" hidden><i class="fa fa-arrow-left"></i> 취소</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록
        </button>
    </form>
    <div class="container mt-md-3">
            <div class="row g-3 d-flex justify-content-center align-items-center">
                <div id="commentWriter" class="col-md-2 text-center">${sessionScope.userDto.id}</div>
                <div class="col-md-8">
                    <input type="text" class="form-control" id="commentContent" name="commentContent">
                </div>
                <div class="col-md-2 d-grid gap-2">
                    <button class="btn btn-outline-dark" type="button" id="commentWrite">댓글작성
                    </button>
                </div>
            </div>
    </div>
        <table class="table caption-top mt-md-3">
            <caption>댓글 (${commentCnt})</caption>
            <tbody>
            <c:forEach var="review" items="${comments}">
                <tr>
                    <td style="width: 15%" hidden>${review.cno}</td>
                    <td style="width: 15%">${review.writer}</td>
                    <td style="width:55%" class="pt-1"><input class="form-control-plaintext pt-0"
                                                              type="text" name="commentEditContent" id="commentEditContent${review.cno}" value="${review.content}"
                                                              readonly></td>
                    <td style="width:15%" align="right"><fmt:formatDate value="${review.reg_date}"
                                                                        type="both"
                                                                        pattern="MM-dd HH시 mm분"/></td>
                    <td style="width:15%" align="right">
                        <div class="btn-group" role="group" aria-label="Basic outlined example">
                            <button type="button" id="commentEdit${review.cno}"
                                    class="btn btn-outline-warning text-decoration-none" ${sessionScope.userDto.id eq review.writer ? "" : "hidden"}
                            >수정</button>
                            <button type="button" id="commentRemove${review.cno}"
                                    class="btn btn-outline-danger text-decoration-none" ${sessionScope.userDto.id eq review.writer ? "" : "hidden"}
                            >삭제</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<jsp:include page="../footer.jsp"/>

    <script>

      $(document).ready(function () {

        let formCheck = function () {
          let form = document.getElementById("form");
          if (form.title.value === "") {
            alert("제목을 입력해 주세요.");
            form.title.focus();
            return false;
          }
          if (form.content.value === "") {
            alert("내용을 입력해 주세요.");
            form.content.focus();
            return false;
          }
          return true;
        };

        $("#modifyBtn").on("click", function () {
          let form = $("#form");
          let isReadonly = $("input[name=title]").attr('readonly');
          // 1. 읽기 상태이면, 수정 상태로 변경
          if (isReadonly === 'readonly') {
            $(".writing-header").html("게시판 수정");
            $("input[name=title]").attr('readonly', false);
            $("#writeNewBtn").attr('hidden', true);
            $("#cancelBtn").attr('hidden', false);
            $("#removeBtn").attr('hidden',true);
            $("textarea").attr('readonly', false);
            $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
            return;
          }
          // 2. 수정 상태이면, 수정된 내용을 서버로 전송
          form.attr("action", "<c:url value='/board/edit${sc.queryString}&bno=${board.bno}'/>");
          form.attr("method", "post");
          if (formCheck())
            form.submit();
        });

        $("#commentWrite").on('click', function () {
          if ($('#commentContent').val() === "") {
            alert("내용을 작성해주세요.");
            $('#commentContent').focus();
            return false;
          }
          $.ajax({
            url:'<c:url value="/comment/write"/>',
            type:'POST',
            data:{
              'content':$('#commentContent').val(),
              'writer':$('#commentWriter').text(),
              'bno':${board.bno}
            },
            success: function (result){
              if(result === "success"){
                location.reload();
              }else{
                alert("작성 실패");
                location.reload();
              }
            },
            error: function (){
              alert("통신에러");
            }
          });
        });

        <c:forEach var="review" items="${comments}">
        $("#commentEdit${review.cno}").on("click", function () {
          if($("#commentEdit${review.cno}").text()==="수정"){
            $("#commentEditContent${review.cno}").attr('readonly',false).focus();
            $("#commentEdit${review.cno}").html("등록");
            $("#commentRemove${review.cno}").html("취소");
            return;
          }

          if($('#commentEditContent${review.cno}').val() === ""){
            alert("댓글을 입력해주세요");
            $('#commentEditContent${review.cno}').select();
            return;
          }
          $.ajax({
            url:"<c:url value="/comment/edit"/>",
            type :'POST',
            data:{
              'content':$('#commentEditContent${review.cno}').val(),
              'cno':${review.cno}},
            success: function (result){
              if(result === "success"){
                location.reload(); // 로케이션 리로드 하면 페이지 스크롤 상태가 그대로임
              }else{
                alert("수정에러 발생");
                location.reload();
              }
            },
            error:function () {
              alert("통신에러");
            }
          });
        });

-       $("#commentRemove${review.cno}").on("click", function () {
          if($("#commentRemove${review.cno}").text()==="취소"){
            location.reload();
          }else{
            if (!confirm("정말로 삭제하시겠습니까?")) return;
            $.ajax({
              url:'<c:url value="/comment/delete"/>',
              type:'POST',
              dataType:'text',
              data:{'cno':${review.cno}},
              success: function (result){
                if(result === "success"){
                  location.reload(); // 로케이션 리로드 하면 페이지 스크롤 상태가 그대로임
                }else{
                  alert("수정에러 발생");
                  location.reload();
                }
              },
              error: function (){
                alert("통신에러");
              }
            });
          }
        });
        </c:forEach>

        $("#listBtn").on("click", function () {
          location.href = "<c:url value='/board/list${sc.queryString}'/>";
        });


        $("#removeBtn").on("click", function () {
          if (!confirm("정말로 삭제하시겠습니까?")) return;
          let form = $("#form");
          form.attr("action", "<c:url value='/board/remove'/>");
          form.attr("method", "post");
          form.submit();
        });


      });




    </script>

</body>
</html>