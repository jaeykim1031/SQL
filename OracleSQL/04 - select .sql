
/*
    select : 테이블의 값을 검색
    
    select (컬럼) form (테이블)[뷰]
    
    select * from employee

*/

-- employee 테이블의 모든 컬럼 출력

SELECT * 
from employee;

-- 특정 컬럼 출력 

select eno, ename, job
from employee;

-- 특정 컬럼 여러번 출력 가능. 컬럼에 연산 할 수 있다. 컬럼 이름이 바뀔 수 있다

SELECT eno, ename, salary, ename, ename, salary * 12
from employee;

-- 컬럼 이름을 별칭으로 바꾸고 출력하기 (as 생략 가능)

SELECT eno as 사원번호, ename as 사원명, salary 월급, salary * 12 연봉
from employee;

-- employee 테이블의 각 컬럼의 의미

SELECT * 
from employee;

SELECT eno 사원번호, ename 사원명, job 직책, manager 직속상관, hiredate 입사일, 
        salary 월급, commission 보너스, dno 부서번호
    from employee;
    
    
-- 테이블 구조 확인
-- desc 테이블명, 실제 컬럼명, null 허용 여부, 자료형 (number: 정수, 실수 varchar2 : 문자열)


DESC employee; /* 삽입시 컬럼의 자료형, NULL 허용 여부 확인 후 값을 넣음 */

SELECT * from employee;

-- 연봉 계산 : 주의 - NULL과의 연산은 결과도 NULL

select eno 사원번호, ename 사원명, salary 월급, commission 보너스
from employee;

-- 연봉 = 월급 * 12 + 보너스 ( null 컬럼과 연산하면 결과도 null - ↓ 연봉이 null로 출력 ) 
    
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
        salary * 12 + commission 연봉
from employee;

-- nvl (컬럼명, 0) : null 처리 함수, 컬럼의 값 중 null을 0으로 변환하는 함수
    
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
        nvl (commission, 0) 널처리, salary * 12 + nvl (commission, 0) 연봉
from employee;    
    
-- 컬럼과 컬럼을 연산 할 수 있다: + - * / <- number(정수, 실수) 타입
-- number : 정수 
-- number(7.2) : 실수     - 전체 7자리, 소수점 이하 2자리

select * from employee;
DESC employee; 

SELECT ename, salary, salary + salary 합연산 , salary * salary 곱연산 , salary * 0.1 "월급의10%"
from employee;

-- 중복처리 후 출력 : distinct (컬럼)

select * from employee;

select dno
from employee;

select DISTINCT dno
from employee;

-- 우리 회사의 직책만 (중복 없이)
    -- 대소문자 구분하지 않음 : 쿼리 (SELECT, create, from, group by, order by)
                            --  컬럼명, 테이블명
                            
    -- 테이블 안의 레코드의 값은 대소문자 구분함
    
SELECT job
from employee;

SELECT DISTINCT job
from employee;

-- MANAGER 사용자 정보 출력

SELECT ename 사원명, job 직책
from employee
where job = 'MANAGER';  -- <- 대문자여야함.

-- 부서 테이블 

SELECT * from department;

SELECT dno 부서번호, dname 부서명, loc 부서위치
from department;

-- salgrade : 연봉의 등급을 적용하는 테이블      <- join 구문

SELECT * from salgrade;

SELECT grade 등급, losal 가장_낮은_연봉, hisal 가장_높은_연봉
from salgrade;

-- select 문의 전체 내용, SQL : 구조화된 질의 언어

/*

select 컬럼명
from 테이블명[뷰명]
where 조건
group by 컬럼명        <- 컬럼에 동일한 값을 그루핑해서 처리
having 조건            <- group by한 결과에 대한 조건문
order by 컬럼명 ASC/DESC       <- 컬럼을 정렬하여 출력 (오름차순/내림차순)


*/

-- where 조건 사용 : 비교 연산자 (NUMBER 타입의 컬럼에서 사용) = (같다), >, <, >=, <=
    -- 같지 않다 : <>, !=, ^=
    -- or
    -- and
    -- between

select * 
from employee
where salary > 1500;

select * 
from employee
where salary = 1500;

select * 
from employee
where salary <> 1500;

-- or 연산자 

select * 
from employee
where salary = 1500 or salary = 800 or salary = 1600 ;

-- in 키워드 : in (값, 값, 값)

select * 
from employee
where salary in (1500, 800, 1600);

-- and 연산자 : 부서 번호가 10번인 사원의 연봉이 1500 이상인 사용자 출력

select * 
from employee
where dno = 10 and salary > 1500;

-- 직책이 MANAGER이면서 월급이 2000 이상인 사원의 사원 번호, 사원명, 월급을 출력

select eno 사번, ename 이름, salary 월급
from employee -- < 테이블
where job = 'MANAGER' and salary >= 2000 ;

-- 비교 연산자를 date, varchar, char에

select *
from employee
where hiredate > '81/01/01' and hiredate < '81/06/30';

-- 문자열 비교 연산자 : char, varchar, nvarchar, nchar (' ' 필요)

select *
from employee
where ename > 'D';

-- like : 문자열에서 특정 값만 검색 - % : 어떤 것이 와도 상관 없음(글자 수 무제한), 
--                                   _ : 한 글자가 어떤 것이 와도 상관 없음   
-- 컬럼의 특정 값을 검색할 때 사용
                                
select *
from employee
where ename like '%LA%';

select *
from employee
where ename like '_CO%';

-- null 검색

SELECT * from employee
-- where commission = null; <- 오류
where commission is null;

SELECT * from employee
where commission is not null;

-- count () : 레코드의 개수를 출력 - 페이징 처리
        -- null은 카운트 하지 않음 

select count(*) 총레코드수
from employee;

SELECT count(ename)
from employee;

SELECT count(commission) -- 레코드 수 : null은 출력하지 않음
from employee;

SELECT commission 수능점수 -- null : 비어있는 상태. 0점
from employee;

desc employee;

-- 전체 레코드를 정확하게 출력하려면, not null 칼럼을 count(컬럼), count(*)

-- 특정 컬럼을 정렬해서 출력 : order by (컬럼) ASC/DESC
    -- ASC : 오름차순 -> 생략 가능 ( A -> Z, ㄱ -> ㅎ, 1 -> 9)
    -- DESC : 내림차순 
    
SELECT * 
from employee
ORDER by salary ASC;    
    
SELECT * 
from employee
ORDER by salary DESC;

SELECT * 
from employee
ORDER by ename aSC;

SELECT * 
from employee
ORDER by job DESC;

-- 정렬할 컬럼을 where와 같이 사용할 때 order by는 가장 나중에 처리
SELECT * 
from employee
where salary > 1500 
ORDER by salary DESC;

-- order by에서 여러 칼럼을 정렬할 때, 앞의 칼럼을 모두 정렬하고 같은 값이 존재할 때,
    -- -> 같은 값에 대해 뒤의 칼럼을 정렬
    
SELECT dno, ename
from employee
ORDER by dno asc, ename desc;

-- job : 오름 차순. dno : job의 동일 값에 대해 dno를 오름차순. ename dno에서 동일한 값에 대해 ename을 오름차순

SELECT job, dno, ename 
from employee
ORDER by job asc, dno asc, ename ;

SELECT dno, job, ename
from employee
ORDER by dno desc, job asc, ename desc;





