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

CREATE user C##HR10 IDENTIFIED by 1234
default tablespace USERS
temporary tablespace TEMP;

--  2. ������ ���� �ο��ϱ� : connnect(����), resource(��ü ����, ����, ����)

grant resource,
connect to c##HR10;
grant create view to c##HR10;

--  3. ���̺� �����̽����� ��뷮 �Ҵ�.

ALTER USER c##hr10
    QUOTA UNLIMITED ON users;

-- 4. ���� ����

DROP USER c##hr4 CASCADE;




