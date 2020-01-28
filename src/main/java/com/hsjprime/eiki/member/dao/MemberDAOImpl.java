package com.hsjprime.eiki.member.dao;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Date;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Autowired
    private DataSource dataSource;

    public MemberDAOImpl() {
    }

    @Override
    public int countMemberNickName(String MEMBER_NICKNAME) {

        String SQL = "SELECT COUNT(*) FROM EIKI_MEMBER WHERE MEMBER_NICKNAME = ?;";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        return jdbcTemplate.queryForObject(SQL, new Object[]{MEMBER_NICKNAME}, Integer.class);

    }

    @Override
    public int insertMember(MemberFormDTO memberFormDTO, String F_UID) {

        System.out.println(memberFormDTO.toString());

        String SQL = "INSERT INTO EIKI_MEMBER (MEMBER_ID, MEMBER_PW, MEMBER_NICKNAME, MEMBER_BIRTHDAY, MEMBER_PHONE, MEMBER_PROFILE_IMAGE)" +
                "VALUES (?, ?, ?, ?, ?, ?)";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        return jdbcTemplate.update(SQL,
                memberFormDTO.getMEMBER_ID(),
                memberFormDTO.getMEMBER_PW(),
                memberFormDTO.getMEMBER_NICKNAME(),
                Date.valueOf(memberFormDTO.getMEMBER_BIRTHDAY()),
                memberFormDTO.getMEMBER_PHONE(),
                F_UID);

    }

}
