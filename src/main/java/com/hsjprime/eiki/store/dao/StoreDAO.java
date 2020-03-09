package com.hsjprime.eiki.store.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

@Repository
public class StoreDAO {

    @Autowired
    DataSource dataSource;
    @Autowired
    NamedParameterJdbcTemplate namedJdbcTemplate;

    public Map<String, Object> selectStoreInfo(int storeIdx, int memberIdx) {

        String SQL = "SELECT ES.STORE_DEC_IDX                                              AS STORE_DEC_IDX,\n" +
                "       ES.STORE_NAME                                                 AS STORE_NAME,\n" +
                "       ES.STORE_CALL                                                 AS STORE_CALL,\n" +
                "       ES.STORE_LATITUDE                                             AS STORE_LATITUDE,\n" +
                "       ES.STORE_LONGITUDE                                            AS STORE_LONGITUDE,\n" +
                "       ES.STORE_TYPE                                                 AS STORE_TYPE,\n" +
                "       ES.STORE_DESCRIPTION                                          AS STORE_DESCRIPTION,\n" +
                "       ES.STORE_COMMENT_COUNT                                        AS STORE_COUNT,\n" +
                "       ES.STORE_PREFERENCE_COUNT                                     AS STORE_PREFERENCE_COUNT,\n" +
                "       ES.IS_DELIVERY                                                AS IS_DELIVERY,\n" +
                "       GET_PREF_RATIO(ESP_AGG.PREF_ONE, ES.STORE_PREFERENCE_COUNT)   AS PREF_ONE_RATIO,\n" +
                "       GET_PREF_RATIO(ESP_AGG.PREF_TWO, ES.STORE_PREFERENCE_COUNT)   AS PREF_TWO_RATIO,\n" +
                "       GET_PREF_RATIO(ESP_AGG.PREF_THREE, ES.STORE_PREFERENCE_COUNT) AS PREF_THREE_RATIO,\n" +
                "       GET_PREF_RATIO(ESP_AGG.PREF_FOUR, ES.STORE_PREFERENCE_COUNT)  AS PREF_FOUR_RATIO,\n" +
                "       GET_PREF_RATIO(ESP_AGG.PREF_FIVE, ES.STORE_PREFERENCE_COUNT)  AS PREF_FIVE_RATIO,\n" +
                "       ESP_MEMBER_SELECTED.SELECTED_PREFERENCE                       AS PREF_SELECTED\n" +
                "FROM EIKI_STORE AS ES\n" +
                "         LEFT OUTER JOIN (\n" +
                "    (SELECT ESP.STORE_DEC_IDX                                       AS STORE_DEC_IDX,\n" +
                "            IFNULL(SUM(CASE WHEN ESP.PREFERENCE = 1 THEN 1 END), 0) AS PREF_ONE,\n" +
                "            IFNULL(SUM(CASE WHEN ESP.PREFERENCE = 2 THEN 1 END), 0) AS PREF_TWO,\n" +
                "            IFNULL(SUM(CASE WHEN ESP.PREFERENCE = 3 THEN 1 END), 0) AS PREF_THREE,\n" +
                "            IFNULL(SUM(CASE WHEN ESP.PREFERENCE = 4 THEN 1 END), 0) AS PREF_FOUR,\n" +
                "            IFNULL(SUM(CASE WHEN ESP.PREFERENCE = 5 THEN 1 END), 0) AS PREF_FIVE\n" +
                "     FROM EIKI_STORE_PREFERENCE AS ESP\n" +
                "     WHERE ESP.STORE_DEC_IDX = :STORE_DEC_IDX\n" +
                "     GROUP BY ESP.STORE_DEC_IDX)\n" +
                "    UNION\n" +
                "    (SELECT 1 AS STORE_DEC_IDX,\n" +
                "            0 AS PREF_ONE,\n" +
                "            0 AS PREF_TWO,\n" +
                "            0 AS PREF_THREE,\n" +
                "            0 AS PREF_FOUR,\n" +
                "            0 AS PREF_FIVE)\n" +
                "    LIMIT 1\n" +
                ") AS ESP_AGG ON ES.STORE_DEC_IDX = ESP_AGG.STORE_DEC_IDX\n" +
                "         LEFT OUTER JOIN (\n" +
                "    SELECT STORE_DEC_IDX, PREFERENCE AS SELECTED_PREFERENCE\n" +
                "    FROM EIKI_STORE_PREFERENCE\n" +
                "    WHERE MEMBER_DEC_IDX = :MEMBER_DEC_IDX\n" +
                ") AS ESP_MEMBER_SELECTED ON ES.STORE_DEC_IDX = ESP_MEMBER_SELECTED.STORE_DEC_IDX\n" +
                "WHERE ES.STORE_DEC_IDX = :STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);

        return namedJdbcTemplate.queryForMap(SQL, paramMap);

    }

    public Map<String, Object> selectStorePostHistory(int storeIdx) {

        String SQL = "SELECT ES.STORE_NAME        AS STORE_NAME,\n" +
                "       ES.STORE_CALL        AS STORE_CALL,\n" +
                "       ES.STORE_TYPE        AS STORE_TYPE,\n" +
                "       ES.IS_DELIVERY       AS IS_DELIVERY,\n" +
                "       ES.STORE_LATITUDE    AS STORE_LATITUDE,\n" +
                "       ES.STORE_LONGITUDE   AS STORE_LONGITUDE,\n" +
                "       ES.STORE_DESCRIPTION AS STORE_DESCRIPTION\n" +
                "FROM EIKI_STORE AS ES\n" +
                "WHERE ES.STORE_DEC_IDX = :STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);

        return namedJdbcTemplate.queryForMap(SQL, paramMap);

    }

    public List<Map<String, Object>> selectStoreMenus(int storeIdx) {

        String SQL = "SELECT MENU_NAME,\n" +
                "       MENU_PRICE\n" +
                "FROM EIKI_STORE_MENU AS ESM\n" +
                "WHERE ESM.STORE_DEC_IDX=:STORE_DEC_IDX;";

        return namedJdbcTemplate.queryForList(SQL, new MapSqlParameterSource("STORE_DEC_IDX", storeIdx));
    }

    public List<Map<String, Object>> selectStoreComments(int storeIdx) {

        String SQL = "SELECT IFNULL(EM.MEMBER_NICKNAME, \"탈퇴한학우\")            AS MEMBER_NICKNAME,\n" +
                "       IFNULL(EM.MEMBER_PROFILE_IMAGE, \"default.png\") AS MEMBER_PROFILE_IMAGE,\n" +
                "       ESC.MEMBER_DEC_IDX                             AS MEMBER_DEC_IDX,\n" +
                "       ESC.COMMENT_DEC_IDX                            AS COMMENT_DEC_IDX,\n" +
                "       ESC.COMMENT_CONTENT                            AS COMMENT_CONTENT,\n" +
                "       ESC.COMMENT_PREFERENCE                         AS COMMENT_PREFERENCE,\n" +
                "       DATE_FORMAT(ESC.UPDATED_AT, '%Y.%m.%d. %r')    AS UPDATED_AT\n" +
                "FROM EIKI_STORE_COMMENT AS ESC\n" +
                "         LEFT OUTER JOIN EIKI_MEMBER AS EM ON ESC.MEMBER_DEC_IDX = EM.MEMBER_DEC_IDX\n" +
                "WHERE ESC.STORE_DEC_IDX = :STORE_DEC_IDX\n" +
                "ORDER BY ESC.UPDATED_AT ASC;";

        return namedJdbcTemplate.queryForList(SQL, new MapSqlParameterSource("STORE_DEC_IDX", storeIdx));

    }

    public List<Map<String, Object>> selectStoreImages(int storeIdx) {

        String SQL = "SELECT STORE_IMAGE\n" +
                "FROM EIKI_STORE_IMAGE\n" +
                "WHERE STORE_DEC_IDX = :STORE_DEC_IDX;";

        return namedJdbcTemplate.queryForList(SQL, new MapSqlParameterSource("STORE_DEC_IDX", storeIdx));

    }

    public boolean isPreferenceExist(int storeIdx, int memberIdx) {

        String SQL = "SELECT (\n" +
                "           CASE WHEN COUNT(*) >= 1 THEN TRUE ELSE FALSE END\n" +
                "           ) AS IS_PREFERENCE_EXIST\n" +
                "FROM EIKI_STORE_PREFERENCE AS ESP\n" +
                "WHERE ESP.STORE_DEC_IDX=:STORE_DEC_IDX\n" +
                "  AND ESP.MEMBER_DEC_IDX=:MEMBER_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);

        return namedJdbcTemplate.queryForObject(SQL, paramMap, Boolean.class);

    }

    public boolean updatePreference(int storeIdx, int memberIdx, int prefValue) {

        String SQL = "UPDATE\n" +
                "    EIKI_STORE_PREFERENCE\n" +
                "SET PREFERENCE=:PREFERENCE\n" +
                "WHERE STORE_DEC_IDX=:STORE_DEC_IDX\n" +
                "  AND MEMBER_DEC_IDX=:MEMBER_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("PREFERENCE", prefValue);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public boolean insertPreference(int storeIdx, int memberIdx, int prefValue) {

        String SQL = "INSERT INTO EIKI_STORE_PREFERENCE(STORE_DEC_IDX, MEMBER_DEC_IDX, PREFERENCE)\n" +
                "VALUES (:STORE_DEC_IDX ,:MEMBER_DEC_IDX ,:PREFERENCE);";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("PREFERENCE", prefValue);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public boolean increasePreferenceCount(int storeIdx) {

        String INCREASE_SQL = "UPDATE\n" +
                "    EIKI_STORE AS ES\n" +
                "SET ES.STORE_PREFERENCE_COUNT = ES.STORE_PREFERENCE_COUNT + 1\n" +
                "WHERE ES.STORE_DEC_IDX=:STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);

        return (namedJdbcTemplate.update(INCREASE_SQL, paramMap)) == 1;

    }

    public boolean insertComment(int storeIdx, int memberIdx, String comment) {

        String SQL = "INSERT INTO EIKI_STORE_COMMENT(STORE_DEC_IDX, MEMBER_DEC_IDX, COMMENT_CONTENT, COMMENT_PREFERENCE, UPDATED_AT)\n" +
                "VALUES (:STORE_DEC_IDX, :MEMBER_DEC_IDX, :COMMENT_CONTENT, 0, NOW());";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("COMMENT_CONTENT", comment);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public boolean isCommentedUser(int memberIdx, int commentIdx) {

        String SQL = "SELECT (CASE WHEN ESC.MEMBER_DEC_IDX = :MEMBER_DEC_IDX THEN TRUE ELSE FALSE END) AS IS_COMMENTED_USER\n" +
                "FROM EIKI_STORE_COMMENT AS ESC\n" +
                "WHERE COMMENT_DEC_IDX = :COMMENT_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("COMMENT_DEC_IDX", commentIdx);

        return namedJdbcTemplate.queryForObject(SQL, paramMap, boolean.class);

    }

    public boolean deleteComment(int commentIdx) {

        String SQL = "DELETE\n" +
                "FROM EIKI_STORE_COMMENT AS ESC\n" +
                "WHERE ESC.COMMENT_DEC_IDX = :COMMENT_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("COMMENT_DEC_IDX", commentIdx);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public boolean updateCommentCount(int storeIdx, int diff) {

        String SQL = "UPDATE\n" +
                "    EIKI_STORE AS ES\n" +
                "SET ES.STORE_COMMENT_COUNT = ES.STORE_COMMENT_COUNT + (:DIFF)\n" +
                "WHERE ES.STORE_DEC_IDX = :STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("DIFF", diff);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public boolean isCommentPreferenceHistoryExist(int storeIdx, int memberIdx, int commentIdx) {

        String SQL = "SELECT COUNT(*)\n" +
                "FROM EIKI_COMMENT_PREFERENCE_HISTORY AS ECPH\n" +
                "WHERE ECPH.STORE_DEC_IDX = :STORE_DEC_IDX\n" +
                "  AND ECPH.MEMBER_DEC_IDX = :MEMBER_DEC_IDX\n" +
                "  AND ECPH.COMMENT_DEC_IDX = :COMMENT_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("COMMENT_DEC_IDX", commentIdx);

        return (namedJdbcTemplate.queryForObject(SQL, paramMap, Integer.class) == 1);

    }

    public boolean deleteCommentPreferenceHistory(int storeIdx, int memberIdx, int commentIdx) {

        String SQL = "DELETE\n" +
                "FROM EIKI_COMMENT_PREFERENCE_HISTORY AS ECPH\n" +
                "WHERE ECPH.STORE_DEC_IDX = :STORE_DEC_IDX\n" +
                "  AND ECPH.MEMBER_DEC_IDX = :MEMBER_DEC_IDX\n" +
                "  AND ECPH.COMMENT_DEC_IDX = :COMMENT_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("COMMENT_DEC_IDX", commentIdx);

        return (namedJdbcTemplate.update(SQL, paramMap) == 1);

    }

    public boolean insertCommentPreferenceHistory(int storeIdx, int memberIdx, int commentIdx) {

        String SQL = "INSERT INTO EIKI_COMMENT_PREFERENCE_HISTORY(STORE_DEC_IDX, MEMBER_DEC_IDX, COMMENT_DEC_IDX)\n" +
                "VALUES (:STORE_DEC_IDX, :MEMBER_DEC_IDX, :COMMENT_DEC_IDX);";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("COMMENT_DEC_IDX", commentIdx);

        return (namedJdbcTemplate.update(SQL, paramMap) == 1);

    }

    public boolean updateCommentPreference(int storeIdx, int memberIdx, int commentIdx, int diff) {

        String SQL = "UPDATE\n" +
                "    EIKI_STORE_COMMENT AS ESC\n" +
                "SET ESC.COMMENT_PREFERENCE = ESC.COMMENT_PREFERENCE + (:DIFF)\n" +
                "WHERE ESC.STORE_DEC_IDX = :STORE_DEC_IDX\n" +
                "  AND ESC.MEMBER_DEC_IDX = :MEMBER_DEC_IDX\n" +
                "  AND ESC.COMMENT_DEC_IDX = :COMMENT_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("COMMENT_DEC_IDX", commentIdx);
        paramMap.addValue("DIFF", diff);

        return (namedJdbcTemplate.update(SQL, paramMap) == 1);

    }

}
