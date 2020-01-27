package com.hsjprime.eiki.auth.controller;

import com.hsjprime.eiki.auth.dto.LoginInfoDTO;
import com.hsjprime.eiki.auth.service.AuthServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping(value = "/auth")
public class AuthController {

    @Autowired
    AuthServiceImpl authServcice;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(LoginInfoDTO loginInfo) {

        System.out.println(loginInfo.getMEMBER_ID());
        System.out.println(loginInfo.getMEMBER_PW());
        return "home";

    }

    @ResponseBody
    @RequestMapping(value = "/isValidAuthNum", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> isValidAuthNum(@RequestBody Map<String, String> authData) {

        Map<String, Object> authResult = new HashMap<>();
        if (authServcice.isValidAuthNum(authData.get("MEMBER_ID"), authData.get("AUTH_NUM"))) {
            authResult.put("success", 1);
            authResult.put("isValid", true);
        } else {
            authResult.put("success", 1);
            authResult.put("isValid", false);
        }

        return authResult;

    }

}
