CREATE DATABASE IF NOT EXISTS EIKI;
USE EIKI;

CREATE TABLE IF NOT EXISTS EIKI_MEMBER (
	MEMBER_DEC_IDX INTEGER NOT NULL AUTO_INCREMENT,
    MEMBER_ID VARCHAR(256) NOT NULL UNIQUE,
    MEMBER_PW VARCHAR(128) NOT NULL,
    MEMBER_NICKNAME VARCHAR(16) NOT NULL UNIQUE,
    MEMBER_BIRTHDAY DATE NOT NULL,
    MEMBER_PHONE VARCHAR(13) NOT NULL UNIQUE,
    MEMBER_PROFILE_IMAGE VARCHAR(128) NOT NULL UNIQUE,
	PRIMARY KEY(MEMBER_DEC_IDX)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS EIKI_MAIL_AUTH (
	MAIL_DEC_IDX INTEGER NOT NULL AUTO_INCREMENT,
    MEMBER_ID VARCHAR(256) NOT NULL,
    AUTH_NUM VARCHAR(4) NOT NULL,
    AUTH_REQUESTED_TIME TIMESTAMP NOT NULL DEFAULT NOW(),
    IS_AUTHORIZED BOOLEAN NOT NULL DEFAULT false,
    PRIMARY KEY(MAIL_DEC_IDX)
) ENGINE = InnoDB;


DROP TABLE EIKI_MEMBER;
DROP TABLE EIKI_MAIL_AUTH;
SELECT * FROM EIKI_MEMBER;
SELECT * FROM EIKI_MAIL_AUTH;
DELETE FROM EIKI_MAIL_AUTH;

commit;

INSERT INTO EIKI_MEMBER(MEMBER_ID, MEMBER_PW, MEMBER_NICKNAME, MEMBER_BIRTHDAY, MEMBER_PHONE) 
VALUES("abc123d@hanyang.ac.kr","","구글링링구글링링구글링링구글링링",'1994.11.19',"010-3425-1209");