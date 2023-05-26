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
    <title>영화관 소개</title>
    <style>
        #quick-menu {
            position: fixed;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
        }
    </style>

</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="justify-content-center">

        <!-- 섹션들 -->
        <div id="section1" class="section text-center">
            <h2><b>영화관 소개</b></h2>
            <div class="justify-content-center">
                <img src="https://www.coex.co.kr/wp-content/uploads/2015/04/%EC%BD%94%EC%97%91%EC%8A%A4%EC%84%BC%ED%84%B0%EC%A0%84%EA%B2%BD_%EC%95%BC%EA%B0%843.jpg"
                     alt="">
            </div>
            <div class="row justify-content-center">
                <div class="col-5 mt-3">
                    <h4><b>DESIGN</b></h4>
                    <ul>
                        <li>섬세하게 디자인된 인테리어와 넓은 개인 공간</li>
                        <li>실용성에 아름다움을 더한 스칸디나비안 리클라이너 시트와 가구세트</li>
                    </ul>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-5 mt-3">
                    <h4><b>DESSCREEN · SOUNDIGN</b></h4>
                    <ul>
                        <li>선명한 화질과 색감의 4K프로젝션 시스템</li>
                        <li>세계 최고 공연장이 선택한 MEYER/JBL 사운드</li>
                    </ul>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="justify-content-center">
                    <img src="https://img.megabox.co.kr/static/pc/images/theater/img-theater-boutique-suite-06.jpg"
                         alt="">
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-5 mt-4">
                    <h3><b>SERVICE</b></h3>
                    <ul>
                        <li>상영관 내 음식 주문이 가능한 룸서비스</li>
                        <li>편안한 관람을 위해 제공되는 스위트 패키지 <br>(프리미엄 웰컴 음료, 무릎담요, 실내용 슬리퍼, 물티슈)</li>
                        <li>와인 콜키지 서비스</li>
                        <li>상영관 좌석까지 안내하는 에스코트 서비스와<br>이용의 편의를 제공하는 컨시어지 서비스</li>
                    </ul>
                </div>
            </div>


            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>

        </div>
        <div id="section2" class="justify-content-center">
            <div class="row justify-content-center">
                <h2><b>시설 안내</b></h2>
                <div>
                    <h2>2023년 아시아 최고의 영화관 선정,<br> 2005년 관객수 6198만으로 월드 레코드 등재<br>
                        VIP 시사회, 제작발표회, 레드 카펫 행사 등 다양한 행사 유치</h2>

                </div>
                <div>
                    <p><b>50년 연속 관객수 9천만 이상인 국내 최대 멀티플렉스 시네마</b>
                </div>
                <div>
                    <i class="fa-solid fa-film fa-2xl"></i>
                    <i class="fa-solid fa-wine-glass fa-2xl"></i>
                    <i class="fa-solid fa-wheelchair-move fa-2xl"></i>
                    <i class="fa-solid fa-couch fa-2xl"></i>
                </div>
            </div>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>

        </div>
        <div id="section3" class="section">
            <div class="row justify-content-center">
                <h1 class="text-center">오시는 길</h1>
                <div class="col-5 col-md-5">
                    <div id="map" style="width:450px;height:400px;"></div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-5 text-center">
                    <p class="mt-5"><b>서울특별시 종로구 우정국로2길 21 (대왕빌딩) 7층</b>
                    <p>[1호선] 종각역 4번출구 50M 직진 대왕빌딩 7층
                    <p>주차장 없음
                </div>

            </div>
            <div class="row justify-content-end">
                <a href="#"><i class="fa-solid fa-up-long fa-2xl"></i></a>
            </div>
        </div>
    </div>
    <!-- 추가적인 섹션들 -->
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

    $(function () {
        $('body').scrollspy({target: '#quick-menu'});
    });

</script>

<jsp:include page="footer.jsp"/>
</body>
</html>
