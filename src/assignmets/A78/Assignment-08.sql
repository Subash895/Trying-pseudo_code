-- ___________________________________ (06)
-- sitestscore less than average (Subquery)
select *
from ExternalCandidate
where siTestScore <
      (
          select avg(siTestScore)
          from ExternalCandidate
      );
-- ___________________________________ (07)
-- cState NOT in Kansas, Virginia, Georgia (Subquery)
select *
from ExternalCandidate
where cState not in
      (
          select cState
          from ExternalCandidate
          where cState in ('Kansas','Virginia','Georgia')
      );
create table Supplier(
                         SupId varchar(10) primary key,
                         SupName varchar(50),
                         SupPhone varchar(20)
);
insert into Supplier values
                         ('S001','ABC Traders','9991112222'),
                         ('S002','Global Supplies','8882223333'),
                         ('S003','Prime Mart','7773334444');
create table Orders(
                       OrderId varchar(10) primary key,
                       OrderDate date,
                       SupplierId varchar(10),
                       foreign key (SupplierId) references Supplier(SupId)
);
insert into Orders values
                       ('O001','2024-01-10','S001'),
                       ('O002','2024-02-15','S002'),
                       ('O003','2024-03-20','S001');
-- ___________________________________ (08)
-- INNER JOIN Supplier & Orders
select *
from Supplier s
         inner join Orders o
                    on s.SupId = o.SupplierId;
-- ___________________________________ (09)
-- LEFT OUTER JOIN
select *
from Supplier s
         left join Orders o
                   on s.SupId = o.SupplierId;
-- ___________________________________ (10)
-- RIGHT OUTER JOIN
select *
from Supplier s
         right join Orders o
                    on s.SupId = o.SupplierId;
-- ___________________________________ (11)
-- Departments where Head name starts with M
select *
from Department
where DeptHeadName like 'M%';
-- ___________________________________ (12)
-- PositionDescription for employees referred by Agencies
select p.PositionDescription
from Position p
where p.PositionId in
      (
          select e.PositionId
          from Employee e
          where e.CandidateId in
                (
                    select CandidateId
                    from ExternalCandidate
                    where cAgencyCode is not null
                )
      );
-- ___________________________________ (13)
-- Employees whose Position CurrentStrength > 50
select *
from Employee
where PositionId in
      (
          select PositionId
          from Position
          where CurrentStrength > 50
      );
-- ___________________________________ (14)
-- Position description for referred candidates (JOIN method)
select distinct p.PositionDescription
from Position p
         join Employee e on p.PositionId = e.PositionId
         join ExternalCandidate ec on e.CandidateId = ec.CandidateId
where ec.cAgencyCode is not null;
-- ___________________________________ (15-A)
-- Employee skills for referred candidates
select es.*
from EmployeeSkill es
         join Employee e on es.EmployeeId = e.EmployeeId
         join ExternalCandidate ec on e.CandidateId = ec.CandidateId
where ec.cAgencyCode is not null;
-- ___________________________________ (15-B)
-- Employee skills for NOT referred candidates
select es.*
from EmployeeSkill es
         join Employee e on es.EmployeeId = e.EmployeeId
         join ExternalCandidate ec on e.CandidateId = ec.CandidateId
where ec.cAgencyCode is null;