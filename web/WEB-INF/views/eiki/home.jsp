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
<%--    <script src="<c:url value="/resources/js/index.js" />"></script>--%>
    <script>
        window.onload = () => {

            initTopbarEvents();

        };

        const initTopbarEvents = () => {

            let $NavIcon = document.querySelector(".Topbar-Nav-Tool");
            let $NavBox = document.querySelector(".Nav-Box");

            $NavIcon.addEventListener("click", (event) => {
                event.stopPropagation();
                if(!$NavIcon.firstElementChild.classList.contains("--Half-Spin-Once-Forward")){
                    $NavIcon.firstElementChild.classList.remove("--Half-Spin-Once-Reverse");
                    $NavIcon.firstElementChild.classList.add("--Half-Spin-Once-Forward")
                } else {
                    $NavIcon.firstElementChild.classList.remove("--Half-Spin-Once-Forward");
                    $NavIcon.firstElementChild.classList.add("--Half-Spin-Once-Reverse");
                }

                $NavBox.classList.toggle("--Nav-Fold");
            })

        };
    </script>
</head>
<body>

    <c:import url="component/topbar.jsp" charEncoding="UTF-8" >
        <c:param name="MEMBER_ID" value="${User.MEMBER_ID}" />
        <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}" />
        <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}" />
    </c:import>

</body>
</html>
