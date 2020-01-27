package com.hsjprime.eiki.member.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository(value = "MemberDAOImpl")
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

}
