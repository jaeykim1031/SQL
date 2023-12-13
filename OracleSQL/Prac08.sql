create table sale40(
    sale_date date default sysdate not null  CONSTRAINT PK_SALE40_SALE_DATE PRIMARY key ,
    
    wine_code varchar2(6) not null,
        CONSTRAINT FK_SALE40_WINE_CODE FOREIGN key(wine_code) REFERENCES wine40(wine_code),
    mem_id varchar2(30) not null ,
        CONSTRAINT FK_SALE40_MEM_ID FOREIGN key(mem_id) REFERENCES member40(mem_id),
    
    sale_amount varchar2(5) default '0' not null ,
    sale_price varchar2(6) default '0' not null ,
    sale_tot_price varchar2(15)default '0' not null 
);

create table member40 (
    mem_id varchar2(6) not null CONSTRAINT PK_MEMBER40_MEM_ID PRIMARY key,
    mem_pw varchar2(20) not null,
    
    mem_grade varchar2(20), 
        CONSTRAINT FK_MEMBER40_MEM_GRADE foreign key(mem_grade) REFERENCES grade_pt_rade40(mem_grade),
        
    mem_birth date default sysdate not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) not null
);

create TABLE grade_pt_rade40(
    mem_grade varchar2(20) not null CONSTRAINT PK_GRADE_PT_RADE40_MEM_GRADE PRIMARY key,
    grade_pt_rate number(3,2)
);

create TABLE today40(
    today_code varchar2(6) not null CONSTRAINT PK_TODAY40_TODAY_CODE PRIMARY key,
    today_sense_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
);

CREATE table nation40(
    nation_code varchar2(26) not null CONSTRAINT PK_NATION40_NATION_CODE PRIMARY KEY,
    nation_name varchar2(50) not null 
);

create table wine40(
    wine_code varchar2(26) not null CONSTRAINT PK_WINE40_WINE_CODE PRIMARY key,
    wine_name varchar2(100) not null,
    wine_url blob,   
    
    nation_code varchar2(6),
        CONSTRAINT FK_WINE40_NATION_CODE FOREIGN key(nation_code) REFERENCES nation40(nation_code),
    wine_type_code varchar2(6),
        CONSTRAINT FK_WINE40_wine_type_code FOREIGN key(wine_type_code) REFERENCES wine_type40(wine_type_code),
    wine_sugar_code number(2),
    
    wine_price number(15),
    wine_vintage date,
    
    theme_code varchar2(6),
        CONSTRAINT FK_WINE40_THEME_CODE FOREIGN key(theme_code) REFERENCES theme40(theme_code) ,
    today_code varchar2(6),
        CONSTRAINT FK_WINE40_TODAY_CODE FOREIGN key(today_code) REFERENCES today40(today_code)
);


CREATE table theme40(
    theme_code varchar2(6) not null CONSTRAINT PK_THEME40_theme_CODE PRIMARY KEY,
    theme_name varchar2(50) not null 
);

CREATE table stock_management40(
    stock_code varchar2(6) not null CONSTRAINT PK_STOCK_MANAGEMENT40_STOCK_CODE PRIMARY key,
    
    wine_code varchar2(6),
        CONSTRAINT FK_STOCK_MANAGEMENT40_WINE_CODE FOREIGN key(wine_code) REFERENCES wine40(wine_code),
    manager_id varchar2(30),
        CONSTRAINT FK_STOCK_MANAGEMENT40_MANAGER_ID FOREIGN key(manager_id) REFERENCES manager40(manager_id),
    
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null 
);

create table manager40(
    manager_id varchar2(30) not null CONSTRAINT PK_MANAGER40_MANAGER_ID PRIMARY key,
    manager_pwd varchar2(30) not null,
    manager_tel varchar2(20)
);

create table wine_type40(
    wine_type_code varchar2(6) not null CONSTRAINT PK_WINE_TYPE40 PRIMARY key,
    wine_type_name varchar2(50)
);

---------------------------------------------------------------------------------------------

insert into sale40
VALUES ( sysdate , '312312', '000001', '3124','413130','214500' );






