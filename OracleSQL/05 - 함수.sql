
/*
    �پ��� �Լ� ���
    1.���� ó��
    2.���� ó��
    3.��¥ ó��
    4.��ȯ �Լ�
    5.�Ϲ� �Լ�
*/

/*  
    1. ���� ó��
        - UPPER : �빮�ڷ�
        - LOWER : �ҹ��ڷ�
        - INITCAP : ù ���ڸ� �빮�ڷ�
        - LENGTH : ���ڿ��� ����
        - LENGTHB : ���ڿ��� ���̸� Byte ������ 
        - CONCAT : ���ڿ� ���� 
        - SUBSTR : ���ڿ� �ڸ���
        - INSTR : Ư�� ������ ��ġ
        - LPAD : Ư�� ���ڷ� ���� ä���(���� ����)
        - RPAD : Ư�� ���ڷ� ���� ä���(������ ����)
        - LTRIM : ������ ���� ����
        - RTRIM : �������� ���� ����
    
    dual : ������ ���̺�        
*/

SELECT Upper ('oracle') from dual;

SELECT * from employee;
SELECT ename as ����, UPPER(ename) as �빮��, Lower(ename) as �ҹ���, 
INITCAP(ename) as "ù ���ڸ� �빮��" 
from employee;

SELECT * 
from employee
where ename = 'smith' ; -- > �÷��� ��ҹ��ڸ� �����ϹǷ� �˻� �Ұ� 

SELECT * 
from employee
where ename = UPPER('smith');

SELECT LENGTH('Oracle mania') from dual;
SELECT LENGTH('����Ŭ �ŴϾ�') from dual;

SELECT LENGTHB('Oracle mania') from dual;
SELECT LENGTHB('����Ŭ �ŴϾ�') from dual;

select ename ����, Length(ename) ���ڼ�
from employee;

-- concat : ���ڿ����� ����
-- || : �÷����� ����

SELECT 'Oracle' , 'Mania' from dual;

SELECT concat ('Oracle' , 'Mania') ����� from dual;

SELECT concat ( ename, job) from employee;

SELECT ename ||'        '|| job �̸�_��å 
from employee;

-- SUBSTR : ���ڿ� �ڸ��� substr (�÷�, 4, 3) - �÷��� �����ϴ� ���ڿ� ��, 4��° �ڸ����� 3���ڸ� �ڸ���

select substr ('oracle mania', 4 , 3) from dual; -- index : 1������ ����

select ename ���� , substr (ename, 2, 3) "substr" from employee;

-- employee ���̺��� �̸�, �Ի���� ��� - 2���� �Ի��� ���

select * from employee;

select ename, substr(hiredate, 4,2) 
from employee
where substr(hiredate, 4,2) = '02';

-- 81�⿡ �Ի��� ����� �̸�, �Ի� ��,��,�� ���

select ename, substr(hiredate, 1,2) �� , substr(hiredate, 4,2) �� , substr(hiredate, 7,2) ��
from employee
where substr(hiredate, 1,2) = '81';

-- instr : Ư�� ������ index ��ȣ ���       *** index�� 1���� ���� ***
        -- instr(�÷�, 'A') : �÷����� A�� �ִ� index ��ȣ ���
        -- instr(�÷�, 'A', 4) : index 4�� ���� ���������� A�� �ִ� index ��ȣ ���
        -- ��� ���� �� 0 ���

SELECT ( instr ('oracle mania', 'a')) from dual;

SELECT ( instr ('oracle mania', 'a', 4)) from dual; -- �ε��� 4 ���ķ� a�� ��ġ�� index �˻�

select ename, instr(ename,'M')
from employee;

-- �߿� �����͸� ���߰� ���.
-- lpad : lpad(�÷�, �� ���ڿ� ����, '����') : ���鿡 '����'�� ä�� (���ʺ���)
-- rpad : rpad(�÷�, �� ���ڿ� ����, '����') : ���鿡 '����'�� ä�� (�����ʺ���)

SELECT '444112-5325634', lpad('444112-5', 20 , '*') from dual;
SELECT '444112-5325634', rpad('444112-5', 20 , '*') from dual;

select ename, rpad(substr(hiredate, 1, 2), 6, '*') from employee;

-- Rtrim : ������ ���� ����, Ltrim : ������ ���� ����, Trim : ���� ���� ����

SELECT  
        ltrim ('                 oracle                       '),
        rtrim ('                 oracle                       '),
        trim ('                 oracle                       ')
from dual;


-- ���� ���� �� ���� �빮�ڷ� ��ȯ
select * 
from employee
where ename = UPPER(ltrim ('    SMITH'));


-- 2. ���ڸ� ó���ϴ� �Լ� : ROUND : �ݿø�, Trunc : Ư�� �ڸ� ������ �߶�
                            -- MOD ������ ���� ���
                            
--  Round �ݿø� �Լ� 
        -- (�Ǽ�) : �Ҽ��� �� �ڸ����� �� �ø�
        -- (�Ǽ�, �ڸ���)
        --        - ���  : �Ҽ��� �������� ������ �̵�, �� ���� �ڸ����� �ݿø�
        --        - ����  : �Ҽ��� �������� ���� �̵�, �� ���� �ڸ����� �ݿø�

select 98.7654 as ����,
        round ( 98.7654) R1, -- ���� ������ �Ҽ��� �ڿ��� �ݿø�
        round (98.7654,2) R2,
        round (98.7654,-3) R3
        
from dual;

-- �ٷ� �ҵ� : ������ 3.3%

select salary, salary * 0.033, round (salary * 0.033),  round ((salary * 0.033), 2),
             round (salary - (salary * 0.033)) as �Ǽ��ɾ�
from employee;

-- Trunc : Ư�� �ڸ����� �߶� ���� 
 
select trunc (98.7654) T1,
        trunc (98.7654,2) T2,
         trunc (98.7654,-1) T3   
from dual;

-- mod : ������ �� , mod (n,m) n�� m���� ����
        -- Trunc���� �� ���

select mod (5523,534) ,
        Trunc (12/5)
from dual;


/*
    ��¥ �Լ�
        - sysdate : ���� �ý����� ��¥�� ���
        - months_between : �� ��¥ ������ ���� �� ���
        - add_months : Ư�� ��¥���� ���� ���� ���ؼ� ���
        - nexy_day : �־��� ��¥�� ���� n���� ��¥�� ���
        - last_day : ���� ������ ��¥�� ���
        - round (��¥) : ��¥�� �ݿø�
        - trunc (��¥) : ��¥�� ����
*/

select sysdate from dual;

-- ��¥�� ���� ����
SELECT sysdate ���糯¥, sysdate -1 ����, sysdate + 1 ���� from dual;

select sysdate -100 "100��_��" from dual;
select sysdate +1000 "1000��_��" from dual;

-- �Ի��Ͽ��� ���ó������� ����� �� ���ϱ�. date �÷�. (sysdate - hiredate)

DESCRIBE employee;

-- ����� �� = trunc (���� - �Ի���)
select ename, trunc(sysdate - hiredate)
from employee;

-- �Ի��Ϸκ��� 1000�� ������ ��¥ ���.

SELECT ename, hiredate + 1000 from employee;

-- Ư�� ��¥���� "��"�� �������� �� ���. (trunc ���)
SELECT hiredate, trunc(hiredate, 'MONTH'), round(hiredate, 'MONTH') 
from employee;

-- ���� ������ ������ ��� 
select ename , hiredate �Ի���, trunc (months_between (sysdate, hiredate)) ������
from employee;

-- 100����, 100�� ���� ��¥
select sysdate as ����, add_months(sysdate, 1000) "100����", sysdate + 100 "100d��" from dual;

-- last_day : �� ���� ������ ����
select last_day(sysdate) from dual;

-- ��� ����� �Ի� ���� ������ ��¥
select last_day(hiredate) from employee; 

/*
   ***** ���� ��ȯ �Լ� *****
        TO_CHAR : ��¥�� ������ -> ������
        TO_DATE : ���� -> ��¥
        TO_NUMBER : ���� -> ����
*/

select sysdate from dual;

--                         YYYY:�� MM:�� DD:�� HH:�� MI:�� SS:�� DAY:n���� DY:n(���� ������)
select To_char (sysdate, 'YYYY-MM-DD HH:MI:SS') from dual;

select hiredate �Ի���, TO_CHAR (hiredate, 'YYYY"��" MM DD HH:MI:SS') �Ի���2
from employee;

-- TO_CHAR
/*
    0 : �ڸ����� ó����, �ڸ����� ������ 0���� ó����
    9 : �ڸ����� ó����, �ڸ����� ������ �������� ó����
    L : �� ������ ��ȭ�� ��ȣ�� ǥ��

    . : �Ҽ������� ó��
    , : õ ���� ������
*/

SELECT TO_CHAR ( 9876,'000,000') from dual; -- 009,876
SELECT TO_CHAR ( 9876,'999,999') from dual; --   9,876

--  ���� ȭ�� ��ȣ�� �ٿ��� ǥ��

select salary ���� , to_char(salary,'L999,999') "����(�ѱ�)"
from employee;

-- TO_DATE : ����, ���� -> ��¥ �������� ��ȯ

select to_date ('1998-10-10', 'YYYY-MM-DD') from dual;

-- 1981�� 1�� 1�Ͽ��� 100��/100���� ���� ������ ��¥

select to_date ('1981-1-1', 'YYYY-MM-DD') + 100 from dual;
select add_months( to_date ('1981-1-1', 'YYYY-MM-DD') , 100) from dual;

select to_date (770114, 'YYMMDD') from dual;

-- �ڽ��� ���Ͽ��� ������� �� ����/ ��ĥ ��Ҵ��� ���.

SELECT months_between( to_date (961031, 'YYMMDD'), sysdate ) from dual;

select sysdate - to_date (961031, 'YYMMDD') from dual;

select to_date (20501224, 'YYYYMMDD') - hiredate
from employee ; 


