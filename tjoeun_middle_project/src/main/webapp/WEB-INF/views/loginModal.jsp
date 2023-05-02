<%--로그인 컨트롤러 비동기 방식 -->
----------------------------------------컨트롤러 코드--------------------------------------------------
<%--@PostMapping("/loginModal")--%>
<%--@ResponseBody--%>
<%--public String loginModal(String id, String password,boolean saveId,HttpServletRequest request,HttpServletResponse response){--%>
<%--try {--%>
<%--User user = userService.login(id,password);--%>
<%--request.getSession().setAttribute("user",user);--%>
<%--Cookie cookie = new Cookie("id", id);--%>
<%--if(saveId) {--%>
<%--response.addCookie(cookie);--%>
<%--}else{--%>
<%--cookie.setMaxAge(0);--%>
<%--response.addCookie(cookie);--%>
<%--}--%>
<%--} catch (Exception e) {--%>
<%--return "fail";--%>
<%--}--%>
<%--return "success";--%>
<%--}--%>
----------------------------------------------컨트롤러 코드 끝-----------------------------------------




----------------------------------------------HTML 코드----------------------------------------------
<!-- 모달 트리거 -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
    Launch demo modal
</button>
<!-- 로그인 모달창 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginHeader"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="loginHeader">로그인</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form name="loginForm" class="row g-3" action="<c:url value='/user/login'/>"
                      method="post">
                    <div class="row mt-md-3">
                        <div class="col-md-12">
                            <label for="id" class="form-label">아이디</label>
                            <input type="text" id="id" name="id" class="form-control"
                                   value="${cookie.id.value}" placeholder="아이디입력">
                        </div>
                    </div>
                    <div class="row mt-md-3">
                        <div class="col-md-12">
                            <label for="password" class="form-label">비밀번호</label>
                            <input class="form-control" type="password" id="password"
                                   name="password" placeholder="비밀번호입력">
                        </div>
                    </div>
                    <div class="row mt-md-3">
                        <div class="col">
                            <input id="saveId" type="checkbox"
                                   name="saveId" ${empty cookie.id ? '':'checked'}>아이디
                            저장
                        </div>
                        <div class="col">
                            <a href="<c:url value="#"/>"
                               style="text-decoration: none; font-size: 12px">아이디 혹은 비밀번호를
                                잊으셨나요?</a>
                        </div>
                    </div>
                    <div class="row mt-md-4 text-center">
                        <div class="col">
                            <input type="hidden" name="toUrl" value="${param.toUrl}"/>
                            <input type="button" class="btn btn-primary" value="로그인하기"
                                   onclick="checkLogin()">
                        </div>
                        <div class="col">
                            <button type="button" class="btn btn-primary">
                                <a href="<c:url value="/user/join"/>"
                                   style="color:white; text-decoration: none">회원가입</a>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!--로그인 정규식 및 비동기 방식의 로그인 처리 -->
<script>
  var form = document.loginForm;
  function checkLogin() {
    if (form.id.value === "") {
      alert("아이디를 입력해주세요.");
      form.id.select();
      return;
    } else if (form.password.value === "") {
      alert("비밀번호를 입력해주세요.")
      form.password.select();
      return;
    }
    let id = $('#id').val();
    let password = $('#password').val();
    let saveId = $('#saveId').val();
    $.ajax({
      type: "post",
      url: "/user/loginModal",
      data: {
        'id': id,
        'password': password,
        'saveId': saveId
      },
      success: function (result) {
        if (result === 'success') {
            //로그인 되었을때 로직추가
          location.reload();
        } else {
          alert('아이디 혹은 비밀번호가 일치하지 않습니다.');
        }
      },
      error: function () {
        alert('비동기 통신 실패');
      }
    });
  }
</script>