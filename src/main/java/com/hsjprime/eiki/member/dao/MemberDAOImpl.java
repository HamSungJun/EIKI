package com.hsjprime.eiki.member.dao;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Autowired
    DataSource dataSource;
    @Autowired
    JdbcTemplate jdbcTemplate;

    public MemberDAOImpl() {
    }

    @Override
    public int countMemberNickName(String MEMBER_NICKNAME) {

        String SQL = "SELECT COUNT(*) FROM EIKI_MEMBER WHERE MEMBER_NICKNAME = ?;";
        return jdbcTemplate.queryForObject(SQL, new Object[]{MEMBER_NICKNAME}, Integer.class);

    }

    @Override
    public int insertMember(MemberFormDTO memberFormDTO, String F_UID, int isAdmin) {

        String SQL = "INSERT INTO EIKI_MEMBER (MEMBER_ID, MEMBER_PW, MEMBER_NICKNAME, MEMBER_BIRTHDAY, MEMBER_PHONE, MEMBER_PROFILE_IMAGE, IS_ADMIN)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {

                PreparedStatement ps = con.prepareStatement(SQL, new String[]{"STORE_DEC_IDX"});
                ps.setString(1, memberFormDTO.getMEMBER_ID());
                ps.setString(2, memberFormDTO.getMEMBER_PW());
                ps.setString(3, memberFormDTO.getMEMBER_NICKNAME());
                ps.setDate(4, Date.valueOf(memberFormDTO.getMEMBER_BIRTHDAY()));
                ps.setString(5, memberFormDTO.getMEMBER_PHONE());
                ps.setString(6, F_UID);
                ps.setInt(7, isAdmin);
                return ps;

            }
        }, keyHolder);

        BigInteger memberIdx = (BigInteger) keyHolder.getKey();
        return memberIdx.intValue();

    }

}
