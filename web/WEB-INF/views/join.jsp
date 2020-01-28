<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>EIKI 회원가입</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/normalize.css">
    <link rel="stylesheet" href="/resources/css/global.css">
    <link rel="stylesheet" href="/resources/css/join.css">
    <script defer src="/resources/js/all.min.js"></script>
    <script>

        let formValidState = {
            isMailSent: false,
            isMailAuthorized: false,
            isPwOK: false,
            isPwConfirmEquals: false,
            isNickNameOK: false,
            isNickNameDupChecked: false,
            isBirthDayOK: false,
            isPhoneOK: false,
            isProfileImageOK: false
        };

        window.onload = () => {
            initFormEvents();
        };

        const initFormEvents = () => {

            const PHONE_REGEX = new RegExp(/^[0-9]{3}-[0-9]{4}-[0-9]{4}$/);
            const BIRTHDAY_REGEX = new RegExp(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/);
            const NICKNAME_REGEX = new RegExp(/^.{1,16}$/);
            const PASSWORD_REGEX = new RegExp(/^[0-9a-zA-Z!@#$%^&*()_+]{4,16}/);

            let $JoinForm = document.querySelector(".Join-Form");

            let $InputId = document.getElementById("MEMBER_ID");
            let $AuthRow = document.getElementById("AUTH-ROW");

            let $AuthMail = document.getElementById("AUTH-MAIL");
            $AuthMail.addEventListener("click", (event) => {
                formValidState.isMailSent = sendAuthEmail(event, $InputId);
            });

            let $InputAuthNum = document.getElementById("AUTH-NUM");
            let $CheckAuth = document.getElementById("CHECK-AUTH-NUM");
            $InputId.addEventListener("input", () => {

                $AuthMail.innerHTML = "";
                $AuthMail.textContent = "인증번호 발송";
                $AuthMail.disabled = false;

                if (!$AuthRow.classList.contains("--Auth-Closed")) {
                    $AuthRow.classList.add("--Auth-Closed");
                    $InputAuthNum.value = "";
                    $CheckAuth.InnerHTML = "";
                    $CheckAuth.textContent = "확인";
                    $CheckAuth.disabled = false;
                }

            });

            $CheckAuth.addEventListener("click", (event) => {
                formValidState.isMailAuthorized = checkAuthNum(event, $InputAuthNum, $InputId);
            });
            $InputAuthNum.addEventListener("input", () => {
                if (!!$CheckAuth.firstElementChild && $CheckAuth.firstElementChild.tagName.toLowerCase() === "svg") {
                    $CheckAuth.innerHTML = "";
                    $CheckAuth.textContent = "확인";
                    $CheckAuth.disabled = false;
                }
                if (formValidState.isMailAuthorized) {
                    formValidState.isMailAuthorized = false;
                }
            });

            let $InputPw = document.getElementById("MEMBER_PW");
            let $InputPwMessage = document.getElementById("MEMBER_PW_MESSAGE");
            let $InputPwConfirm = document.getElementById("MEMBER_PW_CONFIRM");
            let $InputPwConfirmMessage = document.getElementById("MEMBER_PW_CONFIRM_MESSAGE");

            $InputPw.addEventListener("input", (event) => {
                formValidState.isPwOK = handleValidGuide(event, PASSWORD_REGEX, $InputPwMessage, "4 ~ 16글자의 숫자, 영어 대소문자, 특수문자로 구성해 주세요.");
            });
            $InputPw.addEventListener("focus", (event) => {
                formValidState.isPwOK = handleValidGuide(event, PASSWORD_REGEX, $InputPwMessage, "4 ~ 16글자의 숫자, 영어 대소문자, 특수문자로 구성해 주세요.");
            });

            $InputPwConfirm.addEventListener("input", (event) => {
                formValidState.isPwConfirmEquals = handleValidPasswordConfirm(event, $InputPw, $InputPwConfirmMessage, "설정한 비밀번호와 동일하게 입력해야 합니다.");
            });
            $InputPwConfirm.addEventListener("focus", (event) => {
                formValidState.isPwConfirmEquals = handleValidPasswordConfirm(event, $InputPw, $InputPwConfirmMessage, "설정한 비밀번호와 동일하게 입력해야 합니다.");
            });

            let $InputNickName = document.getElementById("MEMBER_NICKNAME");
            let $InputNickNameMessage = document.getElementById("MEMBER_NICKNAME_MESSAGE");
            let $CheckDupNickNameButton = document.getElementById("CHECK-DUP-NICKNAME");
            $InputNickName.addEventListener("input", (event) => {
                formValidState.isNickNameOK = handleValidGuide(event, NICKNAME_REGEX, $InputNickNameMessage, "최대 16글자의 닉네임을 설정 할 수 있습니다.");
                if (!!$CheckDupNickNameButton.firstElementChild && $CheckDupNickNameButton.firstElementChild.tagName === "svg") {
                    $CheckDupNickNameButton.innerHTML = "";
                    $CheckDupNickNameButton.textContent = "중복확인";
                    formValidState.isNickNameDupChecked = false;
                    $CheckDupNickNameButton.disabled = false;
                }
            });
            $InputNickName.addEventListener("focus", (event) => {
                formValidState.isNickNameOK = handleValidGuide(event, NICKNAME_REGEX, $InputNickNameMessage, "최대 16글자의 닉네임을 설정 할 수 있습니다.");
            });
            $CheckDupNickNameButton.addEventListener("click", (event) => {
                formValidState.isNickNameDupChecked = handleDupNickNameCheck(event, $InputNickName);
            });

            let $InputPhone = document.getElementById("MEMBER_PHONE");
            let $InputPhoneMessage = document.getElementById("MEMBER_PHONE_MESSAGE");
            $InputPhone.addEventListener("input", (event) => {
                formValidState.isPhoneOK = handleValidGuide(event, PHONE_REGEX, $InputPhoneMessage, "\"-\" 하이픈을 포함한 13자리 연락처를 입력해 주세요.");
            });
            $InputPhone.addEventListener("focus", (event) => {
                formValidState.isPhoneOK = handleValidGuide(event, PHONE_REGEX, $InputPhoneMessage, "\"-\" 하이픈을 포함한 13자리 연락처를 입력해 주세요.");
            });

            let $InputBirthDay = document.getElementById("MEMBER_BIRTHDAY");
            let $InputBirthDayMessage = document.getElementById("MEMBER_BIRTHDAY_MESSAGE");
            $InputBirthDay.addEventListener("input", (event) => {
                formValidState.isBirthDayOK = handleValidGuide(event, BIRTHDAY_REGEX, $InputBirthDayMessage, "\"-\" 하이픈을 포함한 10자리 생년월일을 입력해 주세요.");
            });
            $InputBirthDay.addEventListener("focus", (event) => {
                formValidState.isBirthDayOK = handleValidGuide(event, BIRTHDAY_REGEX, $InputBirthDayMessage, "\"-\" 하이픈을 포함한 10자리 생년월일을 입력해 주세요.");
            });

            let $InputProfileImage = document.getElementById("MEMBER_PROFILE_IMAGE");
            let $FileName = document.getElementById("FILE_NAME");
            let $ProfileImageView = document.getElementById("PROFILE_IMAGE_VIEW");

            $InputProfileImage.addEventListener("input", (event) => {
                formValidState.isProfileImageOK = handleOnFileInput(event, $FileName, $ProfileImageView);
            });

            let $FileDispatcher = document.getElementById("FILE_DISPATCHER");
            $FileDispatcher.addEventListener("click", () => {
                $InputProfileImage.click();
            });

            let $SubmitButton = document.getElementById("JOIN-BTN");
            $SubmitButton.addEventListener("click", (event) => {
                event.preventDefault();
                if (validateAll()) {
                    $JoinForm.submit();
                }
            });

            let $ToLogin = document.getElementById("TO-LOGIN");
            $ToLogin.addEventListener("click", () => {
                return window.location.href = "/";
            });

        };

        const handleOnFileInput = (event, $FileName, $ProfileImageView) => {

            let fileIn = event.target.files[0];
            let fileReader = new FileReader();
            let $FileMessage = document.getElementById("MEMBER_PROFILE_IMAGE_MESSAGE");

            if (fileIn) {

                if (fileIn.size > 2000000) {
                    event.target.value = "";
                    $FileName.textContent = "";
                    $ProfileImageView.src = "/resources/images/default-user.png";
                    $FileMessage.textContent = "2MB 이하 이미지 파일만 업로드 가능합니다.";
                    return false;
                }

                fileReader.onload = (event) => {
                    let UInt8View = new Uint8Array(event.target.result);
                    $ProfileImageView.src = URL.createObjectURL(new Blob([UInt8View]));
                    $FileName.textContent = fileIn.name;
                    $FileMessage.textContent = "입력 조건 통과.";
                };

                fileReader.readAsArrayBuffer(fileIn);

            }

            return true;

        };

        const handleValidGuide = (event, regex, $Message, guide) => {
            if (regex.test(event.target.value)) {
                $Message.textContent = "입력 조건 통과.";
                return true;
            } else {
                $Message.textContent = guide;
            }
            return false;
        };

        const handleValidPasswordConfirm = (event, $InputPw, $Message, guide) => {
            if (event.target.value === $InputPw.value && $InputPw.value.length > 0) {
                $Message.textContent = "입력 조건 통과.";
                return true;
            } else if ($InputPw.value.length === 0) {
                $Message.textContent = "비밀번호를 먼저 설정해 주세요.";
            } else {
                $Message.textContent = guide;
            }
            return false;
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
                        formValidState.isNickNameDupChecked = true;
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

        const sendAuthEmail = (event, $InputId) => {
            if ($InputId.value.length > 0) {

                appendStatusIcon(event.target, "FETCHING");
                event.target.disabled = true;

                fetch("/mail/auth", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({
                        MEMBER_ID: $InputId.value.concat("@hmail.hanyang.ac.kr")
                    })
                }).then(async response => {

                    if ((await response.json()).success === 1) {
                        let $AuthRow = document.getElementById("AUTH-ROW");
                        appendStatusIcon(event.target, "SUCCESS");
                        if ($AuthRow.classList.contains("--Auth-Closed")) {
                            $AuthRow.classList.remove("--Auth-Closed");
                        }
                    } else {
                        appendStatusIcon(event.target, "ERROR");
                    }

                }).catch(error => {
                    console.log(error);
                });
                return true;
            } else {
                alert("아이디를 먼저 입력해주세요!");
            }
            return false;
        };

        const checkAuthNum = (event, $InputAuthNum, $InputId) => {

            return new Promise((resolve, reject) => {
                if (Number.isInteger(parseInt($InputAuthNum.value)) && $InputAuthNum.value.length === 4) {

                    appendStatusIcon(event.target, "FETCHING");
                    event.target.disabled = true;

                    fetch("/auth/isValidAuthNum", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json; charset=utf-8"
                        },
                        body: JSON.stringify({
                            MEMBER_ID: $InputId.value.concat("@hmail.hanyang.ac.kr"),
                            AUTH_NUM: $InputAuthNum.value
                        })
                    }).then(async response => {
                        event.target.innerHTML = "";
                        const authResult = await response.json();
                        if (authResult.success === 1 && authResult.isValid === true) {
                            appendStatusIcon(event.target, "SUCCESS");
                            resolve(true);
                        } else {
                            alert("잘못된 인증번호 입니다.");
                            appendStatusIcon(event.target, "ERROR");
                            $InputAuthNum.focus();
                        }
                    })

                } else {
                    alert("유효한 인증번호 양식을 입력해주세요.");
                }
            })
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

        const validateAll = () => {

            for (const key in formValidState) {
                if (!formValidState[key]) {
                    switch (key) {
                        case "isMailSent" :
                            alert("인증번호 발송을 위해 발송 버튼을 눌러주세요.");
                            return false;
                        case "isMailAuthorized" :
                            alert("메일에 발송된 인증번호로 인증해 주세요.");
                            return false;
                        case "isPwOK" :
                            alert("유효하지 않은 비밀번호 양식입니다.");
                            return false;
                        case "isPwConfirmEquals" :
                            alert("비밀번호 확인값이 비밀번호와 동일하지 않습니다.");
                            return false;
                        case "isNickNameOK" :
                            alert("유효한 닉네임 양식을 입력해 주세요.");
                            return false;
                        case "isNickNameDupChecked" :
                            alert("닉네임이 중복되는지 확인해 주세요.");
                            return false;
                        case "isPhoneOK" :
                            alert("유효한 휴대전화 번호 양식을 입력해 주세요.");
                            return false;
                        case "isProfileImageOK" :
                            alert("유효한 프로필 이미지를 등록해 주세요.");
                            return false;
                    }
                }
            }

            return true;

        }

    </script>
</head>
<body>
<div class="Join-Wrapper">
    <div class="Join-Box">
        <div class="Profile-Image-Circle">
            <img id="PROFILE_IMAGE_VIEW" src="/resources/images/default-user.png" alt="">
        </div>
        <div class="Join-Header">
            <h2 class="Join-Header-Text"><span class="--Logo-Text-Style">EIKI</span> 회원가입</h2>
            <p class="Join-Header-Paragraph">EIKI의 회원이 되어 "오늘 뭐 먹지?"에 이바지 합시다.</p>
        </div>
        <form class="Join-Form" action="/member/join" method="POST" enctype="multipart/form-data">
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
