package com.hsjprime.eiki.admin.dao.mapper;

import com.hsjprime.eiki.admin.dto.Member;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberMapper implements RowMapper<Member> {

    public Member mapRow(ResultSet rs, int rowNum) throws SQLException {

        Member member = new Member();

        member.setMEMBER_DEC_IDX(rs.getInt("MEMBER_DEC_IDX"));
        member.setMEMBER_ID(rs.getString("MEMBER_ID"));
        member.setMEMBER_NICKNAME(rs.getString("MEMBER_NICKNAME"));
        member.setMEMBER_PHONE(rs.getString("MEMBER_PHONE"));
        member.setMEMBER_PROFILE_IMAGE(rs.getString("MEMBER_PROFILE_IMAGE"));
        member.setIS_ADMIN(rs.getInt("IS_ADMIN"));

        return member;

    }

}
