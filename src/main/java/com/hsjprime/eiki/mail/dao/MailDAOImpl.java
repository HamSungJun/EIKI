package com.hsjprime.eiki.mail.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository(value = "MailDAOImpl")
public class MailDAOImpl implements MailDAO {

    @Autowired
    private DataSource dataSource;

    public MailDAOImpl() {
    }

    @Override
    public void insertAuth(String MEMBER_ID, String authNum) {

        String SQL = "INSERT EIKI_MAIL_AUTH(MEMBER_ID, AUTH_NUM) VALUES (?, ?);";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        jdbcTemplate.update(SQL, MEMBER_ID, authNum);

    }

}
