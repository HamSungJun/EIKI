package com.hsjprime.eiki.auth.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository("AuthDAOImpl")
public class AuthDAOImpl implements AuthDAO {

    @Autowired
    DataSource dataSource;

    public AuthDAOImpl() {
    }

    public boolean selectAuthData(String MEMBER_ID, String AUTH_NUM){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        String SQL = "SELECT (CASE\n" +
                "\tWHEN T.TOUCHED >= 1 THEN 1\n" +
                "    ELSE 0\n" +
                "    END\n" +
                ") AS AUTH_RESULT FROM (\n" +
                "\tSELECT COUNT(*) AS TOUCHED FROM EIKI_MAIL_AUTH\n WHERE MEMBER_ID = ? AND AUTH_NUM = ?" +
                ") AS T;";
        return jdbcTemplate.queryForObject(SQL,new Object[]{MEMBER_ID, AUTH_NUM},boolean.class);
    }


}
