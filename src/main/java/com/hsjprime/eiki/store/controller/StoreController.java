package com.hsjprime.eiki.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@RequestMapping("/eiki/store")
@SessionAttributes("User")
@Controller
public class StoreController {

    @RequestMapping(value = "/{storeId}", method = RequestMethod.GET)
    public String toStoreInfo(@PathVariable String storeId, Model model){
        System.out.print(storeId);
        model.addAttribute("User");
        return "/eiki/store";
    }

}
