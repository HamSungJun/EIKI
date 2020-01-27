package com.hsjprime.eiki.member.service;

import com.hsjprime.eiki.member.dao.MemberDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberDAOImpl memberDAO;

    @Override
    public boolean isUniqNickName(String MEMBER_NICKNAME){

        return memberDAO.countMemberNickName(MEMBER_NICKNAME) != 0;

    }

}
