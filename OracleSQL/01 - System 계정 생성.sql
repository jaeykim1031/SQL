SELECT
    *
FROM
    help;

SELECT
    *
FROM
    redo_log;

-- SQL�� �ּ� : �� �� �ּ�
/*
      �Ϲ� ���� ���� �� �Ϲ� �������� ����
*/
-- system �������� ������ ����â������ ������ ���� �� �� �ִ�

--  1. hr ���� ���� : ����Ŭ 12 ���� �̻���� ���� ������ C##(����) 

CREATE user C##HRexam IDENTIFIED by 1234
default tablespace USERS
temporary tablespace TEMP;

--  2. ������ ���� �ο��ϱ� : connnect(����), resource(��ü ����, ����, ����)

grant resource,
connect to c##HRexam;
grant create view to c##HRexam;

--  3. ���̺� �����̽����� ��뷮 �Ҵ�.

ALTER USER c##HRexam
    QUOTA UNLIMITED ON users;

-- 4. ���� ����

DROP USER c##hr4 CASCADE;




