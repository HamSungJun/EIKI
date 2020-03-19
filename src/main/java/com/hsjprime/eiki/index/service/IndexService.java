package com.hsjprime.eiki.index.service;

import com.hsjprime.eiki.index.dao.IndexDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class IndexService {

    @Autowired
    IndexDAO indexDAO;

    public boolean pageAccess(){

        Map<String, Object> dateCondition = indexDAO.isTodayExist();

        if((long)dateCondition.get("IS_TODAY_EXIST") == 1){
            return indexDAO.updatePageAccess((String)dateCondition.get("ACCESS_DATE"));
        } else {
            return indexDAO.createPageAccess();
        }

    }

}
