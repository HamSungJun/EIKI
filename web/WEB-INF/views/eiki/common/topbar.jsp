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
                <input type="text" class="--Display-None">
                <input autocomplete="new-password" id="SEARCH-INPUT" placeholder="스토어 검색..." type="text">
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
            <a class="Topbar-Link Topbar-MyPage --Overflow-Ellipsis"
               href="<c:url value="/eiki/member/manage" />">${param.MEMBER_NICKNAME}</a>님
        </span>
    </div>
    <div class="Topbar-Column">
        <span class="Topbar-Nav-Tool --Color-Violet"><i class="fas fa-bars fa-2x"></i></span>
    </div>
    <div class="Nav-Box --Nav-Fold">
        <c:if test="${param.IS_ADMIN == 1}">
            <div class="Nav-Row">
                <a href="<c:url value="/eiki/admin" />"><span class="Nav-Text">Admin</span></a>
            </div>
        </c:if>
        <div class="Nav-Row --Show-At-Mobile">
            <a href="<c:url value="/eiki/member/manage" />"><span class="Nav-Text">My Page</span></a>
        </div>
        <div class="Nav-Row">
            <a href=""><span class="Nav-Text">Community</span></a>
        </div>
        <div class="Nav-Row">
            <a href=""><span class="Nav-Text">Contact</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/auth/logout" />"><span class="Nav-Text">Logout</span></a>
        </div>
    </div>
</div>
