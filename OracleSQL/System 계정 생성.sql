select * from help;


SELECT * from redo_log;

-- SQL�� �ּ� : �� �� �ּ�
/*
      �Ϲ� ���� ���� �� �Ϲ� �������� ����
*/
-- system �������� ������ ����â������ ������ ���� �� �� �ִ�

--  1. hr ���� ���� : ����Ŭ 12 ���� �̻���� ���� ������ C##(����) 

CREATE user C##HR4 IDENTIFIED by 1234
default tablespace USERS
temporary tablespace TEMP;

--  2. ������ ���� �ο��ϱ� : connnect(����), resource(��ü ����, ����, ����)

grant resource, connect to C##HR4;

--  3. ���̺� �����̽����� ��뷮 �Ҵ�.

alter user c##HR4 quota unlimited on USERS;

-- 4. ���� ����

drop user C##HR4 CASCADE;




