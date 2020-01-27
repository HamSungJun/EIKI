package com.hsjprime.eiki.mail.service;

public interface MailService {
    String getFourDigitRandNum();
    String createMemberAuth(String MEMBER_ID);
}
