CREATE Table member(
        idx number not null,
        name varchar2(50) not null,
        id varchar2(50) not null,
        pw varchar2(50) not null,
        addr varchar2(50) null
        );
        
        
        select * from member;
        
        insert into member (idx, name, id, pw, addr)
        values(1,'David', 'qwer', '1234', 'Seoul');
        commit;
        
        insert into member ( idx, name, id, pw, addr)
        VALUES(2, 'Lucy', 'asdf', '4321', 'Tokyo');
        commit;
        