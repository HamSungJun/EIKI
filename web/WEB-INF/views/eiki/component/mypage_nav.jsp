<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="My-Page-Panel-Header">
    <div>
        <span>
            <a class="Panel-Item ${param.NAV_SELECTED == 'MEMBER-MANAGE' ? '--Panel-Selected' : ''}" href="<c:url value="/eiki/member/manage" />">회원정보 수정</a>
        </span>
    </div>
    <div>
        <span>
            <a class="Panel-Item ${param.NAV_SELECTED == 'COMMENT-MANAGE' ? '--Panel-Selected' : ''}" href="<c:url value="/eiki/member/comment/manage/1" />">코멘트 관리</a>
        </span>
    </div>
</div>
