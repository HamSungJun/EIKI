package com.hsjprime.eiki.auth.dao;

import java.util.Map;

public interface AuthDAO {
    boolean selectAuthData(String MEMBER_ID, String AUTH_NUM);
    Map<String, String> selectUser(String MEMBER_ID, String MEMBER_PW);
}
