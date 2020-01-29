package com.hsjprime.eiki.mail.service;

import com.hsjprime.eiki.mail.dao.MailDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    MailDAOImpl mailDAO;

    @Override
    public String getFourDigitRandNum(){

        StringBuilder sBuf = new StringBuilder();

        for (int index = 0; index < 4; index++){
            sBuf.append((int)Math.floor(Math.random() * 10));
        }

        return sBuf.toString();

    }

    @Override
    public String createMemberAuth(String MEMBER_ID){

        String randNum = getFourDigitRandNum();
        mailDAO.insertAuth(MEMBER_ID, randNum);
        return randNum;

    }

}
