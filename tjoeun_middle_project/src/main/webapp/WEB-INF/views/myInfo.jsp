<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-04-11
  Time: 오후 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>내 정보</title>
</head>
<body>
<c:set var="user" value="${sessionScope.userDto}"/>
<c:set var="birth" value="${fn:split(user.birth,'-')}"/>
<c:set var="email" value="${fn:split(user.email,'@')}"/>

<jsp:include page="header.jsp"/>
<div class="container mt-md-3" style="width: 500px">
    <div class="row g-3">
        <div class="col-md-12 position-relative bg-primary rounded text-center fs-1"
             style="height: 100px; color:white;">
            <span class="position-absolute top-50 start-50 translate-middle">내 정보</span>
        </div>
        <div id="msg">
            <c:if test="${not empty msg}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>
        <form name="infoForm" class="row g-3" action="<c:url value="/info/edit"/>" method="post">
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="id" class="form-label">아이디</label>
                    <input type="text" id="id" name="id" class="form-control" value="${user.id}" disabled>
                    <p id="result" class="badge"></p>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="passwd" class="form-label">비밀번호</label>
                    <input class="form-control" type="password" id="passwd" name="passwd" value="${user.passwd}" disabled>

                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="name" class="form-label">이름</label>
                    <input class="form-control" type="text" id="name" name="name" value="${user.name}" disabled>

                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="year" class="form-label">생년월일</label>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" id="year" name="year" value="${birth[0]}" disabled>
                </div>
                <div class="col-md-4">
                    <select class="form-select" id="month" name="month" aria-label="this is birth2" disabled>
                        <option>월</option>
                        <c:forEach var="i" begin="1" end="12">
                            <c:if test="${i eq birth[1]}">
                                <option value="${i}" selected>${i}</option>
                            </c:if>
                            <c:if test="${i ne birth[1]}">
                                <option value="${i}">${i}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="day" name="day" aria-label="this is birth3"
                           value="${birth[2]}" disabled>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="sex" class="form-label">성별</label>
                    <select class="form-select" id="sex" name="sex" disabled>
                        <option>성별</option>
                        <option value="남자" ${user.gender eq "남자" ? "selected":""}>남자</option>
                        <option value="여자" ${user.gender eq "여자" ? "selected":""}>여자</option>
                    </select>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="email1">이메일</label>
                </div>
                <div class="col-md-12 mt-md-1">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="email" id="email1" name="email1"
                               value="${email[0]}" disabled>
                        <span class="input-group-text">@</span>
                        <input type="text" class="form-control" placeholder="ex)naver.com" aria-label="Server"
                               name="email2" id="email2" value="${email[1]}" disabled>
                    </div>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="phone" class="form-label">휴대전화</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}"
                           disabled>
                </div>
            </div>
            <div class="row mt-md-3">
                <div class="col-md-12">
                    <label for="address" class="form-label">주소</label>
                    <input type="text" class="form-control" id="address" name="address" value="${user.address}"
                           disabled>
                </div>
            </div>
            <div class="row mt-md-4 text-center">
                <div class="col-md-4">
                    <input type="button" class="btn btn-primary fluid" value="수정하기" id="editBtn">
                </div>
                <div class="col-md-4">
                    <input type="button" class="btn btn-primary fluid" value="확인" id="editOkBtn" onclick="checkForm()" hidden>
                </div>
                <div class="col-md-4">
                    <input type="button" class="btn btn-primary fluid" value="취소" id="cancelBtn" hidden>
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        function checkForm() {
            var form = document.infoForm;
            var regExpPw = /^[a-zA-Z0-9]{4,}$/;
            var regExpName = /^[가-힣]{2,4}$/;
            var regExpYear = /^[0-9]{4}$/;
            var regExpDay = /^[0-9]{1,2}/;
            var regExpEmail1 = /^[a-zA-Z0-9]([-_]?[a-zA-Z0-9])*$/;
            var regExpEmail2 = /^[0-9a-zA-Z]([-_]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
            var regExpPhone = /^010[0-9]{8}$/;
            var current = new Date();

            if (form.passwd.value === "") {
                alert("비밀번호를 입력해주세요.");
                form.passwd.select();
                return;
            } else if (!regExpPw.test(form.passwd.value)) {
                alert("비밀번호는 4자 이상의 영문 대소문자와 숫자만 사용 가능합니다.");
                form.passwd.select();
                return;
            }
            if (form.name.value === "") {
                alert("이름을 입력해주세요.");
                return;
            } else if (!regExpName.test(form.name.value)) {
                alert("이름은 2~4자 사이의 한글만 입력해주세요.");
                return;
            }
            if (!regExpYear.test(form.year.value)) {
                alert("태어난 년도 4자리를 정확하게 입력하세요.");
                form.year.select();
                return;
            } else if (form.month.value === "월") {
                alert("태어난 월을 선택하세요.");
                return;
            } else if (!regExpDay.test(form.day.value)) {
                alert("일(날짜)를 다시 확인해주세요.");
                form.day.select();
                return;
            } else if (Number(form.year.value) > current.getFullYear()) {
                alert("미래에서 오셨군요.^^");
                form.year.select();
                return;
            }
            var lastDay = new Date(Number(form.year.value), Number(form.month.value), 0).getDate();
            if (Number(form.day.value) > lastDay) {
                alert("일(날짜)를 다시 확인해주세요.");
                form.day.select();
                return;
            }
            if (form.sex.value === "성별") {
                alert("성별을 선택해주세요.");
                return;
            }
            if (form.email1.value === "") {
                alert("이메일을 입력해주세요.");
                form.email1.select();
                return;
            } else if (!regExpEmail1.test(form.email1.value)) {
                alert("이메일은 영문 대소문자와 하이픈(-), 언더바(_)만 사용가능합니다.");
                form.email1.select();
                return;
            }
            if (form.email2.value === "") {
                alert("도메인을 입력해주세요.");
                form.email2.select();
                return;
            } else if (!regExpEmail2.test(form.email2.value)) {
                alert("도메인을 다시 확인해주세요.");
                form.email2.select();
                return;
            }
            if (form.phone.value === "") {
                alert("번호를 입력해주세요.");
                form.phone.select();
                return;
            } else if (!regExpPhone.test(form.phone.value)) {
                alert("번호를 다시 확인해주세요.");
                form.phone.select();
                return;
            }
            $('#id').attr("disabled",false);
            form.submit();
        }


        $('#editBtn').on('click', function () {
            $('#passwd').attr('disabled', false);
            $('#name').attr('disabled', false);
            $('#year').attr('disabled', false);
            $('#month').attr('disabled', false);
            $('#day').attr('disabled', false);
            $('#sex').attr('disabled', false);
            $('#email1').attr('disabled', false);
            $('#email2').attr('disabled', false);
            $('#phone').attr('disabled', false);
            $('#address').attr('disabled', false);
            $('#editBtn').attr('hidden',true);
            $('#cancelBtn').attr('hidden', false);
            $('#editOkBtn').attr('hidden', false);
        })

        $('#cancelBtn').on('click', function () {
            location.href = "myInfo.jsp";
        })


    </script>
</body>
</html>
