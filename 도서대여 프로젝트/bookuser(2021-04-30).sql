-- BOOKUSER
-- 2021-04-30


CREATE TABLE tbl_books (
    bk_isbn	    CHAR(13)        PRIMARY KEY,	
    bk_title	nVarCHAR2(125)	NOT NULL,
    bk_ccode	CHAR(5)	        NOT NULL,
    bk_acode	CHAR(5)	        NOT NULL,
    bk_date	    VarCHAR2(10),	
    bk_pages	NUMBER,	
    bk_price	NUMBER	
);


CREATE TABLE tbl_company (
    cp_code	    CHAR(5)		PRIMARY KEY,
    cp_title	nVarCHAR2(125)	NOT NULL,	
    cp_ceo	    nVarCHAR2(20),		
    cp_tel	    VarCHAR2(20),		
    cp_addr	    nVarCHAR2(125),		
    cp_genre	nVarCHAR2(30)		
);


CREATE TABLE tbl_author(
    au_code	    CHAR(5)		PRIMARY KEY,
    au_name	    nVarCHAR2(50)	NOT NULL,	
    au_tel	    VarCHAR2(20),		
    au_addr	    nVarCHAR2(125),		
    au_genre	nVarCHAR2(30)		
);


SELECT * FROM tbl_books;
SELECT * FROM tbl_company;
SELECT * FROM tbl_author;

SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;


DROP VIEW view_도서정보;


-- 3개의 테이블 조인
CREATE View view_도서정보 AS
(
    SELECT B.bk_isbn    AS ISBN,
            B.bk_title  AS 도서명,
            C.cp_title   AS 출판사명,  
            C.cp_ceo    AS 출판사대표,
            A.au_name   AS 저자명,
            A.au_tel    AS 저자연락처,
            B.bk_date   AS 출판일,
            B.bk_price  AS 가격,
            B.bk_pages  AS 페이지
        
    FROM tbl_books  B
        LEFT JOIN tbl_company C
            ON B.bk_ccode = c.cp_code
        LEFT JOIN tbl_author A
            ON B.bk_acode = A.au_code 
);

/*
 단독 테이블로 생성된 VIEW는 INSERT, UPDATEM, DELETRE는
    실행할 수 있다
 하지만 JOIN한 결과로 생성된 VIEW는 읽기전용이므로   
    INSERT, UPDATE, DELETE할 수 없다
*/


SELECT *
FROM VIEW_도서정보 ;


DELETE FROM tbl_books;
COMMIT;








