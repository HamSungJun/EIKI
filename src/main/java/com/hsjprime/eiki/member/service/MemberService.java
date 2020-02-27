package com.hsjprime.eiki.member.service;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import com.hsjprime.eiki.member.dto.PageVO;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface MemberService {
    boolean isUniqNickName(String MEMBER_NICKNAME);
    Map<String, Object> saveMemberForm(MemberFormDTO memberFormDTO);
    boolean updateMember(Map<String, Object> paramMap, MemberSessionVO memberSessionVO);
    int isAdmin(String MEMBER_ID);
    List<Map<String, Object>> getCommentList(PageVO pageVO, int memberIdx);
    int getCommentCount(int memberIdx);
    boolean deleteComment(List<Map<String, Integer>> deleteIds);
}