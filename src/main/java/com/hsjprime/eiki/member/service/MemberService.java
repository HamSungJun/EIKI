package com.hsjprime.eiki.member.service;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public interface MemberService {
    boolean isUniqNickName(String MEMBER_NICKNAME);
    int saveMemberForm(MemberFormDTO memberFormDTO);
}