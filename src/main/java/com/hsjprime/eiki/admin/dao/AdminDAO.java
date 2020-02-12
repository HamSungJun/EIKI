package com.hsjprime.eiki.admin.dao;

import com.hsjprime.eiki.admin.dto.StorePostDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@Repository
public class AdminDAO {

    @Autowired
    DataSource dataSource;

    @Autowired
    JdbcTemplate jdbcTemplate;

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

    public void insertStoreMenu(int storeIdx, String MENU_NAME, int MENU_PRICE) {

        String SQL = "INSERT INTO EIKI_STORE_MENU(STORE_DEC_IDX, MENU_NAME, MENU_PRICE) VALUES (?, ?, ?);";
        jdbcTemplate.update(SQL,
                storeIdx,
                MENU_NAME,
                MENU_PRICE
        );

    }

    public int insertFile(int storeIdx, String filename, boolean isThumbnail) {

        String SQL = "INSERT INTO EIKI_STORE_IMAGE(STORE_DEC_IDX, STORE_IMAGE, STORE_IMAGE_TYPE) VALUES (?, ?, ?);";
        return jdbcTemplate.update(SQL,
                storeIdx,
                filename,
                isThumbnail ? "THUMBNAIL" : "OTHER"
        );

    }

}
