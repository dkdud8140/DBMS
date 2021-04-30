-- 2021-04-30
-- bookuser

-- books Table과 author, company Table은 Relatuion 관계가 있다
--      books의 bk_ccode와 company의 cp_code
--      books의 bk_acode와 author의 au_code
-- 연관관계에 있는 Table을 EQ JOIN을 실행할 떄
-- 만약 author나 company Table에 없는 데이터(코드)가
-- books에 있다면 EQ JOIN을 하면 데이터가 누락되어 버린다,
-- 또한 LEFT JOIN을 하면 값이 null로 출력된다
-- JOIN 데이터가 누락되거나 (null) 출력되는 것은
-- 데이터에 문제가 발생한 것이다.
-- "참조무결성"이 무너졌다.


SELECT *
FROM VIEW_도서정보 ;


-- EQ JOIN
SELECT *
FROM tbl_books, tbl_author, tbl_company
    WHERE bk_ccode = cp_code AND bk_acode = au_code ;
    
/*
    다수의 테이블이 연관(Relation) 관계에 있을 때
    JOIN 결과가 잘못되면 DB 신뢰성에 매우 큰 문제가 발생한다.
    Relation 설정이 된 table 간에 참조무결성을 보장하기 위한 제약조건을 설정할 수 이싿
    이 제약조건을 "FOREIGN KEY"(외래키) 설정이라고 한다.
        == 참조무결성을 유지하기 위한 설정
*/

-- tbl_books와 tbl_company를 참조무결성 설정
-- tbl_company의 PK를 참조하여 tbl_books 데이터에
-- 출판사 정보를 연동
-- tbl_company를 parent라고 하며 REFERENCES Table이라고 한다.
-- FK 를 설정하는 대상은 child table인 tbl_books가 된다
ALTER TABLE tbl_books           -- FK를 설정할 테이블
ADD CONSTRAINT fk_company       -- FK 이름 설정
FOREIGN KEY(bk_ccode)           -- FK를 설정할 칼럼, child의 칼럼
REFERENCES tbl_company(cp_code);-- 누구하고, parent table(칼럼)

ALTER TABLE tbl_books           -- FK를 설정할 테이블
ADD CONSTRAINT fk_author       -- FK 이름 설정
FOREIGN KEY(bk_acode)           -- FK를 설정할 칼럼, child의 칼럼
REFERENCES tbl_author(au_code);-- 누구하고, parent table(칼럼)

-- 만약 tbl_books table의 bk_acode 칼럼에 저장된
-- 데이터를 author에서 삭제하려고 하면
-- 오류가 발생하고 데이터가 삭제되지 않는다.
DELETE FROM tbl_author
WHERE au_code = 'A0001';
--삭제된 코드 : A0003


INSERT INTO tbl_books(bk_isbn, bk_acode, bk_ccode, bk_title)
VALUES ('970001','A0003','C0001', '테스트') ;


/*
===============================================================
    tbl_books.bk_acode          tbl_author.au_code
---------------------------------------------------------------
    코드 O                >>     반드시 있어야 한다            
    있을 수 있음          <<     코드 O
    절대 있을 수 없다     <<     코드가 없으면
    코드가 있으면         >>      삭제 불가
    코드가 있으면         >>      변경 불가
*/


-- FK 삭제
ALTER TABLE tbl_books
DROP CONSTRAINT fk_author;


DELETE FROM tbl_author
WHERE au_code = 'A0001';

-- 데이터가 입력된 테이블간에 FK가 설정하려고 할 경우
-- 먼저 모든 데이터가 참조무결성에 유효한지 검사하고
-- 데이터에 문제가 있을 경우 문제를 해결 한 후
-- FK 설정이 가능하다.
-- parent 테이블에 데이터를 추가하거나
-- child 데이터를 삭제하는 방법이 있다.
ALTER TABLE tbl_books           
ADD CONSTRAINT fk_author       
FOREIGN KEY(bk_acode)          
REFERENCES tbl_author(au_code);


INSERT INTO tbl_author(au_code, au_name)
VALUE('A0001', '삭제된 저자');



-- FK가 설정된 상태에서
-- parent 테이블의 데이터가 잘못입력된 것이 발견되어 데이터를 삭제하고자 한다
-- 하지만 이미 사용된(books에 등록된) 데이터는 삭제가 불가능
-- 그러한 제약사항을 조금 약하게 하는 방법이 있다.
-- parent 데이터를 삭제하면 연관된 테이블의 모든 데이터를 같이 삭제하거나
-- 코드가 변경되면 연관 데이터의 코드 값을 변경하거나

ALTER TABLE tbl_books           
ADD CONSTRAINT fk_author       
FOREIGN KEY(bk_acode)          
REFERENCES tbl_author(au_code)
ON DELETE CASCADE ;