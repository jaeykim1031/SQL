
-- 1. 사용자 DB 생성 
create database myDB;

-- 2. 사용자 DB에 연결
use myDB;

-- 3. myDB에서 테이블 생성
/*
	Oracle : 정수, 실수 - number(4) number(7,2) 
	MSSQL, MySQL : 정수 (int), 실수 (float), varchar() - varchar2 는 오라클만
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
	객체의 전체 이름 : DB, 테이블, 뷰, 저장 프로시저, 함수
	dbo : 생략 가능

	DB이름.스키마이름.객체이름
*/

select * from myDB.dbo.emp01;

/*
	sp_helpdb : 시스템의 모든 DB 정보 출력 (MSSQL)
	sp_help '스키마.테이블'; : 테이블의 정보 출력
*/

sp_helpdb ;
sp_help 'dbo.emp01';		-- desc emp01, select * from user_constraints where table_name in ('EMP01')

-- 3. 값 넣기 ( 자동 commit ) 

insert into	emp01 ( eno, ename, salary,hiredate, dno)
values (1, 'fqeqw', 500, '81-01-01', 10 );

insert into	emp01 ( eno, ename, salary,hiredate, dno)
values (2, 'dffsg', 1000, '71-01-01', 20 );

-- 4. 값 넣을 때 명시적 transaction - All or Nothing

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

rollback; -- 명시적으로 transaction을 시작해야 commit rollback 가능

-- 부서 테이블 : dept01
create table dept01(
		dno int not null primary key,
		dname varchar(50) not null,
		loc varchar(50) null
);

insert into	dept01
values (10, '인사부', '서울' );

insert into	dept01
values (20, '관리부', '부산' );

insert into	dept01
values (30, '영업부', '광주' );

-- alter table을 통해 emp01(dno) : FK -> dept01(dno)

alter table emp01
add foreign key (dno) references dept01(dno);

sp_help 'dbo.emp01';



