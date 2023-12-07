
/*
    다양한 함수 사용
    1.문자 처리
    2.숫자 처리
    3.날짜 처리
    4.변환 함수
    5.일반 함수
*/

/*  
    1. 문자 처리
        - UPPER : 대문자로
        - LOWER : 소문자로
        - INITCAP : 첫 글자만 대문자로
        - LENGTH : 문자열의 길이
        - LENGTHB : 문자열의 길이를 Byte 단위로 
        - CONCAT : 문자열 연결 
        - SUBSTR : 문자열 자르기
        - INSTR : 특정 문자의 위치
        - LPAD : 특정 문자로 공백 채우기(왼쪽 부터)
        - RPAD : 특정 문자로 공백 채우기(오른쪽 부터)
        - LTRIM : 왼쪽의 공백 제거
        - RTRIM : 오른쪽의 공백 제거
    
    dual : 가상의 테이블        
*/

SELECT Upper ('oracle') from dual;

SELECT * from employee;
SELECT ename as 원본, UPPER(ename) as 대문자, Lower(ename) as 소문자, 
INITCAP(ename) as "첫 글자만 대문자" 
from employee;

SELECT * 
from employee
where ename = 'smith' ; -- > 컬럼은 대소문자를 구별하므로 검색 불가 

SELECT * 
from employee
where ename = UPPER('smith');

SELECT LENGTH('Oracle mania') from dual;
SELECT LENGTH('오라클 매니아') from dual;

SELECT LENGTHB('Oracle mania') from dual;
SELECT LENGTHB('오라클 매니아') from dual;

select ename 원본, Length(ename) 글자수
from employee;

-- concat : 문자열끼리 연결
-- || : 컬럼끼리 연결

SELECT 'Oracle' , 'Mania' from dual;

SELECT concat ('Oracle' , 'Mania') 연결됨 from dual;

SELECT concat ( ename, job) from employee;

SELECT ename ||'        '|| job 이름_직책 
from employee;

-- SUBSTR : 문자열 자르기 substr (컬럼, 4, 3) - 컬럼에 존재하는 문자열 중, 4번째 자리에서 3글자를 자르기

select substr ('oracle mania', 4 , 3) from dual; -- index : 1번부터 시작

select ename 원본 , substr (ename, 2, 3) "substr" from employee;

-- employee 테이블에서 이름, 입사월만 출력 - 2월에 입사한 사람

select * from employee;

select ename, substr(hiredate, 4,2) 
from employee
where substr(hiredate, 4,2) = '02';

-- 81년에 입사한 사원의 이름, 입사 년,월,일 출력

select ename, substr(hiredate, 1,2) 년 , substr(hiredate, 4,2) 월 , substr(hiredate, 7,2) 일
from employee
where substr(hiredate, 1,2) = '81';

-- instr : 특정 문자의 index 번호 출력       *** index는 1부터 시작 ***
        -- instr(컬럼, 'A') : 컬럼에서 A가 있는 index 번호 출력
        -- instr(컬럼, 'A', 4) : index 4번 부터 오른쪽으로 A가 있는 index 번호 출력
        -- 결과 없을 시 0 출력

SELECT ( instr ('oracle mania', 'a')) from dual;

SELECT ( instr ('oracle mania', 'a', 4)) from dual; -- 인덱스 4 이후로 a가 위치한 index 검색

select ename, instr(ename,'M')
from employee;

-- 중요 데이터를 감추고 출력.
-- lpad : lpad(컬럼, 총 문자열 길이, '문자') : 공백에 '문자'를 채움 (왼쪽부터)
-- rpad : rpad(컬럼, 총 문자열 길이, '문자') : 공백에 '문자'를 채움 (오른쪽부터)

SELECT '444112-5325634', lpad('444112-5', 20 , '*') from dual;
SELECT '444112-5325634', rpad('444112-5', 20 , '*') from dual;

select ename, rpad(substr(hiredate, 1, 2), 6, '*') from employee;

-- Rtrim : 오른쪽 공백 제거, Ltrim : 왼쪽의 공백 제거, Trim : 공백 전부 제거

SELECT  
        ltrim ('                 oracle                       '),
        rtrim ('                 oracle                       '),
        trim ('                 oracle                       ')
from dual;


-- 공백 제거 후 값을 대문자로 변환
select * 
from employee
where ename = UPPER(ltrim ('    SMITH'));


-- 2. 숫자를 처리하는 함수 : ROUND : 반올림, Trunc : 특정 자리 수에서 잘라냄
                            -- MOD 나머지 값만 출력
                            
--  Round 반올림 함수 
        -- (실수) : 소수점 뒷 자리에서 반 올림
        -- (실수, 자리수)
        --        - 양수  : 소수점 기준으로 오른쪽 이동, 그 다음 자리에서 반올림
        --        - 음수  : 소수점 기준으로 왼쪽 이동, 그 다음 자리에서 반올림

select 98.7654 as 원본,
        round ( 98.7654) R1, -- 숫자 생략시 소수점 뒤에서 반올림
        round (98.7654,2) R2,
        round (98.7654,-3) R3
        
from dual;

-- 근로 소득 : 월급의 3.3%

select salary, salary * 0.033, round (salary * 0.033),  round ((salary * 0.033), 2),
             round (salary - (salary * 0.033)) as 실수령액
from employee;

-- Trunc : 특정 자리에서 잘라내 버림 
 
select trunc (98.7654) T1,
        trunc (98.7654,2) T2,
         trunc (98.7654,-1) T3   
from dual;

-- mod : 나머지 값 , mod (n,m) n을 m으로 나눔
        -- Trunc으로 몫만 출력

select mod (5523,534) ,
        Trunc (12/5)
from dual;


/*
    날짜 함수
        - sysdate : 현재 시스템의 날짜를 출력
        - months_between : 두 날짜 사이의 개월 수 출력
        - add_months : 특정 날짜에서 개월 수를 더해서 출력
        - nexy_day : 주어진 날짜의 다음 n요일 날짜를 출력
        - last_day : 달의 마지막 날짜를 출력
        - round (날짜) : 날짜를 반올림
        - trunc (날짜) : 날짜를 버림
*/

select sysdate from dual;

-- 날짜에 연산 가능
SELECT sysdate 현재날짜, sysdate -1 어제, sysdate + 1 내일 from dual;

select sysdate -100 "100일_전" from dual;
select sysdate +1000 "1000일_후" from dual;

-- 입사일에서 오늘날까지의 출근일 수 구하기. date 컬럼. (sysdate - hiredate)

DESCRIBE employee;

-- 출근일 수 = trunc (오늘 - 입사일)
select ename, trunc(sysdate - hiredate)
from employee;

-- 입사일로부터 1000일 시점의 날짜 출력.

SELECT ename, hiredate + 1000 from employee;

-- 특정 날짜에서 "월"을 기준으로 만 출력. (trunc 사용)
SELECT hiredate, trunc(hiredate, 'MONTH'), round(hiredate, 'MONTH') 
from employee;

-- 현재 까지의 개월수 출력 
select ename , hiredate 입사일, trunc (months_between (sysdate, hiredate)) 개월수
from employee;

-- 100개월, 100일 후의 날짜
select sysdate as 오늘, add_months(sysdate, 1000) "100개월", sysdate + 100 "100d일" from dual;

-- last_day : 그 달의 마지막 날까
select last_day(sysdate) from dual;

-- 모든 사원의 입사 월의 마지막 날짜
select last_day(hiredate) from employee; 

/*
   ***** 형식 변환 함수 *****
        TO_CHAR : 날짜형 숫자형 -> 문자형
        TO_DATE : 문자 -> 날짜
        TO_NUMBER : 문자 -> 숫자
*/

select sysdate from dual;

--                         YYYY:년 MM:월 DD:일 HH:시 MI:분 SS:초 DAY:n요일 DY:n(요일 생략됨)
select To_char (sysdate, 'YYYY-MM-DD HH:MI:SS') from dual;

select hiredate 입사일, TO_CHAR (hiredate, 'YYYY"년" MM DD HH:MI:SS') 입사일2
from employee;

-- TO_CHAR
/*
    0 : 자릿수를 처리함, 자릿수가 많으면 0으로 처리함
    9 : 자릿수를 처리함, 자릿수가 많으면 공백으로 처리함
    L : 각 지역의 통화를 기호로 표기

    . : 소수점으로 처리
    , : 천 단위 구분자
*/

SELECT TO_CHAR ( 9876,'000,000') from dual; -- 009,876
SELECT TO_CHAR ( 9876,'999,999') from dual; --   9,876

--  지역 화폐 기호를 붙여서 표현

select salary 월급 , to_char(salary,'L999,999') "월급(한국)"
from employee;

-- TO_DATE : 문자, 숫자 -> 날짜 형식으로 변환

select to_date ('1998-10-10', 'YYYY-MM-DD') from dual;

-- 1981년 1월 1일에서 100일/100개월 지난 시점의 날짜

select to_date ('1981-1-1', 'YYYY-MM-DD') + 100 from dual;
select add_months( to_date ('1981-1-1', 'YYYY-MM-DD') , 100) from dual;

select to_date (770114, 'YYMMDD') from dual;

-- 자신의 생일에서 현재까지 몇 개월/ 며칠 살았는지 출력.

SELECT months_between( to_date (961031, 'YYMMDD'), sysdate ) from dual;

select sysdate - to_date (961031, 'YYMMDD') from dual;

select to_date (20501224, 'YYYYMMDD') - hiredate
from employee ; 


