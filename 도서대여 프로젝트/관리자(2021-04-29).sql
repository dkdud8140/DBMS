-- 2021-04-29
-- 관리자
-- 프로젝트에서 사용할 TABLE SPACE와 USER 생성

-- 연습하자!!
CREATE TABLESPACE RentBookDB
DATAFILE 'C:/oraclexe/data/rentbook.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K ;


-- 연습하자!!
CREATE USER bookuser IDENTIFIED BY bookuser
DEFAULT TABLESPACE RentBookDB;



GRANT DBA TO bookuser;