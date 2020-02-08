package com.hsjprime.eiki.admin.controller.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class StorePostDTO {

    private String STORE_NAME;
    private String STORE_TYPE;
    private boolean IS_DELIVERY;
    private MultipartFile STORE_THUMBNAIL;
    private List<MultipartFile> STORE_IMAGES;
    private double STORE_LATITUDE;
    private double STORE_LONGITUDE;
    private String STORE_DESCRIPTION;

    public String getSTORE_NAME() {
        return STORE_NAME;
    }

    public String getSTORE_TYPE() {
        return STORE_TYPE;
    }

    public boolean getIS_DELIVERY(){
        return IS_DELIVERY;
    }

    public MultipartFile getSTORE_THUMBNAIL() {
        return STORE_THUMBNAIL;
    }

    public List<MultipartFile> getSTORE_IMAGES() {
        return STORE_IMAGES;
    }

    public double getSTORE_LATITUDE() {
        return STORE_LATITUDE;
    }

    public double getSTORE_LONGITUDE() {
        return STORE_LONGITUDE;
    }

    public String getSTORE_DESCRIPTION() {
        return STORE_DESCRIPTION;
    }

    public void setSTORE_NAME(String STORE_NAME) {
        this.STORE_NAME = STORE_NAME;
    }

    public void setSTORE_TYPE(String STORE_TYPE) {
        this.STORE_TYPE = STORE_TYPE;
    }

    public void setSTORE_THUMBNAIL(MultipartFile STORE_THUMBNAIL) {
        this.STORE_THUMBNAIL = STORE_THUMBNAIL;
    }

    public void setIS_DELIVERY(boolean IS_DELIVERY) {
        this.IS_DELIVERY = IS_DELIVERY;
    }

    public void setSTORE_IMAGES(List<MultipartFile> STORE_IMAGES) {
        this.STORE_IMAGES = STORE_IMAGES;
    }

    public void setSTORE_LATITUDE(double STORE_LATITUDE) {
        this.STORE_LATITUDE = STORE_LATITUDE;
    }

    public void setSTORE_LONGITUDE(double STORE_LONGITUDE) {
        this.STORE_LONGITUDE = STORE_LONGITUDE;
    }

    public void setSTORE_DESCRIPTION(String STORE_DESCRIPTION) {
        this.STORE_DESCRIPTION = STORE_DESCRIPTION;
    }

    @Override
    public String toString() {
        return "StorePostDTO{" +
                "STORE_NAME='" + STORE_NAME + '\'' +
                ", STORE_TYPE='" + STORE_TYPE + '\'' +
                ", IS_DELIVERY=" + IS_DELIVERY +
                ", STORE_THUMBNAIL=" + STORE_THUMBNAIL +
                ", STORE_IMAGES=" + STORE_IMAGES +
                ", STORE_LATITUDE=" + STORE_LATITUDE +
                ", STORE_LONGITUDE=" + STORE_LONGITUDE +
                ", STORE_DESCRIPTION='" + STORE_DESCRIPTION + '\'' +
                '}';
    }
}
