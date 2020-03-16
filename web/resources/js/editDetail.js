let isFetching = false;

window.onload = () => {

    initTopBarAdminEvents();
    initStoreEditDetailEvents();

};

const initStoreEditDetailEvents = () => {

    let $AddThumbnail = document.getElementById("FILE-THUMBNAIL");
    let $ImageThumbnail = document.getElementById("IMAGE-THUMBNAIL");
    let $ThumbnailInput = document.getElementById("THUMBNAIL-INPUT");
    $AddThumbnail.addEventListener("click", () => {
        if ($ImageThumbnail.querySelector(".--From-Server")) {
            return alert("이미 서버에 썸네일 이미지가 존재합니다. 변경을 위해서는 삭제해 주세요.");
        }
        $ThumbnailInput.click();
    });

    $ThumbnailInput.addEventListener("input", handleOnFileInput);

    let $AddFile = document.getElementById("FILE-ADD");
    $AddFile.addEventListener("click", handleAddFile);

    let $PostBtn = document.getElementById("POST-BTN");
    $PostBtn.addEventListener("click", requestStoreUpdate);

    let $MenuAdd = document.getElementById("MENU-ADD");
    $MenuAdd.addEventListener("click", handleAddMenu);

    let $MenuHistory = document.querySelectorAll(".Menu-Item");

    if ($MenuHistory.length > 0) {
        console.log($MenuHistory);
        for (let index = 0; index < $MenuHistory.length; index++) {

            let $MenuRemove = $MenuHistory.item(index).querySelector(".Menu-Remove");
            $MenuRemove.addEventListener("click", () => {
                $MenuHistory.item(index).remove();
            })

        }

    }

    let $RemoveCircles = document.querySelectorAll(".File-Remove-Circle");
    for (let index = 0; index < $RemoveCircles.length; index++) {

        let $RemoveCircle = $RemoveCircles.item(index);

        $RemoveCircle.addEventListener("click", (event) => {

            let $PreviewItem = event.target.closest(".Preview-Item");
            let _fileName = $PreviewItem.querySelector("img").src;
            _fileName = _fileName.substring(_fileName.lastIndexOf("/") + 1);
            requestServerImageRemove($PreviewItem, _fileName);

        });

    }

};

const handleAddMenu = () => {

    let $MenuList = document.getElementById("MENU-LIST");

    let $MenuItem = document.createElement("div");
    $MenuItem.classList.add("Menu-Item");

    let $MenuTitleBox = document.createElement("div");
    let $MenuTitleInput = document.createElement("input");
    $MenuTitleInput.setAttribute("placeholder", "메뉴 이름");

    let $MenuPriceBox = document.createElement("div");
    let $MenuPriceInput = document.createElement("input");
    $MenuPriceInput.setAttribute("placeholder", "메뉴 가격");

    let $MenuRemoveBox = document.createElement("div");
    $MenuRemoveBox.classList.add("Menu-Remove");
    $MenuRemoveBox.addEventListener("click", () => {
        $MenuItem.remove();
    });

    let $MenuRemoveIcon = document.createElement("i");
    $MenuRemoveIcon.classList.add("far", "fa-trash-alt");

    $MenuTitleBox.appendChild($MenuTitleInput);
    $MenuPriceBox.appendChild($MenuPriceInput);
    $MenuRemoveBox.appendChild($MenuRemoveIcon);

    $MenuItem.appendChild($MenuTitleBox);
    $MenuItem.appendChild($MenuPriceBox);
    $MenuItem.appendChild($MenuRemoveBox);

    $MenuList.appendChild($MenuItem);

};

const handleAddFile = (event) => {

    let $FileContent = event.target.closest("div.Post-Input-Group").querySelector(".Store-Post-Content");
    let $FileInputGroup = createFileInputGroup();

    $FileContent.appendChild($FileInputGroup);

};

const createFileInputGroup = () => {

    let $FileGroup = document.createElement("div");
    $FileGroup.classList.add("Post-File-Group");

    let $FileBtn = document.createElement("div");
    $FileBtn.classList.add("Post-File-Btn");
    $FileBtn.textContent = "파일 선택";

    let $FileTitle = document.createElement("div");
    $FileTitle.classList.add("Post-File-Title");

    let $FileInput = document.createElement("input");
    $FileInput.setAttribute("type", "file");
    $FileInput.setAttribute("accept", ".jpg, .jpeg, .png");
    $FileInput.classList.add("--Display-None");

    let $FileRemove = document.createElement("div");
    $FileRemove.classList.add("File-Remove");

    let $FileRemoveIcon = document.createElement("i");
    $FileRemoveIcon.classList.add("far", "fa-trash-alt");

    $FileBtn.addEventListener("click", () => {
        $FileInput.click();
    });

    $FileRemove.addEventListener("click", (event) => {
        let $PostInputGroup = event.target.closest("div.Post-Input-Group");
        $FileGroup.remove();
        let $FileInputs = $PostInputGroup.querySelectorAll(".Post-File-Btn input");
        let $ImagePreviewList = $PostInputGroup.querySelector(".Image-Preview-List");
        refreshPreview($FileInputs, $ImagePreviewList);
    });

    $FileInput.addEventListener("input", handleOnFileInput);

    $FileBtn.appendChild($FileInput);
    $FileRemove.appendChild($FileRemoveIcon);

    [$FileBtn, $FileTitle, $FileRemove].forEach(el => {
        $FileGroup.appendChild(el);
    });

    return $FileGroup;

};

const handleOnFileInput = (event) => {

    let fileIn = event.target.files[0];
    let $FileName = event.target.parentNode.nextElementSibling;

    if (fileIn) {

        if (fileIn.size > 2000000) {
            event.target.value = "";
            $FileName.textContent = "2MB 이하 이미지 파일만 업로드 가능합니다.";
            return;
        }

        $FileName.textContent = fileIn.name;

        let $FileInputs = event.target.closest("div.Post-Input-Group").querySelectorAll(".Post-File-Btn input");
        let $ImagePreviewList = event.target.closest("div.Post-Input-Group").querySelector(".Image-Preview-List");

        refreshPreview($FileInputs, $ImagePreviewList);

    }

};

const refreshPreview = ($FileInputs, $ImagePreviewList) => {

    let $BeforeImages = $ImagePreviewList.querySelectorAll(".Preview-Item");
    for (let index = 0; index < $BeforeImages.length; index++) {
        if (!$BeforeImages.item(index).classList.contains("--From-Server")) {
            $BeforeImages.item(index).remove();
        }
    }

    let files = [];
    for (let index = 0; index < $FileInputs.length; index++) {
        let fileIn = $FileInputs.item(index).files[0];
        if (fileIn) {
            files.push(fileIn);
        }
    }

    Promise.all(files.map(file => fileToBlobURL(file))).then(blobURLs => {

        blobURLs.forEach(blobURL => {

            let $PreviewItem = document.createElement("div");
            $PreviewItem.classList.add("Preview-Item");

            let $PreviewImage = document.createElement("img");
            $PreviewImage.src = blobURL;

            $PreviewItem.appendChild($PreviewImage);
            $ImagePreviewList.appendChild($PreviewItem);

        });

    })

};

const fileToBlobURL = (file) => {

    return new Promise((resolve, reject) => {

        let fileReader = new FileReader();

        fileReader.onload = (e) => {
            let UInt8View = new Uint8Array(e.target.result);
            resolve(URL.createObjectURL(new Blob([UInt8View])));
        };

        fileReader.readAsArrayBuffer(file);

    })

};

const validateAll = () => {

    if (document.getElementById("STORE_NAME").value.length === 0) {
        return alert("최소 한글자의 스토어 이름을 입력해주세요.");
    }

    if (!(new RegExp(/[0-9]{3}-[0-9]{3,4}-[0-9]{4}/).test(document.getElementById("STORE_CALL").value))) {
        return alert("올바른 연락처 양식이 아닙니다.");
    }

    if (!document.getElementById("THUMBNAIL-INPUT").files[0] && !document.querySelector("#IMAGE-THUMBNAIL .--From-Server")) {
        return alert("썸네일 대표 이미지를 등록해 주세요.");
    }

    if (document.getElementById("STORE_LATITUDE").value.length === 0 || isNaN(parseFloat(document.getElementById("STORE_LATITUDE").value))) {
        return alert("올바른 위도 값을 입력해 주세요.");
    }

    if (document.getElementById("STORE_LONGITUDE").value.length === 0 || isNaN(parseFloat(document.getElementById("STORE_LONGITUDE").value))) {
        return alert("올바른 경도 값을 입력해 주세요.");
    }

    if (document.getElementById("STORE_DESCRIPTION").value.length === 0) {
        return alert("스토어 짧은 소개를 입력해 주세요.");
    }

    let menus = [];
    let $MenuItems = document.getElementById("MENU-LIST").querySelectorAll(".Menu-Item");
    for (let index = 0; index < $MenuItems.length; index++) {

        let $MenuInputs = $MenuItems.item(index).querySelectorAll("input");
        const nameValue = $MenuInputs.item(0).value;
        const priceValue = $MenuInputs.item(1).value;

        if (nameValue.length > 0 && Number.isInteger(parseInt(priceValue))) {
            menus.push({
                MENU_NAME: nameValue,
                MENU_PRICE: parseInt(priceValue)
            })
        } else {
            return alert("유효한 메뉴 이름과 가격을 입력해 주십시오.");
        }

    }

    let files = [];
    let $FileInputs = document.getElementById("STORE-IMAGES").querySelectorAll(".Post-File-Btn input");
    for (let index = 0; index < $FileInputs.length; index++) {
        if ($FileInputs.item(index).files[0]) {
            files.push($FileInputs.item(index).files[0]);
        }
    }

    const reqBody = {
        STORE_NAME: document.getElementById("STORE_NAME").value,
        STORE_CALL: document.getElementById("STORE_CALL").value,
        STORE_TYPE: document.querySelector("input[name='STORE_TYPE']:checked").value,
        IS_DELIVERY: document.querySelector("input[name='IS_DELIVERY']:checked").value === "O",
        STORE_THUMBNAIL: document.querySelector("#IMAGE-THUMBNAIL .--From-Server") ? null : document.getElementById("THUMBNAIL-INPUT").files[0],
        STORE_IMAGES: files.length > 0 ? files : null,
        STORE_MENUS: JSON.stringify(menus),
        STORE_LATITUDE: parseFloat(document.getElementById("STORE_LATITUDE").value),
        STORE_LONGITUDE: parseFloat(document.getElementById("STORE_LONGITUDE").value),
        STORE_DESCRIPTION: document.getElementById("STORE_DESCRIPTION").value
    };

    // console.log(reqBody);

    return reqBody

};

const requestStoreUpdate = () => {

    let reqBody = validateAll();

    if (reqBody) {
        console.log(reqBody);
        let formData = new FormData();
        for (let key in reqBody) {
            if (!["STORE_IMAGES"].includes(key)) {
                formData.append(key, reqBody[key]);
            } else {
                if (reqBody[key] !== null && reqBody[key].length > 0) {
                    for (let index = 0; index < reqBody[key].length; index++) {
                        formData.append(key, reqBody[key][index]);
                    }
                }
            }

        }

        const pathName = window.location.pathname;

        if (!isFetching) {
            fetch("/eiki/admin/store/update/" + parseInt(pathName.substring(pathName.lastIndexOf("/") + 1)), {
                method: "POST",
                body: formData
            }).then(async response => {
                if (response.status === 200) {
                    alert("스토어가 성공적으로 업데이트 되었습니다.");
                    window.location.href = "/eiki/admin/store/edit";
                }
            }).catch(error => {
                console.log(error);
            })
        }

    }

};

const requestServerImageRemove = ($PreviewItem, _fileName) => {

    if (confirm("해당 이미지를 서버상에서 지우시겠습니까?")) {

        fetch("/eiki/admin/store/image/delete/" + encodeURIComponent(_fileName), {
            method: "DELETE",
        }).then(async response => {
            if (response.status === 200) {
                alert("해당 이미지가 서버상에서 삭제되었습니다.");
                return $PreviewItem.remove();
            }
        }).catch(error => {
            console.log(error);
        })

    }

};