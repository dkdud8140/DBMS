-- 2021.05.04
-- 관리자 접속

-- KschoolDB, Kschool.dbf
CREATE TABLESPACE KschoolDB
DATAFILE 'C:/oraclexe/data/kschool.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K ;


-- ksuser, ksuser, KschoolDB
CREATE USER ksuser IDENTIFIED BY ksuser
DEFAULT TABLESPACE KschoolDB ;

GRANT DBA TO ksuser ;