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

CREATE user C##HR20 IDENTIFIED by 1234
default tablespace USERS
temporary tablespace TEMP;

--  2. ������ ���� �ο��ϱ� : connnect(����), resource(��ü ����, ����, ����)

grant resource,
connect to c##HR20;
grant create view to c##HR20;

--  3. ���̺� �����̽����� ��뷮 �Ҵ�.

ALTER USER c##HR20
    QUOTA UNLIMITED ON users;

-- 4. ���� ����

DROP USER c##hr4 CASCADE;




