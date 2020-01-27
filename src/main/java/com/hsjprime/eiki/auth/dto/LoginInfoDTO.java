package com.hsjprime.eiki.auth.dto;

public class LoginInfoDTO {
    private String MEMBER_ID;
    private String MEMBER_PW;

    public String getMEMBER_ID() {
        return MEMBER_ID;
    }

    public String getMEMBER_PW() {
        return MEMBER_PW;
    }

    public void setMEMBER_ID(String MEMBER_ID) {
        this.MEMBER_ID = MEMBER_ID;
    }

    public void setMEMBER_PW(String MEMBER_PW) {
        this.MEMBER_PW = MEMBER_PW;
    }
}
