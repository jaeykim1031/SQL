-- join : ANSI JOIN, INNER JOIN

select * 
	from emp01 e 
		join dept01 d
			on e.dno = d.dno;

insert into emp01
values ( 3, 'reraer', 2000, '22-03-10', 30);

-- �μ��� ���� �Ǿ� ���� �ʴ� �μ� ��� - right outer join

select * 
	from emp01 e 
		right join dept01 d
			on e.dno = d.dno;