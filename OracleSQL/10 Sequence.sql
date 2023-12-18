/*
    sequence : �ڵ� ��ȣ �����
            - Ư�� �÷��� ��ȣ�� �ڵ����� ����
            - ���� Ÿ���� �÷��� �����ؾ���
            - user_sequence ������ ���� Ȯ��
            - ������ ����
*/

-- 1. ������ ���� - �ʱ� �� : 1 ���� �� : 1 
CREATE SEQUENCE seq1
    start WITH 1
    INCREMENT by 1;
    
-- 2. �������� ���� Ȯ�� 
SELECT * from user_sequences;

-- 3. ��� ���̺��� ����� ������ ���� Ȯ��
SELECT seq1.CURRVAL from dual;      -- ���� �������� ��ȣ Ȯ��

SELECT seq1.NEXTVAL from dual;      -- ���� �������� �� Ȯ��

-- 4. �� insert �� Ư�� �÷��� ������ ����
create table abc(
    a int not null PRIMARY key,
    b VARCHAR2(50),
    c varchar2(50)
);

INSERT into abc
VALUES (seq1.nextval, 'seoul', 'addr1');

COMMIT;

SELECT * from abc;








