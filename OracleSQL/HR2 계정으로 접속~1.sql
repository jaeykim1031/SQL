
/*

    CRUD : Create, Read, Update, Delete
                    생성      검색      수정      삭제
    
*/

-- 간단한 테이블 생성 

create Table member ( 
        idx number not null ,
        name VARCHAR2(50) not null,
        id VARCHAR2(50) not null,
        pw VARCHAR2(50) not null,
        addr VARCHAR2(50) null
        );  
        
     -- 검색 : select 
    select * from member;

    -- 입력 : 테이블에 값을 넣음
      
    insert into member ( idx, name, id, pw, addr)
    VALUES(1, '홍길동', 'pjw', '1234', '서울');
    commit;         -- DB에 영구히 저장

 insert into member ( idx, name, id, pw, addr)
    VALUES(2, '김길동', 'pjw1', '1234', '부산');
    commit; 

 insert into member ( idx, name, id, pw, addr)
    VALUES(3, '홍동길', 'pjw2', '1234', '서울');
    commit; 
    
    -- 실습 : HR3 계정을 만들고 접속, member 테이블 생성 후 레코드 2개 넣기




        