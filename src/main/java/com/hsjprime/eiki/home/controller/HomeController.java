package com.hsjprime.eiki.home.controller;

import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;

@RequestMapping(value = "/eiki/home")
@SessionAttributes("User")
@Controller
public class HomeController {

    @RequestMapping(method = RequestMethod.GET)
    public String toEikiHome(@ModelAttribute("User") MemberSessionVO memberSessionVO, Model model, HttpServletRequest request){
        model.addAttribute("User", memberSessionVO);
        System.out.println(request.getQueryString());
        return "/eiki/home";
    }

}
