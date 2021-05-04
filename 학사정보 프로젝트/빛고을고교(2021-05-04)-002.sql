-- ksuser로 접속
-- 2021.05.04

CREATE TABLE tbl_student(
    st_num	    CHAR(5)		    PRIMARY KEY,
    st_name	    nVarCHAR2(20)	NOT NULL,	
    st_tel	    VarCHAR2(20)	NOT NULL,	
    st_addr	    nVarCHAR2(125)		,
    st_grade	NUMBER	        NOT NULL,	
    st_dpcode	CHAR(4)	        NOT NULL	
);


CREATE TABLE tbl_dept(
    dp_code	CHAR(4)		    PRIMARY KEY,
    dp_name	nVarCHAR2(20)	NOT NULL,	
    dp_pro	nVarCHAR2(50)	NOT NULL,	
    dp_tel	VarCHAR(5)		
);


CREATE TABLE tbl_subject(
    sb_code	CHAR(5)		    PRIMARY KEY,
    sb_name	nVarCHAR2(20)	NOT NULL,	
    sb_pro	nVarCHAR2(20)		
);


CREATE TABLE tbl_score(
    sc_seq	    NUMBER		PRIMARY KEY,
    sc_stnum	CHAR(5)	    NOT NULL,	
    sc_sbcode	CHAR(5)	    NOT NULL,	
    sc_score	NUMBER		
);




SELECT COUNT(*) FROM tbl_dept;
SELECT COUNT(*) FROM tbl_score;
SELECT COUNT(*) FROM tbl_student;
SELECT COUNT(*) FROM tbl_subject;


-- LEFT JOIN을 하여 import된 두 테이블간의 데이터 유효성 검증
-- 학생 테이블에 없는 학과 코드가 있는지 검증하기
-- 학생 테이블과 학과 테이블간의 FK 설정을 하기 위한 검증 결과
-- LIST에서 절대 null이 없어야 한다.
SELECT st.st_num AS 학번,
        st.st_name AS 이름,
        st.st_dpcode AS 학과코드,
        dp.dp_name AS 학과명,
        st.st_tel AS 연락처,
        st.st_addr AS 주소,
        st.st_grade AS 학년
        
FROM tbl_student ST
    LEFT JOIN tbl_dept DP
        ON st.st_dpcode = dp.dp_code ;


CREATE VIEW view_성적정보 AS
(
    SELECT sc.sc_seq 일련번호,
            sc.sc_stnum 학번,
            st.st_name 학생이름,
            st.st_tel 연락처,
            sc.sc_sbcode 과목코드,
            sb.sb_name 과목이름,
            sc.sc_score 점수,
            sb.sb_pro 주임교수
        
    FROM tbl_score SC
        LEFT JOIN tbl_student ST
            ON sc.sc_stnum = st.st_num 
        LEFT JOIN tbl_subject SB
            ON sc.sc_sbcode = sb.sb_code
);

DROP VIEW view_성적정보;

SELECT *
FROM view_성적정보 ;

SELECT 학번, 학생이름, SUM(점수) AS 총점,
        ROUND(AVG(점수),1) AS 평균
FROM "VIEW_성적정보"
GROUP BY 학번, 학생이름
ORDER BY 학번;

--DECODE() IF와 유사한 조건검색 함수
--DECODE(칼럼명, 값, return)
--          칼럼명에 '값'이 담겨있으면 return명령을 수행하라
-- 과목명 칼럼에 국어 문장열이 담겨 있으면 해당 레코드의
--      점수 칼럼 값을 표시하고 그렇지 않으면 null
SELECT 학번,
    DECODE(과목이름, '국어', 점수) AS 국어점수,
    DECODE(과목이름, '영어', 점수) AS 영어점수,
    DECODE(과목이름, '수학', 점수) AS 수학점수 
FROM view_성적정보
ORDER BY 학번 ;


-- 제2정규화가 되어있는 테이블을 PIVOT하여
-- 일반적인 보고서형식으로 보여줄 수 있다.
-- 위의 sQL 을 학번으로 그룹핑하고
-- 각 점수를 합산(SUM())하면
-- DBMS의 SQL에서는 null + 숫자 = 0 + 숫자와 같다
-- SUM(null, 60, null, null) = sum(0,60,0,0)과 같다

CREATE VIEW view_성적보고서 AS
(
    SELECT 학번,
        SUM(DECODE(과목이름, '국어', 점수)) AS 국어점수,
        SUM(DECODE(과목이름, '영어', 점수)) AS 영어점수,
        SUM(DECODE(과목이름, '수학', 점수)) AS 수학점수,
        SUM(DECODE(과목이름, '미술', 점수)) AS 미술점수,
        SUM(DECODE(과목이름, '소프트웨어공학', 점수)) AS 소프트웨어점수,
        SUM(DECODE(과목이름, '음악', 점수)) AS 음악점수,
        SUM(DECODE(과목이름, '데이터베이스', 점수)) AS 데이터베이스점수,
        SUM(점수) AS 총점,
        ROUND(AVG(점수),1) AS 평균
        
    FROM view_성적정보
    GROUP BY 학번
);

SELECT *
FROM "VIEW_성적보고서"
ORDER BY 학번 ;

SELECT sc.학번,
        st.st_name 학생이름,
        st.st_tel 연락처,
        SC."국어점수", SC."수학점수", SC."데이터베이스점수", SC."미술점수", SC."소프트웨어점수", SC."영어점수", SC."음악점수"
FROM "VIEW_성적보고서" SC
    LEFT JOIN tbl_student ST
        ON SC."학번" = st.st_num ;

