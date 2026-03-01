show tables ;

create table ExternalCandidate(
candidateId INT PRIMARY KEY AUTO_INCREMENT,
vFirstName VARCHAR(50),
vLastName VARCHAR(50),
candidateAddress VARCHAR(50),
cCity VARCHAR(50),
cState VARCHAR(50),
candidatePhone VARCHAR(50),
candidateEmail VARCHAR(50),
siTestScore INT,
gender VARCHAR(50),
cAgencyCode VARCHAR(50),
dateOfApplication DATE,
dateOfBirth DATE
);
-- drop table ExternalCandidate;
-- _________________________________
insert into ExternalCandidate
(vFirstName, vLastName, CandidateAddress, cCity, cState, CandidatePhone, CandidateEmail, siTestScore, Gender, cAgencyCode, DateOfApplication, DateOfBirth)
VALUES
    ('John','Carter','Street 1','Seattle','Arizona','9999999999','john@mail.com
    ',75,'Male','AG01','2023-05-01','1998-04-01'),
    ('Emily','Daisy','Street 2','Norton','California','8888888888','emily@mail.com
    ',65,'Female',NULL,'2022-03-10','2000-02-15'),
    ('Robert','Lee','Street 3','Columbus','Alaska','7777777777','robert@mail.com
    ',82,'Male','AG02','2021-06-20','1995-09-09');
-- _____________________________________________--
select * from ExternalCandidate;
-- _______________________________________ (01)
select * from externalcandidate
where cstate is NULL;
-- _______________________________________ (02)
select * from ExternalCandidate
where cCity is not null;
-- _______________________________________ (03)
select *
from ExternalCandidate
where cCity in ('norton','seattle','columbus')
and  siTestScore > 70;
-- _______________________________________ (04)
select vfirstname, vlastname, ccity, cState
from ExternalCandidate
where cCity like 'c%'
or cCity like 'A%'
and (cState like 'a%'
    or cState like 'b%'
    or cState like 'c%'
    );
-- ___________________________________ (05)
-- CREATING Supplier table
create table Supplier(
SupId varchar(10) primary key,
SupplierName varchar(50),
SupplierAddress varchar(50),
SupplierPhone varchar(20),
SupplierMail varchar(50)
);
-- insert to suppliers
insert into Supplier values
('S001','ABC Traders','New York','9991112222','abc@mail.com'),
('S002','Global Supplies','Seattle','8882223333','global@mail.com'),
('S003','Prime Mart','Chicago','7773334444','prime@mail.com'),
('S004','NextGen Corp','Boston','6664445555','next@mail.com'),
('S005','United Goods','Dallas','5556667777','united@mail.com');
select * from Supplier;
-- ______________________________(06)
-- CREATING Product table
create table Products(
ProductId varchar(10) primary key,
ProductName varchar(50),
ProductDescription varchar(100),
ProductCategory varchar(50),
Price int
);
show tables;
-- INSERT
insert into Products
values
('P001','Laptop','Gaming Laptop','Electronics',70000),
('P002','Mobile','Smart Phone','Electronics',20000),
('P003','Table','Wooden Table','Furniture',8000),
('P004','Chair','Office Chair','Furniture',5000),
('P005','Watch','Digital Watch','Accessories',3000);
select * from Products;
-- CREATE Customer foreign key
create table Customer(
CustId varchar(10) primary key,
CustAddr varchar(50),
CustPhone varchar(20),
ProductId varchar(10),
QtyPurch int,
Value int,
foreign key (ProductId) references Products(ProductId)
);
-- INSERT
insert into Customer
values
('C001','Delhi','9999999999','P001',1,70000),
('C002','Mumbai','8888888888','P002',2,40000),
('C003','Chennai','7777777777','P003',1,8000),
('C004','Kolkata','6666666666','P004',3,15000),
('C005','Hyderabad','5555555555','P005',2,6000);
select * from Customer;
-- _____________________________(07)
select * from ExternalCandidate
where siTestScore between 60 and 80 ;
-- _____________________________(08)
select *
from ExternalCandidate
where vLastName like '%y'
or vLastName like '%a';
-- ______________________________(09)
select
    concat(vFirstName,' ',vLastName) as FullName,
    siTestScore,
    siTestScore+(siTestScore * 0.10) as increasedscore
    from ExternalCandidate;
-- ______________________________(10)
-- dateOfApplication not greater than 2 years
select *
from ExternalCandidate
where dateOfApplication >= date_sub(curdate(),interval 2 year );
/* select *
from ExternalCandidate
where dateOfApplication <= date_sub(curdate(),interval 2 year ); */
-- ______________________________(11)
-- all male candidate
select *
from ExternalCandidate
where gender ='male ';
-- ______________________________(12)
--  candidates referred throught agenies
select  *
from  ExternalCandidate
where cAgencyCode is not null;

-- ____________________________
-- CREATE Movie tables

create table Movies(
MovieId varchar(10) primary key,
MovieName varchar(50),
Category varchar(50),
MCollection int
);
-- INSERT movie table
insert into Movies values
('M001','Dark Knight','Drama',500),
('M002','Comedy Night','Comedy',300),
('M003','Action Hero','Action',400),
('M004','Dream Story','Drama',450),
('M005','Crazy Fun','Comedy',350);
select *
from movies;
-- _________________________________
show tables;
-- _______________________________(13)
-- avrage of mcollectionn of movies whose category starts with d or c
-- assuming table name movies fields Mcollection ,category
select avg(Mcollection) as averagecollection
from movies
where category like 'd%'
or category like 'c%';
-- ___________________________________(14)
-- Create Books Table

create table Books(
BookId varchar(10) primary key,
Title varchar(50),
Price int,
Category varchar(50),
Author varchar(50)
);

-- Insert Sample Records

insert into Books values
('B001','NB',1234,'SciFi','Keats'),
('B002','HJ',2333,'Comedy','Shelly'),
('B003','TY',3440,'Tragedy','Shakespeare'),
('B004','DR1',2000,'Drama','Arthur'),
('B005','CM1',1500,'Comedy','John'),
('B006','SC1',4000,'SciFi','Clark');
-- _______________________________(15)
-- min max avg price of book
select
    min(Price) as MinimumPrice,
    max(Price) as MaximumPrice,
    avg(Price) as AveragePrice
from Books;
-- _______________________________(16)
-- min max and avg price based on category
select
    Category,
    min(Price) as MinimumPrice,
    max(Price) as MaximumPrice,
    avg(Price) as AveragePrice
from Books
group by Category;
-- ______________________________(17)
-- same as above but only drama and comedy
select
    Category,
    min(Price) as MinimumPrice,
    max(Price) as MaximumPrice,
    avg(Price) as AveragePrice
from Books
where Category in ('Drama','Comedy')
group by Category;
-- ___________________________(18)
-- show individual records + aggreagate results
select
    Category,
    BookId,
    Title,
    Price,
    min(Price) over (partition by Category) as MinPrice,
    max(Price) over (partition by Category) as MaxPrice,
    avg(Price) over (partition by Category) as AvgPrice
from Books;
-- _______________________________(19)
-- first 5 characters of firstname and ascii value
select
    vFirstName,
    substring(vFirstName,1,5) as FirstFiveChars,
    ascii(substring(vFirstName,1,1)) as AsciiValue
from ExternalCandidate;
-- __________________________________(20)
-- display firstname last name and age in ascending order
select
    vFirstName,
    vLastName,
    timestampdiff(year, dateOfBirth, curdate()) as Age
from ExternalCandidate
order by Age asc;
-- __________________________________(21)
-- Show date of application and date + 2 yeat
select
    vFirstName,
    vLastName,
    dateOfApplication,
    date_add(dateOfApplication, interval 2 year) as AfterTwoYears
from ExternalCandidate;
-- ____________________________________-
