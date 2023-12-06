
-- ���� 1 commission(���ʽ�) �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�,�Ի糯¥�� ���
SELECT eno, ename, hiredate
from employee
where commission is null;

-- ���� 2 dno(�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
SELECT ename, job, hiredate
from employee
where dno = 20 and hiredate > '81/4/1';

SELECT ename, job, hiredate
from employee
where dno = 20 and hiredate like '81/%';

-- <����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
SELECT eno �����ȣ , ename ����̸� , salary ����, nvl(commission, 0) ���ʽ� , salary * 12 + nvl(commission, 0) ��ü���� 
from employee;

SELECT eno �����ȣ , ename ����̸� , salary ����, nvl(commission, 0) ���ʽ� , salary * 12 + nvl(commission, 0) ��ü���� 
from employee
where salary * 12 + nvl(commission, 0) > 30000;

-- <����4> commission�� null �� �ƴ� ������� �̸��� ��� 
SELECT ename 
from employee
where commission is not null;

-- <����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
SELECT ename, job, manager
from employee
where manager = 7698;

-- <����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥, �μ���ȣ, ������ ���
select ename, hiredate, dno, salary
from employee
where salary >= 1500 and dno = 20;

-- <����7> �Ի糯¥�� 81�� 4�� 1�� �̻��̰� 81�� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
        -- between A and B : A�� B ����
select ename, hiredate
from employee
WHERE hiredate >= '81/4/1' and hiredate <= '81/12/31';

select ename, hiredate
from employee
WHERE hiredate BETWEEN '81/4/1' and '81/12/31';

select ename, hiredate
from employee
WHERE hiredate like '81%';

-- <����8> ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���
SELECT ename
from employee
where job = 'SALESMAN' and salary >= 1500 and dno = 30 ;

-- <����9> ������ 1500 �����̸鼭 �μ���ȣ�� 20�� �� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���

SELECT ename, salary, dno
from employee
where salary <= 1500 and dno != 20 ;

-- <����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ��� 

select dno ename, job
from employee
where eno = 7788 or eno = 7782;

-- <����11> ������ [SALESMAN]�� �ƴ� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno, ename, job, salary
from employee
where job <> 'SALESMAN';        -- <>, !=, ^=

-- <����12> �޿��� [2000]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno, ename, job, salary
from employee
where salary >= 2000 ;

-- <����13> ����̸��� [A],[B],[C]�� ���۵Ǵ� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno, ename, job, salary
from employee
where ename like 'A%' or ename like 'B%' or ename like 'C%';

select eno, ename, job, salary
from employee
where ename < 'D' ;

-- <����14> [1981�� 5�� 1��]������ �Ի��� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�

select eno, ename, job, salary, hiredate
from employee
where hiredate <= '81/5/1';

-- <����15> ������ [SALESMAN]�� ��� �� �޿��� [1500]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno, ename, job, salary
from employee
where job = 'SALESMAN' and salary >= 1500;

-- <����16> �μ���ȣ�� [10]�̰ų� ������ [MANAGER]�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ �˻�

select eno, ename, job, salary, dno
from employee
where dno = 10 or job = 'MANAGER';

-- <����17> �޿��� [1000~3000]�� ����� �����ȣ,����̸�,����,�޿� �˻�

select eno, ename, job, salary
from employee
where salary >= 1000 and salary <= 3000;

select eno, ename, job, salary
from employee
where  salary between 1000 and 3000;

