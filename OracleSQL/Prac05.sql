--��� ����� �Ҽ��� 2�ڸ����� ����ϵ� �ݿø� �ؼ� ��� �Ͻÿ�. 


--1.  10 �� �μ��� �����ϰ� �� �μ��� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�. �μ���ȣ�� �������� ���� �ϼ���.  
select sum (salary), round (avg(salary) , 2), max(salary), min(salary), dno , count(*)
from employee
where dno != 10
group by dno
order by dno ;

-- 2.  ��å�� SALSMAN, PRESIDENT, CLERK �� ������ '''�� �μ���''' ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�.   	
select sum (salary), round (avg(salary) , 2), max(salary), min(salary)
from employee
where job not in ('SALESMAN', 'PRESIDENT', 'CLERK')
group by dno;

-- 3. SMITH �� ������ �μ��� �ٹ��ϴ� ����� �� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�. 
select dno, sum (salary), round (avg(salary) , 2), max(salary), min(salary)
from employee
where job = (select job 
            from employee
            where ename = 'SMITH')   -- �繫�� ���� 
group by dno;

-- 4. group by - �μ��� �ּҿ����� �������� �ּҿ����� 1000 �̻��� �͸� ����ϼ���. 
select min(salary) , dno
from employee
group by dno
having min(salary) >= 1000 ;

-- 5. group by - �μ��� ������ �հ谡 9000 �̻�͸� ���
select sum (salary) , dno
from employee
group by dno
having sum(salary) >= 9000;

-- 6. group by - �μ��� ������ ����� 2000 �̻� ��� �ϵ� �μ���ȣ��  ������������ ���
select round (avg(salary) , 2), dno
from employee
group by dno
having round (avg(salary) , 2) >= 2000
order by dno;

-- 7. group by - ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ��� �϶�. 
select round (avg(salary) , 2), dno
from employee
where salary > 1500
group by dno
having round (avg(salary) , 2) >= 2500;

-- 8. sub query - �μ����� �ּ� �޿��� �޴� ������� �̸��� �޿��� ��å�� �μ���ȣ�� ����ϼ���. 
select ename, salary, job, dno
from employee
where salary in ( select min(salary) -- �μ��� �ּ� ���� 
                 from employee
                 group by dno
                );

-- 9. sub query - ��ü ��� �޿����� ���� �޴� �������  �̸��� �޿��� ��å�� �μ���ȣ�� ����ϼ���. 

select ename, salary, job, dno
from employee
where salary > ( select round (avg(salary) ,2)-- ��ü ��� 
                 from employee
);

select avg(salary)
                 from employee;


--10. sub query - �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� 
--                 ����� �޿��� ���� �������� �����Ͻÿ�. 

select ename, eno
from employee
where salary > ( select avg(salary)
                 from employee

)
order by salary;


