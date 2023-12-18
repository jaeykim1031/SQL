/*
    DDL : Create, Alter, Drop. - 객체(테이블, 뷰, 저장프로시져, 트리거, 시퀀스...)를 만듦
        
    
    - 테이블 생성 후 기존에 생성된 테이블에 대해 빈번히 유지 보수 (alter table)
        - 1. 컬럼의 자료형을 변경 : varchar(50) -> varchar(100)
        - 2. 컬럼의 이름 변경, 삭제, 추가
        - 3. 생성 후 제약 조건 추가, 삭제 ( PK, FK, default, Unique, NOT NULL, CHECK )

*/

-- 컬럼명, 값만 복사됨. 계약 조건은 복사되지 않음
create table emp60
as 
select * from employee;


create table dept60
as 
select * from department;

-- 데이터 사전 : user_ 
        -- user_constraints - 데이터베이스에 존재하는 모든 테이블에 대한 제약조건 출력
SELECT * from user_constraints
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

-- 1. Alter table을 사용해서 기존 테이블에 컬럼 추가 : birth(date), email(varchar2(100))
    --  테이블에 컬럼 추가시 null로 처리 후 컬럼 추가
desc dept60;

alter table dept60
add (birth date);

-- 기존 테이블에 여러 컬럼을 한 번에 추가
alter table dept60
add(email varchar2(100), addr VARCHAR2(200), jumin char(14));

-- 기존 칼럼에 값 넣기 : update   
UPDATE dept60
set birth = sysdate , email = 'aaa@aaa.com', addr = '서울' , jumin = '123447-4812312'
where dno = '10';             /* ->  WHERE 중요 */

-- 컬럼에 부여된 자료형 수정
alter table dept60
modify email VARCHAR2(200);

-- 컬럼 제거
alter table dept60
drop COLUMN JUMIN;

-- 컬럼의 이름 변경 
alter table dept60
RENAME COLUMN addr to address1;

-- 테이블 이름 변경
RENAME dept60 to dept70;

SELECT * from dept70;
RENAME dept70 to dept60;

-- 기존 테이블의 제약 조건 추가, 제거
    -- 테이블에서 1번만 넣을 수 있음
    -- not null 컬럼에 PK를 넣을 수 있다
    -- 컬럼에 null 값이 없어야 함
    
    
SELECT * from user_constraints where table_name in ('DEPT60' , 'EMP60');

-- dept60에 PK 제약 조건 추가
alter table dept60
add PRIMARY key (dno);      -- 제약 조건 이름 생략 가능 'constraint PK_~'

alter table emp60
add PRIMARY key (eno);



-- 제거
alter table dept60 
drop CONSTRAINT PK_DEPT60_DNO;


-- Foreign key : 다른 테이블의 컬럼 값을 참조하여서 값을 넣을 수 있음 
        -- 테이블 (부모 : 하나)    < --   FK 테이블 (자식 : 여럿)
        -- join 시 on 절에서 사용되는 키 컬럼
        -- PK, Unique를 참 조할 수 있다  
        -- 참조 컬럼의 자료형이 비슷하거나 같아야 함

    
        -- 부모 테이블의 PK 할당
    alter table dept60
    add primary key (dno);
    
        -- 자식 테이블의 FK 할당
    alter table emp60
    add FOREIGN key (dno) REFERENCES dept60(dno);

-- join
SELECT eno, ename, salary, e.dno, d.dno, dname , loc
from emp60 e
    join dept60 d
        on e.dno = d.dno;
    
-- Unique 제약 조건 추가 : 중복된 값을 넣지 못하도록 설정'
    -- 한 테이블의 여러 컬럼에 부여 가능 
    -- not null, null 모두 가능 

    
alter table dept60
add unique(email);
    
INSERT into dept60
VALUES (50 , '영업', '부산', sysdate, 'aaa@ffff.com', 'qntks');
    
INSERT into dept60
VALUES (77 , '영업2', '부산', sysdate, 'aaa@ffff.com', 'ooioi');
    
commit;

alter table dept60
add unique(address1);

UPDATE dept60
set dept60.address1 = '광주'
where dno = 50;

-- 계약 조건 제거
alter TABLE dept60
drop CONSTRAINT SYS_C008530;

SELECT * from user_constraints where table_name in ('DEPT60' , 'EMP60');

SELECT * from dept60;


-- CHECK 제약 조건
SELECT * from emp60;

alter TABLE emp60
add ( addr varchar2(50), hdate date);
alter TABLE emp60
add ( addr varchar2(50), hdate date);

-- addr : 서울 부산 광주만
-- hdate : 230101 ~ 231231 만 


alter table emp60
add check( addr in ('seoul','qntks','rhkdwn'));

alter table emp60
add check( hdate BETWEEN to_date('20230101', 'YYYYMMDD') and to_date('20231231','YYYYMMDD' )  );

alter table emp60
add check (age >= 0 and age <= 300);

-- not null 제약 조건 : 컬럼에 null 없도록 설정

alter table dept60
modify address1 CONSTRAINT NN_DEPT60_ADDRESS1 not null;

update dept60
set address1 = 'seoul'
where address1 is null;

INSERT into dept60
VALUES (70, '5345', '5dgggrd5', sysdate , '222@gfgsfd', null);


-- default : ** 제약 조건이 아님 ** 제약 조건 이름을 부여할 수 없음
            -- 컬럼의 값을 넣지 않을 경우 default로 설정된 값이 자동으로 들어감
            -- default의 설정을 제거하기 위해서는 default null

alter table dept60
add address2 varchar2(100);

alter table dept60
modify address2 default 'seoul';

INSERT into dept60
VALUES (80, '5345', '5dgggrd5', sysdate , '222@gfgsfd',' 131' , default );

-- default 제거
    -- 계약 조건 제거 : alter table 테이블명 drop 제약조건

alter table dept60
modify address2 default null;







