window.onload = () => {

    initTopbarEvents();
    initBodyEvents();

};

const initBodyEvents = () => {

    let $OrderPref = document.getElementById("ORDER-PREF");
    let $OrderComment = document.getElementById("ORDER-COMMENT");
    let $OrderName = document.getElementById("ORDER-NAME");
    let $SearchInput = document.getElementById("SEARCH-INPUT");

    if (!QUERY_OBJ.order) {
        $OrderPref.classList.add("--Sort-Btn-Active");
    } else {

        switch (QUERY_OBJ.order) {
            case "pref" :
                $OrderPref.classList.add("--Sort-Btn-Active");
                break;
            case "comment" :
                $OrderComment.classList.add("--Sort-Btn-Active");
                break;
            case "name" :
                $OrderName.classList.add("--Sort-Btn-Active");
                break;
            default :
                $OrderPref.classList.add("--Sort-Btn-Active");
                break;
        }
    }

    $OrderPref.addEventListener("click", () => {
        requestWithQuery($SearchInput.value, "pref");
    });

    $OrderComment.addEventListener("click", () => {
        requestWithQuery($SearchInput.value, "comment");
    });

    $OrderName.addEventListener("click", () => {
        requestWithQuery($SearchInput.value, "name");
    });

};