<%--
  Created by IntelliJ IDEA.
  User: lunat
  Date: 2023-05-15
  Time: 오후 2:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>지도</title>

</head>
<body>
<jsp:include page="WEB-INF/views/header.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-2">
            <div id="list-example" class="list-group">
                <a class="list-group-item list-group-item-action" href="#list-item-1">영화관 소개</a>
                <a class="list-group-item list-group-item-action" href="#list-item-2">Item 2</a>
                <a class="list-group-item list-group-item-action" href="#list-item-3">Item 3</a>
                <a class="list-group-item list-group-item-action" href="#list-item-4">오시는 길</a>
            </div>
        </div>
        <div class="col-8">
            <div data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true"
                 class="scrollspy-example" tabindex="0">
                <h4 class="mt-3" id="list-item-1">영화관 소개</h4>
                <img  src="https://ic.tjoeun.co.kr/upload/campus/2020/2020042215523917332375178.jpg" alt="">
                <h4>Design</h4>
                <ul>
                    <li>섬세하게 디자인된 인테리어와 넓은 개인 공간</li>
                    <li>실용성에 아름다움을 더한 시트와 모니터</li>
                </ul>
                <p>...</p>
                <h4 id="list-item-2">Item 2</h4>
                <p>...</p>
                <h4 id="list-item-3">Item 3</h4>
                <p>...</p>
                <h4 id="list-item-4">오시는 길</h4>
                <div class="row">
                    <div class="col-6">
                        <div id="map" style="width:450px;height:400px;"></div>
                    </div>
                    <div class="col-6 text-center">
                        <p class="mt-5"><b>서울특별시 종로구 우정국로2길 21 (대왕빌딩) 7층</b>
                        <p>[1호선] 종각역 4번출구 50M 직진 대왕빌딩 7층
                        <p>Tel. 02-738-5001Fax.02-738-5002
                    </div>
                </div>
                <p>...</p>
            </div>
        </div>
    </div>

</div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9effe4977e3b2a28efa37623c5e71f48"></script>
<script>
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(37.569732, 126.984269), //지도의 중심좌표.
        level: 2 //지도의 레벨(확대, 축소 정도)
    };

    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

    var marker = new kakao.maps.Marker();

    // 타일 로드가 완료되면 지도 중심에 마커를 표시합니다
    // 마커가 표시될 위치입니다
    var markerPosition = new kakao.maps.LatLng(37.569732, 126.984269);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
    var mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
    // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

    // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
    var zoomControl = new kakao.maps.ZoomControl();
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    $(document).ready(function(){
        var currentPosition = parseInt($(".quickmenu").css("top"));
        $(window).scroll(function() {
            var position = $(window).scrollTop();
            $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
        });
    });
</script>

<jsp:include page="WEB-INF/views/footer.jsp"/>
</body>
</html>
