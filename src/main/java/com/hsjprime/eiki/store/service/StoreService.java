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
//
//    public List<Map<String, Object>> getStoreComments(int storeIdx) {
//
//    }

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
            if(storeDAO.insertPreference(storeIdx, memberIdx, prefValue)){
                result = storeDAO.increasePreferenceCount(storeIdx);
            };
        }

        return result;

    }

}
