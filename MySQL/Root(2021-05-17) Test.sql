
-- 현재 존재하는 database를 보여주라
show databases;
-- 지금부터 MYSQL Database를 사용하겠다.
-- 사용자와 연관 없이 기본적으로 사용할 데이터 베이스를 지정하여 사용할 준비 
USE MYSQL;

-- 현재 접속한 데이터베이스(MYSQL)에 있는 모든 테이블을 보여달라
show tables;

-- myDB라는 database(데이터 저장소) 생성
CREATE database myDB;

-- 생성된 저장소 확인하기
show databases;

-- MySQL에서는 제일 먼저 사용할 DB를 오픈하기
-- USE 명령을 사용하여 DB오픈 
USE MyDB;

-- 현재 DB(MyDB)에 있는 모든 테이블을 보여달라
show tables;

-- MySQL에서는 일련번호와 관련된 칼럼에 
-- auto_increment 옵션을 설정하면 값을 insert 할 때
-- 값을 지정하지 않아도 자동으로 ID, SEQ 값을 생성하여 칼럼에 추가하여 준다.
CREATE TABLE tbl_test (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    tel VARCHAR(20),
    addr VARCHAR(125)
);



DESC tbl_test;

INSERT INTO tbl_test(name, tel, addr)
values('홍길동','010-9999-0000','서울시');

select * from tbl_test;

-- MYSQL은 Linux 철학을 유지 하고 있기 때문에
-- 명령이 정상 수행되면 아무런 메시지도 보이지 않는다
create table tbl_books (
bk_isbn	CHAR(5)			PRIMARY KEY,
bk_pub	VarCHAR(10)	NOT NULL	,
bk_name	VarCHAR(30)	NOT NULL	,
bk_writ	VarCHAR(20)	NOT NULL	,
bk_tran	VarCHAR(5)		,
bk_date	CHAR(10)	NOT NULL	,
bk_page	INT	NOT NULL	,
bk_pric	INT	NOT NULL	
);

show tables;
desc tbl_books;
drop table tbl_books;
select * from tbl_books;

select COUNT(*) from tbl_books;

-- 도서가격이 25000원 이상인 데이터
select * from tbl_books
where bk_price >= 25000 ;

select * from tbl_books
where bk_price between 20000 AND 25000 ;


-- JAVA 등 코딩에서 중간 문자열 검색
-- oracle : '%'||'왕'||'%'
-- MYSQL : like concat('%','왕','%')
select * from tbl_books
where bk_title
like concat('%','왕','%');

-- 날짜 칼럼의 앞에 4글자만 보여라
select left(bk_date,4)
from tbl_books;

select *
from tbl_books
where left(bk_date,4) = '2018';


-- 도서명을 역순으로 정렬하여 보여라
select * from tbl_books
order by bk_title DESC ;

-- 처음 3개의 데이터만 보여라
select * from tbl_books
LIMIT 3;

-- 4번째(0부터 시작하여 3번째) 데이터부터 2개 보이기
-- 게시판 등 코딩에서 pagination을 구현할 때 사용하는 방법
select * from tbl_books
LIMIT 3,2;

CREATE database BookRent;
use BookRent;

create table tbl_books (
	bk_isbn		CHAR(13)		PRIMARY KEY,
	bk_title	VarCHAR(125)	NOT NULL	,
	bk_ccode	CHAR(5)			NOT NULL	,
	bk_acode	CHAR(5)			NOT NULL	,
	bk_date		VarCHAR(10)		,
	bk_pages	INT		,
	bk_price	INT		
);

create table tbl_company (
	cp_code		CHAR(5)		PRIMARY KEY,
	cp_title	VarCHAR(125)	NOT NULL,	
	cp_ceo		VarCHAR(20)		,
	cp_tel		VarCHAR(20)		,
	cp_addr		VarCHAR(125)	,	
	cp_genre	VarCHAR(30)		
);

create table tbl_author (
	au_code	CHAR(5)		PRIMARY KEY,
	au_name	VarCHAR(20)	NOT NULL	,
	au_tel	VarCHAR(20)		,
	au_addr	VarCHAR(125)	,	
	au_genre	VarCHAR(30)		
);

create table tbl_buyer (
	bu_code		CHAR(5)		PRIMARY KEY,
	bu_name		VarCHAR(50)	NOT NULL	,
	bu_birth	INT	NOT NULL	,
	bu_tel		VarCHAR(20)		,
	bu_addr		VarCHAR(125)		
);

create table tbl_book_rent (
	br_seq		BIGINT			PRIMARY KEY AUTO_INCREMENT,
	br_sdate	VarCHAR(10)		NOT NULL,	
	br_isbn		CHAR(13)		NOT NULL,
	br_bcode	CHAR(5)			NOT NULL,
	br_edate	VarCHAR(10)	,
	br_price	INT		
);

select * from tbl_books;





















