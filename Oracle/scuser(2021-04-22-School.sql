-- scuser 관리자

DROP TABLE tbl_student 
CASCADE CONSTRAINTS ;

CREATE TABLE tbl_student (

    -- 고정문자열 
    st_num CHAR(5) ,
    
    -- 한글이 포함된 가변문자열
    st_name nVarCHAR2(20),
    st_dept nVarCHAR2(10),
    
    -- 숫자값 입력
    -- 숫자값을 문자형으로 인식
    st_grade varCHAR2(5),
    
    -- 000-0000-0000
    st_tel varCHAR2(20),
    
    
    st_addr nVarCHAR2(125)

); 


-- 생성한 table에 데이터 추가
-- DML(데이터 조작어)명령을 사용하여 데이터 추가(create)
-- 

INSERT INTO tbl_student(st_num, st_name, st_dept, st_grade)
VALUES('00001','홍길동', '국어국문', '3');

--데이터를 추가한 후에 잘 추가되었는지 확인
-- tbl_student table에 저장되어 있는 모든 데이터를 
SELECT * FROM tbl_student ;

INSERT INTO tbl_student(st_num,st_dept, st_grade)
VALUES('00001','경영', '2');

SELECT * FROM tbl_student ;


--위에서 생성한 tbl_student 테이블에는
-- 데이터를 추가하려고 할 떄
-- 이름 데이터가 없어도 데[이터가 정상적으로 추가가 되어버린다.
-- 같은 학번의 데이터가 이미 추가되어 있어도 또다시 추가가 되어버린다
-- 이런식으로 데이터가 계속 추가된다면 전체 데이터의 신뢰성에 문제가 될 것이다
-- DBMS에서는 table)(Entity)를 설계할 때 이러한 오류를 방지하기 위하여
-- table을 생성할 때 "제약조건"을 설정하여 
-- 데이터가 INSERT 되지 못하도록 하는 기능이 있다.
--작성된 table을 삭제하고 다시 제약조건을 설정하여 생성하자

DROP TABLE tbl_student;

-- 1. 학생의 데이터는 반드시 있어야만 한다
--      st_name(학생이름) 칼럼은 not null이어야 한다
-- 2. 학번은 "절대" 중복되면 안된다.
        -- tbl_student 테이블의 모든 데이터의 학번은 유일해야한다.
CREATE TABLE tbl_student (
    
    st_num CHAR(5) UNIQUE NOT NULL,
    st_name nVarCHAR2(20) NOT NULL,
    st_dept nVarCHAR2(10),
    st_grade varCHAR2(5),
    st_tel varCHAR2(20),
    st_addr nVarCHAR2(125)

); 

-- 학생이름 데이터가 없음므로 Insert 불가
INSERT INTO tbl_student (st_num, st_dept)
VALUES ('00001', '컴공');

--학생이름 데이터를 같이 포함하여 insert 수행
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00001', '컴공', '이성계');

-- 칼럼보다 데이터 개수가 적어서 insert 불가
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('사회과학', '이몽룡');

-- st_num이 null이라서 insert 불가
INSERT INTO tbl_student (st_dept, st_name)
VALUES ('사회과학', '이몽룡');

-- st_num 칼럼이 unique인데 이미 존재하는 00001학번으로
-- 데이터를 추가하려고 하니 문제가 있어서 insert 불가
-- table의 제약조건을 설정할 떄
    -- unique는 매우 신중하게 선택해야한다.
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00001','사회과학', '이몽룡');

-- 명령의 89 행에서 시작하는 중 오류 발생 -
-- INSERT INTO tbl_student (st_num, st_dept, st_name)
-- VALUES ('00001','사회과학', '이몽룡')
-- 오류 보고 -
-- ORA-00001: unique constraint (SCUSER.SYS_C007005) violated


INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00101','사회과학', '이몽룡');

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00002','법학과', '성춘향');

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00002','법학과', '성춘향');

SELECT * FROM tbl_student;


--기본키 칼럼(Primary Key)
-- 데이터를 조회(select)할 떄 st_num 칼럼을 기준으로 조회를 하면
-- 반드시 원하는 데이터 1개만 보여지는 조건을 만족하게 하는 칼럼
-- 제약조건이 반드시 unique하면서 not null이어야 한다.


-- 기본키는 제약조건에 unique와 not null을 같이 설정해야 하는데
-- DBMS에서는 기본키 제약조건을 설정하는 키워드가 별도로 있다.

-- primary key : Unique + not null + 기타조건 + Index 자동 생성
-- 매우 강력한, 가장 우선순위가 높은 제약조건이다
CREATE TABLE tbl_student (
    
    --st_num CHAR(5) UNIQUE NOT NULL,
    st_num CHAR(5) PRIMARY KEY,
    st_name nVarCHAR2(20) NOT NULL,
    st_dept nVarCHAR2(10),
    st_grade varCHAR2(5),
    st_tel varCHAR2(20),
    st_addr nVarCHAR2(125)

); 

DROP TABLE tbl_student ;

-- 테이블의 구조를 보여줘
DESCRIBE tbl_student;
DESC tbl_student;

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00101','사회과학', '이몽룡');

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00002','법학과', '성춘향');

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES ('00100','국어국문', '정몽주');

SELECT * FROM tbl_student;

     
-- Primary Key 로 설정된 칼럼에 조건을 부여하여 데이터 조회하기
--      객체무결성의 완성
SELECT * FROM tbl_student
WHERE st_num = '00100';


SELECT * FROM tbl_student ;