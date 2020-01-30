window.onload = () => {
    initInputEvents();
};

const initInputEvents = () => {

    let $FormInputs = document.querySelectorAll(".Index-Wrapper__Form__Input-Section__Grid-Row__Input-Column input");

    for (let index = 0; index < $FormInputs.length; index++) {

        let $FormInput = $FormInputs.item(index);
        let $FormRow = $FormInput.closest(".Index-Wrapper__Form__Input-Section__Grid-Row");
        let $FormIcon = $FormInput.parentNode.previousElementSibling;

        $FormInput.addEventListener("focus", (event) => {
            if (!$FormRow.classList.contains("--Border-Dark")) {
                $FormRow.classList.add("--Border-Dark");
                $FormIcon.classList.add("--Color-Dark");
            }
        });

        $FormInput.addEventListener("blur", (event) => {
            if ($FormInput.value.length === 0) {
                $FormRow.classList.remove("--Border-Dark");
                $FormIcon.classList.remove("--Color-Dark");
            }
        });

        $FormInput.addEventListener("input", () => {

            let isFormCompleted = 0;
            for (let index = 0; index < $FormInputs.length; index++) {
                if ($FormInputs.item(index).value.length > 0) {
                    isFormCompleted++;
                }
            }

            let $SubmitButton = document.querySelector(".Index-Wrapper__Form__Input-Section__Submit-Btn");
            let $AppHeaderText = document.querySelector(".Index-Wrapper__Form__Header-Section__Text");

            if (isFormCompleted === 2) {
                $SubmitButton.classList.add("--Submit-Active");
                $AppHeaderText.classList.add("--Color-Violet");
            } else {
                $SubmitButton.classList.remove("--Submit-Active");
                $AppHeaderText.classList.remove("--Color-Violet");
            }

        })

    }

    let $RememberElements = document.querySelectorAll([".Remember-Outer-Circle", ".Remember-Text"]);
    let $RememberInner = document.querySelector(".Remember-Inner-Circle");

    for (let index = 0; index < $RememberElements.length; index++) {
        $RememberElements.item(index).addEventListener("click", () => {
            $RememberInner.classList.toggle("--Background-Dark");
        })
    }

    let $SubmitButton = document.getElementById("SUBMIT_BTN");
    $SubmitButton.addEventListener("click", (event) => {
        event.preventDefault();
        if (event.target.classList.contains("--Submit-Active")) {
            fetch("/auth/login",{
                method : "POST",
                headers : {
                    "Content-type" : "application/json; charset=utf-8"
                },
                body : JSON.stringify({
                    "MEMBER_ID" : document.getElementById("MEMBER_ID").value,
                    "MEMBER_PW" : document.getElementById("MEMBER_PW").value
                })
            }).then(async response => {
                const loginResult = await response.json();
                console.log(loginResult);
                if(loginResult.success === 1 && loginResult.isMemberExist === true){
                    window.location.href = "/eiki/home";
                } else {
                    alert("가입되지 않은 계정이거나 잘못된 비밀번호 입니다.");
                }
            }).catch(error => {
                console.log(error);
            })
        } else {
            return alert("아이디와 비밀번호를 입력해주세요.");
        }
    })

};
