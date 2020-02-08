<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 스토어 등록</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/post.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar_admin.js" />"></script>
    <script>

        window.onload = () => {

            initTopBarAdminEvents();
            initPostEvents();

        };

        const initPostEvents = () => {

            let $AddThumbnail = document.getElementById("FILE-THUMBNAIL");
            let $ThumbnailInput = document.getElementById("THUMBNAIL-INPUT");
            $AddThumbnail.addEventListener("click", () => {
                $ThumbnailInput.click();
            });

            $ThumbnailInput.addEventListener("input", handleOnFileInput);


            let $AddFile = document.getElementById("FILE-ADD");
            $AddFile.addEventListener("click", handleAddFile);

            let $PostBtn = document.getElementById("POST-BTN");
            $PostBtn.addEventListener("click", requestStorePost);

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

            $ImagePreviewList.innerHTML = "";

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

            if (!document.getElementById("THUMBNAIL-INPUT").files[0]) {
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

            let files = [];
            let $FileInputs = document.getElementById("STORE-IMAGES").querySelectorAll(".Post-File-Btn input");
            for (let index = 0; index < $FileInputs.length; index++) {
                if ($FileInputs.item(index).files[0]) {
                    files.push($FileInputs.item(index).files[0]);
                }
            }

            return {
                STORE_NAME: document.getElementById("STORE_NAME").value,
                STORE_TYPE: document.querySelector("input[name='STORE_TYPE']:checked").value,
                IS_DELIVERY: document.querySelector("input[name='IS_DELIVERY']:checked").value === "O",
                STORE_THUMBNAIL: document.getElementById("THUMBNAIL-INPUT").files[0],
                STORE_IMAGES: files,
                STORE_LATITUDE: parseFloat(document.getElementById("STORE_LATITUDE").value),
                STORE_LONGITUDE: parseFloat(document.getElementById("STORE_LONGITUDE").value),
                STORE_DESCRIPTION: document.getElementById("STORE_DESCRIPTION").value
            };

        };

        const requestStorePost = () => {

            let reqBody = validateAll();

            if (reqBody) {

                let formData = new FormData();
                for (let key in reqBody) {
                    if (key !== "STORE_IMAGES") {
                        formData.append(key, reqBody[key]);
                    } else {
                        for (let index = 0; index < reqBody[key].length; index++) {
                            formData.append(key, reqBody[key][index]);
                        }
                    }

                }

                fetch("/eiki/admin/post", {
                    method: "POST",
                    body: formData
                })

            }


        }

    </script>
</head>
<body>
<c:import url="component/topbar_admin.jsp" charEncoding="UTF-8"/>

<div class="Store-Post-Box">

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="STORE_NAME">스토어 이름</label></span>
                </div>
            </div>
            <div class="Store-Post-Content">
                <input class="Post-Text-Input" id="STORE_NAME" name="STORE_NAME" placeholder="스토어 이름..." type="text">
            </div>
        </div>
    </div>

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="">스토어 타입</label></span>
                </div>
            </div>
        </div>
        <div class="Store-Post-Content">
            <div class="Post-Radio-Box">
                <label>
                    식당
                    <input value="RESTAURANT" checked name="STORE_TYPE" type="radio">
                </label>
                <label>
                    카페
                    <input value="CAFE" name="STORE_TYPE" type="radio">
                </label>
                <label>
                    PC방
                    <input value="PC" name="STORE_TYPE" type="radio">
                </label>
            </div>
        </div>
    </div>

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="">배달 유무</label></span>
                </div>
            </div>
        </div>
        <div class="Store-Post-Content">
            <div class="Post-Radio-Box">
                <label>
                    O
                    <input value="O" checked name="IS_DELIVERY" type="radio">
                </label>
                <label>
                    X
                    <input value="X" name="IS_DELIVERY" type="radio">
                </label>
            </div>
        </div>
    </div>

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="">썸네일 대표 이미지</label></span>
                </div>
            </div>
        </div>
        <div id="IMAGE-THUMBNAIL" class="Image-Preview-List"></div>
        <div class="Store-Post-Content">
            <div class="Post-File-Group">
                <div id="FILE-THUMBNAIL" class="Post-File-Btn">
                    파일 선택
                    <input id="THUMBNAIL-INPUT" class="--Display-None" accept=".jpg, .jpeg, .png" type="file">
                </div>
                <div class="Post-File-Title"></div>
            </div>
        </div>
    </div>

    <div class="Post-Input-Group">
        <div class="Store-Post-Category">
            <div>
                <span>이미지 리스트</span>
            </div>
            <div>
                <span id="FILE-ADD" class="File-Add-Text">파일 추가</span>
            </div>
        </div>
        <div id="IMAGE-LIST" class="Image-Preview-List"></div>
        <div id="STORE-IMAGES" class="Store-Post-Content"></div>
    </div>

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span>위치</span>
                </div>
            </div>
        </div>
        <div class="Store-Post-Content">
            <input placeholder="위도..." class="Post-Text-Input" id="STORE_LATITUDE" name="STORE_LATITUDE" type="text">
            <input placeholder="경도..." class="Post-Text-Input" id="STORE_LONGITUDE" name="STORE_LONGITUDE" type="text">
        </div>
    </div>

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="STORE_DESCRIPTION">짧은 소개</label></span>
                </div>
            </div>
        </div>
        <div class="Store-Post-Content">
            <input placeholder="짧은 소개..." class="Post-Text-Input" id="STORE_DESCRIPTION" type="text">
        </div>
    </div>

    <div class="Post-Btn-Row">
        <button id="POST-BTN" class="Post-Btn">스토어 등록</button>
    </div>

</div>

</body>
</html>
