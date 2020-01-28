package com.hsjprime.eiki.member.dto;

import org.springframework.web.multipart.MultipartFile;

public class MemberFormDTO {

    private String MEMBER_ID;
    private String MEMBER_PW;
    private String MEMBER_PW_CONFIRM;
    private String AUTH_NUM;
    private String MEMBER_NICKNAME;
    private String MEMBER_BIRTHDAY;
    private String MEMBER_PHONE;
    private MultipartFile MEMBER_PROFILE_IMAGE;

    public String getMEMBER_ID() {
        return MEMBER_ID;
    }

    public String getMEMBER_PW() {
        return MEMBER_PW;
    }

    public String getMEMBER_PW_CONFIRM() {
        return MEMBER_PW_CONFIRM;
    }

    public String getAUTH_NUM() {
        return AUTH_NUM;
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

    public void setMEMBER_ID(String MEMBER_ID) {
        this.MEMBER_ID = MEMBER_ID;
    }

    public void setMEMBER_PW(String MEMBER_PW) {
        this.MEMBER_PW = MEMBER_PW;
    }

    public void setMEMBER_PW_CONFIRM(String MEMBER_PW_CONFIRM) {
        this.MEMBER_PW_CONFIRM = MEMBER_PW_CONFIRM;
    }

    public void setAUTH_NUM(String AUTH_NUM) {
        this.AUTH_NUM = AUTH_NUM;
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
        return "MemberFormDTO{" +
                "MEMBER_ID='" + MEMBER_ID + '\'' +
                ", MEMBER_PW='" + MEMBER_PW + '\'' +
                ", MEMBER_PW_CONFIRM='" + MEMBER_PW_CONFIRM + '\'' +
                ", AUTH_NUM='" + AUTH_NUM + '\'' +
                ", MEMBER_NICKNAME='" + MEMBER_NICKNAME + '\'' +
                ", MEMBER_BIRTHDAY='" + MEMBER_BIRTHDAY + '\'' +
                ", MEMBER_PHONE='" + MEMBER_PHONE + '\'' +
                ", MEMBER_PROFILE_IMAGE=" + MEMBER_PROFILE_IMAGE +
                '}';
    }
}
