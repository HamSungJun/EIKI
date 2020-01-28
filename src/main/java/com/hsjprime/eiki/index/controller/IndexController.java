package com.hsjprime.eiki.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/")
@Controller
public class IndexController {

    @RequestMapping(method = RequestMethod.GET)
    public String toIndexPage() {
        return "index";
    }

    @RequestMapping(value = "join", method = RequestMethod.GET)
    public String toJoinPage() {
        return "join";
    }

    @RequestMapping(value = "find", method = RequestMethod.GET)
    public String toFindPage() {
        return "find";
    }

}
