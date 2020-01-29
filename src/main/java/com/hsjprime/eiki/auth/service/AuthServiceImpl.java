package com.hsjprime.eiki.auth.service;

import com.hsjprime.eiki.auth.dao.AuthDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    AuthDAOImpl authDAO;

    @Override
    public boolean isValidAuthNum(String MEMBER_ID, String AUTH_NUM) {

        return authDAO.selectAuthData(MEMBER_ID, AUTH_NUM);

    }

    @Override
    public Map<String, String> findUser(String MEMBER_ID, String MEMBER_PW) {

        return authDAO.selectUser(MEMBER_ID, MEMBER_PW);

    }

}
