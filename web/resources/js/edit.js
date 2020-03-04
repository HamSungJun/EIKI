window.onload = () => {

    initTopBarAdminEvents();
    initStoreEditEvents();

};

const initStoreEditEvents = () => {

    let $StoreEditButtons = document.querySelectorAll(".--Store-Edit");
    let $StoreDeleteButtons = document.querySelectorAll(".--Store-Delete");

    for (let index = 0; index < $StoreEditButtons.length; index++) {

        let $StoreEditButton = $StoreEditButtons.item(index);
        let $StoreDeleteButton = $StoreDeleteButtons.item(index);

        let storeIdx = parseInt($StoreEditButton.closest(".Store-Data-Row").getAttribute("data-store-idx"));

        $StoreEditButton.addEventListener("click", () => {
            handleStoreEdit(storeIdx);
        });

        $StoreDeleteButton.addEventListener("click", () => {
            handleStoreDelete(storeIdx);
        });

    }
    ;

    let $StoreSearch = document.getElementById("STORE-SEARCH");
    $StoreSearch.addEventListener("keypress", (event) => {

        const key = event.which || event.keyCode;
        if (key === 13) handleStoreSearch(event.target.value);

    });

};

const handleStoreEdit = (storeIdx) => {

    return window.location.href = "/eiki/admin/store/edit/" + storeIdx;

};

const handleStoreDelete = (storeIdx) => {

    if (confirm("해당 스토어를 정말로 삭제할까요?")) {
        fetch("/eiki/admin/store/delete/" + storeIdx, {
            method: "DELETE",
        }).then(response => {
            if (response.status === 200) {
                alert("해당 스토어가 삭제되었습니다.");
                window.location.reload();
            }
        })
    }

};

const handleStoreSearch = (storeName) => {

    return window.location.href = "/eiki/admin/store/edit?storeName=" + storeName;

};