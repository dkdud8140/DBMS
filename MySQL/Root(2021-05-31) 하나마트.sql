-- root 접속
-- 2021.05.31

CREATE DATABASE nhDB ;
USE nhDB ;

create table tbl_iolist (
io_seq		BIGINT	auto_increment PRIMARY KEY,
io_date		VARCHAR(10)		NOT NULL,
io_pname	VARCHAR(50)	NOT NULL,
io_dname	VARCHAR(50)	NOT NULL,
io_dceo		VARCHAR(20)	NOT NULL,
io_inout	VARCHAR(5)		NOT NULL,
io_qty		INT	NOT NULL,
io_price	INT	NOT NULL,	
io_total	INT		
);

DROP table tbl_iolist;

CREATE TABLE tbl_dept (
dp_code	CHAR(5)			PRIMARY KEY,
dp_name	VARCHAR(50)		NOT NULL,
dp_ceo	VARCHAR(50)		NOT NULL,
dp_tel	VARCHAR(20)		,
dp_addr	VARCHAR(125)		
);

CREATE TABLE tbl_product (
);



