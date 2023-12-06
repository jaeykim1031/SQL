SELECT
    *
FROM
    help;

SELECT
    *
FROM
    redo_log;

-- SQL의 주석 : 한 줄 주석
/*
      일반 계정 생성 후 일반 계정으로 접속
*/
-- system 계정으로 접속한 쿼리창에서만 계정을 생성 할 수 있다

--  1. hr 계정 생성 : 오라클 12 버전 이상부터 계정 생성시 C##(계정) 

CREATE user C##HR4 IDENTIFIED by 1234
default tablespace USERS
temporary tablespace TEMP;

--  2. 계정에 권한 부여하기 : connnect(접속), resource(객체 생성, 수정, 삭제)

grant resource,
connect to

c##hr;

--  3. 테이블 스페이스에서 사용량 할당.

ALTER USER c##hr
    QUOTA UNLIMITED ON users;

-- 4. 계정 삭제

DROP USER c##hr4 CASCADE;




