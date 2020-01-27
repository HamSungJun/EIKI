package com.hsjprime.eiki.auth.service;

public interface AuthService {
    boolean isValidAuthNum(String MEMBER_ID, String AUTH_NUM);
}
