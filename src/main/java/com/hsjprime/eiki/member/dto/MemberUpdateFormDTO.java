package com.hsjprime.eiki.member.dto;

import org.springframework.web.multipart.MultipartFile;

public class MemberUpdateFormDTO {

    private String MEMBER_PW;
    private String MEMBER_NICKNAME;
    private String MEMBER_BIRTHDAY;
    private String MEMBER_PHONE;
    private MultipartFile MEMBER_PROFILE_IMAGE;

    public String getMEMBER_PW() {
        return MEMBER_PW;
    }

    public String getMEMBER_NICKNAME() {
        return MEMBER_NICKNAME;
    }

    public String getMEMBER_BIRTHDAY() {
        return MEMBER_BIRTHDAY;
    }

    public String getMEMBER_PHONE() {
        return MEMBER_PHONE;
    }

    public MultipartFile getMEMBER_PROFILE_IMAGE() {
        return MEMBER_PROFILE_IMAGE;
    }

    public void setMEMBER_PW(String MEMBER_PW) {
        this.MEMBER_PW = MEMBER_PW;
    }

    public void setMEMBER_NICKNAME(String MEMBER_NICKNAME) {
        this.MEMBER_NICKNAME = MEMBER_NICKNAME;
    }

    public void setMEMBER_BIRTHDAY(String MEMBER_BIRTHDAY) {
        this.MEMBER_BIRTHDAY = MEMBER_BIRTHDAY;
    }

    public void setMEMBER_PHONE(String MEMBER_PHONE) {
        this.MEMBER_PHONE = MEMBER_PHONE;
    }

    public void setMEMBER_PROFILE_IMAGE(MultipartFile MEMBER_PROFILE_IMAGE) {
        this.MEMBER_PROFILE_IMAGE = MEMBER_PROFILE_IMAGE;
    }

    @Override
    public String toString() {
        return "MemberUpdateFormDTO{" +
                "MEMBER_PW='" + MEMBER_PW + '\'' +
                ", MEMBER_NICKNAME='" + MEMBER_NICKNAME + '\'' +
                ", MEMBER_BIRTHDAY='" + MEMBER_BIRTHDAY + '\'' +
                ", MEMBER_PHONE='" + MEMBER_PHONE + '\'' +
                ", MEMBER_PROFILE_IMAGE=" + MEMBER_PROFILE_IMAGE +
                '}';
    }
}
