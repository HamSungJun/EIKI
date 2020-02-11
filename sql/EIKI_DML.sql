-- /eiki/home 스토어 목록 리스트 쿼리
SELECT *
FROM (
         SELECT ES.STORE_DEC_IDX               AS STORE_IDX,
                ES.STORE_NAME                  AS STORE_NAME,
                ES.STORE_TYPE                  AS STORE_TYPE,
                ES.IS_DELIVERY                 AS IS_DELIVERY,
                ESI.STORE_IMAGE                AS STORE_THUMBNAIL,
                AVG(IFNULL(ESP.PREFERENCE, 0)) AS AVG_PREFERENCE
         FROM EIKI_STORE AS ES
                  INNER JOIN EIKI_STORE_IMAGE AS ESI ON ES.STORE_DEC_IDX = ESI.STORE_DEC_IDX
                  LEFT OUTER JOIN EIKI_STORE_PREFERENCE AS ESP ON ES.STORE_DEC_IDX = ESP.STORE_DEC_IDX
         WHERE ESI.STORE_IMAGE_TYPE = "THUMBNAIL"
           AND ES.STORE_NAME LIKE "%%"
         GROUP BY ES.STORE_DEC_IDX,
                  ESI.STORE_IMAGE
     ) AS T;
