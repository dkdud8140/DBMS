-- gbUser

show databases;

CREATE DATABASE myDB;
USE myDB;
CREATE TABLE tbl_todolist (
	td_seq BIGINT auto_increment primary key,
    td_sdate varchar(10) not null,	-- 추가된 날짜
    td_stime varchar(10) not null,	-- 추가된 시간
	td_doit varchar(300) not null,
    td_edate varchar(10) default '',	-- 완료날짜
    td_etime varchar(10) default ''		-- 완료시간
);

DESC tbl_todolist ;
