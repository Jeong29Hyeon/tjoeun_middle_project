<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>

</head>
<body>
<%@include file="header.jsp"%>
<div class="container mt-md-3" style="width: 500px">
    <div class="row g-3">
        <div class="col-md-12 position-relative bg-primary rounded text-center fs-1"
             style="height: 100px; color:white;">
            <span class="position-absolute top-50 start-50 translate-middle">회원가입</span>
        </div>
        <div id="msg">
            <c:if test="${not empty msg}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-emoji-frown" viewBox="0 0 16 16">
                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                        <path d="M4.285 12.433a.5.5 0 0 0 .683-.183A3.498 3.498 0 0 1 8 10.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.498 4.498 0 0 0 8 9.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/>
                    </svg> ${msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>
        <form name="joinForm" class="row g-3" action="<c:url value="/user/join"/>" method="post">
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="id" class="form-label">아이디</label>
                </div>
            </div>
            <div class="col-md-8">
                <input type="text" id="id" name="id" class="form-control">
                <p id="result" class="badge"></p>
            </div>
            <div class="col-md-4">
                <input id="checkBtn" class="btn btn-warning" type="button" value="중복체크" onclick="checkId()"/>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="password" class="form-label">비밀번호</label>
                    <input class="form-control" type="password" id="password" name="password">

                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="rePw" class="form-label">비밀번호 재확인</label>
                    <input class="form-control" type="password" id="rePw" name="rePw">

                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="name" class="form-label">이름</label>
                    <input class="form-control" type="text" id="name" name="name">

                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="year" class="form-label">생년월일</label>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" id="year" name="year" placeholder="년(4자)">
                </div>
                <div class="col-md-4">
                    <select class="form-select" id="month" name="month" aria-label="this is birth2">
                        <option selected>월</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <select class="form-select" id="day" name="day" aria-label="this is day">
                        <option selected>일</option>
                    </select>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="gender" class="form-label">성별</label>
                    <select class="form-select" id="gender" name="gender">
                        <option selected>성별</option>
                        <option value="남자">남자</option>
                        <option value="여자">여자</option>
                    </select>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="email1">이메일</label>
                </div>
                <div class="col-md-12 mt-md-1">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="email" id="email1" name="email1">
                        <span class="input-group-text">@</span>
                        <input type="text" class="form-control" placeholder="ex)naver.com" aria-label="Server"
                               name="email2">
                    </div>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="phone" class="form-label">휴대전화</label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="ex)01011112222">
                </div>
            </div>
            <div class="row mt-md-4">
                <div class="d-grid gap-2">
                    <input type="button" class="btn btn-primary fluid" value="가입하기" onclick="checkForm()"></input>
                </div>
            </div>
        </form>
    </div>
    <%@include file="footer.jsp"%>
    <script>
      var form = document.joinForm;
      var regExpId = /^[a-z0-9]{5,20}$/;
      var regExpPw = /^[a-zA-Z0-9]{4,}$/;
      var regExpName = /^[a-zA-Z가-힣]{2,15}$/;
      var regExpYear = /^[0-9]{4}$/;
      var regExpDay = /^[0-9]{1,2}/;
      var regExpEmail1 = /^[a-zA-Z0-9]([-_]?[a-zA-Z0-9])*$/;
      var regExpEmail2 = /^[0-9a-zA-Z]([-_]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
      var regExpPhone = /^010[0-9]{8}$/;


      $('#month').on('change',function (){
        $('#day').html("<option selected>일</option>");
        var lastDay = new Date(Number(form.year.value),Number(form.month.value),0).getDate();
        for(let i = 1; i <= lastDay; i++){
          let eachDay = ((i) <= 9 ? "0" + (i) : (i));
          $('#day').append("<option value='"+eachDay+"'>"+eachDay+"</option>");
        }
      })

      function checkForm(){
        var current = new Date();
        if(form.id.value === ""){
          alert("아이디를 입력해주세요.");
          form.id.select();
          return;
        }
        else if(!regExpId.test(form.id.value)){
          alert("아이디는 5~20자의 영문 소문자, 숫자만 사용 가능합니다.");
          form.id.select();
          return;
        }
        if(form.password.value===""){
          alert("비밀번호를 입력해주세요.");
          form.password.select();
          return;
        }else if(!regExpPw.test(form.password.value)){
          alert("비밀번호는 4자 이상의 영문 대소문자와 숫자만 사용 가능합니다.");
          form.password.select();
          return;
        }
        if(form.rePw.value !== form.password.value){
          alert("비밀번호가 일치하지 않습니다.");
          form.rePw.select();
          return;
        }
        if(form.name.value === ""){
          alert("이름을 입력해주세요.");
          return;
        }else if(!regExpName.test(form.name.value)){
          alert("이름을 다시 확인해주세요.");
          return;
        }
        if(!regExpYear.test(form.year.value)){
          alert("태어난 년도 4자리를 정확하게 입력하세요.");
          form.year.select();
          return;
        }else if(form.month.value==="월"){
          alert("태어난 월을 선택하세요.");
          return;
        }else if(form.day.value==='일'){
          alert("태어난 일을 선택하세요.");
          return;
        }else if(Number(form.year.value)>current.getFullYear()){
          alert("미래에서 오셨군요.^^");
          form.year.select();
          return;
        }
        if(form.gender.value==="성별"){
          alert("성별을 선택해주세요.");
          return;
        }
        if(form.email1.value===""){
          alert("이메일을 입력해주세요.");
          form.email1.select();
          return;
        }else if(!regExpEmail1.test(form.email1.value)){
          alert("이메일은 영문 대소문자와 하이픈(-), 언더바(_)만 사용가능합니다.");
          form.email1.select();
          return;
        }
        if(form.email2.value===""){
          alert("도메인을 입력해주세요.");
          form.email2.select();
          return;
        }else if(!regExpEmail2.test(form.email2.value)){
          alert("도메인을 다시 확인해주세요.");
          form.email2.select();
          return;
        }
        if(form.phone.value === ""){
          alert("번호를 입력해주세요.");
          form.phone.select();
          return;
        }else if(!regExpPhone.test(form.phone.value)){
          alert("번호를 다시 확인해주세요.");
          form.phone.select();
          return;
        }
        if(!form.id.disabled){
          alert("아이디 중복검사를 진행해주세요.");
          return;
        }
        $('#id').attr('disabled',false);
        form.submit();
      }

      function checkId(){
        if($('#checkBtn').val() === '변경'){
          $('#id').attr('disabled',false);
          $('#id').val("");
          $('#checkBtn').val("중복체크");
          $('#result').text("");
          return;
        }
        var id = $('#id').val();
        if(id === ""){
          alert("아이디를 입력해주세요.");
          form.id.select();
          return;
        }
        else if(!regExpId.test(id)){
          alert("아이디는 5~20자의 영문 소문자, 숫자만 사용 가능합니다.");
          form.id.select();
          return;
        }
        $.ajax({
          type :'post',
          async :false,
          url:'/user/duplicateCheck',
          data:{'id':id},
          success: function (result){
            if(result === "success"){
              $('#result').text("사용가능한 아이디입니다.");
              $('#result').css("color","green");
              $('#id').attr('disabled',true);
              $('#checkBtn').val("변경");
            }else{
              $('#result').text("중복된 아이디입니다.");
              $('#result').css("color","red");
            }
          },
          error:function () {
            console.log('error');
          }
        });
      }
    </script>
</body>
</html>
