<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-19
  Time: 오후 3:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원관리</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container mt-5">
    <div class="row ">
        <div class="col-6 d-flex justify-content-end">
            <input type="text" id="inputId" placeholder="아이디로 검색하세요">
            <button type="button" id="idViewBtn">회원정보 아이디로 찾기</button>
        </div>
        <div class="col-6">
            <button type="button" id="userAllBtn">회원정보 다보기</button>
        </div>
    </div>
</div>
<div class="mt-5">
    <div class="row ">
        <div id="id" class="col-1">
            아이딩
        </div>
        <div id="password" class="col-1">
            패스워드
        </div>
        <div id="name" class="col-1">
            이름
        </div>
        <div id="birth" class="col-1">
            생일
        </div>
        <div id="gender" class="col-1">
            성별
        </div>
        <div id="email" class="col-1">
            이메일
        </div>
        <div id="phone" class="col-1">
            폰넘버
        </div>
        <div id="rank" class="col-1">
            등급
        </div>
        <div id="reg_day" class="col-1">
            등록시간
        </div>
    </div>
</div>

<div class="mt-5" id="userInfo">
    <!-- 안에 REST API 에서 받아 온 고객 리스트가 들어감 -->
</div>
<%@include file="/WEB-INF/views/footer.jsp" %>

<script>
  $('#userAllBtn').on('click', function () {
    $('#userInfo').html("");
    $.ajax({
      url: "/users",
      type: "get",
      dataType: "json",
      success: function (json) {
        for (var i = 0; i < json.length; i++) {
          const time = new Date(json[i].reg_day);
          const format = time.toLocaleTimeString('ko-KR',{year:'numeric',month:'long',day:'numeric'})
          let trElem =
              `
            <div class="row">
            <div id="id" class="col-1">
                \${json[i].id}
            </div>
            <div id="password" class="col-1">
                \${json[i].password}
            </div>
            <div id="name" class="col-1">
                \${json[i].name}
            </div>
            <div id="birth" class="col-1">
                \${json[i].birth}
            </div>
            <div id="gender" class="col-1">
                \${json[i].gender}
            </div>
            <div id="email" class="col-1">
                \${json[i].email}
            </div>
            <div id="phone" class="col-1">
                \${json[i].phone}
            </div>
            <div id="rank" class="col-1">
                \${json[i].rank}
            </div>
            <div id="reg_day" class="col-1">
                \${format}
            </div>
            <button type="button" id="id\${i}}" onclick="deleteUser('\${json[i].id}')" class="col-3">
              회원삭제\${json[i].id}
              </button>
        </div>`;
          $('#userInfo').append(trElem);
        }
      }
    })
  })

  function deleteUser(id){
    var choice = confirm('삭제할래?');
    if(choice){
    $.ajax({
      url:'/users/'+id,
      type: 'delete',
      dataType:'json',
      success:function (){
        alert("회원삭제 성공 해부럿다")
        location.reload()
      },
      error:function (msg){
        alert(msg.responseText)
      }
    })
    }else{
      alert('잘생각함')
    }
  }

  //아이디로 찾기
  $('#idViewBtn').on('click',function (){
    $('#userInfo').html('');
    var inputId = $('#inputId').val();
    $.ajax({
      url:'/users/'+inputId,
      type: 'get',
      dataType:'json',
      success:function (json){
        const time = new Date(json.reg_day);
        const format = time.toLocaleTimeString('ko-KR',{year:'numeric',month:'long',day:'numeric'})
        let trElem =
            `
            <div class="row">
            <div id="id" class="col-1">
                \${json.id}
            </div>
            <div id="password" class="col-1">
                \${json.password}
            </div>
            <div id="name" class="col-1">
                \${json.name}
            </div>
            <div id="birth" class="col-1">
                \${json.birth}
            </div>
            <div id="gender" class="col-1">
                \${json.gender}
            </div>
            <div id="email" class="col-1">
                \${json.email}
            </div>
            <div id="phone" class="col-1">
                \${json.phone}
            </div>
            <div id="rank" class="col-1">
                \${json.rank}
            </div>
            <div id="reg_day" class="col-1">
                \${format}
            </div>
            <button type="button" id="i" onclick="deleteUser('\${json.id}')" class="col-3">
            회원삭제
              </button>
        </div>`;
        $('#userInfo').append(trElem);
      },
      error:function(error,status,msg){
        alert("상태코드 " + status + "에러메시지" + msg );
      }
    })
  })
</script>

</body>
</html>
