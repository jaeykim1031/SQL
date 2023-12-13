/*
    SQL : ��� ���� ����. select, create, alter, drop, insert, update, delete, grant, revoke, rollbac, commit
            - ����ȭ�� ���� ���
    
    SQL�� ����
        DQL(Data Query Language) : ���, �˻�, select
        DDL(Date Definition Lang) : ��Ű��(Ʋ, ����),  ��ü(���̺� �� �Լ� ������ Ʈ���� �������ν��� �ε���)
                                   ����(create), ����(alter), ����(drop)
        DML(Data Manipulation Lang) : ���̺��� ���ڵ�(��) �����ϴ� ���
                                    �Է�(insert), ����(update), ����(delete)
                                        - transaction �߻� (RAM), commit : �޸��� ������ DB�� ������ ����
                                                                  rollback : ������� �ǵ���
                                                                  
                                        - insert, update, delete�� ���۵Ǹ� �ڵ����� transaction�� ����
                                        
                                        - transaction ���� : rollback - �޸��� ����� ������ ���� ���·� �ǵ��� 
                                                             commit - DB�� ������ ����
                                                             
                                        - transaction�� ������� ������ ���� �� ������ LOCK      
                                        
                                        - *Oracle�� ���* : DML�� ���۽� �ڵ����� transaction ����, ����� ��õǾ�� ��
                                        
                                        - *MySQL, MSSQL �� ���* : commit �ڵ����� ó��
                                        
                                        - ��������� transaction�� ���� �� �� �ְ�, ��������� ���� �� �ִ�.
        
        DCL(Data Control Lang) : �������� ��ü�� ������ �ο��� �ο�(grant), ����(revoke)
        TCL(Transaction Control Lang) : transaction�� �����ϴ� ��� - DML������ ����
                                            commit, rollback, savepoint, begin transaction
*/

/*
    transaction : �۾�(��)�� ó���ϴ� �ּ� ���� : ALL or NOTHING
        - log�� ��ϵǾ����� (������ �������� ����)
        
            1. ���ڼ� : ���� ó���ϴ� �ּ� ����
            2. �ϰ��� : transaction���� ó���� ����� �ϰ����� ���� ALL or NOTHING
            3. ������ : �ϳ��� transaction�� �ٸ� transaction�� �ݸ� �Ǿ����� LOCK
            4. ���Ӽ� : commit. DB�� ������ ����

*/

-- ���̺� ����
create table "account10"
as
SELECT eno as no,  ename as name, salary as account
from employee;

select * from "account10";


-- SMITH���� MILLER���� 10�� �Ա� : 2���� update ������ �ϳ��� transaction���� ó��

/*
    smith account - 10�� : update account10 set account = account - 10 where no = 7569
    miller account + 10�� : update account10 set account = account + 10 where no = 7934

*/
----
--begin transaction ;
--
--    update "account10"
--        set account = account - 10 
--        where no = 7369;
--        
--    update "account10"
--        set account = account + 10 
--        where no = 7934;
--        
--  rollback; 
--  commit; 
--  
--End;  
----  
/*
    DML : insert, update, delete
        transaction �ڵ�����
        transaction ����� ��õǾ�� ��(rollback commit) * ����Ŭ ����

*/ 
        
-- ���̺� ���� 
create table dept03
as
select * from department ;
    
alter table dept03
add CONSTRAINT PK_DEPT03_DNO PRIMARY key (dno);

    
-- insert ���ǻ��� : �� �÷��� �ڷ����� ����� ���� ���� Ȯ��    
desc dept03;
select * from user_constraints where table_name in ('DEPT03');

        
-- insert into ���̺� ( �÷�, �÷�, �÷�) values (��, ��, ��);

insert into dept03 (dno, dname, loc)
values (50, 'HR', 'SEOUL');
        
select * from dept03;
        
        commit;
        
-- insert �� �÷� �̸��� ������� �ʴ� ��� ��� �÷��� ���� �־�� ��       
insert into dept03(dno, dname, loc)
values (6, 'HR', 'Busan');
        
-- �÷� ������ ��� �÷��� ���� ������ �°� �Է�
insert into dept03
values (70, 'uuu', 'dwdwd');
        
-- �÷� ����� �� ���� ���� ���� , Ư�� �÷��� ���� ��� ��
insert into dept03(dname, dno)
values ('Daejeon', 80);


-- UPDATE : �� ������ ���. where �ʼ�. where ���ǿ� ���Ǵ� �÷��� PK �÷��̾�� ��.
/*
    update ���̺�
    set �÷� = ����
    where ����

*/

update dept03
set loc = '�뱸'              -- ���� ó������ ������ ���� ���� 
where dno = 80;

select * from dept03;   

update dept03
set dname = '������',
    loc = '����'
    
where dno = 40 ;

commit;

INSERT into dept03
VALUES (90, '������', '�뱸');

INSERT into dept03
VALUES (91, '������', '����');

update dept03
set dname = '�μ��'
where loc = '����';        --< ���ǹ� ���� - �ߺ��� �÷�

rollback;

-- update �� PK �÷��� �������� �ؼ� ���ϴ� ���� �����ϱ�.


update dept03
set dname = '�μ��'
where dno in (91, 90);


-- delete : ���ڵ带 ����. where <����>, <���� : �ߺ����� �ʴ� �÷�>
/*
    delete ���̺�
    where ����
*/

select * from dept03;   

-- *****************���ǹ��� ������ ��� ���ڵ尡 ������***************

delete dept03
where dno = 91;

   /* ��� ���ڵ� ���� : 
        delete : ���ڵ� �ϳ��� ����. ���� �ɸ� - �ο췹��
        truncate table ���̺� : �� ���� ���� - ���� ���� ->> DDL���̶� �ѹ� �Ұ�, ���� �� ��� commit
        
        drop table ���̺� : ���̺� ��ü�� ����
    */

select * from dept03;
rollback;
commit;

delete dept03;
truncate table dept03;

---------------------------------------------------------------------------

create table emp04
as
select * from employee;

select * from emp04;

/*
    ������ �� �߰� : insert
             ���� : update
             ���� : delete
*/

select * from user_constraints where table_name in ('EMP04');


/*
    DDL : ����(create), ����(alter), ����(drop)
         -> ���̺�, ��, �Լ�, ������, Ʈ����, ���� ���ν���, ��Ű���� ����, ����, ����
         
    �ڷ��� : �����͸� �����ϴ� Ÿ��
        ���� : number(n) : n�ڸ� ����.
               number(n.m) : �Ҽ�. ��ü n�ڸ� �Ҽ��� ���� m�ڸ�
               
        ���� : char(n) : n byte ����. ���� 1���� = 1byte, �ѱ� 1���� = 3byte
                - ���� ����, ���� ���� �߻� ���ɼ�
                - n byte ��ŭ�� �ڸ��� ������
               
               varchar2(n) : n byte ����.
                - ������ ����, ���� �� ����. ���� ���� x
                - �ڸ����� �� �� ���� ������ �� ���
                
               nchar(n) : ���� ���� �����ڵ� n����
               nvarchar2(n) : ���� ���� �����ڵ� n����
               
        ��¥ : date : BC 4712/1/1 ~ 9999/12/31. �� ������ ���� ����
               timestamp : insert�Ǵ� ������ �ð�. ms ���� ���� ����
        
        LOB ������ Ÿ�� : �뷮�� ���� ����, ���̳ʸ� ����
                CLOB : ���ڸ� �뷮���� ���� �� ���� 
                BLOB : mp3, jpeg, hwp ���� ������ ���� 
                BFile : ��뷮 ���� ���� 
*/

create table test10(
    id number(4) not null PRIMARY key,      -- �ߺ� �Ұ�, ���� 4��
    n1 char(10) ,                   -- ���� 10�� , �ѱ� 3��
    n2 nchar(10) ,                  -- ���� 10��, �ѱ� 10��
    n3 varchar2(10) ,               -- ���� 10�� , �ѱ� 3��
    n4 NVARCHAR2(10)                -- ���� 10��, �ѱ� 10��
);

select * from test10;

insert into test10 (id, n1, n2, n3, n4)
values (1111, 'aasdads', '�����ٶ󸶹�', 'aasdads', '�����ٶ󸶹�');

drop table test10;

/*
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
                    
            ���������� ����ϴ� ������ ���� : user_constraints
                    - select * from user_constraints where table_name in ���̺�;
*/
create table member1(
    id varchar2(50) not null PRIMARY key,
    pass varchar2(50) not null,
    addr varchar2(100) null,
    jumin char(13) null,
    phone varchar2(50),
    age number(3),
    weight number(5,2)
);

desc member1;

insert into member1
values ( 'abc', '12314' , '����' , '411234-441232', '010-1111-1111' , 30, 44.44 );

select * from member1;


select * from user_constraints where table_name in ('MEMBER1');


-- �������� �̸��� ���� �ʰ� ���̺��� �����ص� ����Ŭ���� ���� ���� �̸��� ��ü������ ������.
-- insert �� ���� �߻��� ��� ���� ���� �̸����� ������ �÷��� ã�� ����.

create table member2(
    id varchar2(50) not null CONSTRAINT PK_MEMBER2_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER2_PASS  not null,
    addr varchar2(100) null,
    jumin char(13) null,
    phone varchar2(50),
    age number(3),
    weight number(5,2)
);

insert into member2
values ( 'abc', null , '����' , '411234-441232', '010-1111-1111' , 30, 44.44 );
commit;


/* 
     UNIQUE : �ߺ��� �� �Ұ���, null ����, ���̺� ���� �� ����

*/

create table member3(
    id varchar2(50) not null CONSTRAINT PK_MEMBER3_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER3_PASS  not null,
    addr varchar2(100) null,
    jumin char(13) null CONSTRAINT U_MEMBER3_JUMIN UNIQUE ,
    phone varchar2(50) not null CONSTRAINT U_MEMBER3_PHONE unique,
    age number(3),
    weight number(5,2)
);

insert into member3 (id, pass, addr, jumin, phone, age, weight)
values ( 'abc', '1234' , '����' , '411234-441232', '010-1111-1111' , 30, 44.44 );


-- CHECK ���� ���� : �÷��� ���ǿ� �´� ���� ���� �� �ְ� ��
drop table member4;
create table member4(
    id varchar2(50) not null CONSTRAINT PK_MEMBER4_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER4_PASS  not null,
    addr varchar2(100) null CONSTRAINT CK_MEMBER4_ADDR check (addr in ('����', '�λ�', '�뱸')) ,
    jumin char(13) null CONSTRAINT U_MEMBER4_JUMIN UNIQUE ,
    phone varchar2(50) not null CONSTRAINT U_MEMBER4_PHONE unique,
    age number(3) CONSTRAINT CK_MEMBER4_AGE check (age > 0 and age < 200) ,
    gender char(1) CONSTRAINT CK_MEMBER4_GENDER check (gender in ('w','m')),
    weight number(5,2)
);

insert into member4 (id, pass, addr, jumin, phone, age, gender ,weight)
values ( 'abc', '1234' , '����' , '411234-441232', '010-1111-1111' , 100, 'w' , 44.44 );
commit;


-- default : **�������� �ƴ�** ���� ���� �̸��� �ο� �� �� ����.
        -- ���� ������ ������ �� ����, ���� ���� ���� �� defalult�� ������ �� ����
        
create table member5(
    id varchar2(50) not null CONSTRAINT PK_MEMBER5_ID PRIMARY key,
    pass varchar2(50) CONSTRAINT NN_MEMBER5_PASS  not null,
    addr varchar2(100) null CONSTRAINT CK_MEMBER5_ADDR check (addr in ('����', '�λ�', '�뱸')) ,
    jumin char(13) null CONSTRAINT U_MEMBER5_JUMIN UNIQUE ,
    phone varchar2(50) not null CONSTRAINT U_MEMBER5_PHONE unique,
    age number(3) CONSTRAINT CK_MEMBER5_AGE check (age > 0 and age < 200) ,
    gender char(1) CONSTRAINT CK_MEMBER5_GENDER check (gender in ('w','m')),
    weight number(5,2),
    hiredate date default sysdate ,
    addr2 char(10) default 'tjdnf',
    age2 number default 0
);

insert into member5 (id, pass, addr, jumin, phone, age, gender ,weight)
values ( 'abc', '1234' , '����' , '411234-441232', '010-1111-1111' , 100, 'w' , 44.44 );
commit;

select * from member5;











