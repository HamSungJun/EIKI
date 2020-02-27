package com.hsjprime.eiki.member.dao;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import com.hsjprime.eiki.member.dto.PageVO;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface MemberDAO{
    int countMemberNickName(String MEMBER_NICKNAME) throws SQLException;
    int insertMember(MemberFormDTO memberFormDTO, String F_UID, int isAdmin);
    boolean updateMember(Map<String, Object> paramMap);
    List<Map<String, Object>> selectCommentList(PageVO pageVO, int memberIdx);
    int selectCommentCount(int memberIdx);
    boolean deleteComment(List<Map<String, Integer>> deleteIds);
}
