package com.hsjprime.eiki.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

@RequestMapping("/")
@SessionAttributes("User")
@Controller
public class IndexController {

    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    public String toIndexPage(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "index";
    }

    @RequestMapping(value = "join", method = RequestMethod.GET)
    public String toJoinPage(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "join";
    }

    @RequestMapping(value = "find", method = RequestMethod.GET)
    public String toFindPage(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "find";
    }

}
