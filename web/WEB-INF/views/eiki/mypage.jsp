<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 마이 페이지</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/mypage.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar.js" />"></script>
    <script>

        let UPDATE_STATE = {
            IS_PASSWORD_OK: true,
            IS_PASSWORD_CONFIRM_EQUAL: true,
            IS_NICKNAME_OK: true,
            IS_NICKNAME_DUP_CHECKED: true,
            IS_BIRTHDAY_OK: true,
            IS_PHONE_OK: true
        };

        let isUpdating = false;

        window.onload = () => {

            initTopbarEvents();
            initMypageEvents();

        };

        const initMypageEvents = () => {

            const PHONE_REGEX = new RegExp(/^[0-9]{3}-[0-9]{4}-[0-9]{4}$/);
            const BIRTHDAY_REGEX = new RegExp(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/);
            const NICKNAME_REGEX = new RegExp(/^.{1,16}$/);
            const PASSWORD_REGEX = new RegExp(/^([0-9a-zA-Z!@#$%^&*()_+]{4,16}|\w{0})$/);

            let $ProfileImageUpdate = document.getElementById("PROFILE-IMAGE-UPDATE");
            let $HiddenFileInput = document.getElementById("HIDDEN-FILE-INPUT");

            $HiddenFileInput.addEventListener("input", (event) => {
                let $ProfileImageView = document.querySelector(".Profile-Preview");
                handleOnFileInput(event, getGuideMessageDOM(event), $ProfileImageView);
            });

            $ProfileImageUpdate.addEventListener("click", () => {
                $HiddenFileInput.click();
            });

            let $InputPw = document.getElementById("MEMBER_PW");
            let $InputPwConfirm = document.getElementById("MEMBER_PW_CONFIRM");
            $InputPw.addEventListener("input", (event) => {
                UPDATE_STATE.IS_PASSWORD_OK = false;
                if ($InputPw.value !== $InputPwConfirm.value) {
                    UPDATE_STATE.IS_PASSWORD_CONFIRM_EQUAL = false;
                    $InputPwConfirm.nextElementSibling.textContent = "설정한 비밀번호와 동일하게 입력해야 합니다.";
                } else {
                    UPDATE_STATE.IS_PASSWORD_CONFIRM_EQUAL = true;
                }
                UPDATE_STATE.IS_PASSWORD_OK = handleValidGuide(event, PASSWORD_REGEX, getGuideMessageDOM(event), "4 ~ 16글자의 숫자, 영어 대소문자, 특수문자로 구성해 주세요.");
                console.log(UPDATE_STATE.IS_PASSWORD_OK);
            });
            $InputPw.addEventListener("focus", (event) => {
                UPDATE_STATE.IS_PASSWORD_OK = handleValidGuide(event, PASSWORD_REGEX, getGuideMessageDOM(event), "4 ~ 16글자의 숫자, 영어 대소문자, 특수문자로 구성해 주세요.");
            });

            $InputPwConfirm.addEventListener("input", (event) => {
                UPDATE_STATE.IS_PASSWORD_CONFIRM_EQUAL = handleValidPasswordConfirm(event, $InputPw, getGuideMessageDOM(event), "설정한 비밀번호와 동일하게 입력해야 합니다.");
            });
            $InputPwConfirm.addEventListener("focus", (event) => {
                UPDATE_STATE.IS_PASSWORD_CONFIRM_EQUAL = handleValidPasswordConfirm(event, $InputPw, getGuideMessageDOM(event), "설정한 비밀번호와 동일하게 입력해야 합니다.");
            });

            let $InputNickName = document.getElementById("MEMBER_NICKNAME");
            let $CheckDupNickNameButton = document.getElementById("CHECK-DUP-NICKNAME");
            $InputNickName.addEventListener("input", (event) => {
                UPDATE_STATE.IS_NICKNAME_DUP_CHECKED = false;
                UPDATE_STATE.IS_NICKNAME_OK = handleValidGuide(event, NICKNAME_REGEX, getGuideMessageDOM(event), "최대 16글자의 닉네임을 설정 할 수 있습니다.");
                if (!!$CheckDupNickNameButton.firstElementChild && $CheckDupNickNameButton.firstElementChild.tagName === "svg") {
                    $CheckDupNickNameButton.innerHTML = "";
                    $CheckDupNickNameButton.textContent = "중복확인";
                    UPDATE_STATE.IS_NICKNAME_DUP_CHECKED = false;
                    $CheckDupNickNameButton.disabled = false;
                }
            });
            $InputNickName.addEventListener("focus", (event) => {
                UPDATE_STATE.IS_NICKNAME_OK = handleValidGuide(event, NICKNAME_REGEX, getGuideMessageDOM(event), "최대 16글자의 닉네임을 설정 할 수 있습니다.");
            });
            $CheckDupNickNameButton.addEventListener("click", (event) => {
                UPDATE_STATE.IS_NICKNAME_DUP_CHECKED = handleDupNickNameCheck(event, $InputNickName);
            });

            let $InputPhone = document.getElementById("MEMBER_PHONE");
            $InputPhone.addEventListener("input", (event) => {
                UPDATE_STATE.IS_PHONE_OK = handleValidGuide(event, PHONE_REGEX, getGuideMessageDOM(event), "\"-\" 하이픈을 포함한 13자리 연락처를 입력해 주세요.");
            });
            $InputPhone.addEventListener("focus", (event) => {
                UPDATE_STATE.IS_PHONE_OK = handleValidGuide(event, PHONE_REGEX, getGuideMessageDOM(event), "\"-\" 하이픈을 포함한 13자리 연락처를 입력해 주세요.");
            });

            let $InputBirthDay = document.getElementById("MEMBER_BIRTHDAY");
            $InputBirthDay.addEventListener("input", (event) => {
                UPDATE_STATE.IS_BIRTHDAY_OK = handleValidGuide(event, BIRTHDAY_REGEX, getGuideMessageDOM(event), "\"-\" 하이픈을 포함한 10자리 생년월일을 입력해 주세요.");
            });
            $InputBirthDay.addEventListener("focus", (event) => {
                UPDATE_STATE.IS_BIRTHDAY_OK = handleValidGuide(event, BIRTHDAY_REGEX, getGuideMessageDOM(event), "\"-\" 하이픈을 포함한 10자리 생년월일을 입력해 주세요.");
            });

            let $UpdateButton = document.getElementById("UPDATE");
            $UpdateButton.addEventListener("click", () => {
                let validResult = validateAll($HiddenFileInput, $InputPw, $InputNickName, $InputBirthDay, $InputPhone);
                if (validResult) {

                    let formData = new FormData();
                    for (let key in validResult) {
                        formData.append(key, validResult[key]);

                    }

                    formData.forEach((v, k, p) => {
                        console.log(p.get(k));
                    });

                    if (!isUpdating) {
                        fetch("/eiki/member/update", {
                            method: "POST",
                            body: formData
                        }).then(async response => {
                            if (response.status === 200) {
                                alert("회원정보가 수정되었습니다.");
                                window.location.href = "/eiki/home";
                            }
                        }).catch(error => {
                            console.log(error);
                        })
                    } else {
                        return alert("수정중입니다.");
                    }

                }
            });

            let $ResetButton = document.getElementById("RESET");
            $ResetButton.addEventListener("click", () => {
                window.location.reload();
            });

        };

        const validateAll = ($HiddenFileInput, $InputPw, $InputNickName, $InputBirthDay, $InputPhone) => {

            if (!UPDATE_STATE.IS_PASSWORD_OK) {
                return alert("유효한 비밀번호 양식이 아닙니다. 비밀번호를 변경하지 않으시려면 칸을 비워주세요.");
            }

            if (!UPDATE_STATE.IS_PASSWORD_CONFIRM_EQUAL) {
                return alert("비밀번호 확인값이 비밀번호와 동일하지 않습니다.");
            }

            if (!UPDATE_STATE.IS_NICKNAME_OK) {
                return alert("유효한 닉네임 양식이 아닙니다.");
            }

            if (!UPDATE_STATE.IS_NICKNAME_DUP_CHECKED) {
                return alert("닉네임 중복확인 절차를 진행해 주세요.");
            }

            if (!UPDATE_STATE.IS_BIRTHDAY_OK) {
                return alert("유효한 생일 양식이 아닙니다.\nYYYY-MM-DD 형태로 입력해주세요.");
            }

            if (!UPDATE_STATE.IS_PHONE_OK) {
                return alert("유효한 전화번호 양식이 아닙니다.\n000-0000-0000 형태로 입력해주세요.");
            }

            return {
                MEMBER_PROFILE_IMAGE: $HiddenFileInput.files[0] || null,
                MEMBER_PW: $InputPw.value.length === 0 ? "" : $InputPw.value,
                MEMBER_NICKNAME: $InputNickName.value.length === 0 ? "" : $InputNickName.value,
                MEMBER_BIRTHDAY: $InputBirthDay.value.length === 0 ? "" : $InputBirthDay.value,
                MEMBER_PHONE: $InputPhone.value.length === 0 ? "" : $InputPhone.value
            }

        };

        const handleOnFileInput = (event, $GuideMessage, $ProfileImageView) => {

            let fileIn = event.target.files[0];
            let fileReader = new FileReader();

            if (fileIn) {

                if (fileIn.size > 2000000) {
                    event.target.value = "";
                    $GuideMessage.textContent = "2MB 이하 이미지 파일만 업로드 가능합니다.";
                    return false;
                }

                fileReader.onload = (event) => {
                    let UInt8View = new Uint8Array(event.target.result);
                    $ProfileImageView.src = URL.createObjectURL(new Blob([UInt8View]));
                };

                fileReader.readAsArrayBuffer(fileIn);

            }

            return true;

        };

        const handleValidGuide = (event, regex, $Message, guide) => {
            if (regex.test(event.target.value)) {
                $Message.textContent = "";
                return true;
            } else {
                $Message.textContent = guide;
            }
            return false;
        };

        const handleValidPasswordConfirm = (event, $InputPw, $Message, guide) => {
            if (event.target.value === $InputPw.value && $InputPw.value.length >= 0) {
                $Message.textContent = "";
                return true;
            } else {
                // $Message.textContent = guide;
            }
            return false;
        };

        const getGuideMessageDOM = (event) => {
            return event.target.parentNode.querySelector(".Guide-Message");
        };

        const handleDupNickNameCheck = (event, $InputNickName) => {

            const nickName = $InputNickName.value;

            if (nickName.length > 0) {
                appendStatusIcon(event.target, "FETCHING");
                event.target.disabled = true;

                fetch("/member/checkDup", {
                    method: 'POST',
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({
                        MEMBER_NICKNAME: nickName
                    })
                }).then(async response => {

                    const checkResult = await response.json();

                    if (checkResult.success === 1 && !checkResult.isDup) {
                        appendStatusIcon(event.target, "SUCCESS");
                        UPDATE_STATE.IS_NICKNAME_DUP_CHECKED = true;
                    } else {
                        appendStatusIcon(event.target, "ERROR");
                    }

                }).catch(error => {
                    console.log(error)
                })
            } else {
                return alert("닉네임을 먼저 입력해주세요.");
            }
        };

        const appendStatusIcon = ($Parent, status) => {

            $Parent.innerHTML = "";
            let $StatusIcon = document.createElement("i");

            switch (status) {
                case "FETCHING" :
                    $StatusIcon.classList.add("fas", "fa-spinner", "--Spin");
                    break;
                case "SUCCESS" :
                    $StatusIcon.classList.add("fas", "fa-check", "--Color-Success");
                    break;
                case "ERROR" :
                    $StatusIcon.classList.add("fas", "fa-times", "--Color-Error");
                    break;
            }

            return $Parent.appendChild($StatusIcon);

        };

    </script>
</head>
<body>
<c:import url="component/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_DEC_IDX" value="${User.MEMBER_DEC_IDX}"/>
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
    <c:param name="IS_ADMIN" value="${User.IS_ADMIN}"/>
</c:import>
<div class="My-Page-Box">
    <c:import url="component/mypage_nav.jsp" charEncoding="UTF-8">
        <c:param name="NAV_SELECTED" value="MEMBER-MANAGE"/>
    </c:import>
    <div class="User-Info-Box --Panel-Showing">
        <div class="User-Info-Row">
            <div>
                프로필 이미지
            </div>
            <div>
                <input name="MEMBER_PROFILE_IMAGE" id="HIDDEN-FILE-INPUT" class="--Display-None"
                       accept=".jpg, .jpeg, .png" type="file">
                <button id="PROFILE-IMAGE-UPDATE" class="Function-Btn">파일선택</button>
                <img class="Profile-Preview --ml-8"
                     src="<c:url value="/resources/userImages/${User['MEMBER_PROFILE_IMAGE']}" />" alt="">
                <span class="Guide-Message"></span>
            </div>
        </div>
        <div class="User-Info-Row">
            <div>
                비밀번호
            </div>
            <div>
                <input name="MEMBER_PW" id="MEMBER_PW" type="password">
                <span class="Guide-Message"></span>
            </div>
        </div>
        <div class="User-Info-Row">
            <div>
                비밀번호 확인
            </div>
            <div>
                <input id="MEMBER_PW_CONFIRM" type="password">
                <span class="Guide-Message"></span>
            </div>
        </div>
        <div class="User-Info-Row">
            <div>
                닉네임
            </div>
            <div>
                <input value="${User['MEMBER_NICKNAME']}" id="MEMBER_NICKNAME" name="MEMBER_NICKNAME" maxlength="16"
                       type="text">
                <button id="CHECK-DUP-NICKNAME" class="Function-Btn --ml-8">중복확인</button>
                <span class="Guide-Message"></span>
            </div>
        </div>
        <div class="User-Info-Row">
            <div>
                생일
            </div>
            <div>
                <input value="${User['MEMBER_BIRTHDAY']}" id="MEMBER_BIRTHDAY" name="MEMBER_BIRTHDAY"
                       placeholder="YYYY-MM-DD" maxlength="10"
                       type="text">
                <span class="Guide-Message"></span>
            </div>
        </div>
        <div class="User-Info-Row">
            <div>
                연락처
            </div>
            <div>
                <input value="${User['MEMBER_PHONE']}" id="MEMBER_PHONE" name="MEMBER_PHONE" placeholder="000-0000-0000"
                       maxlength="13"
                       type="text">
                <span class="Guide-Message"></span>
            </div>
        </div>
        <div class="Bottom-Button-Row">
            <button id="UPDATE" class="Post-Btn">수정 완료</button>
            <button id="RESET" class="Post-Btn">초기화</button>
        </div>
    </div>
</div>
</body>
</html>
