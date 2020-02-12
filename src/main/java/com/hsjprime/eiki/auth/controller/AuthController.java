package com.hsjprime.eiki.auth.controller;

import com.hsjprime.eiki.auth.service.AuthServiceImpl;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = "/auth")
@SessionAttributes("User")
@Controller
public class AuthController {

    @Autowired
    AuthServiceImpl authService;

    @ResponseBody
    @RequestMapping(value = "/login", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> login(@RequestBody Map<String, String> loginInput, Model model) {

        Map<String, Object> loginResult = new HashMap<>();
        loginResult.put("success",1);
        Map<String, String> userData = authService.findUser(loginInput.get("MEMBER_ID"),loginInput.get("MEMBER_PW"));
        if(userData.get("MEMBER_ID") != null){
            MemberSessionVO memberSessionVO = new MemberSessionVO();
            memberSessionVO.setMEMBER_DEC_IDX(Integer.parseInt(userData.get("MEMBER_DEC_IDX")));
            memberSessionVO.setMEMBER_ID(userData.get("MEMBER_ID"));
            memberSessionVO.setMEMBER_NICKNAME(userData.get("MEMBER_NICKNAME"));
            memberSessionVO.setMEMBER_PHONE(userData.get("MEMBER_PHONE"));
            memberSessionVO.setMEMBER_BIRTHDAY(userData.get("MEMBER_BIRTHDAY"));
            memberSessionVO.setMEMBER_PROFILE_IMAGE(userData.get("MEMBER_PROFILE_IMAGE"));
            memberSessionVO.setIS_ADMIN(Integer.parseInt(userData.get("IS_ADMIN")));
            model.addAttribute("User",memberSessionVO);
            loginResult.put("isMemberExist",true);
        } else {
            loginResult.put("isMemberExist",false);
        }
        return loginResult;

    }

    @ResponseBody
    @RequestMapping(value = "/isValidAuthNum", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> isValidAuthNum(@RequestBody Map<String, String> authData) {

        Map<String, Object> authResult = new HashMap<>();
        authResult.put("success", 1);
        if (authService.isValidAuthNum(authData.get("MEMBER_ID"), authData.get("AUTH_NUM"))) {
            authResult.put("isValid", true);
        } else {
            authResult.put("isValid", false);
        }

        return authResult;

    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(SessionStatus sessionStatus){
        sessionStatus.setComplete();
        return "redirect:/";
    }

}
