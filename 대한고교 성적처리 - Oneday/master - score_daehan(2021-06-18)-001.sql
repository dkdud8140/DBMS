CREATE database score_daehan ;

USE score_daehan;

create table tbl_student (
	st_num	BIGINT	primary key auto_increment,
	st_name	VARCHAR(20)	NOT NULL,	
	st_dept	VARCHAR(20)	NOT NULL,	
	st_grade INT	NOT NULL	,
	st_tel	VARCHAR(15)	NOT NULL,	
	st_addr	VARCHAR(125)
);

create table tbl_score (
	sc_seq	BIGINT	primary key auto_increment,
	sc_stnum	BIGINT	NOT NULL	,
	sc_subject	VARCHAR(20)	NOT NULL	,
	sc_score	INT	NOT NULL	
);

drop table tbl_student ;
drop table tbl_score ;

show tables;
select * from tbl_student ;
select * from tbl_score ;

-- tbl_student 시퀀스 값 초기화
alter table tbl_student auto_increment = 20210001;

-- 폴링키 설정
ALTER TABLE tbl_score
ADD CONSTRAINT fk_student
FOREIGN KEY(sc_stnum)
REFERENCES tbl_student(st_num);

INSERT INTO tbl_student(st_name, st_dept, st_grade,st_tel,st_addr)
values('홍길동','컴퓨터공학과','4','010-0000-0001','광주광역시');

INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210001','컴퓨터언어', 88);
INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210001','생활영어', 90);
INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210001','미디어의이해', 70);
INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210001','일본어회화2', 60);

INSERT INTO tbl_student(st_name, st_dept, st_grade,st_tel,st_addr)
values('성춘향','컴퓨터공학과','4','010-0000-0001','광주광역시');

INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210002','컴퓨터언어', 50);
INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210002','생활영어', 60);
INSERT INTO tbl_score(sc_stnum, sc_subject, sc_score)
VALUES('20210002','미디어의이해', 70);





 CREATE VIEW view_list AS (
	select 
		ST.st_num AS v_num,
		ST.st_name AS v_name,
		ST.st_dept AS v_dept,
		ST.st_grade AS v_grade,
		count(SS.sc_subject) AS v_count,
		SUM(SS.sc_score) AS v_sum,
		ROUND(AVG(SS.sc_score),2) AS v_avg
	FROM tbl_student ST
		LEFT JOIN tbl_score SS
		ON ST.st_num = SS.sc_stnum
	group by ST.st_num
);
    
    
select * from view_list ;
select * from view_list where v_num='20210002';
    
drop view view_list ;    


CREATE VIEW view_subscore AS (
select 
	SS.sc_stnum AS stnum,
    ST.st_name AS stname,
    SUM(IF(sc_subject ="컴퓨터언어",sc_score, 0)) AS sub1,
    SUM(IF(sc_subject ="생활영어",sc_score, 0)) AS sub2,
    SUM(IF(sc_subject ="미디어의이해",sc_score, 0)) AS sub3,
    SUM(IF(sc_subject ="일본어회화2",sc_score, 0)) AS sub4,
    SUM(SS.sc_score) AS sum,
	ROUND(AVG(SS.sc_score),2) AS avg

 from tbl_score SS
	LEFT JOIN tbl_student ST
    ON SS.sc_stnum = ST.st_num
group by sc_stnum 
order by sc_stnum 
);    
    
select * from view_subscore ;
drop view view_subscore ;


SELECT * FROM tbl_student
WHERE st_num = '20210001';

SELECT * FROM tbl_student  WHERE st_num = 20210001 ;

update tbl_student
SET st_name = '홍길동2'
WHERE st_num = '20210001';


select * From tbl_student
WHERE st_name = "홍길동2" && st_dept = '컴퓨터공학과' && st_grade = '4' && st_tel = '010-0000-0001' && st_addr ='광주광역시';

delete from tbl_student
where st_num = '2021003';

ALTER TABLE tbl_student
ADD unique(st_name, st_dept, st_tel);