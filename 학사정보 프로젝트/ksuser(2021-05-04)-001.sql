-- 2021.05.04
-- kuser

DROP TABLE tbl_student;
CREATE TABLE tbl_student(
    st_code	    CHAR(5)		    PRIMARY KEY,
    st_name	    nVarCHAR2(20)	NOT NULL,	
    st_tel	    VarCHAR2(20)	NOT NULL,	
    st_addr	    nVarCHAR2(125),		
    st_grade	NUMBER	        NOT NULL,	
    st_dcode	CHAR(4) 	    NOT NULL	
);

DROP TABLE tbl_dept;
CREATE TABLE tbl_dept(
    td_code	    CHAR(4)		    PRIMARY KEY,
    td_name	    nVarCHAR2(20)	NOT NULL,	
    td_prof	    nVarCHAR2(50)	NOT NULL,	
    td_intel	NUMBER		
);


DROP TABLE tbl_score;
CREATE TABLE tbl_score(
    sc_seq	    NUMBER		PRIMARY KEY,
    sc_scode	CHAR(5)	    NOT NULL,	
    sc_sbcode	CHAR(5)	    NOT NULL,	
    sc_score	NUMBER				
);

DROP TABLE tbl_subject;
CREATE TABLE tbl_subject(
    sb_code	    CHAR(5)		    PRIMARY KEY,
    sb_title	nVarCHAR2(20)	NOT NULL,	
    sb_name	    nVarCHAR2(20)		
);

select COUNT(*) FROM tbl_dept;
select COUNT(*) FROM tbl_score;
select COUNT(*) FROM tbl_student;
select COUNT(*) FROM tbl_subject;






