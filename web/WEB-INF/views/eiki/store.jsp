<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI - ${StoreInfo['STORE_NAME']}</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/store.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/viewer.min.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar.js" />"></script>
    <script src="<c:url value="/resources/js/viewer.min.js" />"></script>
    <script>

        let isCommentFetching = false;
        let isCommentPreferenceFetching = false;
        let isCommentDeleteFetching = false;

        window.onload = () => {
            new Viewer(document.getElementById("images"), {
                inline: false,
                backdrop: true,
                button: true,
                navbar: true,
                title: false,
                movable: false,
                toggleOnDblclick: false,
                toolbar: {
                    zoomIn: 2,
                    zoomOut: 2,
                    oneToOne: 2,
                    reset: 2,
                    prev: 2,
                    play: {
                        show: 0,
                        size: 'large',
                    },
                    next: 1,
                    rotateLeft: 1,
                    rotateRight: 1,
                    flipHorizontal: 1,
                    flipVertical: 1,
                },
            });
            initTopbarEvents();
            initReviewEvents();
        };

        const initReviewEvents = () => {

            let $CommentWrite = document.getElementById("COMMENT-WRITE");
            let $CommentInterface = document.querySelector(".Review-Interface");
            let $CommentPost = document.getElementById("COMMENT-POST");
            let $CommentInput = document.getElementById("COMMENT-INPUT");

            $CommentWrite.addEventListener("click", () => {
                $CommentInput.focus();
            });
            $CommentPost.addEventListener("click", postStoreComment);
            $CommentInput.addEventListener("keypress", (event) => {
                const keyCode = event.which || event.keyCode;
                if (keyCode === 13) {
                    postStoreComment();
                }
            });

            let $MenuShow = document.getElementById("MENU-SHOW");
            let $MenuList = document.querySelector(".Menu-List");
            $MenuList.style.maxHeight = $MenuList.scrollHeight + "px";

            let $PrefPost = document.getElementById("PREF-POST");
            let $PrefPostBox = document.querySelector(".Pref-Post-Box");

            toggleBoxHeight($PrefPost, $PrefPostBox, "선호도 선택", "선호도 접기");
            toggleBoxHeight($MenuShow, $MenuList, "메뉴 보기", "메뉴 접기");
            toggleBoxHeight($CommentWrite, $CommentInterface, "후기 남기기", "후기 접기");

            let $PostPrefInputs = document.querySelectorAll(".Pref-Radio-Item label input");
            for (let index = 0; index < $PostPrefInputs.length; index++) {
                $PostPrefInputs.item(index).addEventListener("click", (event) => {
                    event.stopPropagation();
                    postStorePreference(event.target.value);
                })
            }

        };

        const toggleBoxHeight = ($Controller, $Box, beforeText, afterText) => {

            $Controller.addEventListener("click", () => {
                $Box.classList.toggle("--Interface-Fold");
                if ($Box.classList.contains("--Interface-Fold")) {
                    $Controller.textContent = beforeText;
                } else {
                    $Controller.textContent = afterText;
                }
            });

            $Controller.textContent = beforeText;

        };

        const postStorePreference = (prefValue) => {

            fetch("/eiki/store/preference", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=utf-8"
                },
                body: JSON.stringify({
                    STORE_DEC_IDX: <c:out value="${StoreInfo['STORE_DEC_IDX']}" />,
                    MEMBER_DEC_IDX: <c:out value="${User['MEMBER_DEC_IDX']}" />,
                    PREFERENCE: parseInt(prefValue)
                })
            }).then(async response => {
                if ((await response.json()).success === 1) {
                    window.location.reload();
                }
            }).catch(error => {
                console.log(error)
            })

        };

        const postStoreComment = () => {

            let $CommentInput = document.getElementById("COMMENT-INPUT");
            if ($CommentInput.value.length > 0) {

                if (!isCommentFetching) {

                    fetch("/eiki/store/comment", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json; charset=utf-8"
                        },
                        body: JSON.stringify({
                            STORE_DEC_IDX: <c:out value="${StoreInfo['STORE_DEC_IDX']}" />,
                            MEMBER_DEC_IDX: <c:out value="${User['MEMBER_DEC_IDX']}" />,
                            COMMENT_CONTENT: $CommentInput.value
                        })
                    }).then(async response => {
                        if ((await response.json()).success === 1) {
                            window.location.reload();
                        }
                    }).catch(error => {
                        console.log(error);
                    })

                }

            } else {
                return alert("최소 한글자의 코멘트는 입력해야 합니다.");
            }

        };

        const deleteStoreComment = (storeIdx, memberIdx, commentIdx) => {

            if (!isCommentDeleteFetching) {

                fetch("/eiki/store/comment", {
                    method: "DELETE",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({
                        STORE_DEC_IDX: parseInt(storeIdx),
                        MEMBER_DEC_IDX: parseInt(memberIdx),
                        COMMENT_DEC_IDX: parseInt(commentIdx)
                    })
                }).then(async response => {
                    const toJson = await response.json();
                    if (toJson.success === 1) {
                        refreshCommentPreferences(toJson.refreshedComments || []);
                    }
                }).catch(error => {
                    console.log(error);
                })

            }

            return;

        };

        const postCommentPreference = (storeIdx, memberIdx, commentIdx) => {

            if (!isCommentPreferenceFetching) {
                fetch("/eiki/store/comment/preference", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({
                        STORE_DEC_IDX: parseInt(storeIdx),
                        MEMBER_DEC_IDX: parseInt(memberIdx),
                        COMMENT_DEC_IDX: parseInt(commentIdx)
                    })
                }).then(async response => {
                    const toJson = await response.json();
                    if (toJson.success === 1) {
                        refreshCommentPreferences(toJson.refreshedComments || []);
                    }
                }).catch(error => {
                    console.log(error);
                })

            }

            return;

        };

        const refreshCommentPreferences = (refreshedComments) => {

            let $ReviewListBox = document.querySelector(".Review-List-Box");
            $ReviewListBox.innerHTML = "";

            if (refreshedComments.length > 0) {
                refreshedComments.forEach(comment => {

                    let $ReviewRow = document.createElement("div");
                    $ReviewRow.classList.add("Review-Row");

                    let $ReviewMemberImage = document.createElement("div");
                    $ReviewMemberImage.classList.add("Review-Member-Image");

                    let $MemberImage = document.createElement("img");
                    $MemberImage.setAttribute("src", "/resources/userImages/" + comment["MEMBER_PROFILE_IMAGE"]);

                    let $ReviewBody = document.createElement("div");

                    let $ReviewHeader = document.createElement("div");
                    $ReviewHeader.classList.add("Review-Header");

                    let $ReviewNickname = document.createElement("div");
                    $ReviewNickname.classList.add("--D-Flex-Center");

                    let $Nickname = document.createElement("span");
                    $Nickname.classList.add("Review-Nickname");
                    $Nickname.textContent = comment["MEMBER_NICKNAME"];

                    let $ReviewPref = document.createElement("div");
                    $ReviewPref.classList.add("Review-Pref");

                    let $HeartPrefWrapper = document.createElement("span");
                    $HeartPrefWrapper.classList.add("Heart-Pref-Wrapper");
                    $HeartPrefWrapper.addEventListener("click", () => {
                        postCommentPreference(
                            comment["STORE_DEC_IDX"],
                            comment["MEMBER_DEC_IDX"],
                            comment["COMMENT_DEC_IDX"]
                        )
                    });

                    let $WrapperItem_1 = document.createElement("span");
                    let $WrapperItem_2 = document.createElement("span");
                    $WrapperItem_1.classList.add("Wrapper-Item");
                    $WrapperItem_2.classList.add("Wrapper-Item");

                    let $HeartIcon = document.createElement("i");
                    $HeartIcon.classList.add("fas", "fa-heart", "Heart-Icon");

                    let $CommentPreference = document.createElement("span");
                    $CommentPreference.classList.add("Comment-Preference");
                    $CommentPreference.textContent = comment["COMMENT_PREFERENCE"];

                    let $ReviewContent = document.createElement("div");
                    $ReviewContent.classList.add("Review-Content");

                    let $ReviewContentText = document.createElement("p");
                    $ReviewContentText.classList.add("Review-Content-Text");
                    $ReviewContentText.textContent = comment["COMMENT_CONTENT"];

                    $ReviewMemberImage.appendChild($MemberImage);
                    $ReviewRow.appendChild($ReviewMemberImage);

                    $ReviewNickname.appendChild($Nickname);
                    $ReviewHeader.appendChild($ReviewNickname);

                    $WrapperItem_1.appendChild($HeartIcon);
                    $WrapperItem_2.appendChild($CommentPreference);
                    $HeartPrefWrapper.appendChild($WrapperItem_1);
                    $HeartPrefWrapper.appendChild($WrapperItem_2);

                    $ReviewPref.appendChild($HeartPrefWrapper);

                    if (<c:out value="${User['MEMBER_DEC_IDX']}" /> ===
                    comment["MEMBER_DEC_IDX"]
                )
                    {
                        let $DeleteCommentBox = document.createElement("span");
                        $DeleteCommentBox.classList.add("Delete-Comment-Box");
                        $DeleteCommentBox.addEventListener("click", () => {
                            deleteStoreComment(
                                comment["STORE_DEC_IDX"],
                                comment["MEMBER_DEC_IDX"],
                                comment["COMMENT_DEC_IDX"]
                            )
                        });
                        let $DeleteIcon = document.createElement("i");
                        $DeleteIcon.classList.add("far", "fa-trash-alt");
                        $DeleteCommentBox.appendChild($DeleteIcon);
                        $ReviewPref.appendChild($DeleteCommentBox);
                    }

                    $ReviewHeader.appendChild($ReviewPref);

                    $ReviewContent.appendChild($ReviewContentText);

                    $ReviewBody.appendChild($ReviewHeader);
                    $ReviewBody.appendChild($ReviewContent);
                    $ReviewRow.appendChild($ReviewBody);

                    $ReviewListBox.appendChild($ReviewRow);

                });

            }

        };

    </script>

</head>
<body>

<c:import url="common/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_DEC_IDX" value="${User.MEMBER_DEC_IDX}"/>
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
    <c:param name="IS_ADMIN" value="${User.IS_ADMIN}"/>
</c:import>

<div class="Store-Box">

    <div class="Info-Box">
        <div class="Info-Box-Item Info-Box-Left">
            <div class="Info-Box-Title-Row">
                <div class="--D-Flex-Center Title-Icon-Box">
                    <i class="fas fa-utensils fa-1x"></i>
                </div>
                <div class="--D-Flex --Align-Items-Center --Justify-Flex-Start">
                    <span class="Title-Text">${StoreInfo['STORE_NAME']}</span>
                </div>
                <div class="--D-Flex-Center">
                    <div class="Badge">
                        <div class="Badge-Icon">
                            <i class="fas fa-motorcycle Icon-Delivery"></i>
                        </div>
                        <div class="Badge-Value">
                            <c:choose>
                                <c:when test="${StoreInfo['IS_DELIVERY'] == true}">
                                    <span>O</span>
                                </c:when>
                                <c:when test="${StoreInfo['IS_DELIVERY'] == false}">
                                    <span>X</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="--D-Flex-Center">
                    <div class="Badge">
                        <div class="Badge-Icon">
                            <i class="fas fa-phone Icon-Phone"></i>
                        </div>
                        <div class="Badge-Value">
                            <span>${StoreInfo['STORE_CALL']}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="Info-Box-Body-Row">
                <div id="images" class="Body-Image-Box">
                    <div class="Other-Image-Row">
                        <c:forEach items="${StoreImages}" var="StoreImage" begin="1">
                            <div class="Other-Image-Box">
                                <img src="<c:url value="/resources/storeImages/${StoreImage['STORE_IMAGE']}" />" alt="">
                            </div>
                        </c:forEach>
                    </div>
                    <div class="Thumbnail-Image-Box">
                        <img src="<c:url value="/resources/storeImages/${StoreImages[0]['STORE_IMAGE']}" />" alt="">
                    </div>
                </div>
                <div class="Body-Content-Box">
                    <div>
                        <div class="Content-Category">
                            <div class="Category-Title">
                                <span>짧은 한마디</span>
                            </div>
                            <div>

                            </div>
                        </div>
                        <div class="Content-Body">
                            <p class="Content-Body-Text">${StoreInfo['STORE_DESCRIPTION']}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="Info-Box-Item Info-Box-Right">
            <div class="Content-Category">
                <div class="Category-Title">
                    <span>위치</span>
                </div>
            </div>
            <div id="map" class="Google-Map-Container">

            </div>
            <script>
                let map;
                let storePoint = {
                    lat: <c:out value="${StoreInfo['STORE_LATITUDE']}" />,
                    lng: <c:out value="${StoreInfo['STORE_LONGITUDE']}" />
                };

                function initMap() {
                    map = new google.maps.Map(document.getElementById('map'), {
                        center: storePoint,
                        zoom: 15
                    });
                    let storeMarker = new google.maps.Marker({
                        position: storePoint,
                        draggable: false,
                        animation: google.maps.Animation.DROP,
                        map: map
                    });
                }
            </script>
            <script async defer
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJOLhG5j0iE_NuSx9-9DJbmL2KHa_bb-0&callback=initMap">
            </script>
            <div>
                <div class="Content-Category">
                    <div class="Category-Title">
                        <span>선호도</span>
                    </div>
                    <div class="--D-Flex-Center">
                        <span id="PREF-POST" class="Review-Write-Text">선호도 선택</span>
                    </div>
                </div>
                <div class="Content-Body">
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">5.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_FIVE_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">4.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_FOUR_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">3.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge"
                                 style="grid-template-columns: ${StoreInfo['PREF_THREE_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">2.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_TWO_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Row">
                        <div class="Pref-Category --D-Flex-Center">1.0</div>
                        <div class="Pref-Value --D-Flex-Center">
                            <div class="Pref-Gauge" style="grid-template-columns: ${StoreInfo['PREF_ONE_RATIO']}% 1fr">
                                <div class="Pref-Gauge-Value"></div>
                                <div class="Pref-Gauge-Padding"></div>
                            </div>
                        </div>
                    </div>
                    <div class="Pref-Post-Box --Interface-Fold">
                        <div class="Pref-Radio-Row">
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>1.0</span>
                                    <input ${StoreInfo["PREF_SELECTED"] == 1 ? 'checked' : ''} value="1"
                                                                                               name="STORE_PREFERENCE"
                                                                                               type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>2.0</span>
                                    <input ${StoreInfo["PREF_SELECTED"] == 2 ? 'checked' : ''} value="2"
                                                                                               name="STORE_PREFERENCE"
                                                                                               type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>3.0</span>
                                    <input ${StoreInfo["PREF_SELECTED"] == 3 ? 'checked' : ''} value="3"
                                                                                               name="STORE_PREFERENCE"
                                                                                               type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>4.0</span>
                                    <input ${StoreInfo["PREF_SELECTED"] == 4 ? 'checked' : ''} value="4"
                                                                                               name="STORE_PREFERENCE"
                                                                                               type="radio">
                                </label>
                            </div>
                            <div class="Pref-Radio-Item">
                                <label>
                                    <span>5.0</span>
                                    <input ${StoreInfo["PREF_SELECTED"] == 5 ? 'checked' : ''} value="5"
                                                                                               name="STORE_PREFERENCE"
                                                                                               type="radio">
                                </label>
                            </div>
                        </div>
                        <div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="Menu-Box">
        <div class="Content-Category">
            <div class="Category-Title">
                <span>메뉴 리스트</span>
            </div>
            <div class="--D-Flex-Center">
                <span id="MENU-SHOW" class="Review-Write-Text">메뉴 보기</span>
            </div>
        </div>
        <div class="Menu-List --Interface-Fold">
            <c:forEach items="${StoreMenus}" var="StoreMenu">
                <div class="Menu-List-Item">
                    <div>
                        <span class="Menu-Name-Text">${StoreMenu["MENU_NAME"]}</span>
                    </div>
                    <div>
                        <span class="Menu-Price-Text">${StoreMenu["MENU_PRICE"]}</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="Community-Box">
        <div class="Content-Category">
            <div class="Category-Title">
                <span>후기</span>
            </div>
            <div class="--D-Flex-Center">
                <span id="COMMENT-WRITE" class="Review-Write-Text">후기 남기기</span>
            </div>
        </div>

        <div class="Review-Interface --Interface-Fold">
            <input id="COMMENT-INPUT" placeholder="이용 후기..." type="text">
            <button id="COMMENT-POST" class="Review-Send-Button">작성 완료</button>
        </div>
        <div class="Review-List-Box">
            <c:forEach items="${StoreComments}" var="StoreComment">
                <div class="Review-Row">
                    <div class="Review-Member-Image">
                        <img src="<c:url value="/resources/userImages/${StoreComment['MEMBER_PROFILE_IMAGE']}" />"
                             alt="">
                    </div>
                    <div>
                        <div class="Review-Header">
                            <div class="--D-Flex-Center">
                                <span class="Review-Nickname">
                                        ${StoreComment['MEMBER_NICKNAME']}
                                </span>
                            </div>
                            <div class="Review-Pref">
                                <span class="Heart-Pref-Wrapper" onclick="
                                        postCommentPreference(
                                    <c:out value="${StoreComment['STORE_DEC_IDX']}"/>,
                                    <c:out value="${StoreComment['MEMBER_DEC_IDX']}"/>,
                                    <c:out value="${StoreComment['COMMENT_DEC_IDX']}"/>)
                                        ">
                                    <span class="Wrapper-Item"><i class="fas fa-heart Heart-Icon"></i></span>
                                    <span class="Wrapper-Item Comment-Preference">${StoreComment['COMMENT_PREFERENCE']}</span>
                                </span>
                                <c:if test="${User['MEMBER_DEC_IDX'] == StoreComment['MEMBER_DEC_IDX']}">
                                    <span class="Delete-Comment-Box" onclick="deleteStoreComment(
                                        <c:out value="${StoreComment['STORE_DEC_IDX']}"/>,
                                        <c:out value="${User['MEMBER_DEC_IDX']}"/>,
                                        <c:out value="${StoreComment['COMMENT_DEC_IDX']}"/>
                                            )">
                                        <i class="far fa-trash-alt"></i>
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        <div class="Review-Content">
                            <p class="Review-Content-Text">${StoreComment['COMMENT_CONTENT']}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</div>

</body>
</html>
