package com.hsjprime.eiki.mail.service;

import com.hsjprime.eiki.mail.dao.MailDAOImpl;
import com.hsjprime.eiki.util.method.UtilMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    MailDAOImpl mailDAO;

    @Override
    public String createMemberAuth(String MEMBER_ID){

        String authNumber = UtilMethod.createAuthNumber();
        mailDAO.insertAuth(MEMBER_ID, authNumber);
        return authNumber;

    }

}
