package com.hsjprime.eiki.member.controller;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import com.hsjprime.eiki.member.service.MemberServiceImpl;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = "/member")
@SessionAttributes("User")
@Controller
public class MemberController {

    @Autowired
    MemberServiceImpl memberService;

    @ResponseBody
    @RequestMapping(value = "/checkDup", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> checkDup(@RequestBody Map<String, String> nicknameIn) {
        Map<String, Object> checkedOut = new HashMap<>();
        checkedOut.put("success", 1);
        checkedOut.put("isDup", memberService.isUniqNickName(nicknameIn.get("MEMBER_NICKNAME")));
        return checkedOut;
    }

    @RequestMapping(value = "/join", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String memberJoin(MemberFormDTO memberFormDTO, Model model) {
        memberFormDTO.setMEMBER_ID(memberFormDTO.getMEMBER_ID().concat("@hmail.hanyang.ac.kr"));
        Map<String, Object> serviceResult = memberService.saveMemberForm(memberFormDTO);

        if ((int)serviceResult.get("update") == 1) {

            MemberSessionVO memberSessionVO = new MemberSessionVO();
            memberSessionVO.setMEMBER_ID(memberFormDTO.getMEMBER_ID());
            memberSessionVO.setMEMBER_NICKNAME(memberFormDTO.getMEMBER_NICKNAME());
            memberSessionVO.setMEMBER_PHONE(memberFormDTO.getMEMBER_PHONE());
            memberSessionVO.setMEMBER_BIRTHDAY(memberFormDTO.getMEMBER_BIRTHDAY());
            memberSessionVO.setMEMBER_PROFILE_IMAGE((String)serviceResult.get("F_UID"));
            memberSessionVO.setIS_ADMIN((int)serviceResult.get("IS_ADMIN"));

            model.addAttribute("User",memberSessionVO);
            return "redirect:/eiki/home";

        }

        return "index";

    }

}
