<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>[더조은시네마] 문의하기</title>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container my-4">
    <h5 class="display-5">1대1 문의</h5>
</div>
<div class="container">
    <c:if test="${not empty msg}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                ${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
        </div>
    </c:if>
    <div class="container">
        <div class="row mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" placeholder="제목 입력">
        </div>
        <div class="row mb-3">
            <label for="content" class="form-label">문의 내용</label>
            <textarea class="form-control" id="content" rows="3"
                      placeholder="문의 내용 입력"></textarea>
        </div>
        <div class="d-flex justify-content-end gap-2">
            <button type="button" id="writeBtn" class="btn"><i class="fa fa-edit"></i> 글쓰기
            </button>
            <button type="button" id="listBtn" class="btn"><i class="fa fa-bars"></i> 목록
            </button>
        </div>
    </div>

</div>
<jsp:include page="../footer.jsp"/>
<script>
  let inputTitle = $('#title');
  let inputContent = $('#content');
  let inputPassword = $('#password');

  function onlyNumber(obj) {
    obj.value = obj.value.replace(/[^0-9]/g, "");
  }

  $(document).ready(function () {
    let formCheck = function () {

      if (inputTitle.val() === "") {
        alert("제목을 입력해 주세요.");
        inputTitle.focus();
        return false;
      }
      if (inputContent.val() === "") {
        alert("내용을 입력해 주세요.");
        inputContent.focus();
        return false;
      }
      return true;
    }

    $("#writeBtn").on("click", function () {
      if (formCheck()) {
        $.ajax({
          type: 'post',
          url: '/support/write',
          data: {
            'title': inputTitle.val(),
            'content': inputContent.val(),
            'writer': '${sessionScope.user.id}'
          },
          success: function (result) {
            if (result === 'LOGIN_ERR') {
              alert("세션이 만료되어 로그인화면으로 이동합니다.");
              location.href = '/user/login';
              return;
            }
            if (result === "fail") {
              alert("게시글을 생성할 수 없습니다. 다시 시도해주세요.");
              return;
            }
            location.href = "/support/list";
          }
        });
      }
    });

    $("#listBtn").on("click", function () {
      location.href = "<c:url value='/support/list'/>";
    });
  });
</script>
</body>
</html>
