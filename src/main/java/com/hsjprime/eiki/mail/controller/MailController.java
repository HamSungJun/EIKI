package com.hsjprime.eiki.mail.controller;

import com.hsjprime.eiki.mail.service.MailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/mail")
@Controller
public class MailController {

    @Autowired
    private JavaMailSenderImpl mailSender;
    @Autowired
    private MailServiceImpl mailService;

    @ResponseBody
    @RequestMapping(value = "/auth", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Integer> sendAuthMail(@RequestBody Map<String, String> emailIn) {

        try {

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom("EIKI <eikistudents@gmail.com>");
            messageHelper.setTo(emailIn.get("MEMBER_ID"));
            messageHelper.setSubject("EIKI 회원가입에 대한 인증 메일입니다.");
            messageHelper.setText(String.format("EIKI 회원가입을 위한 인증번호는 [%s] 입니다", mailService.createMemberAuth(emailIn.get("MEMBER_ID"))), false);

            mailSender.send(message);

        } catch (MessagingException e) {

            e.printStackTrace();

        }

        Map<String, Integer> status = new HashMap<>();
        status.put("success", 1);

        return status;
    }


}
