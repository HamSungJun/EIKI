package com.hsjprime.eiki.member.service;

import com.hsjprime.eiki.member.dao.MemberDAOImpl;
import com.hsjprime.eiki.member.dto.MemberFormDTO;
import com.hsjprime.eiki.util.method.UtilMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService {

    private static final String PROFILE_IMAGE_UPLOAD_PATH = "/Users/hsjprime/Desktop/EIKI/web/resources/userImages/";
    private static final String[] ADMIN_IDS = {"god1857@hmail.hanyang.ac.kr"};

    @Autowired
    MemberDAOImpl memberDAO;

    @Override
    public boolean isUniqNickName(String MEMBER_NICKNAME) {

        return memberDAO.countMemberNickName(MEMBER_NICKNAME) != 0;

    }

    @Override
    public Map<String, Object> saveMemberForm(MemberFormDTO memberFormDTO) {

        Map<String, Object> serviceResult = new HashMap<>();
        MultipartFile uploadedImage = memberFormDTO.getMEMBER_PROFILE_IMAGE();
        String imgExtension = uploadedImage.getContentType().split("/")[1];
        File uploadDirectory = new File(PROFILE_IMAGE_UPLOAD_PATH);

        serviceResult.put("F_UID", UtilMethod.createUUID().concat("." + imgExtension));

        if (!uploadDirectory.isDirectory()) {
            if (uploadDirectory.mkdir()) {
                System.out.println("프로필 저장 폴더가 없으므로 생성합니다.");
                uploadDirectory.setExecutable(true);
                uploadDirectory.setReadable(true);
                uploadDirectory.setWritable(true);
            }
        }

        try {
            uploadedImage.transferTo(new File(PROFILE_IMAGE_UPLOAD_PATH + serviceResult.get("F_UID")));
        } catch (IOException e) {
            e.printStackTrace();
        }

        int isAdmin = isAdmin(memberFormDTO.getMEMBER_ID());
        serviceResult.put("MEMBER_DEC_IDX", memberDAO.insertMember(memberFormDTO, (String)serviceResult.get("F_UID"), isAdmin));
        serviceResult.put("IS_ADMIN", isAdmin);
        return serviceResult;

    }

    @Override
    public int isAdmin(String MEMBER_ID){

        int isAdmin = 0;
        for (int i = 0; i < ADMIN_IDS.length; i++) {
            if(ADMIN_IDS[i].equals(MEMBER_ID)){
                isAdmin = 1;
            }
        }
        return isAdmin;

    }

}
