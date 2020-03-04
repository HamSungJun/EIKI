package com.hsjprime.eiki.admin.controller;

import com.hsjprime.eiki.admin.dto.StorePostDTO;
import com.hsjprime.eiki.admin.service.AdminService;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import com.hsjprime.eiki.store.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequestMapping(value = "/eiki/admin")
@SessionAttributes("User")
@Controller
public class AdminController {

    @Autowired
    AdminService adminService;

    @Autowired
    StoreService storeService;

    @RequestMapping(method = RequestMethod.GET)
    public String toAdminPage(@ModelAttribute("User") MemberSessionVO memberSessionVO, Model model) {
        model.addAttribute("User");
        return "/eiki/admin/index";
    }

    @RequestMapping(value = "/store/post", method = RequestMethod.GET)
    public String toStorePostPage() {
        return "/eiki/admin/store/post";
    }

    @ResponseBody
    @RequestMapping(value = "/store/post", method = RequestMethod.POST)
    public ResponseEntity handleStorePost(StorePostDTO storePostDTO) {

        if (adminService.createStore(storePostDTO) == 1) {
            return ResponseEntity.status(HttpStatus.OK).build();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();

    }

    @RequestMapping(value = "/store/edit", method = RequestMethod.GET)
    public String toStoreEditPage(Model model, @RequestParam(name = "storeName", defaultValue = "") String storeName) {
        model.addAttribute("StoreInfos", adminService.getStoreInfo(storeName));
        return "/eiki/admin/store/edit";
    }

    @RequestMapping(value = "/store/edit/{storeIdx}", method = RequestMethod.GET)
    public String toStoreEditDetailPage(Model model, @PathVariable("storeIdx") int storeIdx) {
        model.addAttribute("StorePostHistory", storeService.getStorePostHistory(storeIdx));
        model.addAttribute("StoreMenus", storeService.getStoreMenus(storeIdx));
        model.addAttribute("StoreImages", storeService.getStoreImages(storeIdx));
        return "/eiki/admin/store/editDetail";
    }

    @ResponseBody
    @RequestMapping(value = "/store/update/{storeIdx}", method = RequestMethod.POST)
    public ResponseEntity updateStore(StorePostDTO storePostDTO, @PathVariable("storeIdx") int storeIdx) {
        adminService.updateStore(storePostDTO, storeIdx);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @RequestMapping(value = "/store/delete/{storeIdx}", method = RequestMethod.DELETE)
    public ResponseEntity deleteStore(@PathVariable("storeIdx") int storeIdx) {
        if (adminService.deleteStore(storeIdx)) {
            return ResponseEntity.status(HttpStatus.OK).build();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }

    @RequestMapping(value = "/store/image/delete/{fileName:.+}", method = RequestMethod.DELETE)
    public ResponseEntity deleteStoreImage(@PathVariable("fileName") String fileName) {
        if (adminService.deleteStoreImage(fileName)) {
            return ResponseEntity.status(HttpStatus.OK).build();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }

    @RequestMapping(value = "/member/manage", method = RequestMethod.GET)
    public String toMemberManageIndexPage() {
        return "/eiki/admin/member/index";
    }

}
