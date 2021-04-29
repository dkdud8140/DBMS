CREATE TABLE tbl_books (
    bk_isbn	    CHAR(13)		PRIMARY KEY,
    bk_ccode	CHAR(5)	        NOT NULL,
    bk_title	nVarCHAR2(125)	NOT NULL,
    bk_acode	CHAR(5)	        NOT NULL,
    bk_date	    CHAR(10),
    bk_pages	NUMBER,
    bk_price	NUMBER		
);


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



SELECT TB.bk_isbn ISBN,
        TB.bk_title 도서명,
        TC.cp_title 출판사명,
        TC.cp_ceo 출판사대표,
        TA.au_name 저자명,
        TA.au_tel 저자연락처,
        TB.bk_date 출판일,
        TB.bk_price 가격

FROM tbl_books TB
    LEFT JOIN tbl_company TC
        ON TB.bk_ccode = TC.cp_code
    LEFT JOIN tbl_author TA
        ON TB.bk_acode = TA.au_code ;










