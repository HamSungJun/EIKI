const QUERY_OBJ = Object.fromEntries(new URLSearchParams(window.location.search.substring(1)));

const initTopbarEvents = () => {

    let $NavIcon = document.querySelector(".Topbar-Nav-Tool");
    let $NavBox = document.querySelector(".Nav-Box");
    let $SearchInput = document.getElementById("SEARCH-INPUT");

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

    $SearchInput.value = QUERY_OBJ.search ? QUERY_OBJ.search : "";
    $SearchInput.addEventListener("keypress", (event) => {
        const keyCode = event.which || event.keyCode;
        if (keyCode === 13) {
            requestWithQuery(event.target.value, (QUERY_OBJ.order ? QUERY_OBJ.order : "pref"));
        }

    })

};

const requestWithQuery = (search, order) => {

    return window.location.href = "/eiki/home?search=" + search + "&order=" + order;

};