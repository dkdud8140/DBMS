-- 2021-04-29
-- BOOKUSER

CREATE TABLE tbl_books (
    bk_isbn	    CHAR(13)		PRIMARY KEY,
    bk_ccode	CHAR(5)	        NOT NULL,
    bk_title	nVarCHAR2(125)	NOT NULL,
    bk_acode	CHAR(5)	        NOT NULL,
    bk_date	    VarCHAR2(10),
    bk_pages	NUMBER,
    bk_price	NUMBER		
);

DROP TABLE tbl_books ;


INSERT INTO tbl_books
(bk_isbn,bk_ccode, bk_title,bk_acode, bk_date, bk_pages, bk_price)
VALUES(0000000000000, 00000, '테스트용', 00000, '0000-00-00',100, 100);

SELECT * 
FROM tbl_books;


CREATE TABLE tbl_company(
    cp_code	    CHAR(5)		    PRIMARY KEY,
    cp_title	nVarCHAR2(125)	NOT NULL,
    cp_ceo	    nVarCHAR2(20)	NOT NULL,
    cp_tel	    VarCHAR2(20),
    cp_addr	    nVarCHAR2(125),
    cp_genre	nVarCHAR2(30)		
);

INSERT INTO tbl_company
(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
VALUES(00000, '유령회사', '팬텀', '000-0000-000', '서울시 어쩌고','호러');


SELECT *
FROM tbl_company;


CREATE TABLE tbl_author(
    au_code	    CHAR(5)		    PRIMARY KEY,
    au_name	    nVarCHAR2(20)	NOT NULL,
    au_tel	    VarCHAR2(20),
    au_addr	    nVarCHAR2(125),
    au_genre	nVarCHAR2(30)		
);


INSERT INTO tbl_author
(au_code, au_name, au_tel, au_addr, au_genre)
VALUES(00000, '김유령', '000-0000-0000', '광주시 어쩌고', '호러');


SELECT *
FROM tbl_author;


DELETE FROM tbl_company;
DELETE FROM tbl_books;
DELETE FROM tbl_author;

SELECT * FROM tbl_books;
SELECT * FROM tbl_company;
SELECT * FROM tbl_author;


SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;




-- 3개의 테이블을 조인하여 뷰 만들기

CREATE VIEW view_도서정보 AS
(
    SELECT TB.bk_isbn   AS ISBN,
            TB.bk_title AS 도서명,
            TC.cp_title AS 출판사명,
            TC.cp_ceo   AS 출판사대표,
            TA.au_name  AS 저자명,
            TA.au_tel   AS 저자연락처,
            TB.bk_date  AS 출판일,
            TB.bk_price AS 가격
    
    FROM tbl_books TB
        LEFT JOIN tbl_company TC
            ON TB.bk_ccode = TC.cp_code
        LEFT JOIN tbl_author TA
            ON TB.bk_acode = TA.au_code 
);


SELECT * FROM tbl_books;

/*
고정문자열 type의 칼럼 주의사항
CHAR() Type의 문자열 칼럼은 실제 저장되는 데이터 type에 따라
주의를 해야한다.

만약 데이터가 숫자값으로만 되어 있는 경우 
1. 0001, 00002 와 같이 입력할 경우 0을 삭제해버리는 경우가 있다.
2. ( 엑셀에서 임포트하는) 실제 데이터가  날짜 타입일 경우
    SQL의 낭ㅉ@ㅏ형 데이터로 변환한 후 다시 문자열로 변환하여 저장

칼럼을 PK로 설정하지 않는 경우는 가급적 CHAR로 설정하지 말고
VarCHAR2로 설정하는 것이 좋다

고정문자열 칼럼으로 조회를 할 때 아래와 같은 조건을 부여하면
데이터가 조회되지 않는 현상이 발생할 수 있다.
WHERE 코드 ='00001' 

*/



SELECT * FROM VIEW_도서정보;

-- 조건을 부여하여 찾기
-- PK 칼럼으로 데이터 조회
SELECT * FROM VIEW_도서정보
WHERE isbn = '9791162540695' ;


-- 도서명이 '왕이' 문자열로 시작되는 모든(List) 데이터
SELECT * FROM VIEW_도서정보
WHERE 도서명 LIKE '왕이%' ;


-- 출판사명에 '북스'문자열이 포함된 모든 데이터
SELECT * FROM VIEW_도서정보
WHERE 출판사명 LIKE '%북스%' ;

-- 출판일이 2018인 모든 데이터
SELECT * FROM VIEW_도서정보
WHERE 출판일 > '2018-01-01' AND 출판일 <='2018-12-31' ;
-- ==
SELECT * FROM VIEW_도서정보
WHERE 출판일 BETWEEN '2018-01-01' AND '2018-12-31' ;

-- SUBSTR() 함수를 사용한 문자열 자르기
-- SUBSTR(문자열테이터, 시작위치, 개수)
-- 기타 DB에서는 LEFT(문자열, 몇글자)함수를 사용
--              RIGHT(문자열,몇글자) 오른쪽에서 몇글자
SELECT * FROM VIEW_도서정보
WHERE SUBSTR(출판일,0,4) = '2018';


-- 출판일 칼럼의 데이터를 앞에서 4글자만 잘라서 보여라
SELECT  SUBSTR(출판일,0,4) AS 출판년도 FROM VIEW_도서정보;
-- 출판일 칼럼의 데이터를 오른쪽으로 부터 4글자만 잘라서 보여라
SELECT  SUBSTR(출판일,-5) AS 출판월일 FROM VIEW_도서정보;