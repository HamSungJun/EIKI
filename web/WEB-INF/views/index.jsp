<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 로그인</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:title" content="EIKI" />
    <meta property="og:description" content="에리카 학생들을 위한 학교앞 푸드 위키" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://www.eiki.store" />
    <meta property="og:image" content="<c:url value="/resources/images/sample.png" />" />
    <meta property="og:image:width" content="1200" />
    <meta property="og:image:height" content="630" />
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/index.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/index.js" />"></script>
</head>
<body>
<div class="Index-Wrapper">
    <div class="Index-Wrapper__Form">
        <div class="Index-Wrapper__Form__Header-Section">
            <h1 class="Index-Wrapper__Form__Header-Section__Text">EIKI</h1>
        </div>
        <div class="Index-Wrapper__Form__Input-Section">
            <form autocomplete="off" action="<c:url value="/auth/login"/>" method="POST">
                <div class="Index-Wrapper__Form__Input-Section__Grid-Row">
                    <div class="Index-Wrapper__Form__Input-Section__Grid-Row__Icon-Column">
                        <i class="fas fa-user-circle fa-2x"></i>
                    </div>
                    <div class="Index-Wrapper__Form__Input-Section__Grid-Row__Input-Column">
                        <input type="text" class="--Display-None">
                        <input autocomplete="new-password" id="MEMBER_ID" placeholder="Univ Email" type="text" name="MEMBER_ID">
                    </div>
                </div>
                <div class="Index-Wrapper__Form__Input-Section__Grid-Row">
                    <div class="Index-Wrapper__Form__Input-Section__Grid-Row__Icon-Column">
                        <i class="fas fa-key fa-2x"></i>
                    </div>
                    <div class="Index-Wrapper__Form__Input-Section__Grid-Row__Input-Column">
                        <input type="password" class="--Display-None">
                        <input autocomplete="new-password" id="MEMBER_PW" placeholder="Password" type="password" name="MEMBER_PW">
                    </div>
                </div>
                <div class="Index-Wrapper__Form__Func-Section__Grid-Row">
                    <div class="Index-Wrapper__Form__Func-Section__Grid-Row__Column">
                        <div class="Remember-Outer-Circle">
                            <div class="Remember-Inner-Circle"></div>
                        </div>
                        <span class="Remember-Text">Remember</span>
                    </div>
                    <div class="Index-Wrapper__Form__Func-Section__Grid-Row__Column --Justify-Flex-End">
                        <a class="Nav-Link" href="<c:url value="/find" />">Find ID/PW</a>
                        <a class="Nav-Link" href="<c:url value="/join" />">Join</a>
                    </div>
                </div>
                <button type="submit" class="Index-Wrapper__Form__Input-Section__Submit-Btn" id="SUBMIT_BTN">Login
                </button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
