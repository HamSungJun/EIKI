package com.hsjprime.eiki.admin.dao;

import com.hsjprime.eiki.admin.dao.mapper.MemberMapper;
import com.hsjprime.eiki.admin.dto.Member;
import com.hsjprime.eiki.admin.dto.StorePostDTO;
import com.hsjprime.eiki.member.dto.PageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class AdminDAO {

    @Autowired
    DataSource dataSource;

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    NamedParameterJdbcTemplate namedJdbcTemplate;

    public int insertStore(StorePostDTO storePostDTO) {

        String SQL = "INSERT INTO EIKI_STORE(STORE_NAME, STORE_CALL, STORE_LATITUDE, STORE_LONGITUDE, STORE_TYPE, STORE_DESCRIPTION, STORE_COMMENT_COUNT, IS_DELIVERY)" +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {

                PreparedStatement ps = con.prepareStatement(SQL, new String[]{"STORE_DEC_IDX"});
                ps.setString(1, storePostDTO.getSTORE_NAME());
                ps.setString(2, storePostDTO.getSTORE_CALL());
                ps.setFloat(3, storePostDTO.getSTORE_LATITUDE());
                ps.setFloat(4, storePostDTO.getSTORE_LONGITUDE());
                ps.setString(5, storePostDTO.getSTORE_TYPE());
                ps.setString(6, storePostDTO.getSTORE_DESCRIPTION());
                ps.setInt(7, 0);
                ps.setBoolean(8, storePostDTO.getIS_DELIVERY());
                return ps;

            }
        }, keyHolder);

        BigInteger storeIdx = (BigInteger) keyHolder.getKey();
        return storeIdx.intValue();

    }

    public boolean updateStore(StorePostDTO storePostDTO, int storeIdx) {

        String SQL = "UPDATE\n" +
                "    EIKI_STORE AS ES\n" +
                "SET ES.STORE_NAME        = :STORE_NAME,\n" +
                "    ES.STORE_CALL        = :STORE_CALL,\n" +
                "    ES.STORE_LATITUDE    = :STORE_LATITUDE,\n" +
                "    ES.STORE_LONGITUDE   = :STORE_LONGITUDE,\n" +
                "    ES.STORE_TYPE        = :STORE_TYPE,\n" +
                "    ES.STORE_DESCRIPTION = :STORE_DESCRIPTION,\n" +
                "    ES.IS_DELIVERY       = :IS_DELIVERY\n" +
                "WHERE ES.STORE_DEC_IDX = :STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_NAME", storePostDTO.getSTORE_NAME());
        paramMap.addValue("STORE_CALL", storePostDTO.getSTORE_CALL());
        paramMap.addValue("STORE_LATITUDE", storePostDTO.getSTORE_LATITUDE());
        paramMap.addValue("STORE_LONGITUDE", storePostDTO.getSTORE_LONGITUDE());
        paramMap.addValue("STORE_TYPE", storePostDTO.getSTORE_TYPE());
        paramMap.addValue("STORE_DESCRIPTION", storePostDTO.getSTORE_DESCRIPTION());
        paramMap.addValue("IS_DELIVERY", storePostDTO.getIS_DELIVERY());
        paramMap.addValue("STORE_DEC_IDX", storeIdx);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public void insertStoreMenu(int storeIdx, String MENU_NAME, int MENU_PRICE) {

        String SQL = "INSERT INTO EIKI_STORE_MENU(STORE_DEC_IDX, MENU_NAME, MENU_PRICE) VALUES (?, ?, ?);";
        jdbcTemplate.update(SQL,
                storeIdx,
                MENU_NAME,
                MENU_PRICE
        );

    }

    public boolean deleteStoreMenuAll(int storeIdx) {

        String SQL = "DELETE\n" +
                "FROM EIKI_STORE_MENU AS ESM\n" +
                "WHERE ESM.STORE_DEC_IDX = :STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);

        return (namedJdbcTemplate.update(SQL, paramMap) > 0);

    }

    public int insertFile(int storeIdx, String filename, boolean isThumbnail) {

        String SQL = "INSERT INTO EIKI_STORE_IMAGE(STORE_DEC_IDX, STORE_IMAGE, STORE_IMAGE_TYPE) VALUES (?, ?, ?);";
        return jdbcTemplate.update(SQL,
                storeIdx,
                filename,
                isThumbnail ? "THUMBNAIL" : "OTHER"
        );

    }

    public List<Map<String, Object>> selectStoreInfo(String storeName) {

        String SQL = "SELECT ES.STORE_DEC_IDX AS STORE_DEC_IDX,\n" +
                "       ES.STORE_NAME    AS STORE_NAME,\n" +
                "       ES.STORE_CALL    AS STORE_CALL,\n" +
                "       ES.STORE_TYPE    AS STORE_TYPE,\n" +
                "       ES.IS_DELIVERY   AS IS_DELIVERY\n" +
                "FROM EIKI_STORE AS ES\n" +
                "WHERE ES.STORE_NAME LIKE :STORE_NAME\n" +
                "ORDER BY ES.STORE_DEC_IDX ASC;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_NAME", "%" + storeName + "%");

        return namedJdbcTemplate.queryForList(SQL, paramMap);

    }

    public boolean deleteStore(int storeIdx) {

        String SQL = "DELETE\n" +
                "FROM EIKI_STORE AS ES\n" +
                "WHERE ES.STORE_DEC_IDX = :STORE_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_DEC_IDX", storeIdx);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public boolean deleteStoreImage(String fileName) {

        String SQL = "DELETE\n" +
                "FROM EIKI_STORE_IMAGE AS ESI\n" +
                "WHERE ESI.STORE_IMAGE = :STORE_IMAGE;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("STORE_IMAGE", fileName);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;
    }

    public int selectMemberCount(){

        String SQL = "SELECT COUNT(*) AS COUNT\n" +
                "FROM EIKI_MEMBER;";

        return jdbcTemplate.queryForObject(SQL, Integer.class);

    }

    public List<Member> selectMemberList(PageVO pageVO){

        String SQL = "SELECT EM.MEMBER_DEC_IDX       AS MEMBER_DEC_IDX,\n" +
                "       EM.MEMBER_ID            AS MEMBER_ID,\n" +
                "       EM.MEMBER_NICKNAME      AS MEMBER_NICKNAME,\n" +
                "       EM.MEMBER_PHONE         AS MEMBER_PHONE,\n" +
                "       EM.MEMBER_PROFILE_IMAGE AS MEMBER_PROFILE_IMAGE,\n" +
                "       EM.IS_ADMIN             AS IS_ADMIN\n" +
                "FROM EIKI_MEMBER AS EM\n" +
                "ORDER BY MEMBER_DEC_IDX ASC\n" +
                "LIMIT :LIMIT_VALUE\n" +
                "    OFFSET :OFFSET_BY_PAGE;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("LIMIT_VALUE", pageVO.getItemPerPage());
        paramMap.addValue("OFFSET_BY_PAGE", pageVO.getOffsetByPage());

        return namedJdbcTemplate.query(SQL, paramMap, new MemberMapper());

    }

    public boolean updateMemberAuthority(int memberIdx){

        String SQL = "UPDATE EIKI_MEMBER AS EM\n" +
                "SET EM.IS_ADMIN = IF(EM.IS_ADMIN = 1, 0, 1)\n" +
                "WHERE EM.MEMBER_DEC_IDX = :MEMBER_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);

        return (namedJdbcTemplate.update(SQL, paramMap)) == 1;

    }

    public List<Map<String, Object>> selectAccessHistory(int duration){

        String SQL = "SELECT EAH.ACCESS_DATE  AS ACCESS_DATE,\n" +
                "       EAH.ACCESS_COUNT AS ACCESS_COUNT\n" +
                "FROM EIKI_ACCESS_HISTORY AS EAH\n" +
                "WHERE EAH.ACCESS_DATE >= DATE_SUB(NOW(), INTERVAL :DURATION DAY)\n" +
                "ORDER BY ACCESS_DATE ASC;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("DURATION", duration);

        return namedJdbcTemplate.queryForList(SQL, paramMap);

    }

}
