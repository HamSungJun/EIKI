package com.hsjprime.eiki.index.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class IndexDAO {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public Map<String, Object> isTodayExist() {

        String SQL = "SELECT EAH.ACCESS_DATE AS ACCESS_DATE,\n" +
                "       IF(COUNT(*) = 1, 1, 0) AS IS_TODAY_EXIST\n" +
                "FROM EIKI_ACCESS_HISTORY AS EAH\n" +
                "WHERE EAH.ACCESS_DATE = DATE_FORMAT(NOW(), \"%Y-%m-%d\");";

        return jdbcTemplate.queryForMap(SQL);

    }

    public boolean createPageAccess() {

        String SQL = "INSERT INTO EIKI_ACCESS_HISTORY\n" +
                "VALUES (DATE_FORMAT(NOW(), \"%Y-%m-%d\"), 1);";

        return (jdbcTemplate.update(SQL)) == 1;

    }

    public boolean updatePageAccess(String today) {

        String SQL = "UPDATE EIKI_ACCESS_HISTORY AS EAH\n" +
                "SET EAH.ACCESS_COUNT = EAH.ACCESS_COUNT + 1\n" +
                "WHERE EAH.ACCESS_DATE = :ACCESS_DATE;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("ACCESS_DATE", today);

        return (namedParameterJdbcTemplate.update(SQL, paramMap)) == 1;

    }

}
