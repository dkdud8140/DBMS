-- gbUser 접속

SHOW databases;

DROP TABLE tbl_guest_book;

CREATE DATABASE GuestBook;
USE GuestBook;
CREATE TABLE tbl_guest_book(
	gb_seq	 BIGINT	auto_INCREMENT	PRIMARY KEY,
	gb_date	VARCHAR(10)	NOT NULL	,
	gb_time	VARCHAR(10)	NOT NULL	,
	gb_writer	VARCHAR(10)	NOT NULL,	
	gb_email	VARCHAR(30)	NOT NULL,	
	gb_password	VARCHAR(30)	NOT NULL,	
	gb_content	VARCHAR(2000)	NOT NULL	
);

INSERT INTO tbl_guest_book
(gb_date, gb_time, gb_writer,gb_email, gb_password,gb_content)
VALUES
('2021-05-18', '10:06:00','접니다','aaa@aaa.com','1234','졸려');

SELECT * FROM tbl_guest_book;
SELECT COUNT(*) FROM tbl_guest_book;
SELECT * FROM tbl_guest_book
where gb_date = '2021-05-18';

SELECT * FROM tbl_guest_book
ORDER BY gb_seq DESC;

-- 날짜와 시간을 기준으로 최근 글이 제일 먼저 보이도록
SELECT * FROM tbl_guest_book
ORDER BY gb_date DESC, gb_time DESC;

-- UPDATE,DELETE를 수행할 때는
-- 2개 이상의 레코드에 영향을 미치는 명령은
-- 매우 신중하게 실행해야한다.
-- 가장 좋은 방법은 변경,삭제하고자 하는 데이터가 여랙 있더라도,
-- 가급적 PK를 기준으로 1개씩 처리하는 것이 좋다,
UPDATE tbl_guest_book
SET gb_time = '10:36:00'
WHERE gb_seq = 3 ;

DELETE FROM tbl_guest_book
WHERE gb_seq = 1 ;

SELECT * FROM tbl_guest_book;
ROLLBACK;

SELECT 20*40;

-- MYSQL의 고유함수로 문자열을 연결할 때
SELECT CONCAT('대한','민국','만세');

SELECT * FROM tbl_guest_book
WHERE gb_content LIKE '%졸%';


SELECT * FROM tbl_guest_book
WHERE gb_content LIKE CONCAT('%','졸','%');

-- Oracle 의 DECODE()와 유사한 형태의 조건연산
-- gb_seq의 값이 짝수이면 짝수로 표시
-- 어니면 홀수로 표시
SELECT IF( MOD(gb_seq,2) =0,'짝수','홀수')
FROM tbl_guest_book;

SELECT FLOOR(RAND()*100);


SELECT COUNT(*) FROM tbl_guest_book ;

SELECT * FROM tbl_guest_book
WHERE gb_writer = '지눌';

SELECT * FROM tbl_guest_book
ORDER BY gb_date DESC, gb_time DESC;

SELECT * FROM tbl_guest_book
WHERE gb_content
LIKE '%국가%'
ORDER BY gb_date DESC, gb_time DESC;

CREATE VIEW view_방명록 AS (
SELECT gb_seq '일련번호',
	gb_date '등록일자',
    gb_time '등록시간',
    gb_writer '등록자이름',
    gb_email '이메일',
    gb_password '비밀번호',
    gb_content '내용'
FROM tbl_guest_book
);

SELECT * FROM view_방명록;