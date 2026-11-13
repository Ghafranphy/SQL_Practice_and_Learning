/* =====================================================================
   Project       : SQL Server Practice – SalesDB
   Description   : Hands-on SQL Server practice covering fundamental,
                   intermediate, and advanced SQL concepts.

   Topics Covered:
       01. CASE Statements and Conditional Logic
       02. Aggregate Functions and GROUP BY
       03. Window Functions and PARTITION BY
       04. Ranking and Analytical Functions
       05. Running Totals and Window Frames
       06. Subqueries and Correlated Subqueries
       07. Common Table Expressions (CTEs)
       08. Recursive CTEs and Hierarchical Queries
       09. Views and Temporary Tables
       10. Stored Procedures and Error Handling
       11. Triggers and Identity Columns
       12. Clustered and Nonclustered Indexes
       13. Columnstore Indexes and Storage Formats
       14. Index Monitoring and Performance Tuning
       15. Database Statistics and Index Fragmentation
       16. Query Execution and JOIN Optimization
       17. Table Partitioning and Filegroups

   Database      : SalesDB
   Platform      : Microsoft SQL Server
   Language      : T-SQL
   Author        : Ghafran Khan
   ===================================================================== */

select
category,
Sum(Sales) as totalsales
From (
Select
OrderID,
Sales,
Case 
When sales > 50 then 'high'
When sales < 50 then 'medium'
else 'low'
end as category
From Sales.Orders
)t
Group by category
order by totalsales DESC

-- Find the average score of the customers and treat Nulls as 0 additionally
-- provide details such as customer ID and LastName

Select
Score as avgscore,
removenull
From
(
Select
CustomerID,
LastName,
score,
Case 
when Lastname is Null then 'unknown'
else LastName
end as removenull
From  sales.customers
)t

Select
totalsales,
OrderID
From (
Select
OrderID,
Sales,
Case
when Sales > 30 then 1
else 0
end  as totalsales
From Sales.Orders)t
--Group by OrderID, sales30
where sales30=1

Select
Country,
Min(Score) as miniscore,
Max(Score) as maxscore,
AVG(Score) as avgscore
from sales.Customers
Group by Country
 

 Select
 OrderID,
 OrderDate,
 ProductID,
 SUm(Sales) as totalsales
 From Sales.Orders
 Group by ProductID   -- four products

 Select
 OrderID,
 OrderDate,
 ProductID,
 Sum(Sales) over(partition by ProductID)
 From SaLes.Orders

 
 Select
 OrderID,
 OrderDate,
 ProductID,
 Sum(Sales) over()
 From SaLes.Orders

 Select
 orderID,
 Orderdate,
 ProductID,
 Sales,
 orderstatus,
  Sum(Sales) over() as totalsales1,
 Sum(Sales) over(partition by ProductID) as totalsales2,
  Sum(Sales) over(partition by ProductID,orderstatus) as totalsales3,
    Sum(Sales) over(partition by ProductID,orderstatus order by Sales DESC) as totalsales4
 From Sales.Orders

 Select
 OrderID,
 OrderDate,
 Orderstatus,
 Sales,
 Sum(Sales) over (partition by Orderstatus order by orderstatus) as totalsales
 From Sales.Orders
 where ProductID in (101,102)

 
 Select
CustomerID,
 Sum(Sales),
 Rank() over(order by Sum(Sales) DESC) as rankfunc
 From Sales.Orders
 Group by CustomerID


  Select
CustomerID,
Count(Sales) over(partition by productID) as totalsalesbyproductid
 From Sales.Orders

 Select
 OrderID,
 OrderDate,
 CustomerID,
 Count(OrderID) over(partition by CustomerID) as orderidcus
 From Sales.Orders

 Select
 CustomerID,
 Country,
 LastName,
 Count(Score) over() as dcoreoder,
 Count(Country) over(partition by LastName)
 From Sales.Customers

 Select
 OrderID,
 Count(*)  over(partition by OrderID)
 From Sales.Orders

 select *
 From(
 Select
 OrderID,
 Count(*) over(partition by orderID)  as countorderid
 From Sales.OrdersArchive)t
 where countorderid>1

 Select
 orderID,
 OrderDate,
 Sales,
 Sum(Sales) over(partition by productID) as totalsales
 From Sales.Orders

 Select
 OrderID,
 ProductID,
 Sales,
 Sum(Sales) over(),
 round(Cast(Sales as float)/SUm(Sales) over() * 100,2) as percentagesales
 From Sales.Orders


 Select*
 From
 (
 Select
 CustomerID,
 OrderID,
 Sales,
 AVG(Sales) over(Partition by CustomerID )  as avgsales
 From Sales.orders)t
 where Sales>avgsales

 Select
 
Max(Sales) over(),
min(Sales) over()
 From Sales.Orders

 Select
 OrderID,
 ProductID,
 OrderDate,
 Sales,
 AVG(Sales) over(partition by ProductID) as avgproduct,
  AVG(Sales) over(partition by ProductID order by Sales
  Rows between current row and 2 following) as runningavgproduct
 From Sales.Orders

 use SalesDB
 Select
 OrderID,
 OrderDate,
 Sales,
 rank() over(order by sales Desc) as ranknum,  -- sharesamerank
  row_number() over(order by sales Desc)  as rownum,
  DENSE_RANK()  over (order by sales) as denserank
 From Sales.orders

 Select *
 From (
 Select
 OrderID,
 CreationTime,
 Sales,
 Rank() over(partition by orderID Order by Creationtime Desc) ranksales,
 Ntile(2) over(order by Sales DESC)
 From Sales.OrdersArchive)t
 where ranksales=1


 
 Select
 OrderID,
 CreationTime,
 Sales,
 Rank() over(partition by orderID Order by Creationtime Desc) ranksales,
 Ntile(2) over(order by Sales DESC) as bucket,
 CUME_DIST() over(order by Sales DESC) as cumedistu,
 Round(PERCENT_RANK() over(order by Sales DESC),2) as percentdist,
 Lead(Sales,1,0) over(Order by OrderID) as leadfunction,
 Lag(Sales,1,0) over(Order by OrderID) as lagfunction
 From Sales.OrdersArchive



 Select 
 *,
 currentmonth-previousmonth
From(
 Select
 Month(orderDate) as ordermonth,
 Sum(Sales) as currentmonth,
 Lag(Sum(Sales)) over(order by Month(orderDate)) as previousmonth
 From Sales.Orders
 Group by Month(OrderDate)
 )t


 Select
 CustomerID,
 AVG(daysinorder)as avgdays,
 Rank() over(Order by AVG(daysinorder) ASC ) as rankiavg
 From(
 Select
 OrderID,
 CustomerID,
 OrderDate as currentorderdate,
 Lead(OrderDate) over(partition by CustomerID order by OrderDate) as nextorder,
 DATEDIFF(day,OrderDate,Lead(OrderDate) over(partition by CustomerID order by OrderDate)) as daysinorder
 From Sales.Orders
-- Order by CustomerID, OrderDate
 )t
 Group by CustomerID


 Select
 *
 From INFORMATION_SCHEMA.TABLES

 Select
 OrderId
 From Sales.Orders


 Select
 Score
 From (Select
 Score
 From Sales.Customers
 where Score>100)t

 Select
 *,
 Rank() over(order by totalsales) as rankontoalsales
 From(
 Select
 CustomerID,
 SUm(Sales) as totalsales
 From Sales.Orders
 Group by CustomerID)t

 Select
 OrderID,
 Sales,
 ( Select
 Score
 From Sales.Customers
 where Score=900)
 From Sales.Orders

 Select*
 From Sales.Customers
 where Score=900


 Select
 c.*,
 o.totalorders
 From Sales.Customers as c
 Left join (
 Select
 CustomerID,
 Count(*) as totalorders
 From Sales.Orders 
 Group by CustomerID) o
 On c.CustomerID=o.CustomerID



 Select
 productID,
 price,
 ( Select AVG(Price) From Sales.Products) as avgprice
 From Sales.Products
 where Price>( Select
 AVG(Price)
 From Sales.Products
 )

 Select
 *
 From Sales.Orders
 where CustomerID in (

 Select
 CustomerID
 From Sales.Customers
 where Country = 'Germany'
 )

Select
*,
(Select Count(*) From Sales.Orders as o
where o.CustomerID=c.CustomerID) as totalsales
From Sales.Customers as c

Select
*
From Sales.Customers as c
where  EXISTS (Select 
        1
        From Sales.Orders as o
        where Country='Germany'
        AND o.CustomerID=c.CustomerID )

-- Step1: Find the total sales per customer
With CTE_totalsales as (
Select
CustomerID,
SUM(Sales) as totalsales
From Sales.Orders
Group by CustomerID
),

--Find teh last order date fro each customer
CTE_lastorder as (
Select
CustomerID,
Max(OrderDate) as lastorder
From Sales.Orders
Group by CustomerID
),
-- Steep3: Rank customer base on totalsales from each customer

CTE_rank_customer as (
Select
CustomerID,
totalsales, 
rank() over (order by totalsales DESC) as customerrank
From CTE_totalsales
),
-- step 4 segement customer based on totalsales
CTE_segement_sales as (
Select
CustomerID,
totalsales,
Case when totalsales > 100 then 'High'
     when  totalsales > 50 then 'medium'
          else 'low'
          end as segemntsales
From CTE_totalsales

)
-- Mian Query
Select
c.CustomerID,
c.FirstName,
c.LastName,
cts.totalsales,
clo.lastorder,
ccr.customerrank,
ssg.segemntsales
From Sales.Customers as c
Left Join CTE_totalsales as cts
on c.CustomerID=cts.CustomerID
Left join CTE_lastorder as clo
on c.CustomerID= clo.CustomerID
left join CTE_rank_customer as ccr
on c.CustomerID= ccr.CustomerID
left join CTE_segement_sales as ssg
on c.CustomerID=ssg.CustomerID


With CTE_Series as (
-- Anchor Query
Select
1 as mynumber
union all
select
mynumber+1
from CTE_Series
where mynumber <20
)
-- Main Query
Select
mynumber
From CTE_Series
Option (Maxrecursion 100)

with CTE_employee_hirachy as (
Select
EmployeeId,
FirstName,
ManagerID,
1 as level
From Sales.Employees
where ManagerID is Null
union all
select
e.EmployeeId,
e.FirstName,
e.ManagerID,
level+1
From Sales.Employees as e
inner Join CTE_employee_hirachy as ceh
on e.ManagerID=ceh.EmployeeID
)
Select
*
From CTE_employee_hirachy

with CTE_monthly_Summary As (
Select
DateTrunc(month,OrderDate) as ordermonth,
SUM(Sales) as totalsales,
count(OrderID) as totalorder,
Sum(Quantity) as totalquantity
From Sales.orders
Group by DateTrunc(month,OrderDate)
)
Select
OrderMonth,
totalsales,
SUM(totalsales) over (order by ordermonth) as runningtotal
From CTE_monthly_Summary


Drop View Sales.V_Monthly_2nd

If OBJECT_ID ('Sales.V_Monthly_2nd','V') is not null
Drop View Sales.V_Monthly_2nd ;
Go
Create VIEW Sales.V_Monthly_2nd as 
(
Select
DateTrunc(month,OrderDate) as ordermonth,
SUM(Sales) as totalsales,
count(OrderID) as totalorder,
Sum(Quantity) as totalquantity
From Sales.orders
Group by DateTrunc(month,OrderDate)
)

Select
*
From V_Monthly_2nd


Select
OrderMonth,
totalsales,
SUM(totalsales) over (order by ordermonth) as runningtotal
From V_Monthly_2nd
 Drop View Sales.V_Monthly_2nd

If OBJECT_ID ('Sales.VIE_complex','V') is not null
Drop View Sales.VIE_complex ;
Go
 Create view Sales.VIE_complex As (
 Select
 o.OrderID,
 o.OrderDate,
 p.Product,
 p.Category,
 Coalesce(c.FirstName,'') + '' + Coalesce(c.LastName,'') as customerName,
 c.Country as customercountry,
 Coalesce(e.FirstName,'') + '' + Coalesce(e.LastName,'') as SalesName,
 e.Department,
 --CustomerID,
 --SalesPersonID
 o.Sales,
 o.Quantity
 From Sales.orders as o
 Left join Sales.products as p
 On p.ProductID=o.ProductID
 left join Sales.Customers as c
 on c.CustomerID=o.CustomerID
 left join Sales.Employees e
 on e.EmployeeID=o.SalesPersonID
 where c.Country != 'USA'
 )
 Select
 *
 From Sales.VIE_complex


 IF OBJECT_ID('Sales.monthlyorders33','U') is not null
  Drop Table Sales.monthlyorders33
  Go
 Select
 DateName(month,OrderDate) as ordermonth,
 Count(OrderID) as totalorders
 INTO Sales.monthlyorders33
 From Sales.Orders
 Group by DateName(month,OrderDate)

 Select * From Sales.monthlyorders33
 Drop Table Sales.monthlyorders33
 
 Select
 *
 INTO #orders45
 From Sales.Orders
 

 Select*
 From #orders45

 Delete From #orders45
 where OrderStatus='Delivered'

 Select
 *
 Into Sales.order45
 From #orders45

 Delete Sales.order45



 -- Step1: Write a Query
 -- For US Customers Find the totoal Number of Customers and the Avg Score


 Select
 Count(*) as totalcustomers,
 AVG(Score) as avgscore
 From Sales.Customers
 where Country= 'USA'



 -- Step2 : Turning the Query into a Stored Procedure

 Alter procedure GEtcustomersummary45 @Country NVARCHAR(50) = 'USA'
 as 
 begin

 Begin Try

 Declare @TotalCustomers INT, @AVGScore FLOAT, @TEST INT
 --Prepare and clean up data
 If EXISTS (select 1 From Sales.Customers where Score is Null AND Country=@Country)
 Begin
 Print ('Updating Null Score to 0')
   UPDATE Sales.Customers
   SET SCORE=0
   where Score is Null and Country= @Country;
 end

 else 
 begin
 Print('NO Null Score is found')
 end;
 -- Generating report
 Select
   @TotalCustomers = Count(*) ,
 @AVGScore= AVG(Score),
 @TEST=1/0
 From Sales.Customers
 where Country= @Country;

 PRINT 'Total Customers From ' + @Country + ':' + Cast(@TotalCustomers as NVARCHAR);
 PRINT 'Average Score From' +  @Country + ':' + CAST(@AVGScore as NVARCHAR);
 
 -- FInd the total Nr. of orders and total Sales
 Select
 COUNT(OrderID) as totalOrders,
 SUM(Sales) totalSales
 From Sales.orders o
 Join Sales.Customers c
 On c.CustomerID=o.CustomerID
 where c.Country=@Country;
 end Try
 Begin Catch
 Print ('An error occurded.');
 Print ('Error Message:' + Error_Message());
 Print('Error Number:' + cast(Error_Number() as varchar));
 Print ('Error Line:' + Cast(Error_Line() as varchar));
 Print ('Error Procedure' + cast(Error_procedure() as varchar))
 end Catch
 end

 -- Step 3: Execute the stored procedure
 EXEC GEtcustomersummary45 @Country = 'Germany'



 Create Table Sales333 (
 LodID INT IDentity(1,1) primary Key,
 EmployeeID INT,
 LogMessage VARCHAR(255),
 LogDate DATE
 )
 Create trigger trg_afterinsertSales on Sales333
 After insert
 As 
 begin
      insert into sales333 (EmployeeID, LogMessage, LogDate)
      select
      EmployeeID,
      'NEW Employee Added=' + Cast(EmployeeID as varchar),
      GETDATE()
      From inserted
 end

 Select * From Sales333

 INSERT INTO Sales333 (EmployeeID, LogMessage, LogDate)
VALUES (4, 'Employee inserted', GETDATE());

 
 Select *
 INTO Sales.DB2Customers
 From Sales.Customers

 Select*
 From Sales.DB2Customers
 where CustomerID=1

 Create Clustered INDEX idx_DB2Customer_CustomerID
 on Sales.DB2Customers (CustomerID)

 DROP index idx_DB2Customer_CustomerID  on Sales.DB2Customers
  
  Select
  *
  from Sales.DB2Customers
  where LastName= 'Brown'


  Create nonclustered index idx_Customers_country_score on Sales.DB2Customers (Country, Score)

  Drop index idx_DB2Customer_CustomerID on Sales.DB2Customers
  Create Clustered columnstore index idx_DB2Customer_CS
  on Sales.DB2Customers
  -- we cannot cretae multiple clustered column index whethear clustered or non clustered

  -- Heap
  Select*
  INTO FactInternetSales_HP
  From FactInternetSales

   -- Roestore
  Select*
  INTO FactInternetSales_RS
  From FactInternetSales

  Create Clustered index idx_FactInternetSales_RS_Pk
  On FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber)





  
   -- Columnestore
  Select*
  INTO FactInternetSales_CS
  From FactInternetSales

  Create Clustered columnstore index idx_FactInternetSales_RS_Pk
  On FactInternetSales_CS 


  Select
  * 
  From Sales.Products
  Create unique nonclustered index idx_Products_product34 on Sales.Products (product)



  Insert into Sales.Products (productId,product) values (106, 'Caps')

  Select * From Sales.Customers
  where Country='USA'


  Create nonclustered index idx_customer_country_77 on  Sales.Customers (Country)
   where Country='USA'

   -- List all index on a specific table

   sp_helpindex 'Sales.DBCustomers'

   -- Monitor index usage

   Select  
   tbl.name as TableName,
   idx.object_id,
   idx.name as Indexname,
   idx.type_desc As IndexType,
   idx.is_primary_key as isPrimaryKey,
   idx.is_unique as IsUnique,
   idx.is_disabled as isdisabled,
   s.user_seeks as userseeks,
   s.user_scans as userscan,
   s.user_lookups as userlookups,
   s.user_updates as userupdates,
   Coalesce(s.last_user_seek,s.last_user_scan) as lastupdate
  From sys.indexes as idx
  Join sys.tables as tbl
  on idx.object_id=tbl.object_id
  left join sys.dm_db_index_usage_stats as s
  on s.object_id=tbl.object_id
  and s.index_id=idx.index_id
  order by tbl.name,idx.name



  Select * From sys.dm_db_index_usage_stats

  Select
  fs.SalesOrdernumber,
  dp.EnglishproductName,
  dp.color
  From FactInternetSales as fs
  inner join DimProduct as dp
  on fs.productkey= dp.productkey
  where dp.color='black'
  and fs.orderDateKey between 20101229 and 20101231



  Select
  *
  From sys.dm_db_missing_index_details

  Select
  tbl.name as tableName,
  col.name as IndexColumn,
  idx.name as indexname,
  idx.type_desc as indextype,
  count(*) over (partition by tbl.name, col.name) as columnCount
  From sys.indexes as idx 
  join sys.tables as tbl 
  on idx.object_id=tbl.object_id
  join sys.index_columns as ic
  on idx.object_id=ic.object_id
  and idx.index_id=ic.index_id
  join sys.columns as col
  on ic.object_id=col.object_id 
  and ic.column_id=col.column_id
  order by ColumnCount



  Select
  t.name as tableName,
  s.name as Statisticname,
  sp.modification_counter as modificationlastupdates
  --sp.last_updated as LastUpdate
  From sys.stats as s
  join sys.tables as t
  on s.object_id=t.object_id
  CROSS apply sys.dm_db_stats_histogram(s.object_id,s.stats_id) as sp
    
    EXEC sp_updatestats


    select*
    From sys.dm_db_index_physical_stats(DB_ID(), NUll,Null,Null,'limited')


    
   Select
   tbl.name as TableName,
   idx.name as indexname,
   s.avg_fragmentation_in_percent,
   s.page_count
   From sys.dm_db_index_physical_stats(DB_ID(), NUll,Null,Null,'limited') as s
   inner join sys.tables as tbl
   on s.object_id=tbl.object_id
   inner join sys.indexes as idx
   on idx.object_id=s.object_id
   and idx.index_id=s.index_id
   order by s.avg_fragmentation_in_percent DESC


   Alter index idx_products_product1 on sales.products Reorganize

      Alter index idx_products_product1 on sales.products Rebuild








      Select
      *
      Into FactResellerSales_HP
      From FactResellerSales


      Select
      *
      From FactResellerSales_HP
      where CarrierTrackingNumber = '4911-403C-98'

       Select
      *
      From FactResellerSales
      where CarrierTrackingNumber = '4911-403C-98'

      Create nonclustered index idx_FactReseller_CTA on  FactResellerSales (CarrierTrackingNumber)

      Select
      p.EnglishProductName as productname,
      sum(s.SalesAmount) as totalSales
      From FactResellerSales as s
      Join DimProduct as p
      on p.ProductKey=s.ProductKey
      group by p.EnglishProductName
  
   Select
      p.EnglishProductName as productname,
      sum(s.SalesAmount) as totalSales
      From FactResellerSales_Hp as s
      Join DimProduct as p
      on p.ProductKey=s.ProductKey
      group by p.EnglishProductName

      Create Clustered Columnstore index idx_FactResellerSalesHp 
      on FactResellerSales_Hp 

     Select
     o.Sales,
     c.Country
     From Sales.Orders as o
     Left Join Sales.Customers as c with (Forceseek)
     on o.CustomerID=c.CustomerID
     --Option (Hash join)


     -- Step1: create partition function

     Create Partition Function PartitionByYear2 (Date)
     AS Range Left For Values ('2023-12-31','2024-12-31','2025-12-31')

     -- Query lists all existing partition Function

     Select
     name,
     function_id,
     type,
     type_desc,
     boundary_value_on_right
     From sys.partition_functions



     --Step2: create Filegroups

     Alter Database SalesDB Add filegroup FG2_2023;
          Alter Database SalesDB Add filegroup FG2_2024;
     Alter Database SalesDB Add filegroup FG2_2025;
          Alter Database SalesDB Add filegroup FG2_2026;

          Select *
          From sys.filegroups
          where name= 'FG2_2023'


          -- Step 3: Add .ndf Files to Each Filegroup

          Alter database SalesDB Add file 

          ( Name=P2_2023, -- logical Name
          Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P2_2023.ndf'
          )To filegroup FG2_2023;

           Alter database SalesDB Add file 
           ( Name=P2_2024, -- logical Name
          Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P2_2024.ndf'
          )To filegroup FG2_2024


           Alter database SalesDB Add file 
           ( Name=P2_2025, -- logical Name
          Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P2_2025.ndf'
          )To filegroup FG2_2025


          Alter database SalesDB Add file 
           ( Name=P2_2026, -- logical Name
          Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P2_2026.ndf'
          )To filegroup FG2_2026


          -- Check the metadata

          Select
          fg.name as FilegroupName,
          mf.name as LogicalFileName,
          mf.physical_name as PhysicalFilePath,
          mf.size / 128 as SizeinMB
          From
          sys.filegroups as fg

          Join

          sys.master_files as mf on fg.data_space_id=mf.data_space_id
          where mf.database_id=Db_ID('SalesDB')


          -- Step4: Create Partition Scheme

          Create Partition Scheme SchemePartitionByYear2
          As Partition partitionByYear2
          To (FG2_2023, FG2_2024, FG2_2025, FG2_2026)


          -- Step5 : Cretae the partitioned table

          Create table Sales.Orders_partitioned2

          (

          OrderID INT,
          OrderDate Date,
          Sales INT

          )  On SchemePartitionByYear2


