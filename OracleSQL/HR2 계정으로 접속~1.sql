
/*

    CRUD : Create, Read, Update, Delete
                    ����      �˻�      ����      ����
    
*/

-- ������ ���̺� ���� 

create Table member ( 
        idx number not null ,
        name VARCHAR2(50) not null,
        id VARCHAR2(50) not null,
        pw VARCHAR2(50) not null,
        addr VARCHAR2(50) null
        );  
        
     -- �˻� : select 
    select * from member;

    -- �Է� : ���̺� ���� ����
      
    insert into member ( idx, name, id, pw, addr)
    VALUES(1, 'ȫ�浿', 'pjw', '1234', '����');
    commit;         -- DB�� ������ ����

 insert into member ( idx, name, id, pw, addr)
    VALUES(2, '��浿', 'pjw1', '1234', '�λ�');
    commit; 

 insert into member ( idx, name, id, pw, addr)
    VALUES(3, 'ȫ����', 'pjw2', '1234', '����');
    commit; 
    
    -- �ǽ� : HR3 ������ ����� ����, member ���̺� ���� �� ���ڵ� 2�� �ֱ�




        