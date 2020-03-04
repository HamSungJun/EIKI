<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 스토어 수정 상세</title>
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
    <script src="<c:url value="/resources/js/editDetail.js" />"></script>
</head>
<body>
<c:import url="../../common/topbar_admin.jsp" charEncoding="UTF-8"/>

<div class="Store-Post-Box">

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="STORE_NAME">스토어 이름</label></span>
                </div>
            </div>
            <div class="Store-Post-Content">
                <input value="${StorePostHistory['STORE_NAME']}" class="Post-Text-Input" id="STORE_NAME"
                       name="STORE_NAME" placeholder="${StorePostHistory['STORE_NAME']}" type="text">
            </div>
        </div>
    </div>

    <div class="Post-Input-Group">
        <div>
            <div class="Store-Post-Category">
                <div>
                    <span><label for="STORE_NAME">스토어 연락처</label></span>
                </div>
            </div>
            <div class="Store-Post-Content">
                <input value="${StorePostHistory['STORE_CALL']}" maxlength="13" class="Post-Text-Input" id="STORE_CALL"
                       name="STORE_CALL"
                       placeholder="${StorePostHistory['STORE_CALL']}" type="text">
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
                    <input ${StorePostHistory["STORE_TYPE"] == "RESTAURANT" ? "checked" : ""} value="RESTAURANT"
                                                                                              name="STORE_TYPE"
                                                                                              type="radio">
                </label>
                <label>
                    카페
                    <input ${StorePostHistory["STORE_TYPE"] == "CAFE" ? "checked" : ""} value="CAFE" name="STORE_TYPE"
                                                                                        type="radio">
                </label>
                <label>
                    PC방
                    <input ${StorePostHistory["STORE_TYPE"] == "PC" ? "checked" : ""} value="PC" name="STORE_TYPE"
                                                                                      type="radio">
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
                    <input ${StorePostHistory["IS_DELIVERY"] ? "checked" : ""} value="O" name="IS_DELIVERY"
                                                                               type="radio">
                </label>
                <label>
                    X
                    <input ${!StorePostHistory["IS_DELIVERY"] ? "checked" : ""} value="X" name="IS_DELIVERY"
                                                                                type="radio">
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
        <div id="IMAGE-THUMBNAIL" class="Image-Preview-List">
            <div class="Preview-Item --From-Server">
                <div class="File-Remove-Circle">
                    <i class="fas fa-times"></i>
                </div>
                <img src="<c:url value="/resources/storeImages/${StoreImages[0]['STORE_IMAGE']}" />" alt="">
            </div>
        </div>
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
        <div id="IMAGE-LIST" class="Image-Preview-List">
            <c:forEach items="${StoreImages}" var="StoreImage" begin="1">
                <div class="Preview-Item --From-Server">
                    <div class="File-Remove-Circle">
                        <i class="fas fa-times"></i>
                    </div>
                    <img src="<c:url value="/resources/storeImages/${StoreImage['STORE_IMAGE']}" />" alt="">
                </div>
            </c:forEach>
        </div>
        <div id="STORE-IMAGES" class="Store-Post-Content"></div>
    </div>

    <div class="Post-Input-Group">
        <div class="Store-Post-Category">
            <div>
                <span>메뉴 리스트</span>
            </div>
            <div>
                <span id="MENU-ADD" class="File-Add-Text">메뉴 추가</span>
            </div>
        </div>
        <div id="MENU-LIST" class="Store-Post-Content">
            <c:forEach items="${StoreMenus}" var="StoreMenu">
                <div class="Menu-Item">
                    <div>
                        <input value="${StoreMenu['MENU_NAME']}" placeholder="메뉴 이름" type="text">
                    </div>
                    <div>
                        <input value="${StoreMenu['MENU_PRICE']}" placeholder="메뉴 가격" type="text">
                    </div>
                    <div class="Menu-Remove">
                        <i class="far fa-trash-alt"></i>
                    </div>
                </div>
            </c:forEach>
        </div>
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
            <input value="${StorePostHistory['STORE_LATITUDE']}" placeholder="${StorePostHistory['STORE_LATITUDE']}"
                   class="Post-Text-Input"
                   id="STORE_LATITUDE" name="STORE_LATITUDE" type="text">
            <input value="${StorePostHistory['STORE_LONGITUDE']}" placeholder="${StorePostHistory['STORE_LONGITUDE']}"
                   class="Post-Text-Input"
                   id="STORE_LONGITUDE" name="STORE_LONGITUDE" type="text">
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
            <input value="${StorePostHistory['STORE_DESCRIPTION']}"
                   placeholder="${StorePostHistory['STORE_DESCRIPTION']}" class="Post-Text-Input"
                   id="STORE_DESCRIPTION" type="text">
        </div>
    </div>

    <div class="Post-Btn-Row">
        <button id="POST-BTN" class="Post-Btn">스토어 수정</button>
    </div>

</div>

</body>
</html>
