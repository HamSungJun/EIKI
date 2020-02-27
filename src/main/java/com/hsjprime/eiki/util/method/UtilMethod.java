package com.hsjprime.eiki.util.method;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.util.UriUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

public final class UtilMethod {

    public static String createUUID() {
        return UUID.randomUUID().toString();
    }

    public static String createAuthNumber() {

        StringBuilder sBuf = new StringBuilder();

        for (int index = 0; index < 4; index++) {
            sBuf.append((int) Math.floor(Math.random() * 10));
        }

        return sBuf.toString();

    }

    public static Map<String, String> queryToMap(String queryString) {
        // order -> pref, comment, name
        Map<String, String> queryMap = new HashMap<>();

        if (queryString != null && queryString.contains("search=") && queryString.contains("order=")) {
            StringTokenizer queryToken = new StringTokenizer(queryString, "&");
            while (queryToken.hasMoreTokens()) {
                StringTokenizer keyValueToken = new StringTokenizer(queryToken.nextToken(), "=");
                String key = keyValueToken.nextToken();
                String value = "";
                try {
                    value = UriUtils.decode(keyValueToken.nextToken(), "UTF-8");
                } catch (UnsupportedEncodingException | NoSuchElementException e) {
                    value = "";
                } finally {
                    queryMap.put(key, value);
                }
            }
        } else {
            queryMap.put("search", "");
            queryMap.put("order", "pref");
        }

        return queryMap;

    }

    public static List<Map<String, Object>> jsonToMap(String json) {

        ObjectMapper mapper = new ObjectMapper();
        List<Map<String, Object>> mapResult = new ArrayList<>();
        try{
            mapResult = mapper.readValue(json, new TypeReference<List<Map<String, Object>>>(){});
        } catch (IOException e){
            e.printStackTrace();
        }

        return mapResult;

    }

}
