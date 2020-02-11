package com.hsjprime.eiki.admin.controller;

import com.hsjprime.eiki.admin.dto.StorePostDTO;
import com.hsjprime.eiki.admin.service.AdminService;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = "/eiki/admin")
@SessionAttributes("User")
@Controller
public class AdminController {

    @Autowired
    AdminService adminService;

    @RequestMapping(method = RequestMethod.GET)
    public String toAdminPage(@ModelAttribute("User") MemberSessionVO memberSessionVO, Model model) {
        model.addAttribute("User");
        return "/eiki/admin";
    }

    @RequestMapping(value = "/post", method = RequestMethod.GET)
    public String toPostPage() {
        return "/eiki/post";
    }


    @RequestMapping(value = "/post", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> handleStorePost(StorePostDTO storePostDTO) {
        System.out.println(storePostDTO.toString());
        Map<String, Object> result = new HashMap<>();
        if (adminService.createStore(storePostDTO) == 1) {
            result.put("success", 1);
        }
        return result;

    }
}
