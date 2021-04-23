-- 2021.04.23. scuser
-- 점수 테이블 생성
-- 학번, 국어, 영어, 수학 항목을 저장할 목록

CREATE TABLE tbl_score (
    
    st_num CHAR(5),
    st_kor NUMBER,
    st_eng NUMBER,
    st_math NUMBER

);

INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00001', 50, 60, 70) ;
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00003', 60, 80, 90) ;
INSERT INTO tbl_score(st_num, st_kor, st_eng)
VALUES ('00002', 77, 88) ;
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00001', 40, 20, 30) ;

SELECT * FROM tbl_score ;

DROP TABLE tbl_score 
CASCADE CONSTRAINTS;


CREATE TABLE tbl_score (
    
    st_num CHAR(5) PRIMARY KEY,
    st_kor NUMBER NOT NULL,
    st_eng NUMBER NOT NULL,
    st_math NUMBER NOT NULL

);


-- 수업

-- 고정문자열 : CHAR(최대크기)
-- 가변문자열 : VarCHAR2(최대크기)
-- 한글가변문자열 : nVarCHAR2(최대크기)
-- 숫자 : NUMBER
CREATE TABLE tbl_score (
    
    sc_num CHAR(5),
    sc_kor NUMBER,
    sc_eng NUMBER,
    sc_math NUMBER

);

-- CREATE로 작성한 칼럼의 순서대로 모든 데이터를 포함하여
-- INSERT 수행하기
-- 항상 CRERTE로 작성한 칼럼의 순서를 기억해야 하고
--      순서가 바뀌면 전혀 엉뚱한 데이터가 INSERT 될 수 있다.
-- 모든 카럼에 데이터를 포함해야한다.

INSERT INTO tbl_score
VALUES ('00001', 50, 60, 70) ;

-- INSERT를 수행할 때 데이터의 칼럼을 나열하면
-- 순서를 몰라도 상관없고 필요한 칼럼만 데이터를 포함하여 수행할 수 있다.
INSERT INTO tbl_score(sc_num, sc_kor, sc_eng, sc_math)
VALUES ('00002', 50, 60, 70) ;


SELECT * FROM tbl_score ;

DROP TABLE tbl_score 
CASCADE CONSTRAINTS;


-- 위;에서 실행한 tbl_score는 중복된 학번의 점수가 INSERT 될 수 있다.
-- 한 학생의 점수가 2중 3중으로 INSERT되어 엉뚱한 점수가
-- 나타날 수 있다.

-- 제약조건 부여
-- 1. 학번은 중복될 수 없고 절대 NULL이어서는 안된다 : 
--      NOT NULL UNIQUE : PRIMARY KEY로 선언하는 것도 좋은 방법
-- 2. 점수가 없는 학생의 데이터는 이후에 연산을 수행할 때 문제를 일으킬 수 있기 떄문에
--      NULL값이 없도록 하자 


CREATE TABLE tbl_score (
    
    sc_num CHAR(5),
    sc_kor NUMBER NOT NULL,
    sc_eng NUMBER NOT NULL,
    sc_math NUMBER NOT NULL,
    
    PRIMARY KEY(sc_num)

);


CREATE TABLE tbl_score (
    sc_num	CHAR(5)		PRIMARY KEY,
    sc_kor	NUMBER	NOT NULL,	
    sc_eng	NUMBER	NOT NULL,	
    sc_matn	NUMBER	NOT NULL	

);


SELECT * FROM tbl_score ;

-- 국어점수가 90점 이상인 리스트
SELECT * FROM tbl_score
WHERE sc_kor > 90 ;

-- 데이터를 보여줄 때 머릿글(칼럼제목)을 바꾸어서 보이기
-- AS(Alias, 별명) 
SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어, sc_matn AS 수학,
        sc_kor + sc_eng + sc_matn AS 총점
FROM tbl_score ;    
    
-- 총점이 250 이상인 학생만 보여라
SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어, sc_matn AS 수학,
        sc_kor + sc_eng + sc_matn AS 총점
FROM tbl_score 
WHERE (sc_kor + sc_eng + sc_math) >=250 ;


-- 총점이 150 이상이고 250이하인 학생만 보여라
SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어, sc_matn AS 수학,
        sc_kor + sc_eng + sc_matn AS 총점
FROM tbl_score 
WHERE (sc_kor + sc_eng + sc_matn) <=250  AND (sc_kor + sc_eng + sc_matn) >=150 ;


--SELECT를 사용하여 조회하는데
-- 자꾸 문법이 복잡해진다
-- 계산하는 칼럼도 있고
-- SELECT 된 명령문을 VIEW 객체로 생성을 해둔다
-- VIEW는 사용법이 TABLE과 같다
--      단, VIEW는 보는것만 가능
CREATE VIEW view_score
AS
(
    SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어, sc_matn AS 수학,
            sc_kor + sc_eng + sc_matn AS 총점
    FROM tbl_score 
) ; 


SELECT * FROM view_score
WHERE 총점 >= 150 AND 총점 <= 250 ;


-- 영어선생님에게 전체 학생의 정보를 보여줘야한다
-- 그런데 다른 과목의 점수는 감추고 싶다

-- 보안적인 측면에서 사용자 별로
-- 보여줄 항목,ㅡ 보이지 않는 항목을 선별하여 
-- VIEW를 작성해두면
-- 불필요한 정보가 노출되는 것을 최소화 할 수 있다.
CREATE VIEW view_영어점수
AS
(  
    SELECT sc_num AS 학번, sc_eng AS 영어
    FROM tbl_score
    WHERE 학번>= 'S0030'
) ;


SELECT sc_num AS 학번, sc_eng AS 영어
FROM tbl_score ;


DROP VIEW view_view_1반학생;

CREATE VIEW view_1반학생
AS
(  
    SELECT sc_num AS 학번, sc_eng AS 영어, sc_kor AS 국어, sc_matn AS 수학
    FROM tbl_score
    WHERE 학번>= 'S0010' AND 학번 <= 'S0020'
) ;

SELECT
    *
FROM view
