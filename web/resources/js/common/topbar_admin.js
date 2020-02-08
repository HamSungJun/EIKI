const initTopBarAdminEvents = () => {

    let $NavIcon = document.querySelector(".Topbar-Nav-Tool");
    let $NavBox = document.querySelector(".Nav-Box");
    let $LogoText = document.querySelector(".Topbar-Logo-Text");

    $NavIcon.addEventListener("click", (event) => {
        event.stopPropagation();
        if (!$NavIcon.firstElementChild.classList.contains("--Half-Spin-Once-Forward")) {
            $NavIcon.firstElementChild.classList.remove("--Half-Spin-Once-Reverse");
            $NavIcon.firstElementChild.classList.add("--Half-Spin-Once-Forward")
        } else {
            $NavIcon.firstElementChild.classList.remove("--Half-Spin-Once-Forward");
            $NavIcon.firstElementChild.classList.add("--Half-Spin-Once-Reverse");
        }

        $NavBox.classList.toggle("--Nav-Fold");
    });

    $LogoText.addEventListener("click", () => {
        window.location.href = "/eiki/admin";
    })

}

