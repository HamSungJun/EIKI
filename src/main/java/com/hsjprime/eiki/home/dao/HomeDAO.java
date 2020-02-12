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

        String SQL = "SELECT *\n" +
                "FROM (\n" +
                "         SELECT ES.STORE_DEC_IDX               AS STORE_DEC_IDX,\n" +
                "                ES.STORE_NAME                  AS STORE_NAME,\n" +
                "                ES.STORE_TYPE                  AS STORE_TYPE,\n" +
                "                ES.IS_DELIVERY                 AS IS_DELIVERY,\n" +
                "                ES.STORE_COMMENT_COUNT         AS STORE_COMMENT_COUNT,\n" +
                "                ESI.STORE_IMAGE                AS STORE_THUMBNAIL,\n" +
                "                ROUND(AVG(IFNULL(ESP.PREFERENCE, 0)), 1) AS AVG_PREFERENCE\n" +
                "         FROM EIKI_STORE AS ES\n" +
                "                  INNER JOIN EIKI_STORE_IMAGE AS ESI ON ES.STORE_DEC_IDX = ESI.STORE_DEC_IDX\n" +
                "                  LEFT OUTER JOIN EIKI_STORE_PREFERENCE AS ESP ON ES.STORE_DEC_IDX = ESP.STORE_DEC_IDX\n" +
                "         WHERE ESI.STORE_IMAGE_TYPE = \"THUMBNAIL\"\n" +
                "           AND ES.STORE_NAME LIKE ? \n" +
                "         GROUP BY ES.STORE_DEC_IDX,\n" +
                "                  ESI.STORE_IMAGE\n" +
                "     ) AS T;";

        return jdbcTemplate.queryForList(SQL, new Object[]{"%" + search + "%"});

    }

}
