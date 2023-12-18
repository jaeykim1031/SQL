
-- 1. ����� DB ���� 
create database myDB;

-- 2. ����� DB�� ����
use myDB;

-- 3. myDB���� ���̺� ����
/*
	Oracle : ����, �Ǽ� - number(4) number(7,2) 
	MSSQL, MySQL : ���� (int), �Ǽ� (float), varchar() - varchar2 �� ����Ŭ��
			MySQL : double
			MSSQL : real
*/

create table emp01(
	eno int not null constraint PK_EMP01_ENO primary key,
	ename varchar(50) not null,
	salary float not null,
	hiredate date,
	dno int 
);


/*
	��ü�� ��ü �̸� : DB, ���̺�, ��, ���� ���ν���, �Լ�
	dbo : ���� ����

	DB�̸�.��Ű���̸�.��ü�̸�
*/

select * from myDB.dbo.emp01;

/*
	sp_helpdb : �ý����� ��� DB ���� ��� (MSSQL)
	sp_help '��Ű��.���̺�'; : ���̺��� ���� ���
*/

sp_helpdb ;
sp_help 'dbo.emp01';		-- desc emp01, select * from user_constraints where table_name in ('EMP01')

-- 3. �� �ֱ� ( �ڵ� commit ) 

insert into	emp01 ( eno, ename, salary,hiredate, dno)
values (1, 'fqeqw', 500, '81-01-01', 10 );

insert into	emp01 ( eno, ename, salary,hiredate, dno)
values (2, 'dffsg', 1000, '71-01-01', 20 );

-- 4. �� ���� �� ����� transaction - All or Nothing

begin transaction;

update emp01
set salary = salary - 30
where eno =	1;

update emp01
set salary = salary + 30
where eno = 2;

rollback;
commit;

select * from emp01;

-- delete
delete emp01 
where eno = 1;

rollback; -- ��������� transaction�� �����ؾ� commit rollback ����

-- �μ� ���̺� : dept01
create table dept01(
		dno int not null primary key,
		dname varchar(50) not null,
		loc varchar(50) null
);

insert into	dept01
values (10, '�λ��', '����' );

insert into	dept01
values (20, '������', '�λ�' );

insert into	dept01
values (30, '������', '����' );

-- alter table�� ���� emp01(dno) : FK -> dept01(dno)

alter table emp01
add foreign key (dno) references dept01(dno);

sp_help 'dbo.emp01';



