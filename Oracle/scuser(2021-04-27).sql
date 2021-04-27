-- 2021.04.27
-- scuser
-- 학과 정보를 저장할 테이블 작성

CREATE TABLE tbl_dept (
    dp_code	CHAR(3)		PRIMARY KEY,
    dp_name	nVarCHAR2(20)	NOT NULL,	
    dp_prof	nVarCHAR2(20)	NOT NULL
    );
    
DROP TABLE tbl_dept
CASCADE CONSTRAINTS ;
    
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('001', '컴퓨터공학', '토발즈');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('002', '전자공학', '이철기');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('003', '법학', '킹스필드');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('004', '관광학', '이한우');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('005', '국어국문', '백석기');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('006', '영어영문', '권오순');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('007', '무역학', '심하군');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('008', '미술학', '필리스');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('009', '고전음악학', '파파로티');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('010', '정보통신공학', '최양록');

-- 지금 수행한 INSERT 명령으로 추가된 데이터를
-- 실제 Storage에 반영하라
COMMIT ;


SELECT * FROM tbl_dept ;

SELECT
    dp_code 학과코드,
    dp_name 학과이름,
    dp_prof 담당교수
FROM tbl_dept ;


-- 여러개의 데이터를 동시에 INSERT하기
-- 다른 테이블로부터 데이터를 복사할 때 사용하는 방식
INSERT ALL
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('001', '컴퓨터공학', '토발즈')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('002', '전자공학', '이철기')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('003', '법학', '킹스필드')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('004', '관광학', '이한우')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('005', '국어국문', '백석기')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('006', '영어영문', '권오순')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('007', '무역학', '심하군')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('008', '미술학', '필리스')
INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES ('009', '고전음악학', '파파로티')

SELECT * FROM DUAL ;


DELETE FROM tbl_dept ;








DROP TABLE tbl_student 
CASCADE CONSTRAINTS;


CREATE TABLE tbl_student (
    st_num	CHAR(5)		PRIMARY KEY,
    st_name	nVarCHAR2(20)	NOT NULL,	
    st_dcode	CHAR(3)	NOT NULL	,
    st_grade	CHAR(1)	NOT NULL	,
    st_tel	VarCHAR(20)	NOT NULL	,
    st_addr	nVarCHAR2(125)	NOT NULL
);


SELECT *
FROM tbl_student ;

SELECT COUNT(*)
FROM tbl_student ;


-- 학생테이블과 학과테이블을
-- 학생의 st_dcode 칼럼과 학과의 dp_code 칼럼을 연관지어
-- 조인을 실행하라
-- 학생테이블의 모든 데이터를 나열하고
-- 학과테이블에서 일치하는 데이터를 가져와서 연관하여 보여라


SELECT ST.st_num 학번,
        ST.st_name 학생이름,
        ST.st_dcode 학과코드,
        DP.dp_name 학과명,
        DP.dp_prof 담당교수,
        ST.st_grade 학년,
        ST.st_tel 전화번호,
        ST.st_addr 주소
        
FROM tbl_student ST
    LEFT JOIN tbl_dept DP
        ON ST.st_dcode = DP.dp_code 
ORDER BY ST.st_num ;




CREATE VIEW view_학생정보 AS
(
SELECT ST.st_num 학번,
        ST.st_name 학생이름,
        ST.st_dcode 학과코드,
        DP.dp_name 학과명,
        DP.dp_prof 담당교수,
        ST.st_grade 학년,
        ST.st_tel 전화번호,
        ST.st_addr 주소
        
FROM tbl_student ST
    LEFT JOIN tbl_dept DP
        ON ST.st_dcode = DP.dp_code 
);


SELECT * FROM VIEW_학생정보
ORDER BY 학번 ;



-- 학생정보 테이블에서 학과별로 몇 명의 학생이
-- 재학중인지 알아보자
-- 학과코드 = 학과명은 항상 같은 값이 되므로
-- 학과코드, 학과명으로 GROUP BY를 하면
-- 학과별로 묶음이 이루어진다
-- 학과별로 묶음ㅇ르 만들고 묶은 학과에 포함된 레코드가 몇개인가
-- 세어보면 학과별 학생 인원수가 조회된다.
SELECT 학과코드, 학과명,
COUNT(*) 인원수
FROM view_학생정보
GROUP BY 학과코드, 학과명
ORDER BY 학과코드;



SELECT *
FROM tbl_score ;


SELECT SC.sc_num 학번, ST.st_name 이름, ST.st_dcode 학과코드, 
        DP.dp_name 학과명, DP.dp_prof 담당교수, 
        ST.st_tel 전화번호,
        Sc.sc_kor 국어점수, Sc.sc_eng 영어점수, Sc.sc_math 수학점수,
        ( Sc.sc_kor + Sc.sc_eng + Sc.sc_math) 총점 ,  
        ROUND(( Sc.sc_kor + Sc.sc_eng + Sc.sc_math)/3,0) 평균
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num 
    LEFT JOIN tbl_dept DP
        ON SC.sc_num = DP.dp_code
ORDER BY SC.sc_num;


CREATE VIEW view_성적일람표 AS 
(
SELECT SC.sc_num 학번, ST.st_name 이름, ST.st_dcode 학과코드, 
        DP.dp_name 학과명, DP.dp_prof 담당교수, 
        ST.st_tel 전화번호,
        Sc.sc_kor 국어점수, Sc.sc_eng 영어점수, Sc.sc_math 수학점수,
        ( Sc.sc_kor + Sc.sc_eng + Sc.sc_math) 총점 ,  
        ROUND(( Sc.sc_kor + Sc.sc_eng + Sc.sc_math)/3,0) 평균
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num 
    LEFT JOIN tbl_dept DP
        ON ST.st_dcode = DP.dp_code
    
);

DROP VIEW view_성적일람표
CASCADE CONSTRAINTS;


SELECT COUNT(*) FROM VIEW_성적일람표;


SELECT *
FROM view_성적일람표
ORDER BY 학번 ;


-- 생성된 view_성적일람표를 사용하여
-- 1. 총점이 200점 이상인 학생은 몇명?
-- 2. 평균이 75점 이상인 학생들의 평균 점수는? 
-- 3. 각 학과별로 총점과 평균점수는?


SELECT
COUNT(*)
FROM view_성적일람표
WHERE 총점 >= 200 ;



SELECT ROUND(AVG(평균),0)
FROM view_성적일람표
WHERE 평균 >= 75 ;


-- 학과코드와 학과명으로 그룹을 설정하고
-- 각 그룹의 총점과 평균을 계산
-- 최고점과 최저점, 
SELECT 학과코드, 학과명, 
        COUNT(*) 학과인원수, 
        SUM(총점) 학과총점, ROUND(AVG(평균),0) 학과평균
FROM view_성적일람표
GROUP BY 학과코드, 학과명 
ORDER BY 학과코드 ;
