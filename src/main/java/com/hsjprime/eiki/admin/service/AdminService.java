package com.hsjprime.eiki.admin.service;

import com.hsjprime.eiki.admin.dto.StorePostDTO;
import com.hsjprime.eiki.admin.dao.AdminDAO;
import com.hsjprime.eiki.util.method.UtilMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service
public class AdminService {

    private final static String STORE_IMAGE_UPLOAD_PATH = "/Users/hsjprime/Desktop/EIKI/web/resources/storeImages/";

    @Autowired
    AdminDAO adminDAO;

    public int createStore(StorePostDTO storePostDTO) {

        int storeIdx = adminDAO.insertStore(storePostDTO);

        List<Map<String, Object>> menuMap = UtilMethod.jsonToMap(storePostDTO.getSTORE_MENUS());
        for (int i = 0; i < menuMap.size(); i++) {
            adminDAO.insertStoreMenu(storeIdx, (String)menuMap.get(i).get("MENU_NAME"), (int)menuMap.get(i).get("MENU_PRICE"));
        }

        File uploadDirectory = new File(STORE_IMAGE_UPLOAD_PATH);

        if (!uploadDirectory.isDirectory()) {
            if (uploadDirectory.mkdir()) {
                System.out.println("스토어 이미지 저장 폴더가 없으므로 생성합니다.");
                uploadDirectory.setExecutable(true);
                uploadDirectory.setReadable(true);
                uploadDirectory.setWritable(true);
            }
        }

        List<MultipartFile> imageIn = new ArrayList<>();
        imageIn.add(storePostDTO.getSTORE_THUMBNAIL());
        if(storePostDTO.getSTORE_IMAGES() != null){
            imageIn.addAll(storePostDTO.getSTORE_IMAGES());
        }

        for (int i = 0; i < imageIn.size(); i++) {

            StringBuilder sBuf = new StringBuilder();
            MultipartFile nextFile = imageIn.get(i);
            sBuf.append(STORE_IMAGE_UPLOAD_PATH);
            sBuf.append(UtilMethod.createUUID());
            sBuf.append(".");
            sBuf.append(nextFile.getContentType().split("/")[1]);

            try {
                nextFile.transferTo(new File(sBuf.toString()));
                adminDAO.insertFile(storeIdx, sBuf.delete(0, STORE_IMAGE_UPLOAD_PATH.length()).toString(), i == 0);
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

        return 1;

    }

}