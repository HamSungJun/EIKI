<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 스토어 수정/삭제</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/edit.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar_admin.js" />"></script>
    <script src="<c:url value="/resources/js/edit.js" />"></script>
</head>
<body>
<c:import url="../../common/topbar_admin.jsp" charEncoding="UTF-8"/>
<div class="Store-Edit-Box">
    <div class="Store-Edit-Category">
        <div>
            <span>스토어 리스트</span>
        </div>
        <div class="Store-Search-Box">
            <input id="STORE-SEARCH" placeholder="스토어 검색..." type="text">
        </div>
    </div>
    <div class="Store-List-Box">
        <c:forEach items="${StoreInfos}" var="StoreInfo">
            <div data-store-idx="${StoreInfo['STORE_DEC_IDX']}" class="Store-Data-Row">
                <div class="Store-Data-Item">${StoreInfo['STORE_DEC_IDX']}</div>
                <div class="Store-Data-Item --Justify-Flex-Start">
                    <a class="Store-Link"
                       href="<c:url value="/eiki/store/${StoreInfo['STORE_DEC_IDX']}" />">${StoreInfo['STORE_NAME']}</a>
                </div>
                <div class="Store-Data-Item">${StoreInfo['STORE_CALL']}</div>
                <div class="Store-Data-Item Type-Icon-Box --Store-Data-Icon">
                    <c:choose>
                        <c:when test="${StoreInfo['STORE_TYPE'] == 'RESTAURANT'}">
                            <i class="fas fa-utensils"></i>
                        </c:when>
                        <c:when test="${StoreInfo['STORE_TYPE'] == 'PC'}">
                            <i class="fas fa-gamepad"></i>
                        </c:when>
                        <c:when test="${StoreInfo['STORE_TYPE'] == 'CAFE'}">
                            <i class="fas fa-coffee"></i>
                        </c:when>
                    </c:choose>
                </div>
                <div class="Store-Data-Item --Store-Data-Icon">
                    <c:if test="${StoreInfo['IS_DELIVERY'] == true}">
                        <i class="fas fa-motorcycle"></i>
                    </c:if>
                </div>
                <div class="Icon-Box Icon-Grid">
                    <div class="Store-Data-Item --Store-Data-Icon --Function-Icon --Store-Edit">
                        <i class="far fa-edit"></i>
                    </div>
                    <div class="Store-Data-Item --Store-Data-Icon --Function-Icon --Store-Delete">
                        <i class="far fa-trash-alt"></i>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
