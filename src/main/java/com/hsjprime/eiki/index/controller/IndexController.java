package com.hsjprime.eiki.index.controller;

import com.hsjprime.eiki.index.service.IndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import java.util.Map;

@RequestMapping("/")
@SessionAttributes("User")
@Controller
public class IndexController {

    @Autowired
    IndexService indexService;

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

    @RequestMapping(value = "access", method = RequestMethod.POST)
    public ResponseEntity pageAccess(){

        if(indexService.pageAccess())
            return ResponseEntity.status(HttpStatus.OK).build();

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();

    }

}
