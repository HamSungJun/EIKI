<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 어드민 홈</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/adminHome.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/Chart.min.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/Chart.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar_admin.js" />"></script>
    <script src="<c:url value="/resources/js/adminHome.js" />"></script>
</head>
<body>
<c:import url="../common/topbar_admin.jsp" charEncoding="UTF-8"/>
<div class="Admin-Home-Box">
    <div>
        <h3 class="Access-Header"># 서비스 접근</h3>
    </div>
    <div class="Access-Row">
        <canvas style="height: 100%; width: 100%" id="ACCESS-CHART"></canvas>
    </div>
</div>
</body>
</html>
