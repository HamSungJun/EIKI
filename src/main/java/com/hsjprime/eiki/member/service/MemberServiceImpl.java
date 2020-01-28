package com.hsjprime.eiki.member.service;

import com.hsjprime.eiki.member.dao.MemberDAOImpl;
import com.hsjprime.eiki.member.dto.MemberFormDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class MemberServiceImpl implements MemberService {

    private static final String PROFILE_IMAGE_UPLOAD_PATH = "/Users/hsjprime/Desktop/EIKI/web/resources/userImages/";

    @Autowired
    MemberDAOImpl memberDAO;

    @Override
    public boolean isUniqNickName(String MEMBER_NICKNAME) {

        return memberDAO.countMemberNickName(MEMBER_NICKNAME) != 0;

    }

    @Override
    public int saveMemberForm(MemberFormDTO memberFormDTO) {

        UUID F_UID = UUID.randomUUID();
        File uploadDirectory = new File(PROFILE_IMAGE_UPLOAD_PATH);

        if (!uploadDirectory.isDirectory()) {
            if (uploadDirectory.mkdir()) {
                System.out.println("프로필 저장 폴더가 없으므로 생성합니다.");
                uploadDirectory.setExecutable(true);
                uploadDirectory.setReadable(true);
                uploadDirectory.setWritable(true);
            } else {
                return 0;
            }
        }

        MultipartFile uploadedImage = memberFormDTO.getMEMBER_PROFILE_IMAGE();
        String imgExtension = uploadedImage.getContentType().split("/")[1];

        try {
            uploadedImage.transferTo(new File(PROFILE_IMAGE_UPLOAD_PATH + F_UID + "." + imgExtension));
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }

        return memberDAO.insertMember(memberFormDTO, F_UID.toString().concat("." + imgExtension));

    }
}
