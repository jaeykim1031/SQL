
-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
SELECT substr(hiredate, 1,5)
from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.
SELECT ename , hiredate
from employee
where substr(hiredate, 4,2) = '04';

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select ename, manager
from employee
where MOD (manager , 2) = '1';

-- 4. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select ename, salary
from employee
where MOD( salary , 3) = '0';

-- 5. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�.
select to_char ( hiredate , 'YY-MON-DY')
from employee;

-- 6. ���� ��ĥ�� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
   --������ ������ ��ġ ��Ű�ÿ�.
select sysdate - to_date (230101,'YYMMDD' ) from dual;
   
-- 7. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select sysdate - to_date (961031,'YYMMDD') from dual;

-- 8. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���.

SELECT months_between( to_date (961031, 'YYMMDD'), sysdate ) from dual;


-- 9. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ��� 0���� ��� �Ͻÿ�.
SELECT nvl(manager,0)
from employee;

/* 10.   �����ȣ,
      [�����ȣ 2�ڸ������ �������� *���� ] as "������ȣ", 
      �̸�, 
       [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� * ����] as "�����̸�"  */    
       
SELECT eno, rpad(substr(eno, 1,2), 4, '*' ), ename, rpad(substr(ename, 1,1),4 ,'*')
from employee;
       
       
-- 11.  �ֹι�ȣ:  �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-12*******
	--dual ���̺� ���
SELECT rpad('801210-1', 14 , '*'), rpad('010-12', 13, '*')  from dual;
    
    
-- 12 �ڽ��� ���Ͽ��� ������� ��� ��Ҵ��� ?  ��ĥ ��Ҵ��� ���   <== months_between ( ���糯¥, ����)  : ������ 
        -- sysdate - ���� (date) 
        
SELECT months_between( to_date (961031, 'YYMMDD'), sysdate ) from dual;

select sysdate - to_date (961031, 'YYMMDD') from dual;        
        
        
-- 13.  employee ���̺��� 2050�� 12�� 24 �ϱ����� ��¥(�ϼ�)  �� ��� 

select to_date (20501224, 'YYYYMMDD') - hiredate
from employee ; 





