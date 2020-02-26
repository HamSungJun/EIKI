package com.hsjprime.eiki.member.dao;

import com.hsjprime.eiki.member.dto.MemberFormDTO;
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
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Autowired
    DataSource dataSource;
    @Autowired
    JdbcTemplate jdbcTemplate;
    @Autowired
    NamedParameterJdbcTemplate namedJdbcTemplate;

    public MemberDAOImpl() {
    }

    @Override
    public int countMemberNickName(String MEMBER_NICKNAME) {

        String SQL = "SELECT COUNT(*) FROM EIKI_MEMBER WHERE MEMBER_NICKNAME = ?;";
        return jdbcTemplate.queryForObject(SQL, new Object[]{MEMBER_NICKNAME}, Integer.class);

    }

    @Override
    public int insertMember(MemberFormDTO memberFormDTO, String F_UID, int isAdmin) {

        String SQL = "INSERT INTO EIKI_MEMBER (MEMBER_ID, MEMBER_PW, MEMBER_NICKNAME, MEMBER_BIRTHDAY, MEMBER_PHONE, MEMBER_PROFILE_IMAGE, IS_ADMIN)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {

                PreparedStatement ps = con.prepareStatement(SQL, new String[]{"STORE_DEC_IDX"});
                ps.setString(1, memberFormDTO.getMEMBER_ID());
                ps.setString(2, memberFormDTO.getMEMBER_PW());
                ps.setString(3, memberFormDTO.getMEMBER_NICKNAME());
                ps.setDate(4, Date.valueOf(memberFormDTO.getMEMBER_BIRTHDAY()));
                ps.setString(5, memberFormDTO.getMEMBER_PHONE());
                ps.setString(6, F_UID);
                ps.setInt(7, isAdmin);
                return ps;

            }
        }, keyHolder);

        BigInteger memberIdx = (BigInteger) keyHolder.getKey();
        return memberIdx.intValue();

    }

    @Override
    public boolean updateMember(Map<String, Object> paramMap) {

        if (paramMap.size() <= 1) return true;

        StringBuilder sqlBuilder = new StringBuilder();
        Iterator keyIter = paramMap.keySet().iterator();
        sqlBuilder.append("UPDATE EIKI_MEMBER SET ");

        for (int i = 0; i < paramMap.size(); i++) {
            String nextKey = (String) keyIter.next();
            System.out.println(nextKey);
            if (paramMap.containsKey(nextKey) && !nextKey.equals("MEMBER_DEC_IDX")) {
                sqlBuilder.append(nextKey)
                        .append("=")
                        .append(":")
                        .append(nextKey + " ")
                        .append(", ");
            }
        }
        sqlBuilder.delete(sqlBuilder.length()-3,sqlBuilder.length()-1);
        sqlBuilder.append("WHERE MEMBER_DEC_IDX = :MEMBER_DEC_IDX;");

        System.out.println(sqlBuilder.toString());
        return (namedJdbcTemplate.update(sqlBuilder.toString(), paramMap)) == 1;

    }

    @Override
    public List<Map<String, Object>> selectCommentList(PageVO pageVO, int memberIdx){

        String SQL = "SELECT ES.STORE_DEC_IDX                                 AS STORE_DEC_IDX,\n" +
                "       ESC.COMMENT_DEC_IDX                              AS COMMENT_DEC_IDX,\n" +
                "       ES.STORE_NAME                                    AS STORE_NAME,\n" +
                "       ESC.COMMENT_CONTENT                              AS COMMENT_CONTENT,\n" +
                "       ESC.COMMENT_PREFERENCE                           AS COMMENT_PREFERENCE,\n" +
                "       DATE_FORMAT(ESC.UPDATED_AT, '%Y-%m-%d %H:%i:%s') AS UPDATED_AT\n" +
                "FROM EIKI_STORE_COMMENT ESC\n" +
                "         INNER JOIN EIKI_STORE ES ON ESC.STORE_DEC_IDX = ES.STORE_DEC_IDX\n" +
                "WHERE ESC.MEMBER_DEC_IDX = :MEMBER_DEC_IDX\n" +
                "ORDER BY ESC.UPDATED_AT DESC\n" +
                "LIMIT :LIMIT_VALUE\n" +
                "OFFSET :OFFSET_BY_PAGE;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);
        paramMap.addValue("LIMIT_VALUE", pageVO.getItemPerPage());
        paramMap.addValue("OFFSET_BY_PAGE", pageVO.getOffsetByPage());
        return namedJdbcTemplate.queryForList(SQL, paramMap);

    }

    @Override
    public int selectCommentCount(int memberIdx){

        String SQL = "SELECT COUNT(*) AS MEMBER_COMMENT_COUNT\n" +
                "FROM EIKI_STORE_COMMENT AS ESC\n" +
                "WHERE ESC.MEMBER_DEC_IDX = :MEMBER_DEC_IDX;";

        MapSqlParameterSource paramMap = new MapSqlParameterSource();
        paramMap.addValue("MEMBER_DEC_IDX", memberIdx);

        return namedJdbcTemplate.queryForObject(SQL, paramMap, Integer.class);

    }

}
