

-- auto_increment - 초기값 : 1 증가값 : 1
-- 		오라클 : sequence

create table abc(
	a int not null auto_increment primary key,
    b varchar(50),
    c varchar(50)
);

insert into abc (b,c) 	-- 컬럼 명시 필요
values ('서울', 'ㅁddr1');

select * from abc;











