package com.hsjprime.eiki.home.service;

import com.hsjprime.eiki.home.dao.HomeDAO;
import com.hsjprime.eiki.util.method.UtilMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class HomeService {

    @Autowired
    HomeDAO homeDAO;

    public List<Map<String, Object>> getStoreList(String queryString) {

        Map<String, String> queryMap = UtilMethod.queryToMap(queryString);
        return homeDAO.selectStoreByQuery(queryMap.get("search"), queryMap.get("order"));

    }

}
