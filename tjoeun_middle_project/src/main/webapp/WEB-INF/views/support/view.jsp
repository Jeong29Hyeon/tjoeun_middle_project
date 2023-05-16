<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>[더조은시네마] 문의보기</title>
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
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

<jsp:include page="../header.jsp"/>
<div class="container">
    <h2 class="writing-header">질문</h2>
    <c:if test="${not empty msg}">
    <div class="alert alert-primary alert-dismissible fade show" role="alert">
            ${msg}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    </c:if>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="qno" value="${question.qno}">
        <input type="hidden" name="page" value="${ph.page}"/>
        <input type="hidden" name="writer" value="${ph.writer}"/>
        <input id="title" name="title" type="text" value="${question.title}"
               placeholder="  제목을 입력해 주세요."
               readonly='readonly'><br>
        <textarea id="content" aria-disabled="true" name="content" rows="20"
                  placeholder=" 내용을 입력해 주세요."
                  readonly='readonly'>${question.content}</textarea><br>
        <c:if test="${question.state == '미답변' && question.writer==sessionScope.user.id}">
            <button type="button" id="modifyBtn" class="btn"><i class="fa fa-edit"></i>수정
            </button>
        </c:if>
        <button type="button" id="removeBtn" class="btn"><i class="fa fa-trash"></i>삭제
        </button>
        <button type="button" id="cancelBtn" class="btn"
                onclick="location.reload();" hidden><i class="fa fa-arrow-left"></i> 취소
        </button>
        <button type="button" id="listBtn" class="btn"><i class="fa fa-bars"></i> 목록
        </button>
    </form>
    <div class="container mt-md-3 d-flex flex-column">
        <span style="font-size: 2rem;">답변</span>
        <hr/>
        <div class="mb-2">
            <c:if test="${not empty answer || sessionScope.user.id=='admin'}">
                <span class="ms-1 mb-1"><fmt:formatDate value="${answer.answerDate}"
                                                        pattern="MM-dd HH:mm" type="both"/></span>
            <div class="col-12">
                <textarea type="text" class="form-control" id="answer" name="answer"
                          placeholder="답변을 작성해주세요."
                    ${empty answer?'':'disabled'}>${answer.content}</textarea>
            </div>
            </c:if>
        </div>
        <c:if test="${sessionScope.user.id == 'admin' && empty answer}">
        <div class="d-flex flex-row-reverse">
            <button class="btn btn-outline-dark" type="button" id="answerWrite">답변작성
            </button>
        </div>
        </c:if>
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
          let isReadonly = $("#title").attr('readonly');
          // 1. 읽기 상태이면, 수정 상태로 변경
          if (isReadonly === 'readonly') {
            $(".writing-header").html("문의내용 수정");
            $("#title").attr('readonly', false);
            $("#writeNewBtn").attr('hidden', true);
            $("#cancelBtn").attr('hidden', false);
            $("#removeBtn").attr('hidden', true);
            $("#content").attr('readonly', false);
            $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
            return;
          }
          // 2. 수정 상태이면, 수정된 내용을 서버로 전송
          form.attr("action", "/support/edit");
          form.attr("method", "post");
          if (formCheck())
            form.submit();
        });

        $("#listBtn").on("click", function () {
          location.href = "<c:url value='/support/list${ph.getQueryString(ph.page)}'/>";
        });

        $("#removeBtn").on("click", function () {
          if (!confirm("정말로 삭제하시겠습니까?")) return;
          let form = $("#form");
          form.attr("action", "<c:url value='/support/remove'/>");
          form.attr("method", "post");
          form.submit();
        });

        $('#answerWrite').on('click', function () {
          let answer = $('#answer');
          if (answer.val() === '') {
            alert("답변을 작성해주세요.");
            return;
          }
          $.ajax({
            type: 'post',
            url: '/support/answer-write',
            data: {
              'qno':${question.qno},
              'content': answer.val()
            },
            success: function (result) {
              if (result === 'success') {
                location.reload();
              } else {
                alert("답변 작성실패");
              }
            },
            error: function () {
              alert("비동기통신 에러");
            }
          });

        });
      });
    </script>
</body>
</html>