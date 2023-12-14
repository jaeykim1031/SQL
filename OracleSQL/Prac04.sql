
-- 1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
SELECT substr(hiredate, 1,5)
from employee;

-- 2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
SELECT ename , hiredate
from employee
where substr(hiredate, 4,2) = '04';

-- 3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename, manager
from employee
where MOD (manager , 2) = '1';

-- 4. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select ename, salary
from employee
where MOD( salary , 3) = '0';

-- 5. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오.
select to_char ( hiredate , 'YY-MON-DY')
from employee;

-- 6. 올해 며칠이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
   --데이터 형식을 일치 시키시오.
select sysdate - to_date (230101,'YYMMDD' ) from dual;
   
-- 7. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select sysdate - to_date (961031,'YYMMDD') from dual;

-- 8. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.

SELECT months_between( to_date (961031, 'YYMMDD'), sysdate ) from dual;


-- 9. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 대신 0으로 출력 하시오.
SELECT nvl(manager,0)
from employee;

/* 10.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"  */    
       
SELECT eno, rpad(substr(eno, 1,2), 4, '*' ), ename, rpad(substr(ename, 1,1),4 ,'*')
from employee;
       
       
-- 11.  주민번호:  를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	--dual 테이블 사용
SELECT rpad('801210-1', 14 , '*'), rpad('010-12', 13, '*')  from dual;
    
    
-- 12 자신의 생일에서 현재까지 몇개월 살았는지 ?  며칠 살았는지 출력   <== months_between ( 현재날짜, 생일)  : 개월수 
        -- sysdate - 생일 (date) 
        
SELECT months_between( to_date (961031, 'YYMMDD'), sysdate ) from dual;

select sysdate - to_date (961031, 'YYMMDD') from dual;        
        
        
-- 13.  employee 테이블에서 2050년 12월 24 일까지의 날짜(일수)  를 출력 

select to_date (20501224, 'YYYYMMDD') - hiredate
from employee ; 





