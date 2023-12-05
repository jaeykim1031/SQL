

-- 1. 사용자 데이터베이스 생성
create database myDB;

-- 2. 해당 사용자 데이터비이스에 접속
use myDB;

-- 3. 접속한 DB에서 테이블 생성
create table member (
	idx int not null,
    name varchar(50) not null,
    addr varchar(50) not null
    );
    
    
    
-- 4. 테이블의 내용을 출력 : select
select * from member;

-- 5. 생성된 테이블에 값 넣기(레코드) - 자동 commit 됨
insert into member ( idx, name, addr)
values ( 1, 'John', 'Seoul');

insert into member ( idx, name, addr)
values ( 2, 'Jane', 'Busan');








    