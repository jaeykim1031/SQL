/*
    JOIN 실습
        member10 : 회원 정보를 저장하는 테이블
        zipcode10 : 우편번호를 저장하는 
        product10 : 제품 정보를
        order10 : 주문 정보를
 
*/

--    테이블 삭제 : Foregin Key가 참조하는 테이블은 삭제 되지 않는다 
--                    - cascade constraints 옵션을 이용해 강제 삭제 가능 

drop table zipcode10;
drop table member10;

select * from user_constraints where table_name = 'MEMBER10';

drop table order10;         -- 참조하는 테이블 삭제시 참조 받는 테이블 삭제 가능

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
        -- foreign key 계약조건 추가 - zipcode10의 zipcode를 참조한다
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

-- 각 테이블에 레코드 5개씩 넣기

-- ANSI JOIN 을 활용하여 주문 정보(order10) 테이블을 기준으로 
        -- 주문자명, 주문자 메일 주소, 주문자 번지(시/도), 주문 제품명, 제품의 가격
                     -- order10, member10, zipcode10, product10

----------------------------------------------------------------------------------

-- 값 5개 넣기.

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

-- member10 에는 존재하지만, 주문은 하지 않은 회원  - left outer join
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

-- 주문되지 않은 제품
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


-- ANSI JOIN 문을 사용해서 주문정보(Order10)테이블을 기준으로 
     -- 주문자명, 주문자메일주소, 주문자번지(시도)
     -- 주문제품명, 제품의 가격을 출력 합니다. 
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

-- 모델링 되지 않는 주문 테이블 - order11

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

-- ↑ 상당히 비효율적, 용량 과다

commit;

select * from order11;


/*
    JOIN : ANSI JOIN. 
        INNER JOIN : on 절에 공통의 값만 출력
        LEFT OUTER JOIN : 왼쪽 테이블의 모든 내용 
        RIGHT OUTER JOIN : 오른쪽 테이블의
*/

-- member10 (다) -> zipcode10 (1) 테이블
select *
from member10 m
    join zipcode10 z
        on m.zipcode = z.zipcode;


-- member10 테이블에는 참조되지 않지만 zipcode10 테이블에는 존재함 
        --  ↑ right outer join
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 99352, 'Ansan ', 'Sangnok-gu', '897-bungi' ); 
insert into zipcode10 ( zipcode, si_do, gu_gun, bungi )
VALUES ( 1485, 'Seoul', 'Jung-gu', '553-bungi' ); 


select *
from member10 m 
    right join zipcode10 z
        on m.zipcode = z.zipcode;

-- 주문 테이블(order10), 주문자 정보(member10) <- on m_id
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

-- 3개 테이블 join : order10 member10 zipcode10
select * 
from order10 o
    join member10 m 
        on o.m_id = m.m_id
    join zipcode10 z        -- order와 연결되어 있지 않음 member와 연결 됨 
        on m.zipcode = z.zipcode;

-- 4개 테이블 
select * 
from order10 o
    join member10 m 
        on o.m_id = m.m_id
    join zipcode10 z        
        on m.zipcode = z.zipcode
    join product10 p
        on o.pro_id = p.pro_id;
        
-- 주문하지 않은 사용자 정보, 판매되지 않은 제품 
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
        








