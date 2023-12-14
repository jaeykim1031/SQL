-- 1. �����ȣ(eno)�� 7788�� ����� �̸�(ename)�� �μ���ȣ(dno)�� ����ϼ���.  �÷����� ��Ī(alias) ���Ѽ� ��� �ϼ���.
select ename �̸�, dno �μ���ȣ
from employee
where eno = 7788;

-- 2. 1981�⵵ �Ի��� ����� �̸�(ename)�� �Ի���(hiredate) �� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ���: _ , %)
select ename �̸�, hiredate �Ի���
from employee
where hiredate like '81/%'; 

/*
3. ��� ����(job) �� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭 
    �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�.
*/
select ename �̸�, job ������, salary �޿� 
from employee
where job in ('CLERK' , 'SALESMAN') 
and salary not in (1600, 950, 1300);

/*
4. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
    �Ҽ����� �߶� ��� �ϼ��� . (months_between , trunc �Լ� ���)
*/

SELECT trunc( months_between( to_date (961031, 'YYMMDD'), sysdate ), 0 ) ����_����_�� from dual;


/*
5. �μ���(dno) ������ ����� 2000 �̻� ��� �ϵ� �μ���ȣ(dno)��  ������������ ����ϼ���.
    ����� �Ҽ����� 2�ڸ������� ����ϵ� �ݿø��ؼ� ��� �ϼ���.
*/

select round (avg(salary) , 2) ���_����, dno �μ�_��ȣ
from employee
group by dno
having round (avg(salary) , 2) >= 2000
order by dno;

/*
6. �޿��� ��� �޿����� ���� ������� �����ȣ(eno)�� �̸�(ename)�� ǥ���ϵ� ����� 
    �޿�(salary) �� ���� �������� �����Ͻÿ�. subquery�� ����ؼ� ��� �ϼ���.
*/

select eno �����ȣ,  ename �̸� 
from employee
where salary > ( select round (avg(salary) ,2)
                 from employee
)
order by salary;

/*
7. ��å(job) �� 'MANAGER' �� ����̸�(ename), �μ���ȣ(dno), �μ���(dname),
    �μ���ġ(loc) ����ϵ� ����̸�(ename) �������� �����ϼ���.
*/

SELECT e.ename ����̸�, e.dno �μ���ȣ, d.dname �μ���, d.loc �μ���ġ 
from employee e 
    join department d
on e.dno = d.dno
where e.job = 'MANAGER'
order by e.ename DESC;

/*
8. ������ ������ ������ view �� �����ؼ� �ܼ�ȭ�ϰ� view�� �����Ͻÿ� . 
    ��(view) �� :  v_join 
    
    employee, department ���̺��� '�μ�����' �ּ� ������ �޴� ����̸�(ename), ����� ��å (job), �μ���(dname), �μ���ġ (loc) �� ����ϵ�
    �ּҿ����� 900�̻� �� ����ϼ���. ��, �μ���ȣ 20���� �����ϰ� ����ϼ���. 
*/

create view v_join
as
SELECT e.ename ����̸�, e.job �����å, d.dname �μ���, d.loc �μ���ġ
from employee e
    join department d
        on e.dno = d.dno
        
where salary in (
    select min(salary)
    from employee
    where dno <> 20
    group by dno 
    having min(salary) > 900
);

select * from v_join;

/*
9. ���̺� ����� alter table �� ����Ͽ� ������ ���� ���̺�� ���� ���� ������ �߰� �Ͻÿ� 
   employee ���̺��� ��� �÷��� ���� �����Ͽ� EMP50 ���̺��� �����Ͻÿ�
   department ���̺��� ��� �÷��� ���� �����Ͽ� DEPT50 ���̺��� �����Ͻÿ�. 
   ���� ���̺� �ο��� ���������� ����� ���̺��� �ο� �Ͻÿ� . 
*/

create table EMP50
as
SELECT *
from employee;

create table DEPT50
as
SELECT *
from department;

alter table emp50
add CONSTRAINT PK_EMP50_ENO PRIMARY key (eno);

alter table dept50
add CONSTRAINT PK_DEPT50_DNO PRIMARY key (dno);

alter table emp50
add CONSTRAINT FK_EMP50_DNO FOREIGN key (dno) REFERENCES dept50 (dno);


/*
10. 9�� ���׿��� ������ ���̺� (EMP50, DEPT50) ���̺��� ����Ͽ� �Ʒ� ������ �ۼ��Ͻÿ�. 
     - ��� ������ DataBase �� ������ ���� �Ͻÿ�. 
     1. EMP50 ���̺� ���ڵ�(���� �߰��Ͻÿ�). 
          �����ȣ : 8181     ����̸� : ȫ�浿     ��å : �繫��     ���ӻ�� :  SCOTT (7788) 
          �Ի糯¥ : ������ �ý����� ��¥     ���� : 1000.     ���ʽ� : 100     �μ���ȣ : 20
    2. EMP50 ���̺� ���� ���ʽ��� ���� ������� ã�Ƽ� ���ʽ��� 50���� ���� �Ͻÿ�. 
    3. DEPT50 ���̺��� �μ���ȣ 40�� �μ����� ����Ρ��� �ٲٰ�, �μ���ġ�� ������� �����Ͻÿ�. 
    4. EMP50 ���̺��� ��å�� ��MANAGER�� ������� ã�� ���� �Ͻÿ�. 
*/

insert into emp50 
values( 8181, 'ȫ�浿', 'CLERK', 7788, sysdate, 1000, 100, 20 );

update emp50
    set commission = 50
    where commission is null;
    
update dept50
    set dname = '   ���' , loc = '����'
    where dno = 40;

delete emp50
    where job = 'MANAGER';
    
commit; 

