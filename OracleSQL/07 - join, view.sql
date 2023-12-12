/*
    join : employee ���̺�� department ���̺��� �ϳ��� ���̺��̾����� 
            �𵨸�(����ȭ)�� ���� �и��� ( R-DBMS)
    
    ���� ���� : ���̺��� �÷��� ���� Ű, �������� ���Ἲ(���� ���� ������, ���ϴ� ����)
            primary key : �÷��� 1���� ���� �� �ִ�, Ư�� �÷��� �ߺ��� ���� ���� ���ϰ� ��
                        - �� �� �÷��� ��� primary key�� ���� �� ���� 
                        - �ݵ�� NOT NULL �÷��̾�� ��
                        - ���̺��� ������ �� �ݵ�� primary key�� �����ؾ� ��. 
                            (update, delete �������� primary key�÷��� where �������� ���)
                        - index�� �ڵ����� ����. �÷��� �˻��� ������ ��      
                        - JOIN �� ON���� ���� ���
                        
            unique key : �÷��� �ߺ��� ���� ���� ���ϰ� ��
                        - null ���� (�� ����)
                        - �ϳ��� ���̺� ���� �� ���� �� �ִ�
                        - index �ڵ� ���� JOIN �� ON���� ���.
                        
            foreign key : �ٸ� ���̺� (�θ� ���̺�)�� Ư�� �÷��� �����Ͽ� ���� ����
                        - foreign key�� �����ϴ� �÷��� �θ� ���̺��� PK, UK ������
    
            NOT NULL : �÷��� NULL�� ���� �� �����ϴ� ��������
            
            CHECK : �÷��� ������ �־ ���ϴ� ���� ���� �� �ְ� �� ( ex) month�� 1 ~ 12��)
            
            default : ���� ������ �ƴ����� ���� ����ó�� ����
                    - �÷��� ���� ���� ������ defalut�� ������ ���� ��ϵ�

    �𵨸��� ���� = �ߺ� ����, ���� ���

*/

SELECT * from employee;             -- employee ���̺��� dno �÷��� department ���̺��� dno �÷��� ������
SELECT * from department;

-- ���̺� ���� - ���� ���̺��� ���� ������ ������� �ʴ´�, alter table�� ���� ���� ������ �ο�

create TABLE emp01
as 
select * from employee;

create TABLE dept01
as
SELECT * from department;

/*
    ���̺��� ���� ���� Ȯ��
    user_constraints : ������ ���� - ���̺��� ���� ������ �˷��ִ� ���̺�
*/

SELECT * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');


-- ���̺��� �����ϸ� ���̺��� �÷��� �ο��� ���� ������ ����Ǿ� ���� ����. �÷� & ����
-- alter table�� ���ؼ� ���� ���� �ο�
-- alter table : ���̺� ���� ��ɾ�
select * from user_constraints
where table_name in ('EMP01', 'DEPT01');        -- < ���� ���� ���� 

-- DEPT01 ���̺��� dnoĮ���� PK ���� ���� �߰�
alter table DEPT01 
add CONSTRAINT PK_DEPT01_DNO PRIMARY key (dno);

-- EMP01 ���̺��� enoĮ���� PK ���� ���� �߰�
alter table EMP01 
add CONSTRAINT PK_EMP01_DNO PRIMARY key (eno);

-- emp01 ���̺��� dno �÷��� Foreign Key �ο�, ����(REFERENCES)�� ���̺��� �÷��� dept01 ���̺��� dno �÷� ����
alter table emp01
add CONSTRAINT FK_EMP01_DNO FOREIGN key (dno) REFERENCES dept01(dno) ;

-- primary key �÷� Ȯ�� : 
desc emp01;

select * from emp01;




-- ���� ���� ��(insert) �÷��� �ο��� ���� ������ Ȯ�� �ʼ� 

-- eno : PK�� ��ϵǾ�����. �ߺ��� ���� ������ ����
-- dno : FK�� ��ϵǾ�����. dept01 ���̺��� dno�÷��� �����ϴ� ���� �־���� - 50�� ���� 

insert into emp01 (eno, ename, job, manager, hiredate, salary, commission, dno)
values ( 7977, 'KJY', 'ClERK', 7782 , '23/12/11', 1500, null, 40);  -- ���Ἲ ���� ����(C##HR.PK_EMP01_DNO)�� ����

 commit;  -- > DML(insert, update, delete)���� DB�� ������ ����ǵ��� ��. (Oracle Only)

select * from emp01;
select * from dept01;

-- dept ���̺� �� �ֱ� : dno �÷� - PK ���� 
desc dept01;

insert into dept01 ( dno, dname, loc)
values ( 50 , 'HR', 'SEOUL');

commit;

-- join : ���� ���̺��� �÷��� ����� �� join�� ����ؼ� �ϳ��� ���̺�ó�� �����
        -- �� ���̺��� ���� Ű �÷� Ȯ��.
        -- emp01, dept01 ���̺��� ���� Ű �÷��� dno.
        -- EQUI JOIN : ����Ŭ only
        -- ANSI JOIN : ��� DBMS ���� ���

-- EQUI JOIN
    --  from ������ join �� ���̺� ���
    -- ���̺� �̸��� ��Ī����
    -- where ������ �� ���̺��� ���� Ű �÷� ���
    -- and���� ���� ó��
    --  ����Ű �÷��� ��½� �ݵ�� ���̺��

select e.eno, e.ename, e.job, d.dno, d.dname, loc
from emp01 e, dept01 d
WHERE e.dno = d.dno;

select eno, ename, job, d.dno, dname, loc
from emp01 e, dept01 d
WHERE e.dno = d.dno
and d.dno = 10;

-- ANSI JOIN : ��� DBMS���� ���������� ���
    -- inner join : �� ���̺��� Ű �÷��� ����Ǵ� �κи� ��� 
    -- outer join
        -- left
        -- right
        -- full

    -- SELF
    -- CLOSS
    
    
-- INNER JOIN : ANSI JOIN
        -- from  ���� join, 'inner' ���� ����, on ���� �� ���̺��� ������
    
-- ��Ī ���� )
select eno, ename, salary, dept01.dno, dname, loc
from emp01 inner join  dept01 
on emp01.dno = dept01.dno;


-- ��Ī ���
select eno, ename, salary, d.dno, dname, loc
from emp01 e  join dept01 d
on e.dno = d.dno
where e.dno = 20
order by ename desc;

-- ANSI : on ���� �� ���̺��� ���� �и� ���

select * 
from emp01 e join dept01 d
on e.dno = d.dno;

-- OUTER JOIN
    -- left : ���� ���̺��� ��� ���� ���
        -- �� ���̺��� ����κа� ����  
        
    -- right : ������ 
        -- �� ���̺��� ����κа� ������
    --  ex) ���� ����� ���ų� �����ȣ�� ������ 
        
    -- full : ��� ���̺��� ���� ���
    
select * from dept01;
  
insert into dept01 (dno, dname, loc)
values (60, 'MANAGE', 'BUSAN');
commit;
    
select * 
from emp01 e RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;                       -- < 60, 'MANAGE', 'BUSAN' ������

select * 
from emp01 e LEFT OUTER JOIN dept01 d
on e.dno = d.dno;

select * 
from emp01 e FULL OUTER JOIN dept01 d
on e.dno = d.dno;

-- SELF JOIN : �ڽ��� ���̺��� JOIN, �ڽ��� ���̺��� ������ �̸����� �����Ͽ� JOIN
        -- ������ ���, ���� ��� ���� ����� �� ���
        
        
        
        -- ��� �̸��� ���� ���ӻ�簡 �������� ���
        -- ���� ����� ���� ��� ��� = left outer 
        
        
select e.eno ���, e.ename ���_�̸�, e.manager ���ӻ��_��ȣ, m.eno ���ӻ��_���, m.ename ���ӻ��
from emp01 e right join emp01 m
on e.manager = m.eno;


-- ��� �̸� SCOTT�� �μ���, �μ���ġ <- ename : SCOTT�� emp01 , dept01 :dname, loc


-- ANSI 

select * from emp01;
select * from dept01;

-- emp�� dept�� join �ؼ� ���

select *
from emp01 e join dept01 d
on e.dno = d.dno;

select ename, dmane, loc
from emp01 e join dept01 d
on e.dno = d.dno
where ename = 'SCOTT';



-- ������ 2000���� �̻��� ����� �̸� �μ��� �μ� ��ġ ���� ��� ansi

select ename, salary, dname, loc, e.dno
from emp01 e join dept01 d
on e.dno = d.dno
where salary >= 2000
order by d.dno desc;


-- ��å(job)�� �Ŵ����� ����� �̸�, �μ� ��ȣ, �μ���, �μ���ġ ����ϰ� ��� �̸��� �������� ����

select job, ename, d.dno, dname, loc
from emp01 e join dept01 d
on e.dno = d.dno
where job = 'MANAGER';

/*
    VIEW : ������ ���̺�. ���� ������ �ʰ� �ڵ常 ����
        1. ���� ���̺��� Ư�� �÷��� ����� �� (����)
        2. ������ ������ ���� ���� - ������ Join ������ �ܼ�ȭ 

*/
drop table emp02 CASCADE CONSTRAINTS;

create table EMP02
as 
select eno, ename, salary, commission , job, hiredate, dno
from employee
where salary> 1500;

select * from emp02;

CREATE table dept02
as 
select * from department;

-- ������ ���� ���̺� : employee -> emp01 / department -> dept01
    -- �ʵ��, ���� ���� 
    -- �÷��� �ο��� ���� ������ ������� ���� - alter table�� ���� ���� ���� ���� 
    
select * from user_constraints where table_name in ('EMPLOYEE', 'DEPARTMENT');   
select * from user_constraints where table_name in ('EMP02', 'DEPT02'); 

-- DEPT02 ���̺��� dno(PK)
-- EMP02 ���̺��� eno(PK), dno(FK) -> dept02 (dno)

alter table DEPT02
add CONSTRAINT PK_DEPT02_DNO PRIMARY key (dno);

alter table EMP02
add CONSTRAINT PK_EMP02_ENO PRIMARY key (eno);

alter table EMP02
add CONSTRAINT FK_EMP02_DNO FOREIGN key (dno) REFERENCES dept02(dno);

-- VIEW ���� 
    -- as ������ select �ڵ� ������ ���� 


create view v_emp02
as
select ename, job, dno          -- ���� ���̺��� ���� ������ ���� �ƴ� ���� �ڵ常 ���� �� ���� 
from emp02;

select * from v_emp02;  
/*
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##HR"."V_EMP02" ("ENAME", "JOB", "DNO") AS 
  select ename, job,dno
from emp02;
*/

-- ������ ���� : user_���̺� <- �ý����� ������ ����Ǿ��ִ� ���̺�

select * from user_views; 

-- ����� ���Ǽ� : ������ ������ view�� �����ؼ� ����

--    �� ���̺��� �����ؼ� ������ 2500 �̻��� ��� ���� ���
create view v_join
as
SELECT ename, job , salary, dname, loc
from emp02 e 
    join dept02 d
        on e.dno = d.dno
where salary >= 2500;

select * from v_join;

-- employee, department ���̺��� �μ����� �ּ� ������ �޴� ��� �̸�, ��å, �μ���, �μ���ġ 
    -- 20�� �μ� ����, �ּ� ������ 1500 �̻��� ��� ����
    -- �� �ȿ� ������ �����ϰ� �並 �����ؼ� ���
create view v_join2
as
select ename, job, dname, loc, d.dno
from employee e
    join department d
        on e.dno = d.dno
where salary in (
        select min(salary) from employee        -- �μ��� �ּ� ���� 
        where dno <> 20 
        group by dno 
        having min(salary) > 900                      
);

select * from v_join2;



-- view ���ǻ���

create view v_join3
as
select ename, job, dname, loc, d.dno
from employee e
    join department d
        on e.dno = d.dno
where salary in (
        select min(salary) from employee        -- �μ��� �ּ� ���� 
        where dno <> 20 
        group by dno 
        having min(salary) > 900                      
)
order by ename desc;

select * from v_join3;

---     view�� ���� �� ����, ����         -----

create view v_test01
as
select eno, ename, dno
from emp02;

select *from v_test01;

insert into v_test01 (eno, ename, dno)
VALUES (8080,'kim',30);

commit;

-- ���� -- 
update v_test01
set ename = 'LEE'
where eno = 8080;

-- ���� -- 
delete v_test01
where eno = '8080';

-- v_test02 : insert�� �� �� (dno Į��(- PK)�� ��õǾ� ���� �ʱ� ����, update/delete ����
create view v_test02
as
select eno, ename, salary
from emp02;

insert into v_test02 (eno ,ename, salary)
values (9090,'Park', 3500);

delete v_test02
where eno = '9090';
commit;

















