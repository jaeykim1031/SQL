---------------------------------------------
/*
    데이터베이스 설계서
            -> 테이블 정의서
*/

create table member20(
        id varchar2(20) not null CONSTRAINT PK_member20_id PRIMARY key,
        pwd varchar2(20) not null,
        name varchar2(50) not null,
        address varchar2(20) not null,
        tel varchar2(13) not null,
        indate date default sysdate not null,   
        
        zipcode varchar2(7) not null,
            CONSTRAINT FK_member20_zipcode foreign key (zipcode) references zipcode20(zipcode)           
);


create table zipcode20(
        zipcode varchar2(7) not null CONSTRAINT PK_zipcode20_zipcode primary key,
        sido varchar2(30) not null,
        gugun varchar2(30) not null,
        dong varchar2(30) not null,
        bungi varchar2(30) not null
);

create table product20(
        product_code varchar2(20) not null CONSTRAINT PK_product20_product_code PRIMARY key,
        product_name varchar2(100) not null,
        product_kind char(1) not null ,
        product_price1 varchar2(10) not null ,
        product_price2 varchar2(10) not null ,
        product_content varchar2(1000) not null ,
        product_image varchar2(50) not null ,
        sizeSt varchar2(5) not null ,
        sizeEt varchar2(5) not null ,
        product_quantity varchar2(5) not null ,
        useyn char(1) not null ,
        indate date not null
);

create table orders20(
        o_seq number(10) not null CONSTRAINT PK_orders20_o_seq PRIMARY key,
        product_code varchar2(20)  not null ,       --
        id varchar2(16)  not null ,     --
        product_size varchar2(5)  not null , 
        quantity varchar2(5)  not null , 
        result char(1)  not null ,
        indate date   not null ,
        
            CONSTRAINT FK_orders20_product_code foreign key (product_code) references product20(product_code),
            CONSTRAINT FK_orders20_id foreign key (id) REFERENCES member20(id)
);

insert into member20 ( id, pwd, name, zipcode, address, tel, indate)
VALUES ( 'asdfgh', 'qwerty', 'abc', '12345', 'zxggfc', '010-0000-0000' , sysdate ); 
insert into member20 ( id, pwd, name, zipcode, address, tel, indate)
VALUES ( 'zxcvb', '1q2w3e4r', 'def', '67890', 'eerttw', '010-0000-0000' , sysdate ); 
insert into member20 ( id, pwd, name, zipcode, address, tel, indate)
VALUES ( 'qwerty', '0p9o8i7u', 'hij', '13579', 'ggfdg', '010-0000-0000' , sysdate ); 
insert into member20 ( id, pwd, name, zipcode, address, tel, indate)
VALUES ( 'mnbvbc', '6yhnbg', 'jkl', '24680', 'oipuu', '010-0000-0000' , sysdate ); 
insert into member20 ( id, pwd, name, zipcode, address, tel, indate)
VALUES ( 'poiuyt', '5tgbvf', 'mnop', '19283', 'g
dfgxx', '010-0000-0000' , sysdate ); 


insert into zipcode20 ( zipcode, sido, gugun, dong, bungi)
VALUES ( '12345', 'seoul', 'somewhere','nowhere', '1234' );
insert into zipcode20 ( zipcode, sido, gugun, dong, bungi)
VALUES ( '67890', 'newyork', 'somewhere','nowhere', '5678' );
insert into zipcode20 ( zipcode, sido, gugun, dong, bungi)
VALUES ( '13579', 'london', 'somewhere','nowhere', '9010' );
insert into zipcode20 ( zipcode, sido, gugun, dong, bungi)
VALUES ( '24680', 'tokyo', 'somewhere','nowhere', '1112' );
insert into zipcode20 ( zipcode, sido, gugun, dong, bungi)
VALUES ( '19283', 'paris', 'somewhere','nowhere', '1314' );


insert into product20 ( product_code , product_name, product_kind , product_price1 , product_price2 , product_content 
                        ,product_image ,sizeSt ,sizeEt ,product_quantity ,useyn ,indate)
VALUES ( '0001', 'keyboard', 'y', '123140', '100240', 'Mechanical Keyboard', 'keyboard image', 'tkl', 'full', '100', 'y', '23/1/23'  );
insert into product20 ( product_code , product_name, product_kind , product_price1 , product_price2 , product_content 
                        ,product_image ,sizeSt ,sizeEt ,product_quantity ,useyn ,indate)
VALUES ( '0002', 'mouse', 'y', '78900', '54800', 'wireless mouse', 'mouse image', 'basic', 'full', '435', 'y', '23/9/13'  );

insert into product20 ( product_code , product_name, product_kind , product_price1 , product_price2 , product_content 
                        ,product_image ,sizeSt ,sizeEt ,product_quantity ,useyn ,indate)
VALUES ( '0003', 'cooler', 'y', '34500', '100240', 'case cooler', 'cooler image', 'basic', 'full', '543', 'y', sysdate  );
insert into product20 ( product_code , product_name, product_kind , product_price1 , product_price2 , product_content 
                        ,product_image ,sizeSt ,sizeEt ,product_quantity ,useyn ,indate)
VALUES ( '0004', 'cpu', 'y', '726540', '545530', 'intel cpu', 'cpu image', 'k', 'not-k', '3', 'y', '23/1/23'  );
insert into product20 ( product_code , product_name, product_kind , product_price1 , product_price2 , product_content 
                        ,product_image ,sizeSt ,sizeEt ,product_quantity ,useyn ,indate)
VALUES ( '0005', 'ram', 'y', '54430', '44520', 'samsung ram', 'ram image', 'basic', 'full', '775', 'y', sysdate  );


insert into orders20 (  o_seq , product_code , id , product_size , quantity, result , indate  )
VALUES ( 11111 , '0001', 'asdfgh', 'tkl', '1' , 'n', sysdate );
insert into orders20 (  o_seq , product_code , id , product_size , quantity, result , indate  )
VALUES ( 22222 , '0002', 'zxcvb', 'basic', '4' , 'y', sysdate );
insert into orders20 (  o_seq , product_code , id , product_size , quantity, result , indate  )
VALUES ( 33333 , '0003', 'qwerty', 'basic', '5' , 'y', sysdate );
insert into orders20 (  o_seq , product_code , id , product_size , quantity, result , indate  )
VALUES ( 44444 , '0004', 'mnbvbc', 'not-k', '3' , 'n', sysdate );
insert into orders20 (  o_seq , product_code , id , product_size , quantity, result , indate  )
VALUES ( 55555 , '0005', 'poiuyt', 'full', '8' , 'y', sysdate );


select * from orders20;

------------------------------------------------------------------------------------------------

create view v_join4
as
select * 
from orders20 o
    join product20 p
        on o.product_code = p.product_code
    join member20 m
        on o.id = m.id
    join 


