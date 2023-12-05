-- 실습 
/*
		myDB2 생성
        member 테이블 생성
		레코드 2개 생성 
*/

create database myDB2;

use myDB;

create table member(
	idx int not null,
    name varchar(50) not null,
    addr varchar(50) not null
    );
    
    insert into member (idx, name, addr)
    values (1,'Kim','Gangnam') ;
    
     insert into member (idx, name, addr)
    values (2,'Lee','Songpa') ;
    
    select * from member;