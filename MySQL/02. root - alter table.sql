
-- 주석
create database shop;

-- 데이터 베이스에 접속(사용)하기 : use 

use shop;

-- 테이블 생성 : number(Oracle) , int(MySQL)

create table dept60(
	dno int not null primary key,
	dname varchar(50) not null,
    loc varchar(50) not null
);

desc dept60;


-- 테이블의 값 확인하기
select * from dept60;

-- 값 넣기 		<- MySQL, MSSQL 자동 커밋 transaction
insert into dept60
values (10, '인사부', '서울');

-- insert update delete시 명시적으로 transaction 시작, 명시적으로 rollback, commit
start transaction; 	
insert into dept60 	
values ( 23, '관리부', '부산' );

rollback;
commit;

-- 실제 DB에서는 값을 insert, update, delete transaction을 명시적으로 시작하고 값 확인 후 commit

select * from dept60;

-- update 시 보호 설정있음
update dept60
set loc = 'aeawe'
where dno = 10;

-- delete
delete from dept60
where dno = 23;

-- defalut 제약 조건은 not null 앞에 와야 함
create table account10(
	no int not null primary key,
    name varchar(50),
	money int
);

insert into account10
values (1 , 'aaa', 432434);

insert into account10
values (2 , 'bbb', 41231);


start transaction;

update account10
set money = money - 10
where no  = 1; 

update account10
set money = money + 10
where no = 2 ;

rollback;








