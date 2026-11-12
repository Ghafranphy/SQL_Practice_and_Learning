/*
================================================================================
Project      : SQL Practice and Database Management
Author       : Ghafran Khan
Database     : Microsoft SQL Server (T-SQL)
File         : SQL_Practice_Commented.sql

Description  :
A practical collection of SQL examples covering data retrieval, filtering,
aggregation, table operations, joins, set operators, built-in functions,
subqueries, common table expressions, window functions, views, stored
procedures, triggers, and indexing.

Purpose      :
To practise SQL querying, data transformation, analytical reporting, and
fundamental database administration techniques.

Note         :
Examples use sample tables such as Customers, Orders, Products, and Employees.
Run statements against the matching sample database and review any INSERT,
UPDATE, DELETE, DROP, or object-creation statements before execution.
================================================================================
*/

/*
CONTENTS
--------
01. Basic SELECT statements and column selection
02. Filtering, sorting, DISTINCT, and TOP
03. GROUP BY, aggregate functions, and HAVING
04. CREATE, ALTER, and DROP table operations
05. INSERT, UPDATE, and DELETE statements
06. WHERE conditions and pattern matching
07. INNER, LEFT, RIGHT, FULL, and anti joins
08. Database selection and set operators (UNION, EXCEPT, INTERSECT)
09. String functions and text manipulation
10. Numeric, mathematical, and conversion functions
11. Date and time functions
12. Conditional expressions and NULL handling
13. Subqueries, derived tables, and CTE examples
14. Aggregate and analytical window functions

Execution guidance
------------------
- Execute examples in small sections rather than running the entire file at once.
- Confirm the active database before running statements that use SalesDB.
- Review INSERT, UPDATE, DELETE, ALTER, and DROP statements before execution.
- Some examples are independent exercises and require the sample tables shown.
*/


Select
sum(score) as ang_score,
country
From  customers
--where score > 5 and country='Germany'
Group by country
order by sum(score) ASC


Select
Sum(score),count(id)
From customers
Group by country

Select
sum(score),country
From customers
group by country
Having sum(score) >0
Order by sum(score) DESC

Select Distinct  -- remove duplicate
country
From customers

Select Top 3
Score
From customers


Create Table Ghafran
( id  int not null,
  person_name varchar(50) not null,
  birth_date  date,
  phone varchar(15) not null,
  Constraint pk_persons5 primary key (id)
)

Select*
From Ghafran


Alter table Ghafran
Add emial varchar(50)  not null 

Alter table Ghafran
Drop column emial  



Drop Table Ghafran


Insert Into customers (id, first_name,country,score)
Values 
  (9,'Mustajab', 'USA', Null),
  (10, 'Nadeem', Null,100)

  Select*
  From customers

  Insert Into persons (person_name)
  Select
  first_name
  From customers

  Select*
  From persons




  update customers
  set score =0 , country = 'unknown'
  where score is Null Or country is Null 

  
  Delete customers
  where first_name In ('Mustajab', 'Nadeem')

  
    Select*
  From customers


Rollback



Insert customers (id,first_name,country,score)
 Values
  --(2,'Martin','Germany',500),
  --(3,'Georg','UK',750)
   --(5,'Peter','USA',5),
   --(2,'John','USA',900),
    (1,'Maria','Germany',900)
 

 Select*
 From customers
 where country = 'Germany'


  Select*
 From customers
 where score >= 500 


 Select*
 From customers
 where Score between 10 AND 900

  Select*
 From customers
 where Score between 5 and 900

 Select*
 from customers
 where first_name like '__%n'


 Select*
 From customers
 Select*
 From Orders

 Select
 customers.id,customers.first_name,Orders.order_id,Orders.sales
 From customers
 inner join Orders
 On customers.id=Orders.customer_id



 Select
 cc.id,cc.first_name,oo.order_id,oo.sales
 From customers as cc
 left join Orders as oo
 On cc.id=oo.customer_id


  Select
 cc.id,cc.first_name,oo.order_id,oo.sales
 From  Orders as oo
  full join customers as cc    -- Order of the table is not important
 On cc.id=oo.customer_id


  Select
 cc.id,cc.first_name,oo.order_id,oo.sales
 From customers as cc
 left join Orders as oo
 On cc.id =oo.customer_id
 where oo.customer_id is null 


  Select
 cc.id,cc.first_name,oo.order_id,oo.sales
 From Orders as oo
 right join customers as cc
 On cc.id =oo.customer_id
 where oo.customer_id is Null

 Select
 id,score
 From customers
 Union
 Select
 order_id,sales
 From orders


  Select
  CustomerID,FirstName,LastName
 From Sales.Customers
 Union
 Select
 EmployeeID,FirstName,LastName
 From Sales.Employees

   Select
  CustomerID,FirstName,LastName
 From Sales.Customers
 Except
 Select
 EmployeeID,FirstName,LastName
 From Sales.Employees


    Select
  CustomerID,FirstName,LastName
 From Sales.Customers
 Intersect
 Select
 EmployeeID,FirstName,LastName
 From Sales.Employees


 Select
 FirstName,LastName,
 CONCAT(FirstName,' ',LastName),
 Upper(CONCAT(FirstName,' ',LastName)),
 Lower(CONCAT(FirstName,' ',LastName)),
 Len(FirstName),
 Len(Trim(FirstName)),
 Len(LastName),
 Len(Trim(LastName))
 From Sales.customers

 Select
 first_name,
 len(first_name),
 len(Trim(first_name))
 From customers
 where len(first_name)!=len(Trim(first_name))
 Select
 '123-4565-678',
 Replace('123-4565-678','-','\'),
 'report.text',
 Replace('report.text','text','.CSV')


  Select
 first_name,
 left(first_name,2),
 right(first_name,3),
 substring(first_name,2,5),
 '3.5678',
 Round('3.5678',1)
 From customers

 Select
 CreationTime,
Day(CreationTime),
datepart(WEEKDAY,CreationTime),
MONTH(CreationTime),
Year(CreationTime),
datepart(MONTH,CreationTime),
datepart(YEAR,CreationTime),
datepart(Hour,CreationTime),
datepart(WEEKDAY,CreationTime),
Datename(M,CreationTime),
Datename(weekday,CreationTime),
Datetrunc(Month,CreationTime),
Datetrunc(day,CreationTime),
Datetrunc(YEAR,CreationTime),
EoMonth(CreationTime),
FORMAT(CreationTime,32)
 From Sales.Orders

 Select
 datename(Month,OrderDate),
 Count(*)
 From Sales.Orders
 Group by datename(Month,OrderDate)


  Select
 CreationTime,
Format(CreationTime,'dd/MM/yyyy//mm')
 From Sales.Orders

 Select
 Format(OrderDate,'MMM yy'),
 Count(*)
  From Sales.Orders
  Group by Format(OrderDate,'MMM yy')


  Select
   Convert(Date, Creationtime) as [Datetime to date],
   Convert(varchar, Creationtime,32) as us_time
   From Sales.Orders

   Select
   Cast('123' as varchar)  as var_char,
   cast('2025-10-03' as Date) as Da_te


   Select
   OrderDate,
   DATEADD(MM,2,Orderdate),
   DATEADD(YY,2,Orderdate),
   DATEADD(YY,-2,Orderdate)
   From Sales.Orders

   Select
   OrderDate,
   ShipDate,
   DateDiff(day,OrderDate,ShipDate),
   month(OrderDate) as orderdate
   From Sales.Orders


   Select
   OrderDate,
   Isdate('Orderdate')
   From Sales.Orders

   Select
   CustomerID,FirstName,LastName,Coalesce(Score,10) as score_1,
   Coalesce(Firstname,'  ') + ' ' + Coalesce(LastName,'')   as full_name
   From Sales.Customers



   Select
   CustomerID,Coalesce(Score,0)
   From Sales.Customers
   Order by Coalesce(Score,0) DESC


   Select
   OrderID,Sales,Quantity,Sales/Nullif(Quantity,0) as price
   From Sales.Orders
   where Quantity is not Null




   Select
   cc.*,
   oo.OrderID
   From Sales.Customers as cc
   Left Join Sales.Orders as oo
   On cc.CustomerID=oo.CustomerID
   where oo.CustomerID is null



   Select
   category,
   SUM(Sales) as totalscales
   From (
   Select
   OrderID,
   Sales,
   Case 
   when Sales >50 then 'High'
   when Sales <50  and Sales >30 then 'medium' 
   else  'low'
   end as category

   From Sales.Orders
      )t
   Group by category
   Order by totalscales ASC

   Select
   EmployeeID,
   FirstName,
   LAstName,
   Gender,
   Case 
   when Gender = 'F' then 'female'
   else 'male'
   end  as gender_fullText
   From Sales.Employees


   Select
   CustomerID,
   LastName,
   Score,
   Case
    when  Score is NUll then 0
    else Score
    end as scoreclean,
   AVG( Case
    when  Score is NUll then 0
    else Score
    end) over() as avg_score
   From Sales.Customers



   Select
  
   CustomerID,
  
   Sum(Case 
   when Sales > 30 then 1
   else 0
   end) as sales_flag,
   count( CustomerID) as totalorders
   From Sales.Orders
   Group by CustomerID


   --- Aggregate Function  

   Select
   sales,
   count(*) as total_nr_orders,
   SUM(sales) as totalsales,
   AVG(sales) as avg_sales,
   Max(Sales) as highest
   From orders
   Group by sales 



   USE SalesDB
   Select
   OrderID,OrderDate,
   PRODUCTID,
   Sum(Sales)  over(partition by ProductID) as total_sales_product
   From Sales.Orders
 


 Select
 OrderID,
 OrderDate,
 PRODUCTId,
 OrderStatus,
 Sales,
  Sum(Sales) over ()  as totalsales,
 Sum(Sales) over (partition by ProductID)  as totalsalesproduct,
 Sum(Sales)  over (partition by ProductID, OrderStatus order by Sales DESC) as salesorderstatus
 From Sales.Orders


 
 
 Select
 OrderID,
 OrderDate,
 PRODUCTId,
 OrderStatus,
 Sales,
 Sum(Sales) over (partition by OrderStatus Order by OrderDate
  Rows between 2 preceding and Current Row)  as totalsales
 From Sales.Orders




 Select
 OrderID,
 OrderDate,
 PRODUCTId,
 OrderStatus,
 Sales,
 Sum(Sales) over (partition by OrderStatus Order by OrderDate
  Rows  2 preceding )  as totalsales
 From Sales.Orders


  Select
 OrderID,
 OrderDate,
 PRODUCTId,
 OrderStatus,
 Sales,
 Sum(Sales) over (partition by OrderStatus Order by OrderDate
  Rows between unbounded preceding and current row )  as totalsales   -- Default row wokr with order by
 From Sales.Orders



   Select
 OrderID,
 OrderDate,
 PRODUCTId,
 OrderStatus,
 Sales,
 Sum(Sales) over (partition by OrderStatus)  as totalsales 
 From Sales.Orders
Where ProductId in (101,102)
 

 -- Rank the customer on their total sales
    Select
    CustomerID,
     Sum(Sales) as totalsales,
     rank() over(order by Sum(Sales) DESC ) as rankcustomer
     From Sales.Orders
     Group by CustomerID

     Select
     PRODUCTId,
     OrderID,
     OrderDate,
     Count(*) over(),
     CustomerID,
     Count(*) over(partition by CustomerID) as orderbycustomer
     From Sales.Orders


     Select
     *,
     Count(*)  over() as totalcustomer,
     Count(Coalesce(Score,0)) over() as totalscore
     From Sales.Customers

     Select
     OrderID,
     Count(*) over (partition by OrderID)
     From Sales.Orders


     Select
     *
     From (
     Select
     OrderID,
     Count( OrderID) over(partition by OrderID) as checkPk
     From Sales.OrdersArchive)t where checkPk>1



     Select
     OrderID,OrderDate,
     Sales,ProductID,
     Sum(Sales) over() as totalsales,
     Sum(Sales) over(partition by ProductID) as salesbyproduct
     From Sales.Orders


     Select
     orderID,
     ProductID,
     Sales,
     Sum(Sales) over() as totalsales,
     Round(Cast(Sales as float)/Sum(Sales) over() *100,2) as avgsales
     From Sales.Orders


     Select
     OrderID,
     OrderDate,
     Sales,
     AVG(Sales) over()   as avgsales,
     AVG(Sales) over(partition by ProductID) as avgbyproduct
     From Sales.Orders

     Select
     CustomerID,
     LastName,
     Score,
     AVG(Score) over()  as avg_scaore,
     AVG(Coalesce(Score,0)) over() as avg_score2
     From Sales.Customers

     Select
    *
     
     From(
     Select
     OrderID,
     ProductID,
     Sales,
     AVG(Sales) over() avgSales
     From Sales.Orders
     )t  where Sales > avgSales
     


     Select
     OrderID,
     ProductID,
     Sales,
     Min(Sales) over(partition by ProductID),
     Max(Sales) over(partition by ProductID),
     Sales- Min(Sales) over()  Devfrommin,
     Max(Sales) over()  - Sales  Devfrommax
     From Sales.Orders


     Select
     OrderID,
     ProductID,
     Sales,
     SUM(Sales) over(order by productID
     rows between unbounded preceding and current row)
     From Sales.Orders


     Select
     OrderID,
     ProductID,
     Sales,
     SUM(Sales) over (partition by ProductID order by productID rows between 2 preceding and current row)
     From Sales.Orders
     
     
     
     Select
     OrderID,
     COUNT(OrderID) over( order by OrderID rows between unbounded preceding and current row)
     From Sales.Orders

     Select
     OrderID,
     ProductID,
     Sales,
     Rank()  over(partition by ProductID order by Sales) as Rankfun, -- sharedrank
     DENSE_RANK() over(order by Sales) as denseRankfun   ,  -- shared rank no gao
     Row_number()  over(partition by ProductID order by Sales) as Rankfun2
     From Sales.Orders
    

    --TOP N Analysis
    Select*
    From(
    Select
    OrderID,
    ProductID,
    Sales,
    Row_Number()  over(partition by productID order by Sales DESC)  as rankbyproduct
    From Sales.Orders)t
    where rankbyproduct=1

    --Bottom N analysis
    Select*
    From(
    Select
    CustomerID,
    Sum(Sales)  as totalsales,
    Row_Number() over(order by SUM(Sales) ASC) as rankcus
    From Sales.Orders
    Group by
    CustomerID)t where rankcus<=2



    Select
    ROW_NUMBER() over(order by OrderID,Orderdate) as uniqueID,
    *
    From Sales.OrdersArchive


    Select* From(
    Select
    ROW_NUMBER() over (partition by OrderID Order by CreationTime DESC) as order_id, 
    *
    From Sales.OrdersArchive)t
    where order_id=1


    Select
    ProductID,
    NTIle(2) over(order by ProductID DESC) as bucket
    From Sales.Orders



    Select
    *,
    Case when buckets=1 then 'high'
          when buckets=2 then 'medium'
          else 'low'
          end as salessegement
    From (
    Select
    OrderID,
    Sales,
    NTILE(3) over (order by Sales DESC) as buckets
    From Sales.Orders
    )t


    Select
    NTILE(2) over (Order by OrderID) Buckets,
    *
    From Sales.Orders

    Select*,
    Concat(distrank*100,'%') distrankper
    From(
    Select
    Product,
    Price,
    CUME_DIST()  over(Order by price DESC) distrank,
    percent_rank()  over(Order by price DESC) percentrank
    From Sales.Products)t
    where distrank <=0.4


    Select
    Price,
    Lag(Price,1,0) over( order by Price),
    Lead(Price,1,0) over( order by Price)
    From Sales.Products



    Select
    Sales,OrderDate,
    Month(Orderdate) as monthdate,
    SUM(Sales)  as currentmonthsale,
    lag(SUM(Sales)) over(Order by Month(OrderDate)) as previousmonthsales
    From Sales.Orders
    Group by Sales,OrderDate



    Select
    OrderID,
    CustomerID,
    OrderDate
    From Sales.Orders
    Order by CustomerID,Orderdate
  
  Select
  Sales,
  FIRST_VALUE(Sales)  over(order by Sales),
  LAST_VALUE(Sales)  over(order by Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  From Sales.Orders





  Select
  DIstinct TABLE_NAME
  From INFORMATION_SCHEMA.COLUMNS


  Select
  AVG(Sales),  -- sclar subquery
  CustomerID,
  OrderID
  From Sales.Orders
  Group by Sales,CustomerID,OrderID



  Select
  *
  From(
  --subquery
  Select
  ProductID,
  Price,
  AVG(Price) over()  as avgprice
  From Sales.Products) as t
  where price>avgprice


  Select
  *,
  Rank() over (Order by totalsales DESC) as customerrank
  From(
  Select
          CustomerID,
          Sales,
          Sum(Sales) as totalsales
          From Sales.Orders
          Group by CustomerID,Sales ) as t
          where totalsales>30


          Select
          ProductID,
          Product,
          Price,
          (    Select
          COunt(*)
          From Sales.Orders)  as totalorder
          From sales.Products;


          Select
          COunt(*)
          From Sales.Orders

          Select*
          From Sales.Customers as c
          left join ( 
                      Select
                      CustomerID,
                      Count(*) as ordercount
                      From Sales.Orders
                      Group by CustomerID ) as o
          on c.CustomerID=o.CustomerID


          --main query
          Select
          ProductID,
          Price,
          (Select AVG(Price) From Sales.Products) as avg_price
          From Sales.Products
          where price > (Select AVG(Price) From Sales.Products)   -- Subquery



          Select
          *
          From Sales.Orders
          where CustomerID Not in (Select
                          CustomerID
                          From Sales.Customers
                          where Country='Germany')
                        

   Select
   EmployeeID,
   FirstName,
   Gender,Salary
   From Sales.Employees
   Where Gender='F'
   AND Salary > ANY (Select
  Salary
   From Sales.Employees
   Where Gender='M')

    Select
   EmployeeID,
   FirstName,
   Gender,Salary
   From Sales.Employees
   Where Gender='F'
   AND Salary > All (Select
  Salary
   From Sales.Employees
   Where Gender='M')



   --Correlated query
   Select
   *,
               (   Select
               COUNT(*)
               From Sales.Orders as o where o.CustomerID=c.CustomerID) as totalsales
   From Sales.Customers c


   Select
   COUNT(*)
   From Sales.Orders

   Select
   *
   From Sales.Orders as o
   Where  Not Exists  (Select
                          *
                       From Sales.Customers c
                       Where Country='Germnay'
                       AND o.CustomerID=c.Country)

With CTE_totalsales AS
(
   Select
   CustomerID,
   SUM(Sales) as total_sales
   From Sales.Orders
   Group by CustomerID
   )
   -- Step2: Find the last order date fro each customer
   , CTE_lastorder as 
   (Select
   CustomerID,
   Max(OrderDate) as Last_order
   From Sales.Orders
   Group by CustomerID
   )
   -- Step3: Rank Customers based on total Sales Per Customer
   , CTE_Rank as
   (
   Select
   CustomerID,
    total_sales,
    Rank() over (Order by total_sales DESC) as customer_rank
    From CTE_totalsales
   )
   
    -- Step4:segment customer based on their total sales
    , CTE_customer_segment as
    (Select
    CustomerID,
    total_sales,
    Case When  total_sales > 100 Then 'High'
         When  total_sales > 50 Then 'Medium'
         else 'Low'
    end as CustomerSegments
    From CTE_totalsales
    )
   
  --Main Query
   Select
   c.CustomerID,
   c.FirstName,
   c.LastName,
   cts.total_sales,
   clo.Last_order,
   ccr.customer_rank,
   ccs.CustomerSegments
   From Sales.Customers as c
   left Join CTE_totalsales as cts
   on cts.CustomerID=c.CustomerID
   Left join CTE_lastorder clo
   on clo.CustomerID=c.CustomerID
   Left join CTE_Rank as ccr
   on ccr.CustomerID=c.CustomerID  
   left join CTE_customer_segment as ccs
   on ccs.CustomerID=c.CustomerID


   -- generate a sequence of number from 1 to 20
   with Series as (
            --- anchor query
           Select
           1 as my_number
           UNION All
           --Recusrsive Query
           Select
           my_number+1
           from Series -- name of current CTE or anchor CTE
           where my_number < 20
   )
   --Main Query
   Select*
   from Series
   OPTION(MAXRECURSION 20)  -- how many iteration are allowed


  --- Show the employee hierarchy by displaying each employee level within each organization
  With CTE_EMP_Hierarchy as
 ( -- Anchor Query
  
          Select
          EmployeeID,
          FirstName,
          managerID,
          1 as level
          From Sales.Employees 
          where ManagerID is NUll
          Union All
          --Recusrsive Query
          Select
          e.EmployeeID,
          e.FirstName,
          e.managerID,
          level+1
          from Sales.Employees as e
          inner Join CTE_EMP_Hierarchy as ceh
          On e.ManagerID= ceh.EmployeeID

  )
  -- Main Query
  Select
  * 
  From CTE_EMP_Hierarchy 
  -- Find the running total of sales for each month

  With CTE_month_Summary as 
  (
  Select
  DateTrunc(month, OrderDate) as ordermonth,
  SUM(Sales) as totalSales,
  COUNT(orderID) as totalorder,
  SUM(Quantity) as totalquantity
  From Sales.Orders
  Group by DateTrunc(month, OrderDate)
  )
  Select
  ordermonth,
  totalSales,
  SUM(totalSales) over (order by OrderMonth) as running_total
  From CTE_month_Summary


  Select
  * 
  From V_monthly_summary



  Select
  ordermonth,
  totalSales,
  SUM(totalSales) over (order by OrderMonth) as running_total
  From  V_monthly_summary



  --Provide a view that combines details from orders,products,customers, and employee
  Create View Sales.V_order_Details as (
       Select
       o.OrderID,
       o.OrderDate,
       p.Product,
       p.Category,
       Coalesce(c.FirstName,'') + '' +Coalesce(c.Lastname,'') as customername,
       c.Country as CustomerCountry,
        Coalesce(e.FirstName,'') + '' +Coalesce(e.Lastname,'') as Salesname,
       e.Department,
       o.Sales,
       o.Quantity
       From Sales.Orders as o
       Left Join Sales.Products as p
       On p.ProductID=o.ProductID
       Left join Sales.Customers c
       On c.CustomerID=o.CustomerID
       left Join Sales.Employees e
       On e.EmployeeID=o.SalesPersonID )


       Select
       *
       From Sales.V_order_Details


       -- Provide a view for the EU Sales team that combines details from all tables and 
       -- excludes data related to the USA

       Create View Sales.V_order_Details_EU as (
       Select
       o.OrderID,
       o.OrderDate,
       p.Product,
       p.Category,
       Coalesce(c.FirstName,'') + '' +Coalesce(c.Lastname,'') as customername,
       c.Country as CustomerCountry,
        Coalesce(e.FirstName,'') + '' +Coalesce(e.Lastname,'') as Salesname,
       e.Department,
       o.Sales,
       o.Quantity
       From Sales.Orders as o
       Left Join Sales.Products as p
       On p.ProductID=o.ProductID
       Left join Sales.Customers c
       On c.CustomerID=o.CustomerID
       left Join Sales.Employees e
       On e.EmployeeID=o.SalesPersonID
       where c.Country!= 'USA' )

       Select*
       From Sales.V_order_Details_EU 


       If OBJECT_ID ('Sales.MonthlyOrders','U') is NOT NULL
          Drop table Sales.MonthlyOrders
        GO
       Select
       Datename(month,OrderDate) as orderMonth,
       Count(orderID) as Totalorders
       INTO Sales.MonthlyOrders
       From Sales.Orders
       Group by Datename(month,OrderDate) 

       Select * From Sales.MonthlyOrders

        Select
        *
        INTO #Orders
        From Sales.Orders

        Select
        *
        From #Orders

        Delete From #Orders
        where OrderStatus = 'Delivered'
        Select
        *
        INTO Sales.orderstest
        From #Orders


        ---Step1: Write a Query
        --- For US Customers Find the total Number of Customers and Average score

        Select
        Count(*) as totalcustomers,
        AVG(Score) as AVGScore
        From Sales.Customers
        Where Country='USA'

        --Step2 : turning the Query into s Stored procedure



        ALTER procedure GetCustomerSummary @Country NVARCHAR(50) = 'USA'
        AS 
        Begin
                  Begin Try
                  DECLARE @totalcustomers  INT, @AVGScore FLOAT;
                  --===============================
                  --Step1: prepare & Cleanup Data
                  --===============================
                  IF EXISTS (Select 1 From Sales.Customers Where Score IS NULL AND Country=@Country)
                     BEGIN
                     PRINT('updating Null Score to 0');
                     UPDATE Sales.Customers
                     SET SCORE =0
                     WHERE SCORE IS NULL AND Country = @Country;
                      END 
                      ELSE
                     BEGIN
                     PRINT ('No NUll SCORE found')
                     END;
                    --===============================
                    --Step2: Generating Reports
                    --===============================
                    -- Calculate total Customers and Average Score for specific country
                      Select
                        @totalcustomers = Count(*),
                         @AVGScore = AVG(Score)
                       From Sales.Customers
                       Where Country = @Country;

                       Print 'Total Customer From' + ' ' +@Country+ ':' + Cast(@totalcustomers as NVARCHAR);
                       Print 'Average Score from' + ' ' +@Country + ':' + CAST(@AVGScore as NVARCHAR);

                       --Find the total number of orders and sales for specific country
                         Select
                         Count(OrderID) as totalorders,
                         SUM(Sales) as totalsales
                          From Sales.Orders as o
                          join Sales.Customers as  c
                          on c.CustomerID=o.CustomerID
                          where c.Country = @Country;
                       End Try
       Begin Catch
       --===================
       -- Error Handling
       --===================
       Print ('AN arror occured.');
       Print('Error Message:' + Error_Message());
       Print ('Error Number: '+ Cast(Error_Number() as NVARCHAR));
       Print('Error Line :'+ Cast(Error_Line() as NVARCHAR));
       Print ('Error Procedure' +Error_procedure());
       End Catch
        End
  
        --Step3: Execute the Stored procedure   
        EXEC GetCustomerSummary @Country= 'Germany'

        EXEC GetCustomerSummary
         
        DROP Procedure  GetCustomerSummaryGermany
      
       EXEC GetCustomerSummary


       --Find the total number od orders and sales


       Select
       Count(OrderID) as totalorders,
       SUM(Sales) as totalsales
       From Sales.Orders as o
       join Sales.Customers as  c
       on c.CustomerID=o.CustomerID
       where c.Country = 'USA'




       Create Table Sales.EmployeeLogs(
       LogID INT Identity(1,1) primary key,
       EmployeeID INT,
       LogMessage varchar(255),
       LogDate Date
       )

   Select *
   INTO Sales.DBCustomers
    From Sales.Customers

    Select*
    From Sales.DBCustomers
    Where CustomerID=1

    Create Clustered INDEX idx_DBCustomers_CustomerID On Sales.DBCustomers (CustomerID)
    Create Clustered INDEX idx_DBCustomers_FirstName On Sales.DBCustomers (FirstName)

    DROP INDEX idx_DBCustomers_CustomerID On Sales.DBCustomers
    DROP INDEX idx_DBCustomers_FirstName On Sales.DBCustomers



    Select
    *
    FROM Sales.DBCustomers
    Where Country = 'USA' AND Score > 500



    Create NONCLUSTERED INDEX idx_DBCustomers_LastName ON  Sales.DBCustomers (LastName)

     Create INDEX idx_DBCustomers_FirstName ON  Sales.DBCustomers (Firstname)

     CREATE INDEX idx_DBCustomers_CountryScore on Sales.DBCustomers (Country, Score)

     Drop Index [idx_DBCustomers_CustomerID] on Sales.DBCustomers


     Create CLUSTEREd columnstore index idx_DBCustomer_CS on Sales.DBCustomers
     Drop index idx_DBCustomer_CS on Sales.DBCustomers

      Create nonCLUSTEREd columnstore index idx_DBCustomer_CS_FirstNAME on Sales.DBCustomers (FirstName)



      Select*
      From Sales.Products



      Create Unique NoNClustered index idx_products_product on Sales.Products (product)

      Insert Into Sales.Products (ProductID, Product) Values (106,'Caps')

      Select*
      from Sales.Customers
      where Country='USA'


      Create NONClustered Index idx_Customers_Country on Sales.Customers (Country) where country='USA'



      --List all indexex on a specific table
      sp_helpindex 'Sales.DBCustomers'

      -- Monitoring Index USage
      Select
      tbl.name as tablename,
     idx. object_id,
      idx.name as indexname,
      idx.type_desc as IndexType,
      idx.is_primary_key as isPrimaryKey,
      idx.is_unique as IsUnique,
      idx.is_disabled as IsDisabled,
      s.user_seeks,
      s.user_scans,
      s.user_lookups,
      s.user_updates,
      Coalesce(s.last_user_seek,s.last_user_scan) as Lastupdates
      From sys.indexes as idx
      Join sys.tables as tbl
      On idx.object_id =tbl.object_id
      left join sys.dm_db_index_usage_stats as s
      on s.object_id=idx.object_id
      AND s.index_id=idx.index_id
      order by tbl.name,idx.name

      Select*
      From sys.dm_db_index_usage_stats

      Select* From sales.Products

      ---------------------------------------------------------
      -- Revisons 8:43

      Select
      Sales,
      Count(*) as counts,
      SUM(Sales) as sumall,
      AVG(Sales) as avg_sales
      From Orders
      Group by Sales


      Select
      OrderID,
      OrderDate,
      ProductID,
      Orderstatus,
      Sum(Sales)  over(partition By ProductID,Orderstatus) as totalSales
      From Sales.Orders


      /*  find the total sales across all orders assitionally provide details such as orderid and order date*/


      Select
      OrderID,
      Orderdate,
      Sum(Sales) over() as totalsales
      From Sales.orders

      Select
      OrderID,
      Orderdate,
      ProductID,
      OrderStatus,
      Sales,
      Sum(Sales) over() as totalsales,
      Sum(Sales) over(partition by ProductID, orderstatus) as totalsalesbyproductststus,
      Sum(Sales) over(partition by ProductID) as totalsalesbyproducts
      From Sales.orders



      Select
      OrderID,
      OrderDate,
      Sales,
      Rank()  over(Order by Sales DESC)  as ranksales
      From Sales.Orders

     
     Select
     orderID,
     OrderDate,
     OrderStatus,
     Sales,
     Sum(Sales) over(  Partition by orderstatus order by OrderDate
      Rows between Current row AND 2 Following) as totalsales
      From Sales.Orders


        Select
     orderID,
     OrderDate,
     OrderStatus,
     Sales,
     Sum(Sales) over(  Partition by orderstatus order by OrderDate
      Rows between 2 preceding AND current row) as totalsales
      From Sales.Orders

      -- Default frame
      -- frame only work with order by
        Select
     orderID,
     OrderDate,
     OrderStatus,
     Sales,
     Sum(Sales) over(  Partition by orderstatus order by OrderDate
      Rows between unbounded preceding AND current row) as totalsales
      From Sales.Orders



      Select
     --CustomerID,
     Sales,
     Sum(Sales)  as totalsales,
     rank() Over(order by  SUM(Sales) DESC) as rankcustomers
      From Sales.Orders
      Group by Sales

      Select
      OrderID,
      OrderDate,
      Sales,
      ProductID,
      count(*) over () as totalsales,
      Count(*) over (Partition by CustomerID)
      From Sales.Orders


      Select
      *,
      Count(*) Over() as totalcustomer,
      Count(Score) over() as totalscore
      from Sales.Customers
      
   Select
   OrderID,
   Count(OrderID) over(partition by orderID)
   From Sales.Orders

   Select *
   From(
   Select
   OrderID,
   Count(*) over(partition by orderID)  as primarykey
   From Sales.OrdersArchive)t
    where primarykey>1


    Select
    orderID,
    OrderDate,
    Sales,
    ProductID,
    Sum(Sales) over() as totalsales,
    Sum(Sales) over(partition by productID) as totalsalesbyproduct
    From Sales.Orders


    Select
    orderID,
    ProductId,
    Sales,
    Sum(Sales) over() as totalsales,
    Round(Cast(Sales as float)/Sum(Sales) over() * 100,2) as percenatgetotal
    From Sales.Orders

    Select
    orderID,
    OrderDate,
    Sales,
    ProductID,
    AVG(Sales) over() as avgSales,
    AVG(Sales) over (Partition by ProductID) as avgSalesbyproduct 
    From Sales.Orders

    Select
    CustomerID,
    LastName,
    Score,
    Coalesce(Score,0) as Nulldeal,
    AVG(Coalesce(Score,0)) over() as avgscore
    From Sales.Customers


    Select*
    From(
    Select
    orderID,
    PRODUCTID,
    sales,
    AVG(sales) over() as avgsales
    From Sales.orders)t
    where sales > avgsales


    Select
    OrderId,
    productId,
    Sales,
    Max(Sales) over() as maxsales,
    Min(Sales) over() as minsales
    From sales.Orders


    Select
    OrderID,
    productId,
    OrderDate,
    Sales,
    AVG(Sales) over(partition by productID) as avgsalesbyproduct,
    AVG(Sales) over(partition by productID order by orderDate) as mvngavg,
    AVG(Sales) over(partition by productID order by orderDate
     rows between current row and 1 following) as rollingavg
    From Sales.Orders

    Select
    orderID,
    ProductID,
    Sales,
    Row_Number() over(order by  Sales DESC)  as salesrank
    From Sales.Orders
    
    Select
    orderID,
    productID,
    Sales,
    rank() over(order by  Sales DESC)  as salesrank
    From Sales.Orders


    Select
    OrderId,
    productID,
    Sales,
    DENSE_RANK() over(order by  Sales DESC)  as salesrank
    From Sales.Orders

    --top highest sales
    Select
    *
    From(
    Select
    orderID,
    ProductID,
    Sales,
    Row_number() over(partition by ProductID order by Sales Desc) as rankbyproduct
    From Sales.orders)t
    where rankbyproduct<=1

    Select*
    From(
    Select
    CustomerID,
    SUM(Sales) as totalsales,
    Row_Number() over (order by SUM(Sales) ASC) as rankbyproduct
    From Sales.Orders
    Group by
    CustomerID)t
    Where rankbyproduct >=1


    Select
    Row_number() over(Order by OrderID,OrderDate)  as uniquID,
    *
    From Sales.OrdersArchive 
    
    
    Select* From(
    Select
    Row_Number() over(partition by OrderID order by CreationTime DESC) as rn,
    *
    From Sales.OrdersArchive
    )t
    where rn=1

    Select
    OrderID,
    Sales,
    NTILe(1) over (order by Sales DESC) as bucket1,
    NTILe(2) over (order by Sales DESC) as bucket2,
    NTILe(3) over (order by Sales DESC) as bucket3,
     NTILe(4) over (order by Sales DESC) as bucket4
    From Sales.Orders

    Select
    *,
    Case when buckets =1 Then 'High'
         when buckets =2 Then 'medium'
         else 'low'
         end  as salesegmentation
    From (
    Select
    OrderId,
    Sales,
    NTILe(3) over (Order by Sales DESC) buckets
    From Sales.orders)t


    Select
    NTIle(2) over (Order by OrderID) as bucket1,
    *
    From Sales.Orders


       Select
    OrderId,
    Sales,
    cume_dist() over( Order by Sales ASC)
    From Sales.orders

    Select
    OrderId,
    Sales,
    round(percent_rank() over( Order by Sales ASC),2)
    From Sales.orders

    Select
    orderId,
    Sales,
    lead(Sales,1,0) over (Order by Sales ASC),
    Lag(Sales,1,0) over(Order by Sales ASC)
    From Sales.orders



    Select
    CustomerID,
    AVG(daysuntilnextorder),
    rank() over (order by Coalesce(AVG(daysuntilnextorder),9999)) as rankavg
    From(
    Select 
    OrderID,
    CustomerID,
    OrderDate as currentorder,
    Lead(Orderdate) over(partition by CustomerID Order by orderdate) as nextorder,
    Datediff(day,orderdate,Lead(Orderdate) over(partition by CustomerID Order by orderdate)) as daysuntilnextorder
    From Sales.Orders
      )t
      Group by CustomerID


      Select
      OrderID,
      productId,
      Sales,
      First_Value(Sales) over(partition by productID order by Sales ASC) as lowestsales,
      Last_value(Sales)  over(partition by productID order by Sales ASC 
       Rows between current row and unbounded following) as highestsales,
       Sales-   First_Value(Sales) over(partition by productID order by Sales ASC) as saledifference                                                               
      From Sales.Orders


      Select
      Distinct Table_name
      From INFORMATION_SCHEMA.COLUMNS


      Select
      OrderID,
      CustomerID
      From Sales.Orders

      Select
      *
     
      From(
      Select
      ProductID,
      Price,
      AVG(Price) over() as avgprice
      From Sales.Products)t
      Where Price>avgprice

      Select
      *,
      Rank() over(order by totalsales DESC )
      From(
      Select
      CustomerID,
      SUM(Sales) as totalsales
      From Sales.Orders
      Group by CustomerID)t


     Select
     ProductID,
     Price,
     (Select AVG(Price) From Sales.Products) as avgprice
     From Sales.Products
     where Price >  (Select AVG(Price) From Sales.Products)


     Select
     *
     From Sales.Orders
     where CustomerID Not In (   Select
                             CustomerID
                             From Sales.Customers
                             where Country='Germany')
  
      Select
      EmployeeID,
      FirstName,
      Gender,
      Salary
      From Sales.Employees
      where Gender= 'F'
      AND Salary > ANY  ( Select
                
                          Salary
                          From Sales.Employees
                          where Gender= 'M')
      

         Select
      EmployeeID,
      FirstName,
      Gender,
      Salary
      From Sales.Employees
      where Gender= 'F'
      AND Salary > ALL  ( Select
                
                          Salary
                          From Sales.Employees
                          where Gender= 'M')
     

      Select
      *,
       (Select Count(*) From Sales.Orders o where o.CustomerID=c.CustomerID ) as totalsales
      From Sales.Customers c

      --Main Query
     Select
     *
     From Sales.Orders as o
     where NOT EXISTS (Select 1
                          From Sales.Customers as c
                         Where Country='Germany'
                         AND o.CustomerID=c.CustomerID )

     
    -- FInd the total sales per customer

    --This result will stored in Cache
    WITH CTE_Total_Sales AS 
    (
    Select
    CustomerID,
    Sum(Sales) as totalsales
    From Sales.Orders
    Group by CustomerID
    -- Second CTE
    ) , CTE_last_order AS
    (
    Select
    CustomerID,
    Max(OrderDate) as Last_order
    From Sales.Orders
    Group By CustomerID
    )
    -- step3: rank Customers based on total sales per customer
    , CTE_Customer_rank as
    (
    Select
    CustomerID,
    TotalSales,
    Rank() over (order by TotalSales DESC) as customerRank
    From CTE_Total_Sales
    )
    -- step4: segment customer based on their total sales  (Nested segemnt)
    , CTE_Customer_Segments As
    (
    select
    CustomerID,
    TotalSales,
    Case When totalsales > 100 then 'high'
         when totalsales > 50 then 'medium'
         else 'low'
         end CustomerSegemnts
     From  CTE_Total_Sales
    )
    -- Main Query
    Select
    c.CustomerID,
    c.FirstName,
    c.LastName, 
    cts.totalsales,
    clo.Last_order,
    ccr.customerRank,
    ccs.CustomerSegemnts
    From Sales.Customers  as c
    Left Join CTE_Total_Sales as cts
    On cts.CustomerID=c.CustomerID
    Left join CTE_last_order clo
    On clo.CustomerID=c.CustomerID
     Left join CTE_Customer_rank as ccr
     On ccr.CustomerID=c.CustomerID
      Left join CTE_Customer_Segments  ccs
      on  ccs.CustomerID=c.CustomerID
        order by CustomerID


-- generate a sequence of numbr from 1 to 20
With Series As (
        -- Anchor query
        Select
        1 As mynumber
        Union All
        -- recursiver theory
        Select
        mynumber+1
        From Series
        Where mynumber < 20
) 
-- Main Query
Select*
From Series
option (Maxrecursion 20)

-- Task: Show the employee hierachy dy displaying each employee level within the organization
with CTE_Employee_Hierarchy AS
(
-- Anhor query
    Select
            EmployeeID,
            FirstName,
            ManagerID,
            1 as Level
    From Sales.Employees 
    where ManagerID is Null
    Union All
    --Recurive Theory
    Select
     e.EmployeeID,
      e.FirstName,
      e.ManagerID,
        Level+1
       From Sales.Employees as e
       Inner join CTE_Employee_Hierarchy as ceh
       On e.ManagerID=ceh.EmployeeID
)
-- Main Query
Select
*
From CTE_Employee_Hierarchy


-- Find the running total of sales for each month

With CTE_Monthly_Summary AS 
(
Select
DateTrunc(month,OrderDate) as orderMonth,
SUM(Sales) as totalsales,
COUNt(OrderID) as totalorders,
SUm(Quantity) as totalquantity
From Sales.Orders 
Group by DateTrunc(month,OrderDate)
)
Select
OrderMonth,
totalsales,
SUM(totalsales) over (Order by OrderMonth) as runnungtotall
From CTE_Monthly_Summary


Create View Sales.V_Monthly_Summary as 
(Select
DateTrunc(month,OrderDate) as orderMonth,
SUM(Sales) as totalsales,
COUNt(OrderID) as totalorders,
SUm(Quantity) as totalquantity
From Sales.Orders 
Group by DateTrunc(month,OrderDate))

Select*
From  V_Monthly_Summary

Select
OrderMonth,
totalsales,
SUM(totalsales) over (Order by OrderMonth) as runnungtotall
From V_Monthly_Summary


Drop View Sales.V_monthly_Summary

Drop View  V_Monthly_Summary
Create View V_Monthly_Summary as 
(Select
DateTrunc(month,OrderDate) as orderMonth,
SUM(Sales) as totalsales,
COUNt(OrderID) as totalorders,
SUm(Quantity) as totalquantity
From Sales.Orders 
Group by DateTrunc(month,OrderDate))

If Object_ID ('V_Monthly_Summary','V') IS NOT NULL
Drop View V_Monthly_Summary
Go
Create View V_Monthly_Summary as 
(Select
DateTrunc(month,OrderDate) as orderMonth,
SUM(Sales) as totalsales,
COUNt(OrderID) as totalorders,
SUm(Quantity) as totalquantity
From Sales.Orders 
Group by DateTrunc(month,OrderDate))

-- Provide view that combines details from orders, products,customers and employees
Create VIEW Sales.V1_Order_Details AS(
        Select
        o.OrderID,
        o.OrderDate,
        p.Product,
        p.Category,
        Coalesce(c.FirstName,'') + ''+Coalesce(c.LastName,'') as CustomerName,
        c.Country as CustomerCountry,
        Coalesce(e.FirstName,'') + ''+Coalesce(e.LastName,'') as CountryName,
        e.Department,
        --ProductID,
        --CustomerID,
        --SalesPersonID
        o.Sales,
        o.Quantity
        From Sales.Orders as o
        left Join Sales.Products as p
        On p.ProductID=o.ProductID
        Left Join Sales.Customers as c
        On c.CustomerID=o.CustomerID
        left join Sales.Employees as e
        on e.EmployeeID=o.SalesPersonID

        )
        Select
        *
        From Sales.V1_Order_Details

       /* Provide a view for EU Sales Team
        that combines details from AQll tables
        and excludes data related to the USA*/

        Create VIEW Sales.V1_Order_Details_EU AS(
        Select
        o.OrderID,
        o.OrderDate,
        p.Product,
        p.Category,
        Coalesce(c.FirstName,'') + ''+Coalesce(c.LastName,'') as CustomerName,
        c.Country as CustomerCountry,
        Coalesce(e.FirstName,'') + ''+Coalesce(e.LastName,'') as CountryName,
        e.Department,
        --ProductID,
        --CustomerID,
        --SalesPersonID
        o.Sales,
        o.Quantity
        From Sales.Orders as o
        left Join Sales.Products as p
        On p.ProductID=o.ProductID
        Left Join Sales.Customers as c
        On c.CustomerID=o.CustomerID
        left join Sales.Employees as e
        on e.EmployeeID=o.SalesPersonID
        Where  c.country != 'USA'
       )
       
               Select
        *
        From Sales.V1_Order_Details_EU


        Select
        Datename(month,OrderDate) as ordermonth,
        Count(orderID) as totalorders
        INTO Sales.MonthlyOrders123
        From Sales.orders
        Group by Datename(month,OrderDate)

        Select
        * 
        From Sales.MonthlyOrders123
        Drop Table Sales.MonthlyOrders123


        If Object_ID ('Sales.MonthlyOrders123','U') is Not NUll
        Drop Table Sales.MonthlyOrders123
        Go
        Select
        Datename(month,OrderDate) as ordermonth,
        Count(orderID) as totalorders
        INTO Sales.MonthlyOrders123
        From Sales.orders
        Group by Datename(month,OrderDate)


        Select
        *
        Into #Orders
        From Sales.Order
        
        Select
        *
        From #Orders
        where OrderStatus != 'Delivered'

        -- Step 1: Write a Query
        -- For US Customes Find the total Number of Customers and the Average Score


        Select
        Count(*) as totalsuctomers,
        AVG(Score) as AVGSCORE
        From Sales.Customers
        where country ='USA'


        -- Step 2: Turning the Query Into a Stored Procedure


        Alter Procedure GETCustomerSmmary2 @Country Nvarchar(50) = 'USA'
        As
        Begin
            Begin Try
                    Declare @totalcustomers INT, @AVGSCORE FLOAT;
                    --======================================
                    ----Step1 prrepare and clean up data
                     --=====================================
                    IF EXISTS (Select 1 from Sales.Customers Where Score IS NULL and Country = @Country)
                    Begin
                        Print ('Updating Null Score to 0');
                         UPDATE Sales.Customers
                         SET Score=0
                         where Score is Null and Country =@Country;
                    end
                    ELSE
                    BEGIN
                        Print ('No Null Scores found')
                    END
                    --============================
                    --Step2:Generating  reports
                    --============================
                    -- Calculate total customes and average score for specific country
                       Select
                    @totalcustomers = Count(*)  ,
                    @AVGSCORE = AVG(Score)
                    From Sales.Customers
                    where country = @Country


                    Print 'Total Customers from' + @Country + ':' + Cast(@totalcustomers as Nvarchar);
                    Print 'Average score from' + @Country + ':' + Cast(@AVGSCORE as NVARCHAR) ;
                   --=============================================
                   -- Find the total Nr. of orders and Total Sales
                   --==============================================
                    Select
                          COUNT(OrderID) as totalOrders,
                          Sum(Sales) as totalsales
              
                          From Sales.Orders as o
                          Join Sales.Customers c
                          On c.CustomerID=o.CustomerID
                          where c.Country = @Country
             end Try 
                         Begin Catch
                         --=====================
                         --== Error handling
                         --=====================
                                         Print ('An error occured.')
                                         Print ('Error Message:'+ Error_Message())
                                         Print ('Error Number :'+ Cast(Error_Number() as nvarchar))
                                         Print ('Error Line:'+Cast(Error_Line()as nvarchar));
                                         Print('Error Procedure'+ Error_procedure())
                            end Catch
        end
        Go
-- Step 3: execute the stored procedure
  
  EXEC GetCustomerSummary

  -- For German Customersw Find the total number of customers and the Average Score

  EXEC GetCustomerSummary @country ='Germany'

  
  -- Find the total Nr. of orders and Total Sales

  Select
  COUNT(OrderID) as totalOrders,
  Sum(Sales) as totalsales
  From Sales.Orders as o
  Join Sales.Customers c
  On c.CustomerID=o.CustomerID
  where c.Country = 'USA'


  Create table Sales.EmployeeLogs123(
  LogID INT IDentity(1,1) primary Key,
  EMPloyeeID INT,
  LogMessage Varchar(255),
  LogDate Date
  )




  Create Trigger trg_afterinsertemployee on Sales.EmployeeLogs123
  After insert 
  As 
  Begin
  Insert Into Sales.EmployeeLogs123 (EMPloyeeID,LogMessage,LogDate)
  Select
  EMPloyeeId,
  'New Employee Added =' + Cast(EmployeeID as varchar),
   GETDATE()
   From inserted

  end
  Select*
  From Sales.DBCustomers1
  where CustomerID=1

  Create Clustered index idx_DBCustomers1_CustomerID
  on Sales.DBCustomers1 (CustomerID)

  Drop Index idx_DBCustomers1_CustomerID on Sales.DBCustomers1

  Create Clustered index idx_DBCustomers1_FirstName
  on Sales.DBCustomers1 (FirstName)

   Drop Index idx_DBCustomers1_FirstName on Sales.DBCustomers1

   Select
   *
   From  Sales.DBCustomers1 
   where LastName = 'Brown'

   Create Nonclustered index idx_DBCustomers1_lastName
   On Sales.DBCustomers1 (LastName)

    Create index idx_DBCustomers1_FirstName
   On Sales.DBCustomers1 (FirstName)


    Select
   *
   From  Sales.DBCustomers1 
   where Country='USA' AND Score>500

   Create index idx_DbCustomers_CountryScore
   On Sales.DBCustomers1 (Country,Score)

   Create Clustered ColumnStore index idx_DBCustomers_CS
   on Sales.DBCustomers1
   Drop Index idx_DBCustomers_CS on Sales.DBCustomers1
    Create NonClustered ColumnStore index idx_DBCustomers_FirstName
   on Sales.DBCustomers1 (FirstName)
  

  Select
  *
  From Sales.Products
  Create Unique nonclustered index idx_products_product1
  on Sales.Products (Product)

  Insert Into Sales.Products (ProductID,Product) values (106,'Caps')


  Select * from Sales.Customers
  Where Country ='Germnay'

  Create Nonclustered index idx_Customers_Country2
  on Sales.Customers (Country)
  where Country = 'USA'
  sp_helpindex 'Sales.DBCustomers'

  Select
  tbl.name as Tablename,
  idx.name as indexName,
  idx.type_desc as indextype,
  idx.is_primary_key as isperomarykey,
  idx.is_unique as isUnique,
  idx.is_disabled as isdisabeled,
  s.user_seeks,
  s.user_scans,
  s.user_lookups,
  s.user_updates,
  Coalesce(s.last_user_seek,s.last_user_scan) as lastupdate
  From Sys.indexes as idx
  join sys.tables as tbl
  on idx.object_id =tbl.object_id
  left join sys.dm_db_index_usage_stats as s
  on s.object_id=idx.object_id
  And s.index_id=idx.index_id
  order by tbl.name, idx.name
