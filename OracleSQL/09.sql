/*
    DDL : Create, Alter, Drop. - ��ü(���̺�, ��, �������ν���, Ʈ����, ������...)�� ����
        
    
    - ���̺� ���� �� ������ ������ ���̺� ���� ����� ���� ���� (alter table)
        - 1. �÷��� �ڷ����� ���� : varchar(50) -> varchar(100)
        - 2. �÷��� �̸� ����, ����, �߰�
        - 3. ���� �� ���� ���� �߰�, ���� ( PK, FK, default, Unique, NOT NULL, CHECK )

*/

-- �÷���, ���� �����. ��� ������ ������� ����
create table emp60
as 
select * from employee;


create table dept60
as 
select * from department;

-- ������ ���� : user_ 
        -- user_constraints - �����ͺ��̽��� �����ϴ� ��� ���̺� ���� �������� ���
SELECT * from user_constraints
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

-- 1. Alter table�� ����ؼ� ���� ���̺� �÷� �߰� : birth(date), email(varchar2(100))
    --  ���̺� �÷� �߰��� null�� ó�� �� �÷� �߰�
desc dept60;

alter table dept60
add (birth date);

-- ���� ���̺� ���� �÷��� �� ���� �߰�
alter table dept60
add(email varchar2(100), addr VARCHAR2(200), jumin char(14));

-- ���� Į���� �� �ֱ� : update   
UPDATE dept60
set birth = sysdate , email = 'aaa@aaa.com', addr = '����' , jumin = '123447-4812312'
where dno = '10';             /* ->  WHERE �߿� */

-- �÷��� �ο��� �ڷ��� ����
alter table dept60
modify email VARCHAR2(200);

-- �÷� ����
alter table dept60
drop COLUMN JUMIN;

-- �÷��� �̸� ���� 
alter table dept60
RENAME COLUMN addr to address1;

-- ���̺� �̸� ����
RENAME dept60 to dept70;

SELECT * from dept70;
RENAME dept70 to dept60;

-- ���� ���̺��� ���� ���� �߰�, ����
    -- ���̺��� 1���� ���� �� ����
    -- not null �÷��� PK�� ���� �� �ִ�
    -- �÷��� null ���� ����� ��
    
    
SELECT * from user_constraints where table_name in ('DEPT60' , 'EMP60');

-- dept60�� PK ���� ���� �߰�
alter table dept60
add PRIMARY key (dno);      -- ���� ���� �̸� ���� ���� 'constraint PK_~'

alter table emp60
add PRIMARY key (eno);



-- ����
alter table dept60 
drop CONSTRAINT PK_DEPT60_DNO;


-- Foreign key : �ٸ� ���̺��� �÷� ���� �����Ͽ��� ���� ���� �� ���� 
        -- ���̺� (�θ� : �ϳ�)    < --   FK ���̺� (�ڽ� : ����)
        -- join �� on ������ ���Ǵ� Ű �÷�
        -- PK, Unique�� �� ���� �� �ִ�  
        -- ���� �÷��� �ڷ����� ����ϰų� ���ƾ� ��

    
        -- �θ� ���̺��� PK �Ҵ�
    alter table dept60
    add primary key (dno);
    
        -- �ڽ� ���̺��� FK �Ҵ�
    alter table emp60
    add FOREIGN key (dno) REFERENCES dept60(dno);

-- join
SELECT eno, ename, salary, e.dno, d.dno, dname , loc
from emp60 e
    join dept60 d
        on e.dno = d.dno;
    
-- Unique ���� ���� �߰� : �ߺ��� ���� ���� ���ϵ��� ����'
    -- �� ���̺��� ���� �÷��� �ο� ���� 
    -- not null, null ��� ���� 

    
alter table dept60
add unique(email);
    
INSERT into dept60
VALUES (50 , '����', '�λ�', sysdate, 'aaa@ffff.com', 'qntks');
    
INSERT into dept60
VALUES (77 , '����2', '�λ�', sysdate, 'aaa@ffff.com', 'ooioi');
    
commit;

alter table dept60
add unique(address1);

UPDATE dept60
set dept60.address1 = '����'
where dno = 50;

-- ��� ���� ����
alter TABLE dept60
drop CONSTRAINT SYS_C008530;

SELECT * from user_constraints where table_name in ('DEPT60' , 'EMP60');

SELECT * from dept60;


-- CHECK ���� ����
SELECT * from emp60;

alter TABLE emp60
add ( addr varchar2(50), hdate date);
alter TABLE emp60
add ( addr varchar2(50), hdate date);

-- addr : ���� �λ� ���ָ�
-- hdate : 230101 ~ 231231 �� 


alter table emp60
add check( addr in ('seoul','qntks','rhkdwn'));

alter table emp60
add check( hdate BETWEEN to_date('20230101', 'YYYYMMDD') and to_date('20231231','YYYYMMDD' )  );

alter table emp60
add check (age >= 0 and age <= 300);

-- not null ���� ���� : �÷��� null ������ ����

alter table dept60
modify address1 CONSTRAINT NN_DEPT60_ADDRESS1 not null;

update dept60
set address1 = 'seoul'
where address1 is null;

INSERT into dept60
VALUES (70, '5345', '5dgggrd5', sysdate , '222@gfgsfd', null);


-- default : ** ���� ������ �ƴ� ** ���� ���� �̸��� �ο��� �� ����
            -- �÷��� ���� ���� ���� ��� default�� ������ ���� �ڵ����� ��
            -- default�� ������ �����ϱ� ���ؼ��� default null

alter table dept60
add address2 varchar2(100);

alter table dept60
modify address2 default 'seoul';

INSERT into dept60
VALUES (80, '5345', '5dgggrd5', sysdate , '222@gfgsfd',' 131' , default );

-- default ����
    -- ��� ���� ���� : alter table ���̺�� drop ��������

alter table dept60
modify address2 default null;







