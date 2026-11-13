/* ============================================================
   SQL Server Practice – SalesDB
   Description: SQL practice covering fundamental to advanced
                SQL Server concepts and techniques.
   Topics:
       1. Aggregate Functions
       2. Window Functions
       3. Ranking and Analytical Functions
       4. Subqueries and CTEs
       5. Recursive CTEs
       6. Views and Temporary Tables
       7. Stored Procedures and Error Handling
       8. Triggers
       9. Database Indexing
      10. Table Partitioning
      11. Query Performance Optimization

   Database: SalesDB
   Language: T-SQL
   ============================================================ */
Select
customer_id,
count(*) as total_num_order,
Sum(Sales) as total_sales,
AVG(Sales) as avg_sales,
Max(Sales) as maxsales
from orders
group by  customer_id



Select
Sales,
Sum(Sales) over()
from orders


Use SalesDB


Select
OrderID,
OrderDate,
ProductID,
Sum(Sales) over(partition by ProductID)   as total_sales_product
From Sales.Orders


Select
OrderId,
OrderDate,
ProductId,
OrderStatus,
Sum(Sales) over() as totalsales,
Sum(Sales) over(partition by ProductId) as totalsales_product,
Sum(Sales) over(partition by ProductId,OrderStatus) as totalsales_product_orderstatus,
Sales,
Sum(Sales) over(partition by ProductId Order by Sales DESC) as totalsales_product_2,
Sum(Sales) over( Order by Sales DESC rows between current row and 2  following) as totalsales_product_23,
Sum(Sales) over (Order by Sales DESC rows between current row and unbounded following) as totalsales_frame,
Sum(Sales) over (Order by Sales DESC rows between 1 preceding and current row) as totalsales_frame34,
Sum(Sales) over (Order by Sales DESC rows between 1 preceding and 1 following) as totalsales_frame35
From Sales.Orders


Select
CustomerID,
SUM(Sales) as totalsales,
rank() over(order by SUM(Sales)  DESC) as rankcustomer
From Sales.Orders
group by CustomerID

Select
orderId,
OrderDate,
Count(Sales) over() as totalorder,
CustomerID,
Count(*) over(Partition by CustomerID) as orderderbycustomer
From Sales.Orders


Select
*,
Count(*) over()   as totalsales,
Count(Score) over()   as totalscore,
Count(LastName) over()   as totallastname
From Sales.Customers

Select
OrderID,
Count(*)  over(partition by OrderID) as checkkey
from Sales.Orders


Select
*
From(
Select
OrderID,
Count(*) over (partition by OrderID) as chkeck2
From Sales.OrdersArchive)t
where chkeck2>1

Select
OrderID,
OrderDate,
Sales,
Sum(Sales) over(partition by productid) as totalsalesbyproduct
From Sales.Orders

Select
OrderID,
ProductID,
Sales,
Sum(Sales) over() as totalsales,
round(Cast(Sales as Float)/Sum(Sales) over() * 100,2) as percentagesales
From Sales.orders


Select
orderID,
OrderDate,
ProductId,
Sales,
AVG(Sales) over() as avgsales,
AVG(Sales) over(partition by ProductId) as avgsalesbyproduct
From Sales.orders




Select
CustomerID,
Lastname,
Score,
AVG(Score) over() as avgscore
From Sales.Customers


Select *
From(
Select
Orderdate,
OrderID,
ProductId,
Sales,
AVG(Sales) over() as avgsales
From Sales.orders)t
where avgsales > Sales



Select
orderID,
orderDate,
productID,
Sales,
Max(Sales) over(partition by ProductId) as maxsales,
Min(Sales) over(partition by ProductId) as minsales,
Sales-Min(Sales) over() as fromin,
Sales-Max(Sales) over() as frommax
From Sales.Orders

Select *
From(
Select
*,
Max(Salary) over() as highestsalry
From Sales.Employees)t
where highestsalry=Salary

Select
ProductId,
Orderdate,
Sales,
avg(Sales) over(partition by ProductID order by orderdate ASC rows between unbounded preceding and current row) as runningavgtotal,
sum(Sales) over(order by sales rows between unbounded preceding and current row) as runningtotal,
sum(Sales) over(order by sales rows between 2 preceding and current row) as rollingtotal
From Sales.Orders


Select
ProductId,
Orderdate,
Sales,
Row_number()  over(order by Sales DESC) as sales_rank,
Rank()  over(order by Sales DESC)  as sales_rank2,
Dense_Rank()  over(order by Sales DESC)  as sales_rank3
From Sales.Orders


Select*
From(

Select
OrderID,
ProductID,
Sales,
Row_Number()  over (partition by ProductId order by Sales DESC) as rankbyproduct
From Sales.Orders)t
where rankbyproduct=1

Select*
From
(
Select
CustomerId,
Sum(Sales) as totalsales,
ROW_NUMBER()  over(order by Sum(Sales)) as rankcustomer
From Sales.Orders
Group by CustomerID)t
where rankcustomer<=2

Select *
From (
Select
Row_Number() over(Order by OrderID)  as uniqueID,
*
From Sales.OrdersArchive)t
where uniqueId=OrderID


Select *
From (
Select
Row_Number()  over(partition by OrderID order by CreationTime DESC) as rn,
*
From Sales.OrdersArchive)t
where rn=1


Select
OrderID,
Sales,
NTILE(2) over(order by Sales DESC) as buckets,
NTILE(3) over(order by Sales DESC) as buckets
From Sales.orders

Select *,
Case  when buckets1=1 Then 'High'
      when buckets1=2 Then 'medium'
      else 'low'
      end as casewhencategory
From(
Select
OrderId,
Sales,
NTILe(3) over(order by Sales DESC) as buckets1
From Sales.Orders)t

Select
OrderID,
Sales,
Cume_dist() over(order by Sales DESC) as cumerank,
Round(percent_rank() over(order by Sales DESC)*100,2) as cumerank2
From Sales.Orders


Select*,
concat(distrank*100,'%') as distrankopec
From(
Select
Product,
Price,
CUME_dist()  over(order by Price DESC) as distrank
From Sales.Products)t
where distrank<=0.4


Select
orderID,
ProductID,
Sales,
Lead(Sales,2,0) over(order by Sales DESC) as lagsales,
Lag(Sales,2,0) over(order by Sales DESC) as lagsales2,
First_value(Sales) over(order by Sales DESC rows between current row and 2 following) as lagsales3,
Last_value(Sales) over(order by Sales DESC rows between current row and 2 following) as lagsales4
From Sales.Orders


Select *,
currentmonthsales-previousmonthsales as mom_chnage,
Round(Cast((currentmonthsales-previousmonthsales) as float)/previousmonthsales *100,2) as per_chnage
From(
Select
Month(OrderDate) as ordermonth,
Sum(Sales) as currentmonthsales,
LAG(Sum(Sales)) over(order by Month(OrderDate)) as previousmonthsales
From Sales.Orders
group by Month(OrderDate))t

Select
CustomerID,
avg(nectdays),
rank() over(order by Coalesce(avg(nectdays),9999) ASC )
From(
Select
OrderID,
CustomerID,
orderDate,
lead(orderDate) over(partition by CustomerID order by orderdate) as nectorder, 
DATEDIFF(day,orderdate,lead(orderDate) over(partition by CustomerID order by orderdate)) as nectdays
From Sales.Orders)t
Group by CustomerID


Select
productID,
OrderID,
Sales,
LAST_VALUE(Sales) over(partition by productID order by Sales Rows between current row and unbounded following) as lowest_sales,
Sales-LAST_VALUE(Sales) over(partition by productID order by Sales Rows between current row and unbounded following) as sales_diff,
First_VALUE(Sales) over( partition by productID order by Sales ) as lowest_sales_2,
Sales-First_VALUE(Sales) over( partition by productID order by Sales ) as sales_diff_2
From Sales.Orders




Select
Distinct table_name
From INFORMATION_SCHEMA.COLUMNS



Select
avgsales
From (
Select  
AVG(Sales) over()  as avgsales
From Sales.Orders) as t;


-- /* task: Find the products that have price higher than the average price of all products*/

Select *
   From(
            Select
            price,
            productId,
            AVG(price) over() as avg_price
            From Sales.Products) t
where price>avg_price

   Select 
   *,
   totalsales,
   rank() over(order by totalsales DESC)
   From(
   Select
    CustomerId,
    SUM(Sales) as totalsales
    From Sales.Orders
    Group by CustomerID)t


    Select
    ProductID,
    PRODUCT,
    Price,
    ( Select
    Count(*)
    From Sales.Orders)
    From Sales.Products
    -- Show all customer details and find the total orders fro each customer

    Select
    c.*,
    o.totalorders
    From Sales.Customers as c
    left join(
    Select
    CustomerID,
    Count(*) as totalorders
    From Sales.Orders
    Group by CustomerID) o
     On c.CustomerID=o.CustomerID


     Select
     ProductID,
     Price,
     (Select AVG(Price) from Sales.Products)  as avg_price
     From Sales.Products
     where price >(Select AVG(Price) from Sales.Products) 



     Select
     *
     From Sales.orders
     where CustomerID Not IN ( Select
     CustomerID
     From Sales.Customers
     where Country='Germnay')


     Select
     CustomerID
     From Sales.Customers
     where Country='Germnay'


     Select
     EmployeeId,
     Firstname,
     Gender,
     Salary
     From Sales.Employees
     where Gender ='F'
     AND Salary > ALL (Select
                         
                         Salary
                         From Sales.Employees
                         where Gender ='M'
                      )

     
     Select
     *,
     (Select Count(*)  From Sales.Orders as o where o.CustomerID = c.CustomerID) as totalsales
     From Sales.Customers as c



     Select
     *
     From Sales.Orders as o
     where NOT EXISTS (Select 1
                 From Sales.Customers as c
                 Where Country = 'Germnay'
                 AND o.CustomerID=c.CustomerID)

    --Step1: find the total sales per customer(Standalone_CTE)
    WITH CTE_total_sales as 
    (
    Select
    CustomerID,
    Sum(sales) as totalsales
    From Sales.Orders
    Group by CustomerID
    )
    -- Step2: Find the last order date for each customer(Standalone_CTE)
    , CTE_Last_order As 
    (
     Select
     CustomerID,
     Max(OrderDate) as lastorder
     From Sales.Orders
     Group By CustomerID
    ),
    -- Step3: rank Customer based on total Sales Per Customer (Nested CTE)
    CTE_Customer_Rank AS
    (
    Select
    CustomerID,
    TotalSales, 
    RANK() over(order by totalsales)  as customerrank
    From CTE_Total_Sales
    )
    -- Step4: segement customer based on their total sales (Nested CTE)
    ,
    CTE_Customer_Segemnts as
    (
    Select
    CustomerID,
    totalsales,
    Case when totalsales > 100 then 'High'
         when totalsales > 50  then 'medium'
         else 'Low'
     end CustomerSegments
     From CTE_total_sales
    )
   -- Main Query
    Select
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.totalsales,
    clo.lastorder,
    ccr.customerrank,
    ccg.CustomerSegments
    From Sales.Customers c
    Left join CTE_total_sales cts
    on cts.CustomerID=c.CustomerID
    Left join CTE_Last_order clo
    on clo.CustomerID=c.CustomerID
    left join  CTE_Customer_Rank as ccr
    on ccr.CustomerID=c.CustomerID
    left join CTE_Customer_Segemnts as ccg
    on ccg.CustomerID=c.CustomerID
    order by CustomerID 

    -- generate a Sequence of Numbers From 1 to 20
    -- Anchor Query
    With Series As (
    Select
    1 As mynumber
    Union All
    -- Recursive Query
    Select
    mynumber+1
    From Series
    where mynumber < 10  -- equal to 20 is not allowed because it exceed 20 by 1
    )
    -- Main Query
    Select*
    From Series
    option (Maxrecursion 10)


    -- Task:Show the employee hierarchy by displaying each emplyee level within the organization
    -- Anchor Query
    with CTE_Emp_Hierarchy as (
    Select
    EmployeeID,
    FirstName,
    ManagerID, 
    1 as level
    From Sales.Employees
    where managerID is Null
    Union All
    -- Recursive Query
    Select
    e.EmployeeID,
    e.FirstName,
    e.ManagerID, 
    Level+1
     From Sales.Employees as e
     inner join CTE_Emp_Hierarchy as ceh
     On e.ManagerID=ceh.EmployeeID
    ) 
    -- Main Query
    Select
    * 
    From CTE_Emp_Hierarchy 


    -- find the running total of ales for each month
    With CTE_Monthly_Summary As (
    Select
    DateTrunc(month,OrderDate) as OrderMonth,
    Sum(Sales) as totalsales,
    COUNT(OrderID) as TotalOrders,
    SUM(Quantity) as TotalQuantities
    from Sales.Orders
    group by DateTrunc(month, OrderDate)
    )
    Select
    OrderMonth,
    totalsales,
    TotalQuantities,
    Sum(TotalSales) over(order by OrderMonth) as runningtotal
    From CTE_Monthly_Summary


    Drop View Sales.V2_monthly_Summary
    
    If OBJECT_ID('Sales.V2_monthly_Summary','V') is Not Null
    Drop View Sales.V2_monthly_Summary
    Go
    
    CREATE View Sales.V2_monthly_Summary as (
      Select
    DateTrunc(month,OrderDate) as OrderMonth,
    Sum(Sales) as totalsales,
    COUNT(OrderID) as TotalOrders
    from Sales.Orders
    group by DateTrunc(month, OrderDate)

    )
     

   Select
   *
   From Sales.V2_monthly_Summary

       Select
    OrderMonth,
    TotalSales,
    SUM(TotalSales) over (order by OrderMonth) as runningtotal
    from Sales.V2_monthly_Summary

    Drop VIEW Sales.V2_monthly_Summary
    DRop View V2_Monthly_Summary
    Drop VIEW nV_Monthly_Summary

    Create View Sales.V2_order_Details as (
        -- Provide a view that combines details from orders, products,customers, and employees
        Select
        o.orderId,
        o.OrderDate,
        p.product,
        p.Category,
        Coalesce(c.FirstName,'')+ '' + Coalesce(c.LastName,'') as CustomerName,
        c.Country as CustomerCountry,
         Coalesce(e.FirstName,'')+ '' + Coalesce(e.LastName,'') as SalesName,
        e.Department,
        o.Sales,
        o.Quantity
        From Sales.Orders  as o
        left Join Sales.Products as p
        On p.ProductID=o.ProductID
        left join Sales.Customers c
        on c.CustomerID=o.CustomerID
        left join Sales.Employees e
        On e.EmployeeID=o.SalesPersonID
        )

        Select
        *
        From Sales.V2_order_Details

        /* provide a view for the EU sales Team that combines details from all tables and excludes data related to the USA.*/

        Create View Sales.V_order_Details_Eu2 as (
        Select
        o.orderId,
        o.OrderDate,
        p.product,
        p.Category,
        Coalesce(c.FirstName,'')+ '' + Coalesce(c.LastName,'') as CustomerName,
        c.Country as CustomerCountry,
         Coalesce(e.FirstName,'')+ '' + Coalesce(e.LastName,'') as SalesName,
        e.Department,
        o.Sales,
        o.Quantity
        From Sales.Orders  as o
        left Join Sales.Products as p
        On p.ProductID=o.ProductID
        left join Sales.Customers c
        on c.CustomerID=o.CustomerID
        left join Sales.Employees e
        On e.EmployeeID=o.SalesPersonID
        where c.Country!='USA' )



        Select*
        From Sales.V_order_Details_Eu2

       If OBJECT_ID('Sales.MonthlyOrders2','U') is not null
                Drop Table  Sales.MonthlyOrders2;
        Go
       Select
                Datename(month,OrderDate) as ordermonth,
                Count(OrderID) as totalorders
        Into Sales.MonthlyOrders2
        From Sales.Orders
        Group by Datename(month,OrderDate)

        Select*
        From Sales.MonthlyOrders2
        Drop Table  Sales.MonthlyOrders2

        Select
        *
        INTO #orders22
        From Sales.Orders


        Select
        *
        From #orders22

        Delete From #orders22
       
        Select
        *
        Into Sales.orderTest2
        From #orders22
        
        -- Step1: Write A Query
        -- For US Customer find the total number of customers and the average score
     
        -- Step2: Turning the Query into a stored Procedure
        Alter procedure GetCustomerSumaary @Country NVARCHAR(50) = 'USA'
        AS 
        Begin
            Begin Try
            Declare @TotalCustomer INT,@AVGScore FLOAT;
            --==========================
            -- Prepare & Cleanup Data
            --==========================
            If  EXISTS (Select 1 From Sales.Customers where Score is NUll AND Country = @Country)
                Begin
                Print ('Updating Null Score to 0');
                  UPDATE Sales.Customers
                  Set Score = 0
                  where Score  is Null and Country = @Country
                End
        
            ELSE

            Begin
            Print ('No Null scores found')
            end;
            --==========================
            -- Generating Reports
            --==========================
                   Select
                 @TotalCustomer=COUNT(*) ,
                @AVGScore=AVG(score)
                From Sales.Customers
                Where Country=@Country;

            Print 'Total Customers From' + @Country +':' + Cast(@TotalCustomer as NVARCHAR);
            Print 'Average Score from' +  @Country +':' + Cast(@AVGScore as NVARCHAR);

           --==============================================
           -- Find the total number of orders and total sales
           --================================================
            Select
            Count(OrderID) as totoalorders,
            SUM(Sales) as totalsales
            From Sales.Orders as o
            Join Sales.Customers c
            ON c.CustomerID=o.CustomerID
            where c.country=@Country;

            End Try
            --==========================
            -- Error handling
            --==========================
            begin catch
            Print ('An error occured,')
            Print ('An error Message:' + Error_Message());
            Print ('Error Number :' + cast(Error_Number() as NVARCHAR));
            Print ('Error Line :' + Cast (Error_Line() as NVARCHAR ));
            Print ('Error Procedure' + Error_procedure());
            End catch
        End

        Exec GetCustomerSumaary 
     

       Create table Sales.Employeelogs2 (
       LogID INT Identity(1,1) primary key,
       EmployeeID INT,
       LogMessage varchar(255),
       LogDate Date
       )


       Create Trigger trg_AfterInsertEmolyee2 on Sales.Employees
       After Insert
       As 
       Begin
       Insert into Sales.Employeelogs2 (EmployeeID, LogMessage, LogDate)
       select
       EmployeeID,
       'New Employee added =' + cast(EmployeeID as VARCHAR),
       GetDate()
       From inserted
       end



       Select
       *
       From Sales.Employeelogs2

       Insert Into Sales.Employeelogs2
       VALUES (6, 'Employee record created', GETDATE());

       -- Index


       select*
       Into Sales.DBcustomers2
       From Sales.Customers

       Select*
       From Sales.DBcustomers2
       where CustomerID=1

       Create Clustered index idx_DBCustomer2_CustomerID
       on Sales.DBCustomers2 (CustomerID)

       Create Clustered index idx_DBCustomer2_CustomerID
       on Sales.DBCustomers2 (FirstName)

       Drop Index idx_DBCustomer2_CustomerID on Sales.DBCustomers2 

       Select
       *
       From Sales.Customers
       where LastName='Brown'

       Create Nonclustered index idx_DBCustomers2_LastName
       on Sales.DBCustomers2 (LAstName)

        Create Nonclustered index idx_DBCustomers2_FirstName
       on Sales.DBCustomers2 (FirstName)

       Create index idx_DbCustomers2_CountryScore
       on Sales.DBCustomers2 (Country, Score)


       Create Clustered ColumnStore index idx_DBCustomers2_cs 
       on Sales.DBCustomers2
       
       Drop index  idx_DBCustomers2_cs 
       on Sales.DBCustomers2

       Create NonClustered ColumnStore index idx_DBCustomers2_FirstName2 
       on Sales.DBCustomers2 (Firstname)


       Select
       *
       
       
       Create Unique NONCLUSTERED index idx_Products_Products
       on Sales.Products (Product)

       Insert into Sales.Products (ProductID, Product) values (106, 'Caps')

       Select*
       From Sales.Customers
       Where Country='USA'


       Create NONCLUSTERED index indx_Customer_country
       on Sales.Customers (Country)
       where Country='USA'

       -- List all indexes on a specific table
       sp_helpindex 'Sales.DBCustomers' 
       -- Monitoring index usage

       Select
       tbl.name as tableName,
       
       idx.name as indexName,
       idx.type_desc as IndexType,
       idx.is_primary_key as ISPrimaryKey,
       idx.is_unique as ISUnique,
       idx.is_disabled as isDisabled,
       s.user_seeks as userseek,
       s.user_scans as userscans,
       s.user_lookups as userlookups,
       s.user_updates as userupdates,
       s.last_user_seek as lastuserseek,
       s.last_user_scan as lastuserscan,
       coalesce(s.last_user_seek,s.last_user_scan) as lastupdates
       From sys.indexes as idx
       Join sys.tables as tbl
       on idx.object_id=tbl.object_id
       left join sys.dm_db_index_usage_stats as s
       on s.object_id=idx.object_id
       and s.index_id=idx.index_id
       order by tbl.name,idx.name


       Select * from sys.dm_db_missing_index_details
       EXEC sp_updatestats

       Select *
       From sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'Limited')


       Select
       o.Sales,
       c.Country
       From Sales.Orders as o
       left Join Sales.Customers as c 
       ON o.CustomerID = c.CustomerID
      -- Option (HASH Join)


      -- Step1: cretae a Partition Function

      Create Partition FUNCTIOn PartitionByYear (Date)
      AS RANGE LEFT FOR Values ('2023-12-31','2024-12-31','2025-12-31')

      -- Query lists all existing Partition Function
      Select
      name,
      function_id,
      type,
      type_desc,
      boundary_value_on_right
      From sys.partition_functions
      --step 2: Create FileGroup

      ALter DATABASE SalesDB Add FILEgroup FG1_2023;
      ALter DATABASE SalesDB Add FILEgroup FG1_2024;
      ALter DATABASE SalesDB Add FILEgroup FG1_2025;
      ALter DATABASE SalesDB Add FILEgroup FG1_2026;

      -- Query lists all existing Filegroup
      Select*
      From sys.filegroups
      where type='FG'

      --step3: Add .ndf Files to each filegroup
      Alter database SalesDB ADD File
      (
        NAME=P_2023,  ---logicalname
        FILENAME= 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P_2_2023.ndf'

      )
      To filegroup FG1_2023;

       Alter database SalesDB ADD File
          (
        NAME=P_2024,  ---logicalname
        FILENAME= 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P_2_2024.ndf'

      )
      To filegroup FG1_2024;


      
       Alter database SalesDB ADD File
          (
        NAME=P_2025,  ---logicalname
        FILENAME= 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P_2_2025.ndf'

      )
      To filegroup FG1_2025;

          Alter database SalesDB ADD File
          (
        NAME=P_2026,  ---logicalname
        FILENAME= 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\P_2_2026.ndf'

      )
      To filegroup FG1_2026;


      Select
      fg.name as Filegroupname,
      mf.name as logicalFileName,
      mf.physical_name as physicalfilepath,
      mf.size/128 as SizeInMB
      from
      sys.filegroups fg
      join
      sys.master_files mf on fg.data_space_id=mf.data_space_id
      where mf.database_id=DB_ID('SalesDB');


      -- step4: Create Partition Scheme


      Create Partition Scheme SchemePartitionByYear
      AS partition Partitionbyyear
      To (FG_2023, FG_2024, FG_2025, FG_2026)

      Create table Sales.orders_partitioned

      (

      OrderID INT,
      OrderDate DATE,
      Sales INT
      ) ON Schemepartitiobyyear (date)


      --===============================
      -- Tip1: Select only what you need
      --================================

      Select Firstname, LastName, Score From Sales.Customers

      --=================================
      -- tip2: Avoid unnecesssary DISTINCT and order by
      --================================

      Select FirstName From Sales.Customers order by FirstName

      --==========================================
      --tip3: For Exploration purpose, Limit Rows
      --===========================================
      Select Top 3  OrderID, Sales From Sales.Orders

      --=======================================
      --tip4: Create noncolustered Index on frequently used column in where clause
      --=========================================

      Select * from Sales.orders Where orderStatus  = 'Delievered'

      Create nonclustered index idx_orderstatus on sales.orders(Orderstatus)

      --===========================================
      --tip5: Avoid applying function to columns in where clauses
      --============================================


      select* from Sales.orders where Lower(OrderStatus)='Delievered'

      
      select* from Sales.orders whereOrderStatus='Delievered'

      select* From Sales.orders where year(OrderDate)= 2025

            select* From Sales.orders where OrderDate between '2025-01-01' and '2025-12-31'
      --===============================================
      -- tip6:
      --==============================================

      select* From Sales.Customers where Lastname like 'Gold%'

      --=============================================
      --  try to acoid the OR 
      -- Best peromance is Inner join only focus on inner join
      --make sure to index the columns used in the ON clause
      -- filter before Joining


      -- Filter After Join (where
      Select c.FirstName, o.orderID From Sales.Customers as c
      inner join Sales.Orders as o
      on c.CustomerID=o.CustomerID
      where o.OrderStatus ='Delivered'

      -- Filter During Join (ON)

      Select  c.FirstName , o.orderID
      From Sales.Customers as c
      inner join Sales.Orders as o
      on c.CustomerID=o.CustomerID
      AND o.OrderStatus='Delievered'

      --Aggregate Before Joining the table
      -- used union instead of OR operator
