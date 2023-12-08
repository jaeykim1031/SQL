/*
    �׷� �Լ� : group by, having
    
    select �÷���
    from ���̺�/��
    where ����
    group by �÷���(������ ���� �׷���)
    having ���� (group by �� ����� ����)
*/

/*
    ���� �Լ� : number Ÿ���� Į���� ���� (NULL �ڵ� ó����)
    
    SUM - �÷��� ��� ���� ��
    AVG - ���
    MAX - �÷��� �ִ밪
    MIN - �ּҰ�
    COUNT (*) - �׷��� �� ���ڵ� �� ���
    
    ���� : �ٸ� �÷��� ���� ���� - ���� ������ ��� ��.
            �� group by ���� �׷��ε� Į���� ��� ���� 
*/

desc employee;

select SUM(salary), Round ( AVG(salary), 2), MAX(salary), min(salary), count(*)
from employee;

-- ���� �Լ��� null �ڵ� ó��

select SUM(commission), Round ( AVG(commission), 2), MAX(commission), min(commission), count(*)
from employee;

-- group by - �μ��� ���� �հ� 

select SUM(salary), count(*) 
from employee
group by dno;    -- > DNO Į���� ���� ���� �׷����ؼ� ���� �Լ� ���� dno 10���� - 3��,
                            --                              20���� - 5�� , 30���� - 6��

select salary, dno
from employee
order by dno;

select job ,SUM(salary), Round ( AVG(salary), 2), max(salary), min(salary), count(*)
from employee
group by job;       -- job Į���� ���� ���� �׷�

/*
    group by���� where vs having
    
    where = group by���� ���� ó�� - ��Ī ��� �Ұ�
    having = group by�Ŀ� ���� ó�� - ��Ī ��� �Ұ�
    
    order by - ��Ī ��� ����
*/

-- ���޺��� ������ �հ� ��� �ִ��ּҰ� �׷��ε� �� ���,
    -- 20�� �μ� ����(where), �μ����� ��� 2000�̻�(having)

select job, SUM(salary), Round ( AVG(salary), 2), max(salary), min(salary), count(job)
from employee
where dno != 20
having AVG(salary) >= 2000
group by job
order by AVG(salary) desc;

-- group by ������ �÷��� 2�� �̻� -> �� �÷��� ���ļ� ������ ������ �׷���

select job, dno 
from employee
order by job asc;

select job, dno, sum(salary), count(*)
from employee
group by job, dno;

-- �� job�� ���ؼ� ������ �հ� ��� �ִ��ּҰ� ī��Ʈ ���
-- �Ի����� 81�⸸, ������ ����� 1500 �̻�, ����� ��������

select SUM(salary), Round ( AVG(salary), 2), max(salary), min(salary), count(*)
from employee
where hiredate like '81%'
group by job
having AVG(salary) >= 1500
order by AVG(salary) desc;

/*
 group by���� ���Ǵ� Ű���� 
    rollup : ��� ������ ���ο� ��ü ����� �ѹ� �� ���
     cube : �׷��� ������ ���ο� ��� ���, ������ ���ο� ��ü ����� ������ ���


*/

-- 1. rollup, cube �̻�� - �׷��� ����� ���

select dno, job, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary)
from employee
group by dno, job
order by count(*) desc;

select dno, job
from employee
order by dno asc;

-- 2. rollup ��� - �׷����� ���, ��ü ���� ���

select dno, job, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary)
from employee
group by rollup (dno, job)
order by count(*) desc;


-- 3. cube ��� - �׷����� ���, ��ü ���� ���, ���� ���� ����

select dno, job, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary)
from employee
group by cube (dno, job)
order by count(*) desc; 

/*
    SubQuery : select�� �ȿ� select ���� 
                ���� ���� �۾��� �� �������� ó��
        - where ������ ���� ���� 
        
        
    ename�� SCOTT�� ����� ��å�� ���� ������� ��� - �� �� ������ �ʿ���
    
    1. SCOTT�� ��å�� �˾ƿ��� ����
    2. �˾ƿ� ��å���� �˻��� �̸� ��� 
*/
select ename
from employee
where ename = 'SCOTT';

select ename 
from employee
where job = 'ANALYST';

-- -> �ϳ��� ������ ó��

select ename, job
from employee
where job = (select job from employee where ename = 'ALLEN'); -- select ���� select inner ���� -> outer ����

select * from employee;

-- SCOTT �� ALLEN�� ��å�� �ش���� �ʴ� ����� ��� ��� (���� ����)

    -- 1. SCOTT�� ��å
    select job from employee where ename = 'SCOTT';
    
    -- 2. ALLEN�� ��å
    select job from employee where ename = 'ALLEN';
    
    -- 3. �� �� ��ο� �ش���� �ʴ� �� 
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

-- 'SCOTT' ���� ���� ������ �޴� ����� ����

select ename, salary
from employee
where salary > ( select salary from employee where ename = 'SCOTT' );

select * from employee
order by salary desc;

-- �ּ� �޿��� �޴� ����� �̸� ������ �޿� ���

select ename, job, salary
from employee
where salary = ( select MIN(salary) from employee );

-- �μ����� �ּ� �޿��� �޴� ��� ������ �̸� ��å ���� ���
    -- group by, dno, min, in Ű����

select ename, dno, salary
from employee
order by dno asc, salary desc;

select ename, job, salary, dno
from employee
where salary in(
        -- �� �μ��� �ּ� ������ select�� �� ��� 
        select MIN(salary) 
        from employee 
        group by dno
);

-- �� �μ��� �ּ� �޿��� 30�� �μ��� �ּ� �޿����� ū �μ� ��� 
select dno , count(*), min(salary)
from employee
group by dno        -- < �μ� ��ȣ ������ �� �׷���
having min(salary) > (
                -- ���� ���� : 30�� �μ��� �ּ� �޿�
                select min(salary)
                from employee
                where dno = 30
 
);






















 

