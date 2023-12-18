/*
    sequence : 자동 번호 재생기
            - 특정 컬럼에 번호를 자동으로 생성
            - 정수 타입의 컬럼에 적용해야함
            - user_sequence 시퀀스 정보 확인
            - 전진만 가능
*/

-- 1. 시퀀스 생성 - 초기 값 : 1 증가 값 : 1 
CREATE SEQUENCE seq1
    start WITH 1
    INCREMENT by 1;
    
-- 2. 시퀀스의 정보 확인 
SELECT * from user_sequences;

-- 3. 듀얼 테이블을 사용해 시퀀스 정보 확인
SELECT seq1.CURRVAL from dual;      -- 현재 시퀀스의 번호 확인

SELECT seq1.NEXTVAL from dual;      -- 다음 시퀀스의 값 확인

-- 4. 값 insert 시 특정 컬럼에 시퀀스 부착
create table abc(
    a int not null PRIMARY key,
    b VARCHAR2(50),
    c varchar2(50)
);

INSERT into abc
VALUES (seq1.nextval, 'seoul', 'addr1');

COMMIT;

SELECT * from abc;








