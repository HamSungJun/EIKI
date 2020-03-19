<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 어드민 멤버 관리</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/memberEdit.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar_admin.js" />"></script>
    <script defer src="<c:url value="/resources/js/memberEdit.js" />"></script>
</head>
<body>
<c:import url="../../common/topbar_admin.jsp" charEncoding="UTF-8"/>
<div class="Member-Edit-Box">
    <div class="Member-Edit-Category">
        <div>
            <span>멤버 리스트</span>
        </div>
        <div class="Member-Search-Box">
            <input id="MEMBER-SEARCH" placeholder="멤버 검색..." type="text">
        </div>
    </div>
    <div class="Member-List-Box">
        <c:forEach items="${MemberList}" var="Member">
            <div data-member-idx="${Member['MEMBER_DEC_IDX']}" class="Member-Data-Row">
                <div class="Member-Data-Item">
                    <div class="Member-Image-Circle">
                        <img src="<c:url value="/resources/userImages/${Member['MEMBER_PROFILE_IMAGE']}" />" alt="">
                    </div>
                </div>
                <div class="Member-Data-Item --Justify-Flex-Start">
                    <span class="--Overflow-Ellipsis" title="${Member["MEMBER_ID"]}">${Member["MEMBER_NICKNAME"]}</span>
                </div>
                <div class="Member-Data-Item">
                    <span>${Member["MEMBER_PHONE"]}</span>
                </div>
                <div class="Member-Data-Item">
                    <div class="Circular-Pill ${Member["IS_ADMIN"] == 1 ? "--Admin-True" : ""}">
                        <span>Admin</span>
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="Comment-Page-Row">
            <div>
                <c:if test="${PageVO.prev}">
                    <a class="Page-Mover"
                       href="<c:url value="/eiki/admin/member/manage/${PageVO.currentPageIdx - 1}" />">이전</a>
                </c:if>
                <c:forEach begin="${PageVO.startPageIdx}" end="${PageVO.endPageIdx}" var="pageIdx">
                    <a class="Page-Link ${PageVO.currentPageIdx == pageIdx ? "--Page-Link-Selected" : ""}"
                       href="<c:url value="/eiki/admin/member/manage/${pageIdx}"/>">${pageIdx}</a>
                </c:forEach>
                <c:if test="${PageVO.next}">
                    <a class="Page-Mover"
                       href="<c:url value="/eiki/admin/member/manage/${PageVO.currentPageIdx + 1}" />">다음</a>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
