-- 시퀀스 1부터 1000까지
CREATE SEQUENCE ADMIN_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 100 CYCLE NOCACHE;
DROP SEQUENCE ADMIN_SEQ;

CREATE SEQUENCE BOOK_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 10000 CYCLE NOCACHE;
DROP SEQUENCE BOOK_SEQ;

CREATE SEQUENCE MEMBER_PICK_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 10000 CYCLE NOCACHE;
DROP SEQUENCE MEMBER_PICK_SEQ;

CREATE SEQUENCE MEMBER_CART_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 10000 CYCLE NOCACHE;
DROP SEQUENCE MEMBER_CART_SEQ;

CREATE SEQUENCE SALED_BOOK_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 10000 CYCLE NOCACHE;
DROP SEQUENCE SALED_BOOK_SEQ;

CREATE SEQUENCE REVIEW_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 100000 CYCLE NOCACHE;
DROP SEQUENCE REVIEW_SEQ;
--

SELECT * FROM SEQ;

-- 유저 테이블
CREATE TABLE TBL_MEMBER(
	M_ID			VARCHAR2(20)	PRIMARY KEY,
	M_PW			VARCHAR2(100)	NOT NULL,
	M_NAME			VARCHAR2(20)	NOT NULL,
	M_MAIL			VARCHAR2(50)	NOT NULL,
	M_PHONE			VARCHAR2(30)	NOT NULL,
	M_ADDR_CODE		VARCHAR2(100),
	M_ADDR			VARCHAR2(200),
	M_DETAIL_ADDR	VARCHAR2(200),
	M_GRADE			NUMBER(1)		DEFAULT 0,
	M_STATE			NUMBER(1)		DEFAULT 1,
	M_REG_DATE		TIMESTAMP,
	M_MOD_DATE		TIMESTAMP
);

SELECT * FROM TBL_MEMBER;
DROP TABLE TBL_MEMBER;
-- 

-- 관리자 테이블
CREATE TABLE TBL_ADMIN(
	A_NO		NUMBER(1)		PRIMARY KEY,
	A_ID		VARCHAR2(20)	NOT NULL,
	A_PW		VARCHAR2(100)	NOT NULL,
	A_GRADE		NUMBER(1)		DEFAULT 0,
	A_NAME		VARCHAR2(20)	NOT NULL,
	A_PHONE		VARCHAR2(30)	NOT NULL,
	A_REG_DATE	TIMESTAMP,
	A_MOD_DATE	TIMESTAMP
);
	-- 시퀀스 사용방법
INSERT INTO TBL_ADMIN(A_NO, A_ID, A_NAME, A_PW) VALUES(ADMIN_SEQ.NEXTVAL, 'ADMIN123', 'ADMIN123', '123');

SELECT * FROM TBL_ADMIN;
DROP TABLE TBL_ADMIN;
--

-- 책 테이블
CREATE TABLE TBL_BOOK(
	B_NO			NUMBER(4)		PRIMARY KEY,
	B_THUMBNAIL		VARCHAR2(1200)	NOT NULL,
	B_NAME			VARCHAR2(1400)	NOT NULL,
	B_AUTHOR		VARCHAR2(1200)	NOT NULL,
	B_INTRODUCE		VARCHAR2(4000)	NOT NULL,
	B_PUBLISHER		VARCHAR2(1200)	NOT NULL,
	B_PUBLISH_DATE	VARCHAR2(40)	NOT NULL,
	B_KDC			VARCHAR2(30)	NOT NULL,
	B_ISBN			VARCHAR2(14)	NOT NULL,
	B_PRICE			NUMBER(20)		NOT NULL,
	B_COUNT			NUMBER(4)		DEFAULT 0,
	B_REG_DATE		TIMESTAMP,
	B_MOD_DATE		TIMESTAMP
);

SELECT * FROM TBL_BOOK;
DROP TABLE TBL_BOOK;
--

-- 리뷰 테이블
CREATE TABLE TBL_REVIEW(
	R_NO		NUMBER(4)		PRIMARY KEY,
	M_ID		VARCHAR2(20),
	B_NO		NUMBER(4),
	R_TEXT		VARCHAR2(2400)	NOT NULL,
	R_STARS		NUMBER(4)		NOT NULL,
	R_REG_DATE	TIMESTAMP,
	R_MOD_DATE	TIMESTAMP
);

SELECT * FROM TBL_REVIEW;
DROP TABLE TBL_REVIEW;
--

-- 포인트 테이블
CREATE TABLE TBL_POINT(
	M_ID			VARCHAR2(20),
	P_BOOK_POINT	NUMBER(20)		DEFAULT 0,
	P_MOD_DATE		TIMESTAMP
);

SELECT * FROM TBL_POINT;
DROP TABLE TBL_POINT;
--

-- 포인트 리스트 테이블
CREATE TABLE TBL_POINT_LIST(
	M_ID					VARCHAR2(20),
	PL_LAST_BOOK_POINT		NUMBER(20)		NOT NULL,
	PL_PAYMENT_BOOK_POINT	NUMBER(20)		DEFAULT 0,
	PL_REG_DATE				TIMESTAMP	
);

SELECT * FROM TBL_POINT_LIST;
DROP TABLE TBL_POINT_LIST;
--

-- 찜 테이블
CREATE TABLE TBL_MEMBER_PICK(
	MP_NO		NUMBER(4)		PRIMARY KEY,
	M_ID		VARCHAR2(20),
	B_NO		NUMBER(4),
	MP_REG_DATE	TIMESTAMP
);
		-- 시퀀스 사용방법 --
INSERT INTO TBL_MEMBER_PICK(UP_NO, M_ID, B_NO) VALUES(MEMBER_PICK_SEQ.NEXTVAL, 1, 20);

SELECT * FROM TBL_MEMBER_PICK;
DROP TABLE TBL_MEMBER_PICK;
--

-- 장바구니 테이블
CREATE TABLE TBL_MEMBER_CART(
	C_NO		NUMBER(4),
	M_ID		VARCHAR2(20),
	B_NO		NUMBER(4),
	C_NUMBER	NUMBER(4),
	C_REG_DATE	TIMESTAMP,
	C_MOD_DATE	TIMESTAMP
);
		-- 시퀀스 사용방법 --
INSERT INTO TBL_MEMBER_CART(C_NO, M_ID, B_NO) VALUES(MEMBER_CART_SEQ.NEXTVAL, 1, 20);
INSERT INTO TBL_MEMBER_CART VALUES(12, 'gildong', 1200, 2, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO TBL_MEMBER_CART VALUES(24, 'gildong', 2000, 2, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO TBL_MEMBER_CART VALUES(36, 'gildong', 150, 2, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO TBL_MEMBER_CART VALUES(100, 'gildong', 4444, 1, SYSTIMESTAMP, SYSTIMESTAMP);

SELECT * FROM TBL_MEMBER_CART;
DROP TABLE TBL_MEMBER_CART;
--

-- 책 판매 테이블
CREATE TABLE TBL_SALED_BOOK(
	SB_NO			VARCHAR2(30)	PRIMARY KEY,
	B_NO			NUMBER(4),
	M_ID			VARCHAR2(20),
	SB_NUMBER		NUMBER(4)		NOT NULL,
	SB_NAME			VARCHAR2(20)	NOT NULL,
	SB_ADDR_CODE	VARCHAR2(100)	NOT NULL,
	SB_ADDR			VARCHAR2(200)	NOT NULL,
	SB_DETAIL_ADDR	VARCHAR2(200)	NOT NULL,
	SB_MEMO			VARCHAR2(100),
	SB_SALE_DATE	TIMESTAMP		NOT NULL,
	SB_ALL_PRICE	NUMBER(20)	NOT NULL,
	SB_COUPON		CHAR(1),
	SB_STATE		NUMBER(1)		DEFAULT 1	NOT NULL,
	SB_RETURN_DATE	TIMESTAMP,
	SB_REG_DATE		TIMESTAMP,
	SB_MOD_DATE		TIMESTAMP
);
		-- 시퀀스 사용방법 --
INSERT INTO TBL_SALED_BOOK(SB_NO, M_ID, B_NO) VALUES(SALED_BOOK_SEQ.NEXTVAL, 1, 20);

ALTER TABLE TBL_SALED_BOOK ADD(SB_RETURN_COUNT NUMBER(4) NOT NULL);

SELECT * FROM TBL_SALED_BOOK;
DROP TABLE TBL_SALED_BOOK;
--

