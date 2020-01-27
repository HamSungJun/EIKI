package com.hsjprime.eiki.member.controller;

import com.hsjprime.eiki.member.service.MemberServiceImpl;
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
@RequestMapping(value = "/member")
public class MemberController {

    @Autowired
    MemberServiceImpl memberService;

    @ResponseBody
    @RequestMapping(value = "/checkDup", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> checkDup(@RequestBody Map<String, String> nicknameIn) {
        Map<String, Object> checkedOut = new HashMap<String, Object>();
        checkedOut.put("success",1);
        checkedOut.put("isDup",memberService.isUniqNickName(nicknameIn.get("MEMBER_NICKNAME")));
        return checkedOut;
    }

}
