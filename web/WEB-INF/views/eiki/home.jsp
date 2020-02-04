<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 홈</title>
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
            initBodyEvents();

        };

        const initBodyEvents = () => {

            let $OrderPref = document.getElementById("ORDER-PREF");
            let $OrderComment = document.getElementById("ORDER-COMMENT");
            let $OrderName = document.getElementById("ORDER-NAME");
            let $SearchInput = document.getElementById("SEARCH-INPUT");

            if (!QUERY_OBJ.order) {
                $OrderPref.classList.add("--Sort-Btn-Active");
            } else {

                switch (QUERY_OBJ.order) {
                    case "pref" :
                        $OrderPref.classList.add("--Sort-Btn-Active");
                        break;
                    case "comment" :
                        $OrderComment.classList.add("--Sort-Btn-Active");
                        break;
                    case "name" :
                        $OrderName.classList.add("--Sort-Btn-Active");
                        break;
                    default :
                        $OrderPref.classList.add("--Sort-Btn-Active");
                        break;
                }
            }

            $OrderPref.addEventListener("click", () => {
                requestWithQuery($SearchInput.value, "pref");
            });

            $OrderComment.addEventListener("click", () => {
                requestWithQuery($SearchInput.value, "comment");
            });

            $OrderName.addEventListener("click", () => {
                requestWithQuery($SearchInput.value, "name");
            });

        };

    </script>
</head>
<body>

<c:import url="component/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
</c:import>

<div class="Store-List-Box">
    <div class="Sort-Box">
        <button id="ORDER-PREF" class="Sort-Btn">선호도</button>
        <button id="ORDER-COMMENT" class="Sort-Btn">댓글</button>
        <button id="ORDER-NAME" class="Sort-Btn">이름</button>
    </div>

    <div class="Card-Box">
        <a class="--No-Link-Style" href="">
            <div class="Store-Card">
                <div class="Store-Card-Body">
                    <div class="Store-Type">
                        <i class="fas fa-utensils fa-1x"></i>
                    </div>
                    <img src="<c:url value="/resources/images/bongus.jpeg" />" alt="">
                </div>
                <div class="Store-Card-Title">
                    <span class="Store-Name-Text">봉구스 밥버거</span>
                </div>
                <div class="Store-Card-Bottom">
                </div>
            </div>
        </a>
    </div>


</div>

</body>
</html>
