/*
    join : employee 테이블과 department 테이블은 하나의 테이블이었으나 
            모델링(정규화)을 통해 분리됨 ( R-DBMS)
    
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

    모델링의 이유 = 중복 제거, 성능 향상

*/

SELECT * from employee;             -- employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조함
SELECT * from department;

-- 테이블 복사 - 원본 테이블의 제약 조건은 복사되지 않는다, alter table을 통해 제약 조건을 부여

create TABLE emp01
as 
select * from employee;

create TABLE dept01
as
SELECT * from department;

/*
    테이블의 제약 조건 확인
    user_constraints : 데이터 사전 - 테이블의 각종 정보를 알려주는 테이블
*/

SELECT * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');


-- 테이블을 복사하면 테이블의 컬럼에 부여된 제약 조건은 복사되어 오지 않음. 컬럼 & 값만
-- alter table을 통해서 제약 조건 부여
-- alter table : 테이블 수정 명령어
select * from user_constraints
where table_name in ('EMP01', 'DEPT01');        -- < 제약 조건 없음 

-- DEPT01 테이블의 dno칼럼에 PK 제약 조건 추가
alter table DEPT01 
add CONSTRAINT PK_DEPT01_DNO PRIMARY key (dno);

-- EMP01 테이블의 eno칼럼에 PK 제약 조건 추가
alter table EMP01 
add CONSTRAINT PK_EMP01_DNO PRIMARY key (eno);

-- emp01 테이블의 dno 컬럼에 Foreign Key 부여, 참조(REFERENCES)할 테이블의 컬럼은 dept01 테이블의 dno 컬럼 참조
alter table emp01
add CONSTRAINT FK_EMP01_DNO FOREIGN key (dno) REFERENCES dept01(dno) ;

-- primary key 컬럼 확인 : 
desc emp01;

select * from emp01;




-- 값을 넣을 때(insert) 컬럼에 부여된 제약 조건을 확인 필수 

-- eno : PK가 등록되어있음. 중복된 값을 넣으면 오류
-- dno : FK가 등록되어있음. dept01 테이블의 dno컬럼에 존재하는 값만 넣어야함 - 50은 없음 

insert into emp01 (eno, ename, job, manager, hiredate, salary, commission, dno)
values ( 7977, 'KJY', 'ClERK', 7782 , '23/12/11', 1500, null, 40);  -- 무결성 제약 조건(C##HR.PK_EMP01_DNO)에 위배

 commit;  -- > DML(insert, update, delete)에서 DB에 영구히 저장되도록 함. (Oracle Only)

select * from emp01;
select * from dept01;

-- dept 테이블에 값 넣기 : dno 컬럼 - PK 있음 
desc dept01;

insert into dept01 ( dno, dname, loc)
values ( 50 , 'HR', 'SEOUL');

commit;

-- join : 여러 테이블의 컬럼을 출력할 때 join을 사용해서 하나의 테이블처럼 출력함
        -- 두 테이블의 공통 키 컬럼 확인.
        -- emp01, dept01 테이블의 공통 키 컬럼은 dno.
        -- EQUI JOIN : 오라클 only
        -- ANSI JOIN : 모든 DBMS 공통 사용

-- EQUI JOIN
    --  from 절에서 join 할 테이블 명시
    -- 테이블 이름은 별칭으로
    -- where 절에서 두 테이블의 공통 키 컬럼 명시
    -- and에서 조건 처리
    --  공통키 컬럼을 출력시 반드시 레이블명

select e.eno, e.ename, e.job, d.dno, d.dname, loc
from emp01 e, dept01 d
WHERE e.dno = d.dno;

select eno, ename, job, d.dno, dname, loc
from emp01 e, dept01 d
WHERE e.dno = d.dno
and d.dno = 10;

-- ANSI JOIN : 모든 DBMS에서 공통적으로 사용
    -- inner join : 두 테이블에서 키 컬럼에 공통되는 부분만 출력 
    -- outer join
        -- left
        -- right
        -- full

    -- SELF
    -- CLOSS
    
    
-- INNER JOIN : ANSI JOIN
        -- from  절에 join, 'inner' 생략 가능, on 절에 두 테이블의 동통의
    
-- 별칭 없음 )
select eno, ename, salary, dept01.dno, dname, loc
from emp01 inner join  dept01 
on emp01.dno = dept01.dno;


-- 별칭 사용
select eno, ename, salary, d.dno, dname, loc
from emp01 e  join dept01 d
on e.dno = d.dno
where e.dno = 20
order by ename desc;

-- ANSI : on 절에 두 테이블의 공통 분모만 출력

select * 
from emp01 e join dept01 d
on e.dno = d.dno;

-- OUTER JOIN
    -- left : 왼쪽 테이블의 모든 내용 출력
        -- 두 테이블의 공통부분과 왼쪽  
        
    -- right : 오른쪽 
        -- 두 테이블의 공통부분과 오른쪽
    --  ex) 직속 상관이 없거나 사원번호는 있짐나 
        
    -- full : 모든 테이블의 내용 출력
    
select * from dept01;
  
insert into dept01 (dno, dname, loc)
values (60, 'MANAGE', 'BUSAN');
commit;
    
select * 
from emp01 e RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;                       -- < 60, 'MANAGE', 'BUSAN' 존재함

select * 
from emp01 e LEFT OUTER JOIN dept01 d
on e.dno = d.dno;

select * 
from emp01 e FULL OUTER JOIN dept01 d
on e.dno = d.dno;

-- SELF JOIN : 자신의 테이블을 JOIN, 자신의 테이블을 임의의 이름으로 생성하여 JOIN
        -- 조직도 출력, 직급 상사 등을 출력할 때 사용
        
        
        
        -- 사원 이름에 대한 직속상사가 누구인지 출력
        -- 직속 상관이 없는 사원 출력 = left outer 
        
        
select e.eno 사번, e.ename 사원_이름, e.manager 직속상관_번호, m.eno 직속상관_사번, m.ename 직속상관
from emp01 e right join emp01 m
on e.manager = m.eno;


-- 사원 이름 SCOTT의 부서명, 부서위치 <- ename : SCOTT은 emp01 , dept01 :dname, loc


-- ANSI 

select * from emp01;
select * from dept01;

-- emp와 dept를 join 해서 출력

select *
from emp01 e join dept01 d
on e.dno = d.dno;

select ename, dmane, loc
from emp01 e join dept01 d
on e.dno = d.dno
where ename = 'SCOTT';



-- 월급이 2000만원 이상인 사원의 이름 부서명 부서 위치 월급 출력 ansi

select ename, salary, dname, loc, e.dno
from emp01 e join dept01 d
on e.dno = d.dno
where salary >= 2000
order by d.dno desc;


-- 직책(job)이 매니저인 사원의 이름, 부서 번호, 부서명, 부서위치 출력하고 사원 이름을 내림차순 정리

select job, ename, d.dno, dname, loc
from emp01 e join dept01 d
on e.dno = d.dno
where job = 'MANAGER';

/*
    VIEW : 가상의 테이블. 값을 가지지 않고 코드만 가짐
        1. 실제 테이블의 특정 컬럼만 출력할 때 (보안)
        2. 복잡한 쿼리를 만들어서 실행 - 복잡한 Join 쿼리를 단순화 

*/
drop table emp02 CASCADE CONSTRAINTS;

create table EMP02
as 
select eno, ename, salary, commission , job, hiredate, dno
from employee
where salary> 1500;

select * from emp02;

CREATE table dept02
as 
select * from department;

-- 기존의 원본 테이블 : employee -> emp01 / department -> dept01
    -- 필드명, 값만 복사 
    -- 컬럼에 부여된 제약 조건은 복사되지 않음 - alter table을 통해 제약 조건 복사 
    
select * from user_constraints where table_name in ('EMPLOYEE', 'DEPARTMENT');   
select * from user_constraints where table_name in ('EMP02', 'DEPT02'); 

-- DEPT02 테이블의 dno(PK)
-- EMP02 테이블의 eno(PK), dno(FK) -> dept02 (dno)

alter table DEPT02
add CONSTRAINT PK_DEPT02_DNO PRIMARY key (dno);

alter table EMP02
add CONSTRAINT PK_EMP02_ENO PRIMARY key (eno);

alter table EMP02
add CONSTRAINT FK_EMP02_DNO FOREIGN key (dno) REFERENCES dept02(dno);

-- VIEW 생성 
    -- as 다음에 select 코드 가지고 있음 


create view v_emp02
as
select ename, job, dno          -- 실제 테이블의 값을 가지는 것이 아닌 실행 코드만 소유 값 없음 
from emp02;

select * from v_emp02;  
/*
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##HR"."V_EMP02" ("ENAME", "JOB", "DNO") AS 
  select ename, job,dno
from emp02;
*/

-- 데이터 사전 : user_테이블 <- 시스템의 정보가 저장되어있는 테이블

select * from user_views; 

-- 사용의 편의성 : 복잡한 구문을 view로 생성해서 실행

--    두 테이블을 조인해서 월급이 2500 이상인 사원 정보 출력
create view v_join
as
SELECT ename, job , salary, dname, loc
from emp02 e 
    join dept02 d
        on e.dno = d.dno
where salary >= 2500;

select * from v_join;

-- employee, department 테이블의 부서별로 최소 월급을 받는 사원 이름, 직책, 부서명, 부서위치 
    -- 20번 부서 제외, 최소 월급이 1500 이상인 사원 정보
    -- 뷰 안에 쿼리를 저장하고 뷰를 실행해서 출력
create view v_join2
as
select ename, job, dname, loc, d.dno
from employee e
    join department d
        on e.dno = d.dno
where salary in (
        select min(salary) from employee        -- 부서별 최소 월급 
        where dno <> 20 
        group by dno 
        having min(salary) > 900                      
);

select * from v_join2;



-- view 주의사항

create view v_join3
as
select ename, job, dname, loc, d.dno
from employee e
    join department d
        on e.dno = d.dno
where salary in (
        select min(salary) from employee        -- 부서별 최소 월급 
        where dno <> 20 
        group by dno 
        having min(salary) > 900                      
)
order by ename desc;

select * from v_join3;

---     view를 통해 값 삽입, 수정         -----

create view v_test01
as
select eno, ename, dno
from emp02;

select *from v_test01;

insert into v_test01 (eno, ename, dno)
VALUES (8080,'kim',30);

commit;

-- 수정 -- 
update v_test01
set ename = 'LEE'
where eno = 8080;

-- 삭제 -- 
delete v_test01
where eno = '8080';

-- v_test02 : insert가 안 됨 (dno 칼럼(- PK)이 명시되어 있지 않기 때문, update/delete 가능
create view v_test02
as
select eno, ename, salary
from emp02;

insert into v_test02 (eno ,ename, salary)
values (9090,'Park', 3500);

delete v_test02
where eno = '9090';
commit;

















