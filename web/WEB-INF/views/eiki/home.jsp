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
    <script src="<c:url value="/resources/js/home.js" />"></script>
</head>
<body>

<c:import url="common/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_DEC_IDX" value="${User.MEMBER_DEC_IDX}"/>
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
    <c:param name="IS_ADMIN" value="${User.IS_ADMIN}"/>
</c:import>

<div class="Store-List-Box">

    <div class="Sort-Box">
        <button id="ORDER-PREF" class="Sort-Btn">선호도순</button>
        <button id="ORDER-COMMENT" class="Sort-Btn">댓글순</button>
        <button id="ORDER-NAME" class="Sort-Btn">이름순</button>
    </div>

    <div class="Card-Box">
        <c:forEach items="${StoreList}" var="StoreItem">
            <a class="--No-Link-Style" href=<c:url value="/eiki/store/${StoreItem['STORE_DEC_IDX']}" />>
                <div class="Store-Card">
                    <div class="Store-Card-Body">
                        <div class="Store-Type">
                            <c:choose>
                                <c:when test="${StoreItem['STORE_TYPE'] == 'RESTAURANT'}">
                                    <i class="fas fa-utensils fa-1x"></i>
                                </c:when>
                                <c:when test="${StoreItem['STORE_TYPE'] == 'PC'}">
                                    <i class="fas fa-gamepad fa-1x"></i>
                                </c:when>
                                <c:when test="${StoreItem['STORE_TYPE'] == 'CAFE'}">
                                    <i class="fas fa-coffee fa-1x"></i>
                                </c:when>
                            </c:choose>
                        </div>
                        <img src="<c:url value="/resources/storeImages/${StoreItem['STORE_THUMBNAIL']}" />" alt="">
                    </div>
                    <div class="Store-Card-Title">
                        <span class="Store-Name-Text">${StoreItem['STORE_NAME']}</span>
                    </div>
                    <div class="Store-Card-Bottom">
                        <div class="Card-Statistic-Group">
                            <i class="fas fa-comment-dots"></i>
                            <span class="Card-Statistic-Value">${StoreItem['STORE_COMMENT_COUNT']}</span>
                        </div>
                        <div class="Card-Statistic-Group">
                            <i class="fas fa-heart --Color-Heart"></i>
                            <span class="Card-Statistic-Value">${StoreItem['AVG_PREFERENCE']}</span>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>

</div>
</body>
</html>
