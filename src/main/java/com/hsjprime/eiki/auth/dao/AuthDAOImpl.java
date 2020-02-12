package com.hsjprime.eiki.auth.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

@Repository
public class AuthDAOImpl implements AuthDAO {

    @Autowired
    DataSource dataSource;

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public boolean selectAuthData(String MEMBER_ID, String AUTH_NUM) {

        String SQL = "SELECT (CASE\n" +
                "\tWHEN T.TOUCHED >= 1 THEN 1\n" +
                "    ELSE 0\n" +
                "    END\n" +
                ") AS AUTH_RESULT FROM (\n" +
                "\tSELECT COUNT(*) AS TOUCHED FROM EIKI_MAIL_AUTH\n WHERE MEMBER_ID = ? AND AUTH_NUM = ?" +
                ") AS T;";
        return jdbcTemplate.queryForObject(SQL, new Object[]{MEMBER_ID, AUTH_NUM}, boolean.class);

    }

    @Override
    public Map<String, String> selectUser(String MEMBER_ID, String MEMBER_PW) {

        String SQL = "SELECT MEMBER_DEC_IDX, MEMBER_ID, MEMBER_NICKNAME, MEMBER_PHONE, MEMBER_BIRTHDAY, MEMBER_PROFILE_IMAGE, IS_ADMIN FROM EIKI_MEMBER WHERE MEMBER_ID = ? AND MEMBER_PW = ?;";
        return jdbcTemplate.query(SQL, new Object[]{MEMBER_ID, MEMBER_PW}, (ResultSet rs) -> {
            Map<String, String> result = new HashMap<>();
            while(rs.next()){
                result.put("MEMBER_DEC_IDX", rs.getString("MEMBER_DEC_IDX"));
                result.put("MEMBER_ID",rs.getString("MEMBER_ID"));
                result.put("MEMBER_NICKNAME",rs.getString("MEMBER_NICKNAME"));
                result.put("MEMBER_PHONE",rs.getString("MEMBER_PHONE"));
                result.put("MEMBER_BIRTHDAY",rs.getString("MEMBER_BIRTHDAY"));
                result.put("MEMBER_PROFILE_IMAGE",rs.getString("MEMBER_PROFILE_IMAGE"));
                result.put("IS_ADMIN", String.valueOf(rs.getInt("IS_ADMIN")));
            }
            return result;
        });

    }

}
