package com.hsjprime.eiki.member.service;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface MemberService {
    boolean isUniqNickName(String MEMBER_NICKNAME);
    Map<String, Object> saveMemberForm(MemberFormDTO memberFormDTO);
    int isAdmin(String MEMBER_ID);
}