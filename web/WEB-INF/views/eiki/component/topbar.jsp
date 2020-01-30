<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="Topbar">
    <div class="Topbar-Column Topbar-Logo-Box">
        <h1 class="Topbar-Logo-Text">
            EIKI
        </h1>
    </div>
    <div class="Topbar-Column">
        <div class="Topbar-Search-Box">
            <div class="Search-Input-Box">
                <input placeholder="식당, 카페, PC방 ..." type="text">
            </div>
            <div class="Search-Icon-Box">
                <i class="fas fa-search"></i>
            </div>
        </div>
    </div>
    <div class="Topbar-Column Topbar-User-Box">
        <div class="User-Image-Box">
            <img src="<c:url value="/resources/userImages/${param.MEMBER_PROFILE_IMAGE}" />" alt="">
        </div>
        <span>
            <a class="Topbar-Link Topbar-MyPage"
               href="<c:url value="/member/mypage?memberId=${param.MEMBER_ID}" />">${param.MEMBER_NICKNAME}</a>님
        </span>
    </div>
    <div class="Topbar-Column">
        <span class="Topbar-Nav-Tool --Color-Violet"><i class="fas fa-bars fa-2x"></i></span>
    </div>
    <div class="Nav-Box --Nav-Fold">
        <div class="Nav-Row">
            <a href="<c:url value="/auth/logout" />">logout</a>
        </div>
        <div class="Nav-Row">
            <a href="">etc</a>
        </div>
    </div>
</div>
<%--<h1>탑바</h1>--%>
<%--<h1>${User.MEMBER_ID}</h1>--%>
<%--<h1>${User.MEMBER_NICKNAME}</h1>--%>
<%--<h1>${User.MEMBER_PHONE}</h1>--%>
<%--<h1>${User.MEMBER_BIRTHDAY}</h1>--%>
<%--<h1>${User.MEMBER_PROFILE_IMAGE}</h1>--%>