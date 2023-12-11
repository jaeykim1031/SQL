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











