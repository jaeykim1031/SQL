/*
    JOIN �ǽ�
        member10 : ȸ�� ������ �����ϴ� ���̺�
        zipcode10 : �����ȣ�� �����ϴ� 
        product10 : ��ǰ ������
        order10 : �ֹ� ������
*/

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

insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )z
VALUES ( 054452, 'Jeonju', 'Wansan-gu', '51-bungi' ); 

insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 766758, 'Incheon', 'Jung-gu', '272-bungi' ); 


select * from zipcode10;

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

select * from product10;

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

select * from order10;


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
    on m.zipcode = z.zipcode
where o.ord_id = 4713;


select m.name, m.email, m.zipcode , pro_name , pro_price
from order10 o 
join product10 p 
    on o.pro_id = p.pro_id
join member10 m
    on o.m_id = m.m_id
where o.ord_id = 776;


select m.name, m.email, m.zipcode , pro_name , pro_price
from order10 o 
join product10 p 
    on o.pro_id = p.pro_id
join member10 m
    on o.m_id = m.m_id
where o.ord_id = 66466;


select m.name, m.email, m.zipcode , pro_name , pro_price
from order10 o 
join product10 p 
    on o.pro_id = p.pro_id
join member10 m
    on o.m_id = m.m_id
where o.ord_id = 99906;


select m.name, m.email, m.zipcode , pro_name , pro_price
from order10 o 
join product10 p 
    on o.pro_id = p.pro_id
join member10 m
    on o.m_id = m.m_id
where o.ord_id = 98790;









