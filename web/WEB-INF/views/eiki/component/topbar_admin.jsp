<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="Topbar">
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
    <div class="Nav-Box --Nav-Fold">
        <div class="Nav-Row">
            <a href="<c:url value="/eiki/home" />"><span class="Nav-Text">Home</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/eiki/admin/post" />"><span class="Nav-Text">Post</span></a>
        </div>
        <div class="Nav-Row">
            <a href="<c:url value="/auth/logout" />"><span class="Nav-Text">Logout</span></a>
        </div>
    </div>
</div>
