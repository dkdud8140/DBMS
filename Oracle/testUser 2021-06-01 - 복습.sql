-- testUser 접속

DROP TABLE tbl_books ;

CREATE TABLE tbl_books (
    bk_isbn CHAR(13) PRIMARY KEY,
    bk_pub  CHAR(5)         NOT NULL,
    bk_name nVarCHAR2(125)    NOT NULL,
    bk_writ CHAR(5)         NOT NULL,
    bk_date VarCHAR2(10)    NOT NULL,
    bk_page NUMBER          NOT NULL,
    bk_pric NUMBER          NOT NULL
);

CREATE TABLE tbl_company (
    cp_code CHAR(5) PRIMARY KEY,
    cp_name nVarCHAR2(125) NOT NULL,
    cp_ceo  nVarCHAR2(30)  NOT NULL,
    cp_tel  VarCHAR2(20)   NOT NULL,
    cp_addr nVarCHAR2(125) NOT NULL
);

CREATE TABLE tbl_author (
    au_code	CHAR(5) PRIMARY KEY,
    au_name	nVarCHAR2(125)	NOT NULL,	
    au_tel	VarCHAR2(20),		
    au_addr	nVarCHAR2(125)	
);

/* 임포트 된 데이터 확인*/
SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;


-- tbl_books 테이블에서 
-- 각 출판사별로 몇 권의 도서를 출판하였는지 조회
SELECT bk_pub, COUNT(*) 
FROM tbl_books
GROUP BY bk_pub;


SELECT B.bk_pub AS 코드, C.cp_name AS 출판사명, COUNT(*) AS 권수 
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_pub = C.cp_code        
GROUP BY bk_pub, cp_name
ORDER BY B.bk_pub;


--  tbl_books 테이블에서 도서가격이 2만원 이상인 도서들의 리스트
SELECT *
FROM tbl_books
WHERE bk_pric >= 20000;


-- 도서가격이 2만원 이상인 도서들의 전체 합계 금액
SELECT SUM(bk_pric) AS 도서값의합계
FROM tbl_books
WHERE bk_pric >= 20000;


-- tbl_books, tbl_company, tbl_author 세 개의 table Join하여
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자연락처로 출력
SELECT b.bk_isbn AS ISBN,
        b.bk_name AS 도서명,
        c.cp_name AS 출판사명,
        c.cp_ceo AS 출판사대표,
        a.au_name AS 저자,
        a.au_tel AS 저자연락처
FROM tbl_books b
    LEFT JOIN tbl_company c
        ON bk_pub = cp_code
    LEFT JOIN tbl_author a
        ON b.bk_writ = au_code
ORDER BY ISBN ;
    

-- tbl_books, tbl_company, tbl_author 세 개의 table Join하여
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자연락처, 출판일로 출력
-- 출판일이 2018년 데이터
SELECT b.bk_isbn AS ISBN,
        b.bk_name AS 도서명,
        c.cp_name AS 출판사명,
        c.cp_ceo AS 출판사대표,
        a.au_name AS 저자,
        a.au_tel AS 저자연락처,
        b.bk_date AS 출판일
FROM tbl_books b
    LEFT JOIN tbl_company c
        ON b.bk_pub = c.cp_name
    LEFT JOIN tbl_author a
        ON b.bk_writ = a.au_code
WHERE SUBSTR(bk_date,0,4) = '2018';

/*
    SUBSTR
*/

CREATE VIEW view_도서정보  AS ( 
SELECT b.bk_isbn AS ISBN,
        b.bk_name AS 도서명,
        c.cp_name AS 출판사명,
        c.cp_ceo AS 출판사대표,
        a.au_name AS 저자,
        a.au_tel AS 저자연락처,
        b.bk_date AS 출판일
FROM tbl_books b
    LEFT JOIN tbl_company c
        ON b.bk_pub = c.cp_name
    LEFT JOIN tbl_author a
        ON b.bk_writ = a.au_code
) ;

SELECT * FROM view_도서정보
WHERE SUBSTR(출판일,0,4) = '2018';



/*
    자주 사용할 것 같은 SELECT SQL은 view로 등록하면
    언제든지 사용이 가능하다
    
    그런데 자주 사용할 것 같지 않은 경우
    view 생성하면 아무래도 저장공간을 차지하게 된다
    
    이럴 때 한개의 SQL(SELECT)를 마치 가상의 table처럼
    FROM 절에 부착하여 사용할 수 있다
*/
SELECT * FROM (
SELECT b.bk_isbn AS ISBN,
        b.bk_name AS 도서명,
        c.cp_name AS 출판사명,
        c.cp_ceo AS 출판사대표,
        a.au_name AS 저자,
        a.au_tel AS 저자연락처,
        b.bk_date AS 출판일
FROM tbl_books b
    LEFT JOIN tbl_company c
        ON b.bk_pub = c.cp_name
    LEFT JOIN tbl_author a
        ON b.bk_writ = a.au_code
)
WHERE SUBSTR(출판일,0,4) = '2018';


-- tbl_books와 tbl_company, tbl_books와 tbl_author FK 설정
-- bk_pub,와 cp_code
-- bk_author와 au_code
ALTER TABLE tbl_books
ADD CONSTRAINT fk_comp
FOREIGN KEY(bk_pub)
REFERENCES tbl_company(cp_code);

ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY(bk_writ)
REFERENCES tbl_author(au_code);


/*
    Primary Key
    개체무결성을 보장하기 위한 조건
    내가 어떤 데이터를 수정, 삭제 할 때
    수정하거나 삭제해서는 안되는 데이터는 유지하면서
    반드시 수정하거나 삭제하는 데이터는 수정, 삭제된다
    수정이상, 삭제이상을 방지하는 방법
    중복된 데이터는 절대 추가될 수 없다 : 삽입이상 방지
    
    Foreign Key
    두 개 이상의 table을 연결하여 view(조회)를 할 때
    어떤 데이터가 NULL 값으로 보이는 것을 방지하기 위한 조치
    Child(tbl_books) : bk_pub           Parent(tbl_company): cp_code
    있을 수 있고, 추가 가능        <<              있음
    있어서는 안되고, 추가불가능     <<             없음
    있는 코드                      >>             코드 삭제불가능
    있는 코드                      >>             반드시 있어야 한다
    
*/



-- 리쳐드 쇼튼의 연락처가 010-7270-5520에서
-- 010-9999-5520로 변경이 되었다
-- 리쳐드 쇼튼의 연락처를 변경해보기
UPDATE tbl_author
SET au_tel = '010-9999-5520'
-- WHERE au_name ='리처드 쇼튼'
-- WHERE au_tel = '010-7270-5520';
WHERE au_code = ? ;

-- 정보를 수정, 삭제하는 절차
-- 내가 수정, 삭제하고자 하는 데이터가 어떤 상태인지 조회
SELECT au_code 
FROM tbl_author
WHERE au_name = '리처드 쇼튼';

-- 수정하고자 하는 리처드 쇼튼의 PK를 확인
-- 수정, 삭제하고자 할 떄는 먼저 대상 데이터의 PK를 확인하고
-- PK를 WHERE 절에 포함하여  UPDATE, DELETE를 수행하자
UPDATE tbl_author
SET au_tel = '010-9999-5520'
WHERE au_code = 'A0006';

-- 실무에서 UPDATE, DELETE를 2개 이상 레코드에
-- 동시에 적용하는 것은 매우 위험한 코드이다
-- 꼭 필요한 경우가 아니면
-- UPDATE, DELETE는 PK를 기준으로 한 개 씩 수행하도록 해야한다 

ROLLBACK;


