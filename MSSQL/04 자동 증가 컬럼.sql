

-- 컬럼에 값을 넣지 않을 때 자동으로 증가하는 컬럼 : identity	<- mssql만 사용 가능
--			값을 넣지 않는다
--		 초기값 1 부터 1씩 증가함
--			 primary key

create table abc(
	a int not null identity primary key,
	b varchar(50),
	c varchar(50)

);

insert into abc
values ( 'tjdnf', 'add1');
 
select * from abc;