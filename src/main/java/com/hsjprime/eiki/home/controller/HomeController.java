package com.hsjprime.eiki.home.controller;

import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@RequestMapping(value = "/eiki/home")
@SessionAttributes("User")
@Controller
public class HomeController {

    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    public String toEikiHome(@ModelAttribute("User") MemberSessionVO memberSessionVO, Model model){
        model.addAttribute("User", memberSessionVO);
        return "/eiki/home";
    }

}
