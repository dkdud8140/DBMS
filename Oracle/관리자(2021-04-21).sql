-- 관리자 권한 접속

--tablespace 생성하기
CREATE TABLESPACE iolistDB
DATAFILE 'C:/oraclexe/data/iolistDB'
SIZE 1M AUTOEXTEND ON NEXT 1K ;

--TABLESPACE 삭제
--반드시 옵션을 같이 작성하자
DROP TABLESPACE iolistDB            -- 반드시
INCLUDING CONTENTS AND DATAFILES    -- 옵션
CASCADE CONSTRAINTS;                -- 옵션


-- 새로운 사용자 등록
CREATE USER iouser IDENTIFIED BY iouser 
DEFAULT TABLESPACE iolistDB ;

-- 사용자의 권한 부여
GRANT DBA TO iouser ;

-- 사용자 삭제
-- CASCADE : 관련된 모든 정보
DROP USER iouser CASCADE;

