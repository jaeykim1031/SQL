/*
    SQL : 모든 쿼리 구문. select, create, alter, drop, insert, update, delete, grant, revoke, rollbac, commit
            - 구조화된 질의 언어
    
    SQL의 종류
        DQL(Data Query Language) : 출력, 검색, select
        DDL(Date Definition Lang) : 스키마(틀, 구조),  객체(테이블 뷰 함수 시퀀스 트리거 저장프로시저 인덱스)
                                   생성(create), 수정(alter), 삭제(drop)
        DML(Data Manipulation Lang) : 테이블의 레코드(값) 조작하는 언어
                                    입력(insert), 수정(update), 삭제(delete)
                                        - transaction 발생 (RAM), commit : 메모리의 내용을 DB에 영구적 저장
                                                                  rollback : 원래대로 되돌림
                                                                  
                                        - insert, update, delete가 시작되면 자동으로 transaction이 시작
                                        
                                        - transaction 종료 : rollback - 메모리의 변경된 내용을 원래 상태로 되돌림 
                                                             commit - DB에 영구적 저장
                                                             
                                        - transaction이 종료되지 않으면 종료 될 때까지 LOCK      
                                        
                                        - *Oracle의 경우* : DML문 시작시 자동으로 transaction 시작, 종료는 명시되어야 함
                                        
                                        - *MySQL, MSSQL 의 경우* : commit 자동으로 처리
                                        
                                        - 명시적으로 transaction을 시작 할 수 있고, 명시적으로 끝낼 수 있다.
        
        DCL(Data Control Lang) : 계정에서 객체에 권한을 부여함 부여(grant), 제거(revoke)
        TCL(Transaction Control Lang) : transaction을 관리하는 언어 - DML문에서 사용됨
                                            commit, rollback, savepoint, begin transaction
*/

/*
    transaction : 작업(일)을 처리하는 최소 단위 : ALL or NOTHING
        - log에 기록되어있음 (오류난 시점까지 복원)
        
            1. 원자성 : 일을 처리하는 최소 단위
            2. 일관성 : transaction에서 처리된 결과는 일관성을 가짐 ALL or NOTHING
            3. 독립성 : 하나의 transaction은 다른 transaction과 격리 되어있음 LOCK
            4. 지속성 : commit. DB에 영구히 저장

*/

-- 테이블 복사
create table "account10"
as
SELECT eno as no,  ename as name, salary as account
from employee;

select * from "account10";


-- SMITH에서 MILLER에게 10억 입금 : 2개의 update 구문을 하나의 transaction으로 처리

/*
    smith account - 10억 : update account10 set account = account - 10 where no = 7569
    miller account + 10억 : update account10 set account = account + 10 where no = 7934

*/
----
--begin transaction ;
--
--    update "account10"
--        set account = account - 10 
--        where no = 7369;
--        
--    update "account10"
--        set account = account + 10 
--        where no = 7934;
--        
--  rollback; 
--  commit; 
--  
--End;  
----  
/*
    DML : insert, update, delete
        transaction 자동시작
        transaction 종료는 명시되어야 함(rollback commit) * 오라클 한정

*/ 
        
-- 테이블 복사 
create table dept03
as
select * from department ;
    
alter table dept03
add CONSTRAINT PK_DEPT03_DNO PRIMARY key (dno);

    
-- insert 주의사항 : 각 컬럼의 자료형에 적용된 제약 조건 확인    
desc dept03;
select * from user_constraints where table_name in ('DEPT03');

        
-- insert into 테이블 ( 컬럼, 컬럼, 컬럼) values (값, 값, 값);

insert into dept03 (dno, dname, loc)
values (50, 'HR', 'SEOUL');
        
select * from dept03;
        
        commit;
        
-- insert 시 컬럼 이름을 명시하지 않는 경우 모든 컬럼에 값을 넣어야 함       
insert into dept03(dno, dname, loc)
values (6, 'HR', 'Busan');
        
-- 컬럼 생략시 모든 컬럼에 값을 순서에 맞게 입력
insert into dept03
values (70, 'uuu', 'dwdwd');
        
-- 컬럼 명시할 때 순서 변경 가능 , 특정 컬럼은 값이 없어도 됨
insert into dept03(dname, dno)
values ('Daejeon', 80);


-- UPDATE : 값 수정시 사용. where 필수. where 조건에 사용되는 컬럼은 PK 컬럼이어야 함.
/*
    update 테이블
    set 컬럼 = 변경
    where 조건

*/

update dept03
set loc = '대구'              -- 조건 처리하지 않으면 전부 변함 
where dno = 80;

select * from dept03;   

update dept03
set dname = '관리부',
    loc = '광주'
    
where dno = 40 ;

commit;

INSERT into dept03
VALUES (90, '영업부', '대구');

INSERT into dept03
VALUES (91, '영업부', '광주');

update dept03
set dname = '인쇄부'
where loc = '광주';        --< 조건문 조심 - 중복된 컬럼

rollback;

-- update 시 PK 컬럼을 조건으로 해서 원하는 값만 수정하기.


update dept03
set dname = '인쇄부'
where dno in (91, 90);


-- delete : 레코드를 삭제. where <조건>, <조건 : 중복되지 않는 컬럼>
/*
    delete 테이블
    where 조건
*/

select * from dept03;   

-- *****************조건문이 없으면 모든 레코드가 삭제됨***************

delete dept03
where dno = 91;

   /* 모든 레코드 삭제 : 
        delete : 레코드 하나씩 삭제. 오래 걸림 - 로우레벨
        truncate table 테이블 : 한 번에 삭제 - 빠른 포맷 ->> DDL문이라 롤백 불가, 실행 후 즉시 commit
        
        drop table 테이블 : 테이블 자체를 삭제
    */

select * from dept03;
rollback;
commit;

delete dept03;
truncate table dept03;

---------------------------------------------------------------------------

create table emp04
as
select * from employee;

select * from emp04;

/*
    임의의 값 추가 : insert
             수정 : update
             삭제 : delete
*/

select * from user_constraints where table_name in ('EMP04');


/*
    DDL : 생성(create), 수정(alter), 삭제(drop)
         -> 테이블, 뷰, 함수, 시퀀스, 트리거, 저장 프로시저, 스키마를 생성, 수정, 삭제
         
    자료형 : 데이터를 저장하는 타입
        숫자 : number(n) : n자리 정수.
               number(n.m) : 소수. 전체 n자리 소수점 이하 m자리
               
        문자 : char(n) : n byte 문자. 영문 1글자 = 1byte, 한글 1글자 = 3byte
                - 빠른 성능, 공간 낭비 발생 가능성
                - n byte 만큼의 자리가 고정됨
               
               varchar2(n) : n byte 문자.
                - 가변형 공간, 느릴 수 있음. 공간 낭비 x
                - 자릿수를 알 수 없는 문자일 때 사용
                
               nchar(n) : 고정 길이 유니코드 n글자
               nvarchar2(n) : 가변 길이 유니코드 n글자
               
        날짜 : date : BC 4712/1/1 ~ 9999/12/31. 초 까지만 저장 가능
               timestamp : insert되는 순간의 시간. ms 까지 저장 가능
        
        LOB 데이터 타입 : 대량의 값을 저장, 바이너리 파일
                CLOB : 문자를 대량으로 넣을 수 있음 
                BLOB : mp3, jpeg, hwp 이진 데이터 파일 
                BFile : 대용량 파일 저장 
*/

create table test10(
    id number(4) not null PRIMARY key,      -- 중복 불가, 정수 4자
    n1 char(10) ,                   -- 영문 10자 , 한글 3자
    n2 nchar(10) ,                  -- 영문 10자, 한글 10자
    n3 varchar2(10) ,               -- 영문 10자 , 한글 3자
    n4 NVARCHAR2(10)                -- 영문 10자, 한글 10자
);

select * from test10;

insert into test10 (id, n1, n2, n3, n4)
values (1111, 'aasdads', '가나다라마바', 'aasdads', '가나다라마바');

drop table test10;

/*
제약 조건 : 테이블의 컬럼에 들어가는 키, 데이터의 무결성(결함 없는 데이터, 원하는 값만)
            primary key : 컬럼에 1번만 넣을 수 있다, 특정 컬럼에 중복된 값을 넣지 못하게 함
                        - 두 개 컬럼을 묶어서 primary key를 넣을 수 있음 
                        - 반드시 NOT NULL 컬럼이어야 함
                        - 테이블을 생성할 때 반드시 primary key가 존재해야 함. 
                            (update, delete 구문에서 primary key컬럼을 where 조건으로 사용)
                        - index가 자동으로 생성. 컬럼의 검색을 빠르게 함      
                        - JOIN 시 ON에서 많이 사용
                        
            unique key : 컬럼에 중복된 값을 넣지 못하게 함
                        - null 가능 (한 번만)
                        - 하나의 테이블에 여러 번 넣을 수 있다
                        - index 자동 생성 JOIN 시 ON에서 사용.
                        
            foreign key : 다른 테이블 (부모 테이블)의 특정 컬럼을 참조하여 값을 넣음
                        - foreign key가 참조하는 컬럼은 부모 레이블의 PK, UK 참조함
    
            NOT NULL : 컬럼에 NULL을 넣을 수 없게하는 제약조건
            
            CHECK : 컬럼에 조건을 넣어서 원하는 값만 넣을 수 있게 함 ( ex) month에 1 ~ 12만)
            
            default : 제약 조건은 아니지만 제약 조건처럼 사용됨
                    - 컬럼에 값을 넣지 않으면 defalut로 설정된 값이 등록됨
                    
            제약조건을 출력하는 데이터 사전 : user_constraints
                    - select * from user_constraints where table_name in 테이블;
*/
create table member1(
    id varchar2(50) not null PRIMARY key,
    pass varchar2(50) not null,
    addr varchar2(100) null,
    jumin char(13) null,
    phone varchar2(50),
    age number(3),
    weight number(5,2)
);

desc member1;

insert into member1
values ( 'abc', '12314' , '서울' , '411234-441232', '010-1111-1111' , 30, 44.44 );

select * from member1;


select * from user_constraints where table_name in ('MEMBER1');


-- 제약조건 이름을 넣지 않고 테이블을 생생해도 오라클에서 제약 조건 이름을 자체적으로 생성함.
-- insert 시 오류 발생할 경우 제약 조건 이름으로 오류난 컬럼을 찾기 힘듦.

create table member2(
    id varchar2(50) not null CONSTRAINT PK_MEMBER2_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER2_PASS  not null,
    addr varchar2(100) null,
    jumin char(13) null,
    phone varchar2(50),
    age number(3),
    weight number(5,2)
);

insert into member2
values ( 'abc', null , '서울' , '411234-441232', '010-1111-1111' , 30, 44.44 );
commit;


/* 
     UNIQUE : 중복된 값 불가능, null 가능, 테이블에 여러 번 가능

*/

create table member3(
    id varchar2(50) not null CONSTRAINT PK_MEMBER3_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER3_PASS  not null,
    addr varchar2(100) null,
    jumin char(13) null CONSTRAINT U_MEMBER3_JUMIN UNIQUE ,
    phone varchar2(50) not null CONSTRAINT U_MEMBER3_PHONE unique,
    age number(3),
    weight number(5,2)
);

insert into member3 (id, pass, addr, jumin, phone, age, weight)
values ( 'abc', '1234' , '서울' , '411234-441232', '010-1111-1111' , 30, 44.44 );


-- CHECK 제약 조건 : 컬럼의 조건에 맞는 값만 넣을 수 있게 함
drop table member4;
create table member4(
    id varchar2(50) not null CONSTRAINT PK_MEMBER4_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER4_PASS  not null,
    addr varchar2(100) null CONSTRAINT CK_MEMBER4_ADDR check (addr in ('서울', '부산', '대구')) ,
    jumin char(13) null CONSTRAINT U_MEMBER4_JUMIN UNIQUE ,
    phone varchar2(50) not null CONSTRAINT U_MEMBER4_PHONE unique,
    age number(3) CONSTRAINT CK_MEMBER4_AGE check (age > 0 and age < 200) ,
    gender char(1) CONSTRAINT CK_MEMBER4_GENDER check (gender in ('w','m')),
    weight number(5,2)
);

insert into member4 (id, pass, addr, jumin, phone, age, gender ,weight)
values ( 'abc', '1234' , '서울' , '411234-441232', '010-1111-1111' , 100, 'w' , 44.44 );
commit;


-- default : **제약조건 아님** 제약 조건 이름을 부여 할 수 있음.
        -- 값을 넣을때 임의의 값 들어가고, 값을 넣지 않을 때 defalult로 설정된 값 삽입
        
create table member5(
    id varchar2(50) not null CONSTRAINT PK_MEMBER5_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER5_PASS  not null,
    addr varchar2(100) null CONSTRAINT CK_MEMBER5_ADDR check (addr in ('서울', '부산', '대구')) ,
    jumin char(13) null CONSTRAINT U_MEMBER5_JUMIN UNIQUE ,
    phone varchar2(50) not null CONSTRAINT U_MEMBER5_PHONE unique,
    age number(3) CONSTRAINT CK_MEMBER5_AGE check (age > 0 and age < 200) ,
    gender char(1) CONSTRAINT CK_MEMBER5_GENDER check (gender in ('w','m')),
    weight number(5,2),
    hiredate date default sysdate ,
    addr2 char(10) default 'tjdnf',
    age2 number default 0
);

insert into member5 (id, pass, addr, jumin, phone, age, gender ,weight)
values ( 'abc', '1234' , '서울' , '411234-441232', '010-1111-1111' , 100, 'w' , 44.44 );
commit;

select * from member5;











