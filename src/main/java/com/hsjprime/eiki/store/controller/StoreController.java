package com.hsjprime.eiki.store.controller;

import com.hsjprime.eiki.member.vo.MemberSessionVO;
import com.hsjprime.eiki.store.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/eiki/store")
@SessionAttributes("User")
@Controller
public class StoreController {

    @Autowired
    StoreService storeService;

    @RequestMapping(value = "/{storeIdx}", method = RequestMethod.GET)
    public String toStoreInfo(@PathVariable String storeIdx, HttpSession session, Model model) {

        MemberSessionVO memberSessionVO = (MemberSessionVO) session.getAttribute("User");
        model.addAttribute("User");
        model.addAttribute("StoreInfo", storeService.getStoreInfo(Integer.parseInt(storeIdx), memberSessionVO.getMEMBER_DEC_IDX()));
        model.addAttribute("StoreMenus", storeService.getStoreMenus(Integer.parseInt(storeIdx)));
        model.addAttribute("StoreImages", storeService.getStoreImages(Integer.parseInt(storeIdx)));
        model.addAttribute("StoreComments", storeService.getStoreComments(Integer.parseInt(storeIdx)));
        return "/eiki/store";

    }

    @ResponseBody
    @RequestMapping(value = "/preference", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> postPreference(@RequestBody Map<String, Object> jsonPref) {

        Map<String, Object> result = new HashMap<>();

        if (storeService.setPreference(jsonPref)) {
            result.put("success", 1);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/comment", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> postComment(@RequestBody Map<String, Object> jsonComment) {

        Map<String, Object> result = new HashMap<>();

        if (storeService.setComment(jsonComment)) {
            result.put("success", 1);
        }

        return result;

    }

    @ResponseBody
    @RequestMapping(value = "/comment/preference", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> postCommentPreference(@RequestBody Map<String, Object> jsonCommentPreference) {

        Map<String, Object> result = new HashMap<>();

        if(storeService.setCommentPreference(jsonCommentPreference)){
            result.put("success", 1);
            result.put("refreshedComments", storeService.getStoreComments((int)jsonCommentPreference.get("STORE_DEC_IDX")));
        }

        return result;

    }

}
