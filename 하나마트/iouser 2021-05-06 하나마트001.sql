-- iouser

CREATE TABLE tbl_iolist(
    io_seq	    NUMBER		    PRIMARY KEY,
    io_date	    VarCHAR2(10)	NOT NULL	,
    io_pname	nVarCHAR2(50)	NOT NULL	,
    io_dname	nVarCHAR2(50)	NOT NULL	,
    io_dceo	    nVarCHAR2(20)	NOT NULL	,
    io_inout	nVarCHAR2(5)	NOT NULL	,
    io_qty	    NUMBER	        NOT NULL	,
    io_price	NUMBER	        NOT NULL	,
    io_total	NUMBER	        NOT NULL	
);

SELECT COUNT(*)
FROM tbl_iolist
WHERE io_inout = '매입' ;

SELECT *
FROM tbl_iolist
WHERE io_inout = '매출';


SELECT io_inout, COUNT(*)
FROM tbl_iolist
GROUP BY io_inout;


-- 매입과 매출 금액 총합
SELECT io_inout, SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout;


SELECT io_inout,
    SUM(DECODE(io_inout, '매입', io_total)) AS 매입합계,
    SUM(DECODE(io_inout, '매출', io_total)) AS 매출합계
FROM tbl_iolist
GROUP BY io_inout;


-- 일년동안 매입과 매출금액을 계산하고
-- 단순 이익금액 계산해보기
SELECT 
    SUM(DECODE(io_inout, '매입', io_total)) AS 매입합계,
    SUM(DECODE(io_inout, '매출', io_total)) AS 매출합계,
    SUM(DECODE(io_inout,'매출',io_total)) -
    SUM(DECODE(io_inout,'매입',io_total)) AS 이익금
FROM tbl_iolist ; 


-- 매입매출관련하여
-- 소매점에서 상품을 매입하여 소비자한테 판매할 떄
-- 매입할 떄 매입부가세 발생
-- 판매할 때 매출부가세 발생
-- 매출부가세 - 매입부가세를 계산하여 일년에 2~4회에 부가가치세를 납부한다.

-- 농사를 지어서 쌀 20kg를 생산 하여 판매를 하면
-- 5만원 정도의 금액에 판매가 된다.
-- 쌀을 공장에서 가공하여 생산품(공산품)을 만들게 되면
-- 실제 20kg의 쌀을 직접 판매하는 것보다 더 비싼 가격에 판매하게 된다,
-- 이 때 실제 쌀보다 더 많은 이익이 발생하게 되므로
-- 가치가 부가 되었다 라고 표현한다
-- 가치가 부가된 만큼 세금을 납부하도록 한다.
-- 부가가치세(Value Add Tax, VAT)
-- 매입을 할 때는 매입금액의 10% 만큼 세금을 포함하여 매입하고
-- 매출을 할 때는 매출금액의 10% 만큼 세금을 포함하여 판매한다.

-- 매입매출 데이터에서 보면
-- 매입금액은 부가세 10%를 제외한 금액으로 입력하고
-- 매출금액은 부가제 10%를 포함한 금액으로 입력한다.
-- 샘플데이터의 매입금액은 VAT 제외금액이고
--              매출금액은 VAT 포함된 금액이다.
-- 매입과 매출 데이터로 지난 1년간 납부한 VAT 금액을 계산해보자.

-- VAT = (매출금액에 포함된 VAT) - (매입금액*0.1)

-- 매출금액의 VAT 제외된 합계 = 매출금액/1.1
-- 매출부가세 : VAT 제외된 매출금액 *0.1

SELECT SUM(io_total)
FROM tbl_iolist
WHERE io_inout = '매입';

SELECT SUM(io_total)
FROM tbl_iolist
WHERE io_inout = '매출';

-- 일년동안 매입매출결과에 납부한 부가세 계산
SELECT SUM(DECODE(io_inout, '매입', ROUND(io_total*0.1))) AS 매입부가세,
        SUM(DECODE(io_inout, '매출',ROUND(io_total/1.1)*0.1)) AS 매출부가세,
        SUM(DECODE(io_inout, '매출',ROUND(io_total/1.1)*0.1)) -
        SUM(DECODE(io_inout, '매입', ROUND(io_total*0.1))) AS 납부세액
FROM tbl_iolist;


-- 거래처별로 매입과 매출 합계
-- DECODE(칼럼명, 조건값, true일 때, false일 때)
--        조건값에 해당하는 값이 없으면 null이 아닌 0을 출력하라
-- 실제 저장된 데이터를 PIVOT으로 보여주기
SELECT io_dname, SUM(DECODE(io_inout,'매입',io_total,0)) AS 매입합계,
                    SUM(DECODE(io_inout,'매출',io_total,0)) AS 매출합계
FROM tbl_iolist
GROUP BY io_dname;

-- 상품별로 매입과 매출 합계
SELECT io_pname, 
    SUM(DECODE(io_inout,'매입',io_total,0)) AS 매입합계,
    SUM(DECODE(io_inout,'매출',io_total,0)) AS 매출합계
FROM tbl_iolist
GROUP BY io_pname;



-- 2020-01-01부터 2020-06-30 기간동안
-- 거래된 리스트를 거래처별로 조회하기
SELECT io_dname AS 거래처, io_pname AS 상품명
FROM tbl_iolist
WHERE io_date BETWEEN '01/01/2020' AND '06/30/2020'
GROUP BY io_pname, io_dname
ORDER BY io_dname;

-- 기간동안 거래처별 매입,매출 합계구하기
SELECT 
    io_dname AS 거래처, 
    SUM(DECODE(io_inout, '매입',io_total,0)) AS 매입총액,
    SUM(DECODE(io_inout, '매출',io_total,0)) AS 매출총액
FROM tbl_iolist
WHERE io_date BETWEEN '01/01/2020' AND '06/30/2020'
GROUP BY io_dname
ORDER BY io_dname;

-- 전체 데이터에서 상품 리스트만 중복없이 조회
-- 상품리스트와 매입, 매출 단가를 조회하기
-- 같은 상품이라도 거래 시기에 따라 매입과 매출금액이
-- 달라질 수 있기 때문에
-- 단가 데이터 중에서 제일 높은 단가를 가져오기
SELECT io_pname AS 상품,
         MAX(DECODE(io_inout,'매입',io_price,0)) AS 매입단가,
        MAX(DECODE(io_inout,'매출',io_price,0)) AS 매출단가
FROM tbl_iolist
GROUP BY io_pname 
ORDER BY io_pname;

/*
 매입매출 데이터로부터 상품정보 테이블 데이터를 생성하기
    1. 매입매출 데이터에서 상품명으로 그룹을 하고
    2. 매입, 매출 구분에 따라 각각 매입단가, 매출단가를 가져오기
    3. 매입과 매출에 0인 값이 있다.
    4. 매입단가가 0인 데이터는 매출데이터에서 임의로 생성하기
        매출단가의 80%를 매입단가로 하고, 부가세를 제외한 금액으로 계산
        E2 항목의 값을 0.8을 곱하면 E2의 80%가격이 되고
        그 그 금액을 1.1로 나누면 부가세를 제외한 가격이 된다.
        =ROUND(IF(C2 = 0, ((E2 * 0.8 )/1.1), C2),0)
    5. 매출단가가 0인 데이터는 매입데이터에서 임의로 생성하기
        매입단가의 20%를 추가하고 부가세 10% 추가
        매입단가 + 20% + 10%
        = INT(IF(E2 =0,((D2 * 1.2)*1.1)/10, E2)
*/




-- 전체 데이터에서 거래처 리스트만 중복없이 조회
SELECT io_dname AS 거래처, io_dceo AS 대표
FROM tbl_iolist
GROUP BY io_dname, io_dceo 
ORDER BY io_dname;


--상품 정보 테이블
--DEFAULT 속성
-- INSERT를 수핼할 때 값이 지정되지 않으면
--  자동으로 추가될 데이터
--  자동으로 NOT NULL로 설정된다.
CREATE TABLE tbl_product (
    p_code	    CHAR(6)		    PRIMARY KEY,
    p_name	    nVarCHAR2(50)	NOT NULL	,
    p_iprice	NUMBER	        NOT NULL	,
    p_oprice	NUMBER	        NOT NULL	,
    p_vat	    VarCHAR2(125)	DEFAULT'Y'	
);

DROP TABLE tbl_dept ;
CREATE TABLE tbl_dept(
    dp_code	CHAR(5)		    PRIMARY KEY,
    dp_name	nVarCHAR2(50)	NOT NULL	,
    dp_ceo	nVarCHAR2(50)	NOT NULL	,
    dp_tel	VarCHAR2(20)	,
    dp_addr	nVarCHAR2(125)	
);

/*
 매입매출 데이터로 분리
 상품정보, 거래처정보 데이터를 생성하고
 테이블을 생성하여 데이터를 import했다.
 
 매입매출데이터와 상품정보 거래처정보를 JOIN하기 위해서는
 매입매출데이터에 상품코드, 거래처 코드가 있어야 한다.
 
 그러나 현재 데이터는 코드 칼럼이 없이 이름 칼럼만 있는 상태이다.
 
 매입매출데이터에 상품코드, 거래처코드 칼럼을 추가하고
 세 테이블을 JOIN할 수 있도록 변경하기
 
 
*/





