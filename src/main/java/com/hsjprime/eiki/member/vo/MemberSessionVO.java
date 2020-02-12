package com.hsjprime.eiki.member.vo;

public class MemberSessionVO {
    private int MEMBER_DEC_IDX;
    private String MEMBER_ID;
    private String MEMBER_NICKNAME;
    private String MEMBER_PHONE;
    private String MEMBER_BIRTHDAY;
    private String MEMBER_PROFILE_IMAGE;
    private int IS_ADMIN;

    public int getMEMBER_DEC_IDX() {
        return MEMBER_DEC_IDX;
    }

    public String getMEMBER_ID() {
        return MEMBER_ID;
    }

    public String getMEMBER_NICKNAME() {
        return MEMBER_NICKNAME;
    }

    public String getMEMBER_PHONE() {
        return MEMBER_PHONE;
    }

    public String getMEMBER_BIRTHDAY() {
        return MEMBER_BIRTHDAY;
    }

    public String getMEMBER_PROFILE_IMAGE() {
        return MEMBER_PROFILE_IMAGE;
    }

    public int getIS_ADMIN() {
        return IS_ADMIN;
    }

    public void setMEMBER_DEC_IDX(int MEMBER_DEC_IDX) {
        this.MEMBER_DEC_IDX = MEMBER_DEC_IDX;
    }

    public void setMEMBER_ID(String MEMBER_ID) {
        this.MEMBER_ID = MEMBER_ID;
    }

    public void setMEMBER_NICKNAME(String MEMBER_NICKNAME) {
        this.MEMBER_NICKNAME = MEMBER_NICKNAME;
    }

    public void setMEMBER_PHONE(String MEMBER_PHONE) {
        this.MEMBER_PHONE = MEMBER_PHONE;
    }

    public void setMEMBER_BIRTHDAY(String MEMBER_BIRTHDAY) {
        this.MEMBER_BIRTHDAY = MEMBER_BIRTHDAY;
    }

    public void setMEMBER_PROFILE_IMAGE(String MEMBER_PROFILE_IMAGE) {
        this.MEMBER_PROFILE_IMAGE = MEMBER_PROFILE_IMAGE;
    }

    public void setIS_ADMIN(int IS_ADMIN) {
        this.IS_ADMIN = IS_ADMIN;
    }

}
