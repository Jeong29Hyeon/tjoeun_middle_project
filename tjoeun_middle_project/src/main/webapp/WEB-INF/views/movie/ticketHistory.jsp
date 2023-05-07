<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-04
  Time: 오후 2:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>예약내역 확인</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container mt-5">
    <h1 style="text-align: center">나의 예매 내역</h1>
</div>
<ul class="nav nav-tabs justify-content-center mt-4" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="pastTicket-tab" data-bs-toggle="tab" data-bs-target="#pastTicket" type="button"
                role="tab" aria-controls="pastTicket" aria-selected="false">과거 관람 내역
        </button>
    </li>
    <li class="nav-item active" role="presentation">
        <button class="nav-link active" id="currentTicket-tab" data-bs-toggle="tab" data-bs-target="#currentTicket"
                type="button" role="tab" aria-controls="currentTicket" aria-selected="true">당일 관람 내역
        </button>
    </li>

    <li class="nav-item" role="presentation">
        <button class="nav-link" id="futureTicket-tab" data-bs-toggle="tab" data-bs-target="#futureTicket" type="button"
                role="tab" aria-controls="futureTicket" aria-selected="false">관람 예정 내역
        </button>
    </li>
</ul>
<div class="container tab-content justify-content-center" id="ticket">
    <div class="container tab-pane fade  text-center" id="pastTicket" role="tabpanel" aria-labelledby="pastTicket-tab">
        <div class="container mt-5">
            <div class="row">
                <c:forEach var="past" items="${pastTicketList}">
                    <div class="col-4">
                        <div class="card text-black bg-light mb-3 mt-3" style=" max-width: 18rem;">
                            <div class="card-header">예약 정보</div>
                            <div class="card-body">
                                <h5 class="card-title">${past.titleInfo}</h5>
                                <hr>
                                <p class="card-text">
                                <div class="row">
                                    <div class="col-6">예약자성함</div>
                                    <div class="col-6">${sessionScope.user.name}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영관</div>
                                    <div class="col-6">${past.hallInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영날짜</div>
                                    <div class="col-6">${past.dayInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영시간</div>
                                    <div class="col-6"> ${past.timeInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">좌석</div>
                                    <div class="col-6 mb-3"> ${past.seats}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="container tab-pane fade show active text-center" id="currentTicket" role="tabpanel"
         aria-labelledby="currentTicket-tab"><p>
        <div class="container mt-5">
            <div class="row">
                <c:forEach var="current" items="${currentTicketList}">
                    <div class="col-4">
                        <div class="card text-black bg-info mb-3 mt-3" style=" max-width: 18rem;">
                            <div class="card-header">예약 정보</div>
                            <div class="card-body">
                                <h5 class="card-title">${current.titleInfo}</h5>
                                <hr>
                                <p class="card-text">
                                <div class="row">
                                    <div class="col-6">예약자성함</div>
                                    <div class="col-6">${sessionScope.user.name}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영관</div>
                                    <div class="col-6">${current.hallInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영날짜</div>
                                    <div class="col-6">${current.dayInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영시간</div>
                                    <div class="col-6"> ${current.timeInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">좌석</div>
                                    <div class="col-6 mb-3"> ${current.seats}</div>
                                </div>
                                <div class="container">
                                    <input type="hidden" name="currentTno" id="currentTno" value="${current.tno}">
                                    <div class="row">
                                        <div class="col-6">
                                            <button class="btn btn-outline-light" style="color: black">예약변경</button>
                                        </div>
                                        <div class="col-6">
                                            <button id="deleteBtn${current.tno}" type="button"
                                                    class="btn btn-outline-light"
                                                    style="color: black"
                                            >예약취소
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="container tab-pane fade  text-center" id="futureTicket" role="tabpanel"
         aria-labelledby="futureTicket-tab">
        <p>
        <div class="container mt-5">
            <div class="row">
                <c:forEach var="future" items="${futureTicketList}">
                    <div class="col-4">
                        <div class="card text-black bg-info mb-3 mt-3" style=" max-width: 18rem;">
                            <div class="card-header">예약 정보</div>
                            <div class="card-body">
                                <h5 class="card-title">${future.titleInfo}</h5>
                                <hr>
                                <p class="card-text">
                                <div class="row">
                                    <div class="col-6">예약자성함</div>
                                    <div class="col-6">${sessionScope.user.name}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영관</div>
                                    <div class="col-6">${future.hallInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영날짜</div>
                                    <div class="col-6">${future.dayInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">상영시간</div>
                                    <div class="col-6"> ${future.timeInfo}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">좌석</div>
                                    <div class="col-6 mb-3"> ${future.seats}</div>
                                </div>
                                <div class="container">
                                    <input type="hidden" name="futureTno" id="futureTno" value="${future.tno}">
                                    <div class="row">
                                        <div class="col-6">
                                            <button class="btn btn-outline-light" style="color: black">예약변경</button>
                                        </div>
                                        <div class="col-6">
                                            <button class="btn btn-outline-light" id="deleteF${future.tno}"
                                                    style="color: black">예약취소
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/views/footer.jsp" %>
<script>
    <c:forEach var="current" items="${currentTicketList}">
    $('#deleteBtn${current.tno}').on('click', function () {
        var choice = confirm('예약 취소시 되돌림이 불가능 합니다. 삭제하시겠습니까?')
        if (!choice) {
            alert('취소진행이 취소되었습니다.')
            return
        }
        $.ajax({
            url: '/deleteTicket',
            type: 'POST',
            data: {
                'tno': $('#currentTno').val()
            },
            success: function (result) {
                if (result === 'success') {
                    alert('예매내역이 정상적으로 취소되었습니다.')
                    location.reload()
                } else {
                    alert("예매내역시간이 가까워 삭제 하지 못했습니다. 고객센터로 문의주세요.");
                    location.reload();
                }
            },
            error: function () {
                alert("통신에러");
            }
        })
    })
    </c:forEach>

    <c:forEach var="future" items="${futureTicketList}">
    $('#deleteF${future.tno}').on('click', function () {
        var choice = confirm('예약 취소시 되돌림이 불가능 합니다. 삭제하시겠습니까?')
        if (!choice) {
            alert('취소진행이 취소되었습니다.')
            return
        }
        $.ajax({
            url: '/deleteTicket',
            type: 'POST',
            data: {
                'tno': $('#futureTno').val()
            },
            success: function (result) {
                if (result === 'success') {
                    alert('예매내역이 정상적으로 취소되었습니다.')
                    location.reload()
                } else {
                    alert("예매내역시간이 가까워 삭제 하지 못했습니다. 고객센터로 문의주세요.");
                    location.reload();
                }
            },
            error: function () {
                alert("통신에러");
            }
        })
    })
    </c:forEach>
</script>
</body>
</html>
