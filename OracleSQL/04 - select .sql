
/*
    select : ���̺��� ���� �˻�
    
    select (�÷�) form (���̺�)[��]
    
    select * from employee

*/

-- employee ���̺��� ��� �÷� ���

SELECT * 
from employee;

-- Ư�� �÷� ��� 

select eno, ename, job
from employee;

-- Ư�� �÷� ������ ��� ����. �÷��� ���� �� �� �ִ�. �÷� �̸��� �ٲ� �� �ִ�

SELECT eno, ename, salary, ename, ename, salary * 12
from employee;

-- �÷� �̸��� ��Ī���� �ٲٰ� ����ϱ� (as ���� ����)

SELECT eno as �����ȣ, ename as �����, salary ����, salary * 12 ����
from employee;

-- employee ���̺��� �� �÷��� �ǹ�

SELECT * 
from employee;

SELECT eno �����ȣ, ename �����, job ��å, manager ���ӻ��, hiredate �Ի���, 
        salary ����, commission ���ʽ�, dno �μ���ȣ
    from employee;
    
    
-- ���̺� ���� Ȯ��
-- desc ���̺��, ���� �÷���, null ��� ����, �ڷ��� (number: ����, �Ǽ� varchar2 : ���ڿ�)


DESC employee; /* ���Խ� �÷��� �ڷ���, NULL ��� ���� Ȯ�� �� ���� ���� */

SELECT * from employee;

-- ���� ��� : ���� - NULL���� ������ ����� NULL

select eno �����ȣ, ename �����, salary ����, commission ���ʽ�
from employee;

-- ���� = ���� * 12 + ���ʽ� ( null �÷��� �����ϸ� ����� null - �� ������ null�� ��� ) 
    
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
        salary * 12 + commission ����
from employee;

-- nvl (�÷���, 0) : null ó�� �Լ�, �÷��� �� �� null�� 0���� ��ȯ�ϴ� �Լ�
    
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
        nvl (commission, 0) ��ó��, salary * 12 + nvl (commission, 0) ����
from employee;    
    
-- �÷��� �÷��� ���� �� �� �ִ�: + - * / <- number(����, �Ǽ�) Ÿ��
-- number : ���� 
-- number(7.2) : �Ǽ�     - ��ü 7�ڸ�, �Ҽ��� ���� 2�ڸ�

select * from employee;
DESC employee; 

SELECT ename, salary, salary + salary �տ��� , salary * salary ������ , salary * 0.1 "������10%"
from employee;

-- �ߺ�ó�� �� ��� : distinct (�÷�)

select * from employee;

select dno
from employee;

select DISTINCT dno
from employee;

-- �츮 ȸ���� ��å�� (�ߺ� ����)
    -- ��ҹ��� �������� ���� : ���� (SELECT, create, from, group by, order by)
                            --  �÷���, ���̺��
                            
    -- ���̺� ���� ���ڵ��� ���� ��ҹ��� ������
    
SELECT job
from employee;

SELECT DISTINCT job
from employee;

-- MANAGER ����� ���� ���

SELECT ename �����, job ��å
from employee
where job = 'MANAGER';  -- <- �빮�ڿ�����.

-- �μ� ���̺� 

SELECT * from department;

SELECT dno �μ���ȣ, dname �μ���, loc �μ���ġ
from department;

-- salgrade : ������ ����� �����ϴ� ���̺�      <- join ����

SELECT * from salgrade;

SELECT grade ���, losal ����_����_����, hisal ����_����_����
from salgrade;

-- select ���� ��ü ����, SQL : ����ȭ�� ���� ���

/*

select �÷���
from ���̺��[���]
where ����
group by �÷���        <- �÷��� ������ ���� �׷����ؼ� ó��
having ����            <- group by�� ����� ���� ���ǹ�
order by �÷��� ASC/DESC       <- �÷��� �����Ͽ� ��� (��������/��������)


*/

-- where ���� ��� : �� ������ (NUMBER Ÿ���� �÷����� ���) = (����), >, <, >=, <=
    -- ���� �ʴ� : <>, !=, ^=
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

-- or ������ 

select * 
from employee
where salary = 1500 or salary = 800 or salary = 1600 ;

-- in Ű���� : in (��, ��, ��)

select * 
from employee
where salary in (1500, 800, 1600);

-- and ������ : �μ� ��ȣ�� 10���� ����� ������ 1500 �̻��� ����� ���

select * 
from employee
where dno = 10 and salary > 1500;

-- ��å�� MANAGER�̸鼭 ������ 2000 �̻��� ����� ��� ��ȣ, �����, ������ ���

select eno ���, ename �̸�, salary ����
from employee -- < ���̺�
where job = 'MANAGER' and salary >= 2000 ;

-- �� �����ڸ� date, varchar, char��

select *
from employee
where hiredate > '81/01/01' and hiredate < '81/06/30';

-- ���ڿ� �� ������ : char, varchar, nvarchar, nchar (' ' �ʿ�)

select *
from employee
where ename > 'D';

-- like : ���ڿ����� Ư�� ���� �˻� - % : � ���� �͵� ��� ����(���� �� ������), 
--                                   _ : �� ���ڰ� � ���� �͵� ��� ����   
-- �÷��� Ư�� ���� �˻��� �� ���
                                
select *
from employee
where ename like '%LA%';

select *
from employee
where ename like '_CO%';

-- null �˻�

SELECT * from employee
-- where commission = null; <- ����
where commission is null;

SELECT * from employee
where commission is not null;

-- count () : ���ڵ��� ������ ��� - ����¡ ó��
        -- null�� ī��Ʈ ���� ���� 

select count(*) �ѷ��ڵ��
from employee;

SELECT count(ename)
from employee;

SELECT count(commission) -- ���ڵ� �� : null�� ������� ����
from employee;

SELECT commission �������� -- null : ����ִ� ����. 0��
from employee;

desc employee;

-- ��ü ���ڵ带 ��Ȯ�ϰ� ����Ϸ���, not null Į���� count(�÷�), count(*)

-- Ư�� �÷��� �����ؼ� ��� : order by (�÷�) ASC/DESC
    -- ASC : �������� -> ���� ���� ( A -> Z, �� -> ��, 1 -> 9)
    -- DESC : �������� 
    
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

-- ������ �÷��� where�� ���� ����� �� order by�� ���� ���߿� ó��
SELECT * 
from employee
where salary > 1500 
ORDER by salary DESC;

-- order by���� ���� Į���� ������ ��, ���� Į���� ��� �����ϰ� ���� ���� ������ ��,
    -- -> ���� ���� ���� ���� Į���� ����
    
SELECT dno, ename
from employee
ORDER by dno asc, ename desc;

-- job : ���� ����. dno : job�� ���� ���� ���� dno�� ��������. ename dno���� ������ ���� ���� ename�� ��������

SELECT job, dno, ename 
from employee
ORDER by job asc, dno asc, ename ;

SELECT dno, job, ename
from employee
ORDER by dno desc, job asc, ename desc;





