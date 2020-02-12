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
    <link rel="stylesheet" href="<c:url value="/resources/css/store.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar.js" />"></script>
    <script>

        window.onload = () => {
            initTopbarEvents();
            initReviewEvents();
        };

        const initReviewEvents = () => {

            let $ReviewWrite = document.getElementById("REVIEW-WRITE");
            let $ReviewInterface = document.querySelector(".Review-Interface");

            let $MenuShow = document.getElementById("MENU-SHOW");
            let $MenuList = document.querySelector(".Menu-List");
            $MenuList.style.maxHeight = $MenuList.scrollHeight + "px";

            let $PrefPost = document.getElementById("PREF-POST");
            let $PrefPostBox = document.querySelector(".Pref-Post-Box");

            toggleBoxHeight($ReviewWrite, $ReviewInterface);
            toggleBoxHeight($MenuShow, $MenuList);
            toggleBoxHeight($PrefPost, $PrefPostBox);

            let $PostPrefInputs = document.querySelectorAll(".Pref-Radio-Item label input");
            for (let index = 0; index < $PostPrefInputs.length; index++){
                $PostPrefInputs.item(index).addEventListener("click", (event) => {
                    event.stopPropagation();
                    postStorePreference(event.target.value);
                })
            }

        };

        const toggleBoxHeight = ($Controller, $Box) => {

            $Controller.addEventListener("click", () => {
                $Box.classList.toggle("--Interface-Fold");
            })

        };

        const postStorePreference = (prefValue) => {

            fetch("/eiki/store/preference",{
                method : "POST",
                headers : {
                    "Content-Type" : "application/json; charset=utf-8"
                },
                body : JSON.stringify({
                    STORE_DEC_IDX : <c:out value="${StoreInfo['STORE_DEC_IDX']}" />,
                    MEMBER_DEC_IDX : <c:out value="${User['MEMBER_DEC_IDX']}" />,
                    PREFERENCE : parseInt(prefValue)
                })
            }).then(async response => {
                if((await response.json()).success === 1){
                    window.location.href = "/eiki/store/<c:out value="${StoreInfo['STORE_DEC_IDX']}" />";
                }
            }).catch(error => {
                console.log(error)
            })

        };

    </script>

</head>
<body>

<c:import url="component/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
    <c:param name="IS_ADMIN" value="${User.IS_ADMIN}"/>
</c:import>

<div class="Store-Box">

    <div class="Info-Box">
        <div class="Info-Box-Item Info-Box-Left">
            <div class="Info-Box-Title-Row">
                <div class="--D-Flex-Center Title-Icon-Box">
                    <i class="fas fa-utensils fa-1x"></i>
                </div>
                <div class="--D-Flex --Align-Items-Center --Justify-Flex-Start">
                    <span class="Title-Text">${StoreInfo['STORE_NAME']}</span>
                </div>
                <div class="--D-Flex-Center">
                    <div class="Badge">
                        <div class="Badge-Icon">
                            <i class="fas fa-motorcycle Icon-Delivery"></i>
                        </div>
                        <div class="Badge-Value">
                            <c:choose>
                                <c:when test="${StoreInfo['IS_DELIVERY'] == true}">
                                    <span>O</span>
                                </c:when>
                                <c:when test="${StoreInfo['IS_DELIVERY'] == false}">
                                    <span>X</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="--D-Flex-Center">
                    <div class="Badge">
                        <div class="Badge-Icon">
                            <i class="fas fa-phone Icon-Phone"></i>
                        </div>
                        <div class="Badge-Value">
                            <span>${StoreInfo['STORE_CALL']}</span>
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
                            <p class="Content-Body-Text">${StoreInfo['STORE_DESCRIPTION']}</p>
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
                let storePoint = {lat: <c:out value="${StoreInfo['STORE_LATITUDE']}" />, lng: <c:out value="${StoreInfo['STORE_LONGITUDE']}" />};
                function initMap() {
                    map = new google.maps.Map(document.getElementById('map'), {
                        center: storePoint,
                        zoom: 4
                    });
                    let storeMarker = new google.maps.Marker({
                        position: storePoint,
                        draggable: false,
                        animation: google.maps.Animation.BOUNCE,
                        map: map});
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
                    <div class="--D-Flex-Center">
                        <span id="PREF-POST" class="Review-Write-Text">선호도 선택</span>
                    </div>
                </div>
                <div class="Content-Body">
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">5.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_FIVE_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">4.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_FOUR_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">3.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_THREE_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">2.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_TWO_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">1.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_ONE_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Post-Box --Interface-Fold">
                        <div class="Pref-Radio-Row">
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>1.0</span>
                                    <input value="1" name="STORE_PREFERENCE" type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>2.0</span>
                                    <input value="2" name="STORE_PREFERENCE" type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>3.0</span>
                                    <input value="3" name="STORE_PREFERENCE" type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>4.0</span>
                                    <input value="4" name="STORE_PREFERENCE" type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>5.0</span>
                                    <input value="5" name="STORE_PREFERENCE" type="radio">
                                </label>
                            </div>
                        </div>
                        <div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="Menu-Box">
        <div class="Content-Category">
            <div class="Category-Title">
                <span>메뉴 리스트</span>
            </div>
            <div class="--D-Flex-Center">
                <span id="MENU-SHOW" class="Review-Write-Text">메뉴 보기</span>
            </div>
        </div>
        <div class="Menu-List --Interface-Fold">
            <c:forEach items="${StoreMenus}" var="StoreMenu">
                <div class="Menu-List-Item">
                    <div>
                        <span class="Menu-Name-Text">${StoreMenu["MENU_NAME"]}</span>
                    </div>
                    <div>
                        <span class="Menu-Price-Text">${StoreMenu["MENU_PRICE"]}</span>
                    </div>
                </div>
            </c:forEach>
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

        <div class="Review-Interface --Interface-Fold">
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
