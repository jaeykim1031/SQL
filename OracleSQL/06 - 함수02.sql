/*
    그룹 함수 : group by, having
    
    select 컬럼명
    from 테이블/뷰
    where 조건
    group by 컬럼명(동일한 값을 그루핑)
    having 조건 (group by 한 결과의 조건)
*/

/*
    집계 함수 : number 타입의 칼럼에 적용 (NULL 자동 처리됨)
    
    SUM - 컬럼의 모든 값의 합
    AVG - 평균
    MAX - 컬럼의 최대값
    MIN - 최소값
    COUNT (*) - 그루핑 된 레코드 수 출력
    
    주의 : 다른 컬럼과 사용시 오류 - 단일 행으로 출력 됨.
            단 group by 옆에 그루핑된 칼럼은 출력 가능 
*/

desc employee;

select SUM(salary), Round ( AVG(salary), 2), MAX(salary), min(salary), count(*)
from employee;

-- 집계 함수는 null 자동 처리

select SUM(commission), Round ( AVG(commission), 2), MAX(commission), min(commission), count(*)
from employee;

-- group by - 부서별 월급 합계 

select SUM(salary), count(*) 
from employee
group by dno;    -- > DNO 칼럼의 동일 값을 그루핑해서 집계 함수 적용 dno 10끼리 - 3번,
                            --                              20끼리 - 5번 , 30끼리 - 6번

select salary, dno
from employee
order by dno;

select job ,SUM(salary), Round ( AVG(salary), 2), max(salary), min(salary), count(*)
from employee
group by job;       -- job 칼럼의 동일 값을 그룹

/*
    group by에서 where vs having
    
    where = group by전에 조건 처리 - 별칭 사용 불가
    having = group by후에 조건 처리 - 별칭 사용 불가
    
    order by - 별칭 사용 가능
*/

-- 직급별로 월급의 합계 평균 최대최소값 그루핑된 수 출려,
    -- 20번 부서 제외(where), 부서별로 평균 2000이상(having)

select job, SUM(salary), Round ( AVG(salary), 2), max(salary), min(salary), count(job)
from employee
where dno != 20
having AVG(salary) >= 2000
group by job
order by AVG(salary) desc;

-- group by 절에서 컬럼이 2개 이상 -> 두 컬럼에 걸쳐서 동일한 내용을 그루핑

select job, dno 
from employee
order by job asc;

select job, dno, sum(salary), count(*)
from employee
group by job, dno;

-- 각 job에 대해서 월급의 합계 평균 최대최소값 카운트 출력
-- 입사일이 81년만, 월급의 평균이 1500 이상만, 평균을 내림차순

select SUM(salary), Round ( AVG(salary), 2), max(salary), min(salary), count(*)
from employee
where hiredate like '81%'
group by job
having AVG(salary) >= 1500
order by AVG(salary) desc;

/*
 group by에서 사용되는 키워드 
    rollup : 결과 마지막 라인에 전체 결과도 한번 더 출력
     cube : 그루핑 마지막 라인에 결과 출력, 마지막 라인에 전체 결과도 세부적 출력


*/

-- 1. rollup, cube 미사용 - 그루핑 결과만 출력

select dno, job, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary)
from employee
group by dno, job
order by count(*) desc;

select dno, job
from employee
order by dno asc;

-- 2. rollup 사용 - 그루핑한 결과, 전체 내용 출력

select dno, job, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary)
from employee
group by rollup (dno, job)
order by count(*) desc;


-- 3. cube 사용 - 그루핑한 결과, 전체 내용 출력, 세부 사항 까지

select dno, job, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary)
from employee
group by cube (dno, job)
order by count(*) desc; 

/*
    SubQuery : select문 안에 select 쿼리 
                여러 번의 작업을 한 구문에서 처리
        - where 절에서 많이 사용됨 
        
        
    ename이 SCOTT인 사원의 직책과 같은 사원들을 출력 - 두 번 쿼리가 필요함
    
    1. SCOTT의 직책을 알아오는 쿼리
    2. 알아온 직책으로 검색해 이름 출력 
*/
select ename
from employee
where ename = 'SCOTT';

select ename 
from employee
where job = 'ANALYST';

-- -> 하나의 쿼리로 처리

select ename, job
from employee
where job = (select job from employee where ename = 'ALLEN'); -- select 안의 select inner 쿼리 -> outer 쿼리

select * from employee;

-- SCOTT 과 ALLEN의 직책에 해당되지 않는 사원을 모두 출력 (삼중 쿼리)

    -- 1. SCOTT의 직책
    select job from employee where ename = 'SCOTT';
    
    -- 2. ALLEN의 직책
    select job from employee where ename = 'ALLEN';
    
    -- 3. 그 둘 모두에 해당되지 않는 것 
    --    where job not in (scott, allen job)
    select ename, job
    from employee
    where job not in ('ANALIST', 'SALESMAN');

    -- subquery
    select ename, job
    from employee
    where job not in (
        (select job from employee where ename = 'SCOTT'),
        (select job from employee where ename = 'ALLEN')
        );
    
    select ename, job
    from employee
    where job not in (
        select job from employee
        where ename = 'SCOTT' or ename = 'ALLEN'
    );

    select ename, job
    from employee
    where job not in (
        select job from employee
        where ename in('SCOTT' , 'ALLEN')
    );

-- 'SCOTT' 보다 많은 월급을 받는 사원의 정보

select ename, salary
from employee
where salary > ( select salary from employee where ename = 'SCOTT' );

select * from employee
order by salary desc;

-- 최소 급여를 받는 사원의 이름 담당업무 급여 출력

select ename, job, salary
from employee
where salary = ( select MIN(salary) from employee );

-- 부서별로 최소 급여를 받는 사원 정보의 이름 직책 월급 출력
    -- group by, dno, min, in 키워드

select ename, dno, salary
from employee
order by dno asc, salary desc;

select ename, job, salary, dno
from employee
where salary in(
        -- 각 부서별 최소 월급의 select한 값 출력 
        select MIN(salary) 
        from employee 
        group by dno
);

-- 각 부서의 최소 급여가 30번 부서의 최소 급여보다 큰 부서 출력 
select dno , count(*), min(salary)
from employee
group by dno        -- < 부서 번호 동일한 값 그루핑
having min(salary) > (
                -- 서브 쿼리 : 30번 부서의 최소 급여
                select min(salary)
                from employee
                where dno = 30
 
);






















 

