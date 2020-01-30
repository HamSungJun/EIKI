<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>EIKI 회원가입</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/join.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/join.js" />"></script>
</head>
<body>
<div class="Join-Wrapper">
    <div class="Join-Box">
        <div class="Profile-Image-Circle">
            <img id="PROFILE_IMAGE_VIEW" src="<c:url value="/resources/images/default-user.png" />" alt="">
        </div>
        <div class="Join-Header">
            <h2 class="Join-Header-Text"><span class="--Logo-Text-Style">EIKI</span> 회원가입</h2>
            <p class="Join-Header-Paragraph">EIKI의 회원이 되어 "오늘 뭐 먹지?"에 이바지 합시다.</p>
        </div>
        <form class="Join-Form" action="<c:url value="/member/join" />" method="POST" enctype="multipart/form-data">
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <label for="MEMBER_ID"><span><span class="--Color-Red">*</span>한양대학교 이메일</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input id="MEMBER_ID" name="MEMBER_ID" type="text">
                    <span class="--mx-4">@</span>
                    <input readonly placeholder="hmail.hanyang.ac.kr" type="text">
                    <button class="--ml-8 Function-Btn" type="button" id="AUTH-MAIL">인증번호 발송</button>
                </div>
            </div>
            <div id="AUTH-ROW" class="Join-Form-Row --Auth-Closed">
                <div class="Join-Form-Field">
                    <label for="AUTH-NUM"><span><span class="--Color-Red">*</span>인증번호 확인</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input maxlength="4" placeholder="인증번호 4자리" id="AUTH-NUM" name="AUTH_NUM" type="text">
                    <button class="--ml-8 Function-Btn" type="button" id="CHECK-AUTH-NUM">확인</button>
                </div>
            </div>
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <label for="MEMBER_PW"><span><span class="--Color-Red">*</span>비밀번호</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input id="MEMBER_PW" name="MEMBER_PW" type="password">
                    <span class="--Join-Form-Guide-Message --ml-8" id="MEMBER_PW_MESSAGE"></span>
                </div>
            </div>
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <label for="MEMBER_PW_CONFIRM"><span><span class="--Color-Red">*</span>비밀번호 확인</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input id="MEMBER_PW_CONFIRM" name="MEMBER_PW_CONFIRM" type="password">
                    <span class="--Join-Form-Guide-Message --ml-8" id="MEMBER_PW_CONFIRM_MESSAGE"></span>
                </div>
            </div>
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <label for="MEMBER_NICKNAME"><span><span class="--Color-Red">*</span>닉네임</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input id="MEMBER_NICKNAME" name="MEMBER_NICKNAME" maxlength="16" type="text">
                    <button class="Function-Btn --ml-8" type="button" id="CHECK-DUP-NICKNAME">중복확인</button>
                    <span class="--Join-Form-Guide-Message --ml-8" id="MEMBER_NICKNAME_MESSAGE"></span>
                </div>
            </div>
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <label for="MEMBER_BIRTHDAY"><span><span class="--Color-Red">*</span>생일</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input maxlength="10" id="MEMBER_BIRTHDAY" name="MEMBER_BIRTHDAY" placeholder="YYYY-MM-DD"
                           type="text">
                    <span class="--Join-Form-Guide-Message --ml-8" id="MEMBER_BIRTHDAY_MESSAGE"></span>
                </div>
            </div>
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <label for="MEMBER_PHONE"><span><span class="--Color-Red">*</span>연락처</span></label>
                </div>
                <div class="Join-Form-Content">
                    <input maxlength="13" id="MEMBER_PHONE" name="MEMBER_PHONE" placeholder="000-0000-0000" type="text">
                    <span class="--Join-Form-Guide-Message --ml-8" id="MEMBER_PHONE_MESSAGE"></span>
                </div>
            </div>
            <div class="Join-Form-Row">
                <div class="Join-Form-Field">
                    <span><span class="--Color-Red">*</span>프로필 이미지</span>
                </div>
                <div class="Join-Form-Content">
                    <input name="MEMBER_PROFILE_IMAGE" id="MEMBER_PROFILE_IMAGE" class="--Display-None"
                           accept=".jpg, .jpeg, .png" type="file">
                    <button id="FILE_DISPATCHER" type="button" class="Function-Btn">파일 선택</button>
                    <span id="FILE_NAME"></span>
                    <span class="--Join-Form-Guide-Message --ml-8" id="MEMBER_PROFILE_IMAGE_MESSAGE"></span>
                </div>
            </div>
        </form>
        <div class="Join-Footer">
            <div>
                <span class="--Color-Red">*</span><span class="--mx-4">:</span>필수 입력 사항입니다.
            </div>
            <div>
                <button class="Join-Footer-Btn" id="JOIN-BTN" type="submit">가입하기</button>
                <button id="TO-LOGIN" class="Join-Footer-Btn --ml-8">로그인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
