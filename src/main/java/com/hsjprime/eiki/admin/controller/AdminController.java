package com.hsjprime.eiki.admin.controller;

import com.hsjprime.eiki.admin.dto.StorePostDTO;
import com.hsjprime.eiki.admin.service.AdminService;
import com.hsjprime.eiki.member.dto.PageVO;
import com.hsjprime.eiki.member.vo.MemberSessionVO;
import com.hsjprime.eiki.store.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

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
    public ResponseEntity updateStore(
            @RequestParam(value = "STORE_NAME", required = true) String STORE_NAME,
            @RequestParam(value = "STORE_CALL", required = true) String STORE_CALL,
            @RequestParam(value = "STORE_TYPE", required = true) String STORE_TYPE,
            @RequestParam(value = "IS_DELIVERY", required = true) boolean IS_DELIVERY,
            @RequestParam(value = "STORE_THUMBNAIL", required = false) MultipartFile STORE_THUMBNAIL,
            @RequestParam(value = "STORE_IMAGES", required = false) List<MultipartFile> STORE_IMAGES,
            @RequestParam(value = "STORE_MENUS", required = true) String STORE_MENUS,
            @RequestParam(value = "STORE_LATITUDE", required = true) float STORE_LATITUDE,
            @RequestParam(value = "STORE_LONGITUDE", required = true) float STORE_LONGITUDE,
            @RequestParam(value = "STORE_DESCRIPTION", required = true) String STORE_DESCRIPTION,
            @PathVariable("storeIdx") int storeIdx) {

        StorePostDTO storePostDTO = new StorePostDTO();
        storePostDTO.setSTORE_NAME(STORE_NAME);
        storePostDTO.setSTORE_CALL(STORE_CALL);
        storePostDTO.setSTORE_TYPE(STORE_TYPE);
        storePostDTO.setIS_DELIVERY(IS_DELIVERY);
        storePostDTO.setSTORE_THUMBNAIL(STORE_THUMBNAIL);
        storePostDTO.setSTORE_IMAGES(STORE_IMAGES);
        storePostDTO.setSTORE_MENUS(STORE_MENUS);
        storePostDTO.setSTORE_LATITUDE(STORE_LATITUDE);
        storePostDTO.setSTORE_LONGITUDE(STORE_LONGITUDE);
        storePostDTO.setSTORE_DESCRIPTION(STORE_DESCRIPTION);

        if (adminService.updateStore(storePostDTO, storeIdx)) {
            return ResponseEntity.status(HttpStatus.OK).build();
        }
        ;
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();

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

    @RequestMapping(value = "/member/manage/{pageIdx}", method = RequestMethod.GET)
    public String toMemberManageIndexPage(Model model, @PathVariable("pageIdx") int pageIdx) {

        PageVO pageVO = new PageVO(pageIdx, adminService.getMemberCount());

        if (pageIdx < 1)
            return "redirect:/eiki/admin/member/manage/1";
        if (pageIdx > pageVO.getMaxPageIdx() && pageVO.getMaxPageIdx() >= 1)
            return "redirect:/eiki/admin/member/manage/" + pageVO.getMaxPageIdx();

        model.addAttribute("PageVO", pageVO);
        model.addAttribute("MemberList", adminService.getMemberList(pageVO));
        return "/eiki/admin/member/index";

    }

    @RequestMapping(value = "/member/manage/auth/{memberIdx}", method = RequestMethod.PUT)
    public ResponseEntity memberAuthorityUpdate(@PathVariable("memberIdx") int memberIdx){

        if(adminService.memberAuthorityUpdate(memberIdx)){
            return ResponseEntity.status(HttpStatus.OK).build();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();

    }

    @RequestMapping(value = "/access/history/{duration}", method = RequestMethod.GET)
    public ResponseEntity getAccessHistory(@PathVariable("duration") int duration){

        List<Map<String, Object>> accessHistory = adminService.getAccessHistory(duration);
        if(accessHistory.size() >= 1){
            return ResponseEntity.status(HttpStatus.OK).body(accessHistory);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();

    }

}
