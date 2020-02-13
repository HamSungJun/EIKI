package com.hsjprime.eiki.store.service;

import com.hsjprime.eiki.store.dao.StoreDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StoreService {

    @Autowired
    StoreDAO storeDAO;

    public Map<String, Object> getStoreInfo(int storeIdx, int memberIdx) {

        return storeDAO.selectStoreInfo(storeIdx, memberIdx);

    }

    public List<Map<String, Object>> getStoreMenus(int storeIdx) {

        return storeDAO.selectStoreMenus(storeIdx);

    }

    public List<Map<String, Object>> getStoreComments(int storeIdx) {

        return storeDAO.selectStoreComments(storeIdx);

    }

    public List<Map<String, Object>> getStoreImages(int storeIdx) {

        return storeDAO.selectStoreImages(storeIdx);

    }

    public boolean isPreferenceExist(int storeIdx, int memberIdx) {

        return storeDAO.isPreferenceExist(storeIdx, memberIdx);

    }

    public boolean setPreference(Map<String, Object> jsonPref) {

        int storeIdx = (int) jsonPref.get("STORE_DEC_IDX");
        int memberIdx = (int) jsonPref.get("MEMBER_DEC_IDX");
        int prefValue = (int) jsonPref.get("PREFERENCE");
        boolean result = false;

        if (isPreferenceExist(storeIdx, memberIdx)) {
            result = storeDAO.updatePreference(storeIdx, memberIdx, prefValue);
        } else {
            if (storeDAO.insertPreference(storeIdx, memberIdx, prefValue)) {
                result = storeDAO.increasePreferenceCount(storeIdx);
            }
            ;
        }

        return result;

    }

    public boolean setComment(Map<String, Object> jsonComment) {

        int storeIdx = (int) jsonComment.get("STORE_DEC_IDX");
        int memberIdx = (int) jsonComment.get("MEMBER_DEC_IDX");
        String comment = (String) jsonComment.get("COMMENT_CONTENT");
        boolean result = false;

        if (storeDAO.insertComment(storeIdx, memberIdx, comment)) {
            result = storeDAO.increaseCommentCount(storeIdx);
        }

        return result;

    }

}
