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

};