<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI - 식당 정보</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/home.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar.js" />"></script>
    <script>

        window.onload = () => {
            initTopbarEvents();
            initReviewEvents();
        }

        const initReviewEvents = () => {

            let $ReviewWrite = document.getElementById("REVIEW-WRITE");
            let $ReviewInterface = document.querySelector(".Review-Interface");

            $ReviewWrite.addEventListener("click", () => {
                $ReviewInterface.classList.toggle("--Review-Interface-Fold");
            })

        }

    </script>
    <style>
        .Store-Box {
            box-sizing: border-box;
            padding: 40px;
            background-color: white;
            min-height: calc(100vh - 70px);
        }

        .Info-Box {
            height: auto;
            display: grid;
            column-gap: 40px;
            grid-template-columns: 6.5fr 3.5fr;
        }

        .Info-Box-Left {
            border-radius: 4px;
            overflow: hidden;
        }

        .Info-Box-Title-Row {
            display: grid;
            grid-template-columns: 45px 1fr auto auto;
            border-bottom: 1px solid #7c4dff;
            column-gap: 20px;
            height: 45px;
            margin-bottom: 20px;
        }

        .Title-Icon-Box {
            background-color: #7c4dff;
            color: white;
        }

        .Title-Text {
            font-size: 22px;
            margin-bottom: 3px;
            font-weight: 400;
        }

        .Badge {
            display: grid;
            grid-template-columns: auto auto;
            column-gap: 10px;
            padding: 5px 10px;
            border-radius: 14px;
            height: 28px;
            background-color: hsl(264, 45%, 94%);
            color: #272c34;
        }

        .Badge-Icon {
            border-right: 2px solid #272c34;
            padding-right: 7px;
            margin-top: 1px;
        }

        .Icon-Phone {
            transform: rotate(128deg);
        }

        .Icon-Delivery {
            font-size: 18px;
        }

        .Badge-Value {

        }

        .Info-Box-Body-Row {
            display: grid;
            grid-template-columns: 1fr;
        }

        .Body-Image-Box {
            text-align: center;
        }

        .Body-Image-Box img {
            width: 80%;
            object-fit: fill;
            box-shadow: 0px 2px 4px #ccc;
        }

        .Body-Content-Box {
            padding: 20px 0;
        }

        .Content-Category {
            display: grid;
            grid-template-columns: 1fr auto;
            height: 45px;
            border-bottom: 1px solid #ccc;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .Category-Title {
            display: flex;
            align-items: center;
            justify-content: flex-start;
        }

        .Pref-Row {
            display: grid;
            grid-template-columns: 45px 1fr;
            margin-bottom: 20px;
        }

        .Pref-Category {
            font-weight: 300;
        }

        .Pref-Gauge {
            display: grid;
            border-radius: 4px;
            overflow: hidden;
            background-color: #eee;
            width: 90%;
            height: 10px;
        }

        .Pref-Gauge-Value {
            background-color: #FFF176;
        }

        .Content-Body {
            padding: 20px;
        }

        .Content-Body-Text {
            margin: 0;
            font-weight: 300;
            font-size: 16px;

        }

        .Google-Map-Container {
            height: 400px;
            border-radius: 4px;
            overflow: hidden;
            margin: 20px 0;
        }

        .Review-Write-Text {
            font-weight: 300;
            font-size: 16px;
            color: #424242;
            cursor: pointer;
        }

        .Review-Write-Text:hover {
            text-decoration: underline;
        }

        .Review-Row {
            padding: 10px 0 10px 20px;
            display: grid;
            grid-template-columns: 45px 1fr;
            column-gap: 20px;
            margin-bottom: 5px;
        }

        .Review-Header {
            display: grid;
            grid-template-columns: auto 1fr;
            column-gap: 20px;
            margin-bottom: 5px;
        }

        .Review-Pref {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            font-weight: 300;
            font-size: 14px;
        }

        .Heart-Icon {
            color: #FF5252;
            margin-right: 3px;
            margin-top: 1px;
        }

        .Review-Nickname {
            font-weight: 400;
            font-size: 16px;
        }

        .Review-Member-Image {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            overflow: hidden;
        }

        .Review-Member-Image img {
            width: 100%;
            height: 100%;
            object-fit: fill;
        }

        .Review-Content-Text {
            margin: 0;
            font-weight: 300;
            font-size: 14px;
        }

        .Review-Interface {
            padding: 10px 0 10px 20px;
            display: grid;
            max-height: 80px;
            grid-template-columns: 1fr auto;
            column-gap: 20px;
            transition: max-height 0.3s ease;
            overflow: hidden;
        }

        .--Review-Interface-Fold {
            max-height: 0;
        }

        .Review-Interface input {
            border: none;
            outline: none;
            border-bottom: 2px solid #272c34;
            height: 40px;
            padding-left: 10px;
        }

        .Review-Interface button {
            border: none;
            outline: none;
            font-weight: 300;
            cursor: pointer;
        }

        .Review-Interface button:hover {
            font-weight: 500;
        }

    </style>
</head>
<body>

<c:import url="component/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
</c:import>

<div class="Store-Box">

    <div class="Info-Box">
        <div class="Info-Box-Item Info-Box-Left">
            <div class="Info-Box-Title-Row">
                <div class="--D-Flex-Center Title-Icon-Box">
                    <i class="fas fa-utensils fa-1x"></i>
                </div>
                <div class="--D-Flex --Align-Items-Center --Justify-Flex-Start">
                    <span class="Title-Text">봉구스 밥버거</span>
                </div>
                <div class="--D-Flex-Center">
                    <div class="Badge">
                        <div class="Badge-Icon">
                            <i class="fas fa-motorcycle Icon-Delivery"></i>
                        </div>
                        <div class="Badge-Value">
                            <span>O</span>
                        </div>
                    </div>
                </div>
                <div class="--D-Flex-Center">
                    <div class="Badge">
                        <div class="Badge-Icon">
                            <i class="fas fa-phone Icon-Phone"></i>
                        </div>
                        <div class="Badge-Value">
                            <span>010-3455-1209</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="Info-Box-Body-Row">
                <div class="Body-Image-Box">
                    <img src="<c:url value="/resources/images/bongus.jpeg" />" alt="">
                </div>
                <div class="Body-Content-Box">
                    <div>
                        <div class="Content-Category">
                            <div class="Category-Title">
                                <span>짧은 한마디</span>
                            </div>
                            <div>

                            </div>
                        </div>
                        <div class="Content-Body">
                            <p class="Content-Body-Text">고소하고 단짠단짠한 밥버거를 맛볼 수 있는 곳.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="Info-Box-Item Info-Box-Right">
            <div class="Content-Category">
                <div class="Category-Title">
                    <span>위치</span>
                </div>
            </div>
            <div id="map" class="Google-Map-Container">

            </div>
            <script>
                let map;

                function initMap() {
                    map = new google.maps.Map(document.getElementById('map'), {
                        center: {lat: 37.301898, lng: 126.840894},
                        zoom: 15
                    });
                }
            </script>
            <script async defer
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJOLhG5j0iE_NuSx9-9DJbmL2KHa_bb-0&callback=initMap">
            </script>
            <div>
                <div class="Content-Category">
                    <div class="Category-Title">
                        <span>선호도</span>
                    </div>
                </div>
                <div class="Content-Body">
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">5.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: 13% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">4.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: 13% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">3.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: 13% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">2.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: 13% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">1.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: 13% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="Community-Box">
        <div class="Content-Category">
            <div class="Category-Title">
                <span>후기</span>
            </div>
            <div class="--D-Flex-Center">
                <span id="REVIEW-WRITE" class="Review-Write-Text">후기 남기기</span>
            </div>
        </div>

        <div class="Review-Interface">
            <input placeholder="이용 후기..." type="text">
            <button class="Review-Send-Button">작성 완료</button>
        </div>

        <div class="Review-Row">
            <div class="Review-Member-Image">
                <img src="/resources/userImages/f9baacf0-695f-4e71-9259-932f09fd6968.jpeg" alt="">
            </div>
            <div>
                <div class="Review-Header">
                    <div class="--D-Flex-Center">
                        <span class="Review-Nickname">
                            HSJPRIME
                        </span>
                    </div>
                    <div class="Review-Pref">
                        <i class="fas fa-heart Heart-Icon"></i>
                        13
                    </div>
                </div>
                <div class="Review-Content">
                    <p class="Review-Content-Text">밥버거의 진리는 역시 스팸밥버거임.</p>
                </div>
            </div>
        </div>
        <div class="Review-Row">
            <div class="Review-Member-Image">
                <img src="/resources/userImages/f9baacf0-695f-4e71-9259-932f09fd6968.jpeg" alt="">
            </div>
            <div>
                <div class="Review-Header">
                    <div class="--D-Flex-Center">
                        <span class="Review-Nickname">
                            HSJPRIME
                        </span>
                    </div>
                    <div class="Review-Pref">
                        <i class="fas fa-heart Heart-Icon"></i>
                        13
                    </div>
                </div>
                <div class="Review-Content">
                    <p class="Review-Content-Text">밥버거의 진리는 역시 스팸밥버거임.</p>
                </div>
            </div>
        </div>
        <div class="Review-Row">
            <div class="Review-Member-Image">
                <img src="/resources/userImages/f9baacf0-695f-4e71-9259-932f09fd6968.jpeg" alt="">
            </div>
            <div>
                <div class="Review-Header">
                    <div class="--D-Flex-Center">
                        <span class="Review-Nickname">
                            HSJPRIME
                        </span>
                    </div>
                    <div class="Review-Pref">
                        <i class="fas fa-heart Heart-Icon"></i>
                        13
                    </div>
                </div>
                <div class="Review-Content">
                    <p class="Review-Content-Text">밥버거의 진리는 역시 스팸밥버거임.</p>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>
