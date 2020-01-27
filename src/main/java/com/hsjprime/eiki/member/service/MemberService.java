package com.hsjprime.eiki.member.service;

import org.springframework.stereotype.Service;

@Service
public interface MemberService {
    boolean isUniqNickName(String MEMBER_NICKNAME);
}