-- join : ANSI JOIN, INNER JOIN

select * 
	from emp01 e 
		join dept01 d
			on e.dno = d.dno;

insert into emp01
values ( 3, 'reraer', 2000, '22-03-10', 30);

-- 부서가 적용 되어 있지 않는 부서 출력 - right outer join

select * 
	from emp01 e 
		right join dept01 d
			on e.dno = d.dno;