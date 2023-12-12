/*
    JOIN �ǽ�
        member10 : ȸ�� ������ �����ϴ� ���̺�
        zipcode10 : �����ȣ�� �����ϴ� 
        product10 : ��ǰ ������
        order10 : �ֹ� ������
 
*/

--    ���̺� ���� : Foregin Key�� �����ϴ� ���̺��� ���� ���� �ʴ´� 
--                    - cascade constraints �ɼ��� �̿��� ���� ���� ���� 

drop table zipcode10;
drop table member10;

select * from user_constraints where table_name = 'MEMBER10';

drop table order10;         -- �����ϴ� ���̺� ������ ���� �޴� ���̺� ���� ����

-- -  cascade constraints 
drop table zipcode10 cascade constraints;



create table zipcode10 (
        zipcode number(6) not null CONSTRAINT PK_ZIPCODE10_ZIPCODE PRIMARY key,
        si_do varchar2(200) not null,
        gu_gun varchar2(200) not null,
        bungi varchar2(200) not null
);

create table member10(
        m_id number(4) not null CONSTRAINT PK_MEMBER10_M_ID primary key,
        pass varchar2(200) not null,
        name varchar2(200) not null, 
        email varchar2(200) not null,
        zipcode number(6) null,
        -- foreign key ������� �߰� - zipcode10�� zipcode�� �����Ѵ�
            CONSTRAINT FK_MENBER10_ZIPCODE foreign key (zipcode) references ZIPCODE10(zipcode)
);

create table product10(
    pro_id number(6) not null CONSTRAINT PK_PRODUCT10_PRO_ID primary key,
    pro_name varchar2(200) not null,
    pro_price number(7,2) not null,
    pro_cnt number(4) default 0 not null
);

create table order10(
    ord_id number(6) not null CONSTRAINT PK_ORDER10_ORD_ID primary key,
    m_id number(4) not null,        -- FK : member10(m_id)
    pro_id number(6) not null,       -- FK : product10(pro_id)
        CONSTRAINT FK_ORDER10_M_ID foreign key (m_id) references member10(m_id),
        CONSTRAINT FK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)
);

----------------------------------------------------------------------------------

-- �� ���̺� ���ڵ� 5���� �ֱ�

-- ANSI JOIN �� Ȱ���Ͽ� �ֹ� ����(order10) ���̺��� �������� 
        -- �ֹ��ڸ�, �ֹ��� ���� �ּ�, �ֹ��� ����(��/��), �ֹ� ��ǰ��, ��ǰ�� ����
                     -- order10, member10, zipcode10, product10

----------------------------------------------------------------------------------

-- �� 5�� �ֱ�.

insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 112414, 'Seoul', 'Gangnam-gu', '23-bungi' ); 
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 444326, 'Busan', 'Haeundae-gu', '55-bungi' ); 
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 778908, 'Daejeon', 'Jung-gu', '15-bungi' ); 
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 054452, 'Jeonju', 'Wansan-gu', '51-bungi' ); 
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 766758, 'Incheon', 'Jung-gu', '272-bungi' ); 


insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0001, '1q2w3e4r', 'James', 'JamesLee0312@gmail.com' , 112414  ); 
insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0002, 'asdfghzxc', 'Karen', 'Karen_Program@gmail.com' , 444326  ); 
insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0003, 'poiuyt', 'Peach', 'hcaeP00348@gmail.com' , 778908  ); 
insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0004, 'lkjhhjkg', 'Leif', 'thracia776@gmail.com' , 054452  ); 
insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0005, 'nmmbnmgh', 'Arthur', 'Pendragon1127@gmail.com' , 766758  ); 

-- member10 ���� ����������, �ֹ��� ���� ���� ȸ��  - left outer join
insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0006, 'llloo3fs', 'bcccdfg', 'gvgvbbg@gmail.com' , 054452 ); 
insert into member10 ( m_id, pass, name, email, zipcode )
VALUES ( 0007, 'nngfg3442', 'noogkf', '885jjhgf@gmail.com' , 766758  ); 


select * from member10;


insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 38981, 'Computer', 1990.98,  231 ); 
insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 15437, 'Mouse', 30.58,  12 ); 
insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 776, 'Keyboard', 390.49,  678 ); 
insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 112457, 'EarPhone', 90.28,  87 ); 
insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 532, 'MousePad', 60.18,  561 ); 

-- �ֹ����� ���� ��ǰ
insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 7545, 'HeadPhone', 490.28,  4145 ); 
insert into product10 ( pro_id, pro_name, pro_price, pro_cnt )
VALUES ( 77869, 'CableTie', 0.178,  53 ); 




insert into order10 ( ord_id , m_id, pro_id )
VALUES ( 4713, 0001, 38981 ) ;
insert into order10 ( ord_id , m_id, pro_id )
VALUES ( 98790, 0002, 15437 ) ;
insert into order10 ( ord_id , m_id, pro_id )
VALUES ( 776, 0003, 776 ) ;
insert into order10 ( ord_id , m_id, pro_id )
VALUES ( 66466, 0004, 112457 ) ;
insert into order10 ( ord_id , m_id, pro_id )
VALUES ( 99906, 0005, 532 ) ;


---------------------------------------------------------------------------


-- ANSI JOIN ���� ����ؼ� �ֹ�����(Order10)���̺��� �������� 
     -- �ֹ��ڸ�, �ֹ��ڸ����ּ�, �ֹ��ڹ���(�õ�)
     -- �ֹ���ǰ��, ��ǰ�� ������ ��� �մϴ�. 
     -- order10, member10, zipcode10, product10
     
---------------------------------------------------------------------------    

select m.name, m.email, si_do , pro_name , pro_price
from order10 o 
join product10 p 
    on o.pro_id = p.pro_id
join member10 m
    on o.m_id = m.m_id
join zipcode10 z 
    on m.zipcode = z.zipcode ;   

-- �𵨸� ���� �ʴ� �ֹ� ���̺� - order11

create table order11(
    o_id number(6) not null primary key,
    
    m_name varchar2(200) not null,
    m_phone varchar2(200) not null,
    m_addr varchar2(200) not null,
    m_email varchar2(200) null,
    
    p_id number(6) not null,
    p_name varchar2(200) not null,
    p_price number(7,2) not null,
    p_cnt number(6) null
    
);

insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
values (0001, 'James', '010-1111-1111', 'Seoul' ,'JamesLee0312@gmail.com' , 38981, 'Computer', 1990.98,  231 );

-- �� ����� ��ȿ����, �뷮 ����

commit;

select * from order11;


/*
    JOIN : ANSI JOIN. 
        INNER JOIN : on ���� ������ ���� ���
        LEFT OUTER JOIN : ���� ���̺��� ��� ���� 
        RIGHT OUTER JOIN : ������ ���̺���
*/

-- member10 (��) -> zipcode10 (1) ���̺�
select *
from member10 m
    join zipcode10 z
        on m.zipcode = z.zipcode;


-- member10 ���̺��� �������� ������ zipcode10 ���̺��� ������ 
        --  �� right outer join
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 99352, 'Ansan ', 'Sangnok-gu', '897-bungi' ); 
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 1485, 'Seoul', 'Jung-gu', '553-bungi' ); 


select *
from member10 m 
    right join zipcode10 z
        on m.zipcode = z.zipcode;

-- �ֹ� ���̺�(order10), �ֹ��� ����(member10) <- on m_id
select * from order10;

select * 
from order10 o
    join member10 m 
        on o.m_id = m.m_id;

select * 
from order10 o
    right join member10 m 
        on o.m_id = m.m_id;

select * 
from order10 o
    left join member10 m 
        on o.m_id = m.m_id;

-- 3�� ���̺� join : order10 member10 zipcode10
select * 
from order10 o
    join member10 m 
        on o.m_id = m.m_id
    join zipcode10 z        -- order�� ����Ǿ� ���� ���� member�� ���� �� 
        on m.zipcode = z.zipcode;

-- 4�� ���̺� 
select * 
from order10 o
    join member10 m 
        on o.m_id = m.m_id
    join zipcode10 z        
        on m.zipcode = z.zipcode
    join product10 p
        on o.pro_id = p.pro_id;
        
-- �ֹ����� ���� ����� ����, �Ǹŵ��� ���� ��ǰ 
select * 
from order10 o
    join member10 m 
        on o.m_id = m.m_id
    join zipcode10 z        
        on m.zipcode = z.zipcode
    right join product10 p
        on o.pro_id = p.pro_id;
        
select * 
from member10 m
   left join order10 o 
        on o.m_id = m.m_id
    join zipcode10 z        
        on m.zipcode = z.zipcode
     left join product10 p
        on o.pro_id = p.pro_id;
        








