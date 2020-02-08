package com.hsjprime.eiki.admin.controller;

import com.hsjprime.eiki.admin.controller.dto.StorePostDTO;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = "/eiki/admin")
@SessionAttributes("User")
@Controller
public class AdminController {

    @RequestMapping(method = RequestMethod.GET)
    public String toAdminPage(@ModelAttribute("User") MemberSessionVO memberSessionVO, Model model){
        model.addAttribute("User");
        return "/eiki/admin";
    }

    @RequestMapping(value = "/post", method = RequestMethod.GET)
    public String toPostPage(){
        return "/eiki/post";
    }


    @RequestMapping(value = "/post", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> handleStorePost(@ModelAttribute StorePostDTO storePostDTO){
        Map<String, Object> result = new HashMap<>();
        result.put("success", 1);
        return result;
    }
}
