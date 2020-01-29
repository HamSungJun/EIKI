package com.hsjprime.eiki.auth.controller;

import com.hsjprime.eiki.auth.dto.LoginInfoDTO;
import com.hsjprime.eiki.auth.service.AuthServiceImpl;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = "/auth")
@SessionAttributes("User")
@Controller
public class AuthController {

    @Autowired
    AuthServiceImpl authServcice;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(LoginInfoDTO loginInfoDTO, Model model) {

        Map<String, String> userData = authServcice.findUser(loginInfoDTO.getMEMBER_ID(),loginInfoDTO.getMEMBER_PW());
        MemberSessionVO memberSessionVO = new MemberSessionVO();
        memberSessionVO.setMEMBER_ID(userData.get("MEMBER_ID"));
        memberSessionVO.setMEMBER_NICKNAME(userData.get("MEMBER_NICKNAME"));
        memberSessionVO.setMEMBER_PHONE(userData.get("MEMBER_PHONE"));
        memberSessionVO.setMEMBER_BIRTHDAY(userData.get("MEMBER_BIRTHDAY"));
        memberSessionVO.setMEMBER_PROFILE_IMAGE(userData.get("MEMBER_PROFILE_IMAGE"));
        model.addAttribute("User",memberSessionVO);
        return "redirect:/eiki/home";

    }

    @ResponseBody
    @RequestMapping(value = "/isValidAuthNum", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> isValidAuthNum(@RequestBody Map<String, String> authData) {

        Map<String, Object> authResult = new HashMap<>();
        authResult.put("success", 1);
        if (authServcice.isValidAuthNum(authData.get("MEMBER_ID"), authData.get("AUTH_NUM"))) {
            authResult.put("isValid", true);
        } else {
            authResult.put("isValid", false);
        }

        return authResult;

    }

}
