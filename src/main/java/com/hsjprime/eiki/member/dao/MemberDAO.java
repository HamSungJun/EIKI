package com.hsjprime.eiki.member.dao;

import com.hsjprime.eiki.member.dto.MemberFormDTO;

import java.sql.SQLException;

public interface MemberDAO{
    int countMemberNickName(String MEMBER_NICKNAME) throws SQLException;
    int insertMember(MemberFormDTO memberFormDTO, String F_UID, int isAdmin);
}
