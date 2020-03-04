<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>EIKI 코멘트 관리</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="description" content="에리카 학생들을 위한 학교앞 푸드 위키">
    <meta name="keywords" content="음식,푸드,에리카,학생,위키,학교,학교앞">
    <meta name="author" content="HSJPRIME">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/global.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/mypage.css" />">
    <script defer src="<c:url value="/resources/js/all.min.js" />"></script>
    <script src="<c:url value="/resources/js/common/topbar.js" />"></script>
    <script>

        let isMemberCommentFetching = false;
        let isCommentDeleting = false;
        let isCheckedAll = false;

        window.onload = () => {

            initTopbarEvents();
            initCommentManageEvents();

        };

        const initCommentManageEvents = () => {

            let $SelectAll = document.getElementById("SELECT-ALL");
            $SelectAll.addEventListener("click", selectAllCheckBox);

            let $SelectDelete = document.getElementById("SELECT-DELETE");
            $SelectDelete.addEventListener("click", selectDelete);
        };

        const selectAllCheckBox = () => {

            let $CheckBoxes = document.querySelectorAll(".Comment-Checkbox");

            for (let index = 0; index < $CheckBoxes.length; index++) {

                let $Checkbox = $CheckBoxes.item(index);
                $Checkbox.checked = !isCheckedAll;

            }

            isCheckedAll = !isCheckedAll;

        };

        const selectDelete = () => {

            let $CommentContentRows = document.querySelectorAll(".Comment-Content-Row");

            if ($CommentContentRows && $CommentContentRows.length > 0) {

                if (confirm("선택한 댓글들을 정말로 삭제할까요?")) {

                    let _deleteIds = [];

                    for (let index = 0; index < $CommentContentRows.length; index++) {

                        let $CommentContentRow = $CommentContentRows.item(index);
                        if ($CommentContentRow.querySelector(".Comment-Checkbox").checked) {
                            _deleteIds.push({
                                commentIdx: parseInt($CommentContentRow.getAttribute("data-comment-idx")),
                                storeIdx: parseInt($CommentContentRow.getAttribute("data-store-idx"))
                            });
                        }

                    }

                    if (_deleteIds.length > 0 && !isCommentDeleting) {

                        fetch("/eiki/member/comment/manage", {
                            method: "DELETE",
                            headers: {
                                "Content-Type": "application/json; charset=utf-8"
                            },
                            body: JSON.stringify(_deleteIds)
                        }).then(response => {
                            if (response.status === 200) window.location.reload();
                        });

                    }

                }

            } else {
                return alert("댓글이 존재하지 않습니다.");
            }

        }


    </script>
</head>
<body>
<c:import url="../common/topbar.jsp" charEncoding="UTF-8">
    <c:param name="MEMBER_DEC_IDX" value="${User.MEMBER_DEC_IDX}"/>
    <c:param name="MEMBER_ID" value="${User.MEMBER_ID}"/>
    <c:param name="MEMBER_NICKNAME" value="${User.MEMBER_NICKNAME}"/>
    <c:param name="MEMBER_PROFILE_IMAGE" value="${User.MEMBER_PROFILE_IMAGE}"/>
    <c:param name="IS_ADMIN" value="${User.IS_ADMIN}"/>
</c:import>
<div class="My-Page-Box">
    <c:import url="../common/mypage_nav.jsp" charEncoding="UTF-8">
        <c:param name="NAV_SELECTED" value="COMMENT-MANAGE"/>
    </c:import>
    <div class="Comment-List-Box">
        <div class="Comment-Header-Row">
            <div class="Comment-Header-Item">선택</div>
            <div class="Comment-Header-Item">댓글</div>
            <div class="Comment-Header-Item">좋아요</div>
            <div class="Comment-Header-Item">작성 시각</div>
        </div>
        <div class="Comment-Content-Box">
            <c:forEach items="${CommentList}" var="CommentItem">
                <div data-comment-idx="${CommentItem['COMMENT_DEC_IDX']}" data-store-idx="${CommentItem['STORE_DEC_IDX']}" class="Comment-Content-Row">
                    <div class="Comment-Content-Item">
                        <input class="Comment-Checkbox" type="checkbox">
                    </div>
                    <div class="Comment-Content-Item --Justify-Flex-Start">
                        <a class="Comment-Link"
                           href="<c:url value="/eiki/store/${CommentItem['STORE_DEC_IDX']}" />">${CommentItem['COMMENT_CONTENT']}</a>
                    </div>
                    <div class="Comment-Content-Item">
                        <span>${CommentItem['COMMENT_PREFERENCE']}</span>
                    </div>
                    <div class="Comment-Content-Item">
                        <span>${CommentItem['UPDATED_AT']}</span>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="Comment-Buttons">
            <div>
                <button id="SELECT-ALL" class="Post-Btn">전체선택</button>
                <button id="SELECT-DELETE" class="Post-Btn">선택삭제</button>
            </div>
        </div>
        <div class="Comment-Page-Row">
            <div>
                <c:if test="${PageVO.prev}">
                    <a class="Page-Mover"
                       href="<c:url value="/eiki/member/comment/manage/${PageVO.currentPageIdx - 1}" />">이전</a>
                </c:if>
                <c:forEach begin="${PageVO.startPageIdx}" end="${PageVO.endPageIdx}" var="pageIdx">
                    <a class="Page-Link ${PageVO.currentPageIdx == pageIdx ? "--Page-Link-Selected" : ""}"
                       href="<c:url value="/eiki/member/comment/manage/${pageIdx}"/>">${pageIdx}</a>
                </c:forEach>
                <c:if test="${PageVO.next}">
                    <a class="Page-Mover"
                       href="<c:url value="/eiki/member/comment/manage/${PageVO.currentPageIdx + 1}" />">다음</a>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
