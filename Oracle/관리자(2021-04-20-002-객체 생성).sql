--관리자 접속
-- 실습을 위한 기존 객체 삭제
--suser 사용자 삭데
 DROP USER scuser CASCADE ;
 
 DROP TABLESPACE schoolDB
 INCLUDING CONTENTS and DATAFILES
 CASCADE CONSTRAINTS;
 
 
 -------------------------
 
 -- 테이블 스페이스 생성
 -- 이름 : schoolDB, datagile : school.dbf, SIze : 1m , ex : 1k
 CREATE TABLESPACE schoolDB
 DATAFILE 'C:/oraclexe/data/schoolDB.dbf'
 SIZE 1M AUTOEXTEND on NEXT 1k ;
 
 
 --사용자생성
 -- id : scuser, pw : scuser
 -- default tableSpace : schoolDB
 CREATE user scuser IDENTIFIED by scuser 
 DEFAULT TABLESPACE schoolDB ;
 
 -- 사용자 권한 부여
 -- 편의상 DBA 권한을 부여
 Grant DBA TO scuser ;
 