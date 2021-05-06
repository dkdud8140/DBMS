-- 2021.05.06
-- 관리자화면

-- 시스템에 작성된 TablcSpace를 확인하기
SELECT * FROM DBA_TABLESPACES ;

-- 오라클의 System 값
SELECT * FROM DBA_PROFILES;

-- 오라클에 새로 등록된 사용자의 password 만료일자
-- 기본값이 180으로 되어 있어서
-- 새로운 사용자 등록 후 비번을 변경하지 않으면
-- 180일 이후에는 접속이 불가능해진다.
SELECT * FROM DBA_PROFILES
WHERE resource_name = 'PASSWORD_LIFE_TIME';

-- 사용자의 Password 만료일자를 무제한으로 변경
ALTER PROFILE
DEfAULT LIMIT PASSWORD_LIFE_TIME
UNLIMITED;