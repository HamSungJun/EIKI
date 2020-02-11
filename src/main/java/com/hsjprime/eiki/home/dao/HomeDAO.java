package com.hsjprime.eiki.home.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

@Repository
public class HomeDAO {

    @Autowired
    DataSource dataSource;
    @Autowired
    JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> selectStoreByQuery(String search, String order) {

        String SQL = "SELECT * FROM (\n" +
                "\tSELECT\n" +
                "\t\tES.STORE_DEC_IDX AS STORE_DEC_IDX,\n" +
                "\t\tES.STORE_NAME AS STORE_NAME,\n" +
                "\t\tES.STORE_TYPE AS STORE_TYPE,\n" +
                "\t\tES.IS_DELIVERY AS IS_DELIVERY,\n" +
                "\t\tESI.STORE_IMAGE AS STORE_IMAGE,\n" +
                "\t\tAVG(IFNULL(ESP.PREFERENCE,0)) AS AVG_PREFERENCE\n" +
                "\t\tCOUNT() AS COMMENTS\n" +
                "\tFROM\n" +
                "\t\tEIKI_STORE AS ES\n" +
                "\t\tINNER JOIN EIKI_STORE_IMAGE AS ESI ON ES.STORE_DEC_IDX = ESI.STORE_DEC_IDX\n" +
                "\t\tLEFT OUTER JOIN EIKI_STORE_PREFERENCE AS ESP ON ES.STORE_DEC_IDX = ESP.STORE_DEC_IDX\n" +
                "\t\tLEFT OUTER JOIN EIKI_STORE_COMMENT AS ESC ON ES.STORE_DEC_IDX = ESC.STORE_DEC_IDX\n" +
                "\tWHERE\n" +
                "\t\tESI.STORE_IMAGE_TYPE=\"THUMBNAIL\" AND\n" +
                "\t\tES.STORE_NAME LIKE ?\n"+
                "\tGROUP BY\n" +
                "\t\tES.STORE_DEC_IDX,\n" +
                "\t\tESI.STORE_IMAGE\n" +
                ") AS T;";

        return jdbcTemplate.queryForList(SQL,new Object[]{"%"+search+"%"});

    }

}
