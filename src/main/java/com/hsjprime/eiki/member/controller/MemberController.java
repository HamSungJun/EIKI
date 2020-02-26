package com.hsjprime.eiki.member.controller;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
import com.hsjprime.eiki.member.dto.PageVO;
import com.hsjprime.eiki.member.service.MemberServiceImpl;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = {"/member", "/eiki/member"})
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

        if ((int) serviceResult.get("MEMBER_DEC_IDX") >= 1) {

            MemberSessionVO memberSessionVO = new MemberSessionVO();
            memberSessionVO.setMEMBER_DEC_IDX((int) serviceResult.get("MEMBER_DEC_IDX"));
            memberSessionVO.setMEMBER_ID(memberFormDTO.getMEMBER_ID());
            memberSessionVO.setMEMBER_NICKNAME(memberFormDTO.getMEMBER_NICKNAME());
            memberSessionVO.setMEMBER_PHONE(memberFormDTO.getMEMBER_PHONE());
            memberSessionVO.setMEMBER_BIRTHDAY(memberFormDTO.getMEMBER_BIRTHDAY());
            memberSessionVO.setMEMBER_PROFILE_IMAGE((String) serviceResult.get("F_UID"));
            memberSessionVO.setIS_ADMIN((int) serviceResult.get("IS_ADMIN"));

            model.addAttribute("User", memberSessionVO);
            return "redirect:/eiki/home";

        }

        return "index";

    }

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String toMypage(Model model) {

        model.addAttribute("User");
        return "/eiki/mypage";

    }

    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateMember(
            @RequestParam(value = "MEMBER_PROFILE_IMAGE", required = false) MultipartFile MEMBER_PROFILE_IMAGE,
            @RequestParam(value = "MEMBER_PW", required = false) String MEMBER_PW,
            @RequestParam(value = "MEMBER_NICKNAME", required = false) String MEMBER_NICKNAME,
            @RequestParam(value = "MEMBER_PHONE", required = false) String MEMBER_PHONE,
            @RequestParam(value = "MEMBER_BIRTHDAY", required = false) String MEMBER_BIRTHDAY,
            HttpServletRequest request) {

        HttpSession httpSession = request.getSession();
        MemberSessionVO memberSessionVO = (MemberSessionVO) httpSession.getAttribute("User");
        if (memberSessionVO != null) {

            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("MEMBER_DEC_IDX", memberSessionVO.getMEMBER_DEC_IDX());
            if (MEMBER_PROFILE_IMAGE != null) paramMap.put("MEMBER_PROFILE_IMAGE", MEMBER_PROFILE_IMAGE);
            if (MEMBER_PW.length() > 0) paramMap.put("MEMBER_PW", MEMBER_PW);
            if (MEMBER_NICKNAME.length() > 0 && !MEMBER_NICKNAME.equals(memberSessionVO.getMEMBER_NICKNAME()))
                paramMap.put("MEMBER_NICKNAME", MEMBER_NICKNAME);
            if (MEMBER_PHONE.length() > 0 && !MEMBER_PHONE.equals(memberSessionVO.getMEMBER_PHONE()))
                paramMap.put("MEMBER_PHONE", MEMBER_PHONE);
            if (MEMBER_BIRTHDAY.length() > 0 && !MEMBER_BIRTHDAY.equals(memberSessionVO.getMEMBER_BIRTHDAY()))
                paramMap.put("MEMBER_BIRTHDAY", MEMBER_BIRTHDAY);

            if (memberService.updateMember(paramMap, memberSessionVO)) {

                if (paramMap.containsKey("MEMBER_PROFILE_IMAGE"))
                    memberSessionVO.setMEMBER_PROFILE_IMAGE((String) paramMap.get("MEMBER_PROFILE_IMAGE"));
                if (paramMap.containsKey("MEMBER_NICKNAME"))
                    memberSessionVO.setMEMBER_NICKNAME((String) paramMap.get("MEMBER_NICKNAME"));
                if (paramMap.containsKey("MEMBER_PHONE"))
                    memberSessionVO.setMEMBER_PHONE((String) paramMap.get("MEMBER_PHONE"));
                if (paramMap.containsKey("MEMBER_BIRTHDAY"))
                    memberSessionVO.setMEMBER_BIRTHDAY((String) paramMap.get("MEMBER_BIRTHDAY"));

                httpSession.setAttribute("User", memberSessionVO);

            }

        }

        return "123";

    }

    @RequestMapping(value = "/comment/manage/{pageIdx}", method = RequestMethod.GET)
    public String getCommentList(@PathVariable("pageIdx") int pageIdx, HttpServletRequest request, Model model) {

        if (pageIdx < 1) {
            return "redirect:/eiki/member/comment/manage/1";
        }

        HttpSession httpSession = request.getSession();
        MemberSessionVO memberSessionVO = (MemberSessionVO) httpSession.getAttribute("User");

        int memberCommentCount = memberService.getCommentCount(memberSessionVO.getMEMBER_DEC_IDX());
        PageVO pageVO = new PageVO(pageIdx, memberCommentCount);

        if (pageIdx > pageVO.getMaxPageIdx() && pageVO.getMaxPageIdx() >= 1) {
            return "redirect:/eiki/member/comment/manage/" + pageVO.getMaxPageIdx();
        }

        model.addAttribute("User");
        model.addAttribute("PageVO", pageVO);
        model.addAttribute("CommentList", memberService.getCommentList(pageVO, memberSessionVO.getMEMBER_DEC_IDX()));

        return "/eiki/comment_manage";

    }

}
