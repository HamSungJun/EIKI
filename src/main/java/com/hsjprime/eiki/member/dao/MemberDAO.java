package com.hsjprime.eiki.member.dao;

import java.sql.SQLException;

public interface MemberDAO{
    int countMemberNickName(String MEMBER_NICKNAME) throws SQLException;
}
