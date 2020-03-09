<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="Topbar --Admin-Top-Bar">
    <div class="Topbar-Column Topbar-Logo-Box">
        <h1 class="Topbar-Logo-Text">
            ADMIN
        </h1>
    </div>
    <div class="Topbar-Column">

    </div>
    <div class="Topbar-Column Topbar-User-Box">

    </div>
    <div class="Topbar-Column">
        <span class="Topbar-Nav-Tool --Color-Violet"><i class="fas fa-bars fa-2x"></i></span>
    </div>
    <div class="Nav-Box --Admin-Nav-Box --Nav-Fold">
        <div class="Nav-Row">
            <a href="<c:url value="/eiki/home" />"><span class="Nav-Text">Home</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/eiki/admin/store/post" />"><span class="Nav-Text">Store Post</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/eiki/admin/store/edit?storeName=" />"><span class="Nav-Text">Store Edit</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/eiki/admin/member/manage" />"><span class="Nav-Text">Member Edit</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/auth/logout" />"><span class="Nav-Text">Logout</span></a>
        </div>
    </div>
</div>
