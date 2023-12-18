use myDB; 



-- 부모 테이블은 다른 테이블에서 참조하기 때문에 삭제가 불가능 : cascade constraints
/*
drop table Members cascade constraints;  
drop table Addresses cascade constraints;
drop table Products cascade constraints;  
drop table Orders cascade constraints;
*/ 

/* 
    int : 4byte  === > NUMBER (4)
    
    -- NUMBER : Oracle , 정수, 실수 
    NUMBER (4) : 정수 4자리만 입력 
    NUMBER (10, 2) : 실수 , 전체 10자리, 소숫점이하 2자리 
    
    int : MS-SQL, MySQL 
    Varchar : MS-SQL, MySQL 
    
    Varchar2 (10) : 오라클에서만 적용되는 자료형 : varchar ===> varchar2 
    
*/ 


/* 
	DML : 트랜잭션이 작동 ( Insert, Update, Delete )  
		MS-SQL, MY-SQL 자동 커밋 트랜잭션 

*/ 

-- desc Members; 

-- Members 테이블
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20) 
);

-- Addresses 테이블
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    MemberID INT,
    AddressLine1 VARCHAR(100),
    AddressLine2 VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(20),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Products 테이블
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price float,
    Description VARCHAR(500)
);

-- Orders 테이블
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    MemberID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- Members 테이블에 레코드 5개 삽입
INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '1234567890');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (3, 'David', 'Johnson', 'david.johnson@example.com', '5555555555');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (4, 'Sarah', 'Williams', 'sarah.williams@example.com', '9999999999');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (5, 'Michael', 'Brown', 'michael.brown@example.com', '1111111111');

-- Addresses 테이블에 레코드 5개 삽입
INSERT INTO Addresses (AddressID, MemberID, AddressLine1, AddressLine2, City, State, ZipCode)
VALUES (1, 1, '123 Main St', 'Apt 4B', 'New York', 'NY', '10001');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, City, State, ZipCode)
VALUES (2, 2, '456 Elm St', 'Los Angeles', 'CA', '90001');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, City, State, ZipCode)
VALUES (3, 3, '789 Oak Ave',  'Chicago', 'IL', '60601');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, AddressLine2, City, State, ZipCode)
VALUES (4, 4, '321 Pine St', 'Suite 10', 'Seattle', 'WA', '98101');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, City, State, ZipCode)
VALUES (5, 5, '555 Maple Dr', 'Dallas', 'TX', '75201');

-- Products 테이블에 레코드 5개 삽입
INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (1, 'iPhone 12', 999.99, 'Latest iPhone model');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (2, 'Samsung Galaxy S21', 899.99, 'Flagship Android smartphone');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (3, 'MacBook Pro', 1999.99, 'Powerful laptop for professionals');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (4, 'Sony PlayStation 5', 499.99, 'Next-gen gaming console');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (5, 'Amazon Echo Dot', 49.99, 'Smart speaker with voice assistant');

-- Orders 테이블에 레코드 5개 삽입
INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (1, 1, 1, '23/01/01', 3);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (2, 2, 4, '23/02/01', 5);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (3, 5, 5, '23/03/13', 2);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (4, 3, 4, '23/05/1', 7);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (5, 3, 5, '23/01/01', 2);

-- Ansi Join 

select * from Members; 
select * from addresses; 
select * from products; 
select * from orders; 


-- 1. inner join (ansi)
		-- 주문자의 이름, 전화번호, 주소, 제품명, 가격, 구매일, 갯수를 출력
select orderID, m.memberID, p.ProductID, FirstName, LastName, phoneNumber, addressLine1, city, productName, price, orderDate, quantity
from orders o
	join Members m
		on o.MemberID = m.MemberID
	join Addresses a
		on m.MemberID = a.MemberID
	join products p
		on o.productID = p.productID;

select * from members; 

-- 2. outer join 
		-- 주문 하지 않은 사용자 정보를 출력
		-- 주문 되지 않은 제품 정보
select *
from Orders o
	right outer join Members m
		on o.MemberID = m.MemberID
where OrderID is null ;

select LastName, FirstName
from Orders o
	right outer join Members m
		on o.MemberID = m.MemberID
where OrderID is null ;

-- 주문되지 않는 제품 정보

select ProductName
	from Orders o 
	right join Products p
		on o.ProductID = p.ProductID
	where Orderid is null;

select FirstName
	from Members m 
		left join Orders o
			on m.MemberID = o.MemberID;













