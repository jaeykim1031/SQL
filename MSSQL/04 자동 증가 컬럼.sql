

-- �÷��� ���� ���� ���� �� �ڵ����� �����ϴ� �÷� : identity	<- mssql�� ��� ����
--			���� ���� �ʴ´�
--		 �ʱⰪ 1 ���� 1�� ������
--			 primary key

create table abc(
	a int not null identity primary key,
	b varchar(50),
	c varchar(50)

);

insert into abc
values ( 'tjdnf', 'add1');
 
select * from abc;