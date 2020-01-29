package com.hsjprime.eiki.auth.service;

import java.util.Map;

public interface AuthService {
    boolean isValidAuthNum(String MEMBER_ID, String AUTH_NUM);
    Map<String, String> findUser(String MEMBER_ID, String MEMBER_PW);
}
