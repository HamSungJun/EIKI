let isFetching = false;

window.onload = () => {

    initTopBarAdminEvents();
    initMemberEditEvents();

};

const initMemberEditEvents = () => {

    let $MemberAuthButtons = document.querySelectorAll(".Circular-Pill");

    if ($MemberAuthButtons !== null && $MemberAuthButtons.length > 0) {
        for (let index = 0; index < $MemberAuthButtons.length; index++) {

            let $MemberAuthButton = $MemberAuthButtons.item(index);
            $MemberAuthButton.addEventListener("click", handleAuthToggleClick);

        }
    }

};

const handleAuthToggleClick = (event) => {

    if(!isFetching){
        const memberIdx = parseInt(event.target.closest(".Member-Data-Row").getAttribute("data-member-idx"));
        fetch("/eiki/admin/member/manage/auth/"+memberIdx,{
            method : "PUT"
        }).then(res => {
            if(res.status === 200){
                window.location.reload();
            }
        }).catch(error => {
            console.log(error);
        })

    } else {
        return alert("유저 권한을 변경중입니다.");
    }

};



