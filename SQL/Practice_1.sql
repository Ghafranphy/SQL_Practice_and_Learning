/*
===============================================================================
Project     : SQL Practice and Learning
File        : SQLFile1_2.sql
Author      : Ghafran Khan
Description : A collection of SQL queries covering fundamental to advanced
              SQL concepts, including data retrieval, filtering, joins,
              aggregate functions, data manipulation, and analytical queries.
Database    : SQL Server
Purpose     : Developing practical SQL skills for Data Analytics and Data Science.
===============================================================================
*/
Select*
From customers;

Select*
From orders

Select
customer_id,sales
From orders

Select
first_name,country,score
From customers

Select*
From customers
where score > 0

Select
score,country
From customers
where country='Germany'

Select*
From customers
where score!=0

Select*
from customers
where score!=0
order by country ASC,score DESC


Select
 country ,sum(score) As total_score
from customers
group by country


Select
id,first_name
from customers
group by id,first_name

Select
first_name,country,score
from customers
group by first_name,country,score
having score>500 and country !='USA'


Select Distinct 
 country
from customers


Select Top 3
score
From customers
order by score DESC

Select Top 3
order_id,customer_id,order_date,sales
From orders
order by order_date ASC

Select 
123 As number,
order_date
From orders


create Table person_crime1 (
id INT Not NUll,
person_name varchar(50) Not Null,
birth_date date,
phone Varchar(15) not null,
constraint pk_persons1 primary key (id)
)

Select*
From person_crime1

Alter table person_crime1
Add email varchar(50) Not Null

Select*
From person_crime1

Alter table person_crime1
Drop column person_name

Select*
From person_crime1


Drop table person_crime1

Insert into customers (id,first_name,country,score)
values 
    (6,'Anna','USA',Null),
        (7,'Ghafran','Pakistan',Null)
  Select*
  From customers

  Insert into persons (id,person_name,birth_date,phone)
  Select
  id, first_name,Null,'Unknown'
  From customers

  Select*
  From persons



  Select*
  From customers

  Update customers
  Set score=0,  country= 'Itlay'
  where id=6 

   Update customers
   Set score=100
   where score is NULL
 
  Select*
  From customers

  Delete customers
  where id>6
  
   Select*
  From customers

  Select*
  From customers
  where country= 'Germany'

  Select*
  From customers
  where country!= 'Germany'

  Select*
  From customers
  where score>500

    Select*
  From customers
  where score>=500

      Select*
  From customers
  where score>500 and country='USA'



       Select*
  From customers
  where score>500 Or country='USA'


  Select*
  From customers
  where score between 100 and 500


   Select*
  From customers
  where country not in ('USA','Germany') 


  Select*
  from customers
  Where first_name like 'M%'

   Select*
  from customers
  Where first_name like '%n'


  Select*
  from customers
  where first_name like '%r%'

    Select*
  from customers
  where first_name like '__r%'

  Select*
  From customers

  Select*
  From orders


  Select
  customers.id,customers.first_name,orders.order_id,orders.sales
  From customers
  inner join orders
  on customers.id=orders.customer_id


  Select
  customers.id,customers.first_name,orders.order_id,orders.sales
  From customers
  left join orders
  on customers.id=orders.customer_id



   Select
  customers.id,customers.first_name,orders.order_id,orders.sales
  From  orders
  left join customers 
  on customers.id=orders.customer_id

     Select
  customers.id,customers.first_name,orders.order_id,orders.sales
  From  orders
  right join customers 
  on customers.id=orders.customer_id


       Select
  customers.id,customers.first_name,orders.order_id,orders.sales
  From  customers
  left join orders 
  on customers.id=orders.customer_id


         Select
  customers.id,customers.first_name,orders.order_id,orders.sales
  From   orders
  full join customers 
  on customers.id=orders.customer_id


   Select*
  From   customers
  left join orders
  on customers.id= orders.customer_id
  where orders.customer_id is null


 
 
   Select*
  From   customers
  right join orders
  on customers.id= orders.customer_id
  where customers.id is null


     Select*
  From   customers
  Full join orders
  on customers.id= orders.customer_id
  where customers.id is null or orders.customer_id is null


  Use SalesDB
  
  Select
  o.OrderID,o.Sales
  From Sales.Orders AS o

  Select
  CustomerID,
   Lastname
   From Sales.Customers

   Union

   Select
   EmployeeID,
   Lastname
   From Sales.Employees


   Select
   FirstName,
   LastName
   From Sales.Customers
    Union

   Select
    FirstName,
   LastName
   From Sales.Employees



     Select
   FirstName,
   LastName
   From Sales.Customers
    Union all  -- include duplicates

   Select
    FirstName,
   LastName
   From Sales.Employees

   
     Select
   FirstName,
   LastName
   From Sales.Customers
   Except

   Select
    FirstName,
   LastName
   From Sales.Employees


 

   Select
    FirstName,
   LastName
   From Sales.Employees
   Except
       Select
   FirstName,
   LastName
   From Sales.Customers


     Select
    FirstName,
   LastName
   From Sales.Employees
   intersect
       Select
   FirstName,
   LastName
   From Sales.Customers

        Select
    FirstName,
   LastName
   From Sales.Employees
   union
       Select
   FirstName,
   LastName
   From Sales.Customers

   Select
   'orders' As sourceTable,
   [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
   From Sales.orders
   union
   Select
   'ordersArchive' As sourceTable,
   [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]

   From Sales.ordersArchive
   order by  OrderID

  
  Select
  FirstName,Country,
  CONCAT(FirstName,'-',Country) As name_country
  From Sales.Customers


   Select
  FirstName,Country,
  Lower(FirstName) As lower_case
  From Sales.Customers

     Select
  FirstName,Country,
  Lower(FirstName) As lower_case,
  Upper(Country)  As Upper_case
  From Sales.Customers



       Select
  FirstName
  From Sales.Customers
  Where FirstName!= Trim(FirstName)

  Select
  first_name,
  len(first_name) As length_name,
  len(trim(first_name)) AS len_trim_name
  From   customers

  Select
  '123-456-7890',
  Replace('123-456-7890','-','\')

  Select
  'report.txt',
  Replace('report.txt','.txt','.csv')


  Select
  first_name,
  len(first_name) AS length_name
  from customers


   Select
  first_name,
  len(first_name) AS length_name,
  left(first_name,2) AS left_side
  from customers

     Select
  first_name,
  len(first_name) AS length_name,
  left(Trim(first_name),2) AS left_side,
  right(Trim(first_name),2) AS right_side
  from customers


       Select
  first_name,
  len(first_name) AS length_name,
  left(Trim(first_name),2) AS left_side,
  right(Trim(first_name),2) AS right_side,
  substring(Trim(first_name),2,len(first_name)) As sub_name
  from customers

  Select  3.156,
  Round(3.156,2) AS round_2,
  Round(3.156,1) AS round_1


   Select  -3.156,
   Abs(-3.156)

   Select
   CreationTime,
   --Datetrunction
   Datetrunc(second,CreationTime) As sec_trunc,
   Datetrunc(hour,CreationTime) AS hour_trunc,
   Datetrunc(day,CreationTime) AS hour1_trunc,
   Datetrunc(year,CreationTime) AS year_trucn,
   -- Datenaemexample
   Datename(Month,CreationTime) As Month_dp,
   Datename(weekday,CreationTime) AS week_dy,
      -- Datapartexample
   Datepart(year,CreationTime),
   datepart(month,CreationTime),
   datepart(day,CreationTime),
   datepart(hour,CreationTime),
   datepart(quarter,CreationTime) As qurter_dp,
   datepart(week,CreationTime) As week_dp,
   YEAR(CreationTime) year,
   MONTH(CreationTime) Month,
   DAY(CreationTime) Day
   From Sales.Orders

   Select
   DateTrunc(year,CreationTime),count(*)
   From Sales.Orders
   Group by DateTrunc(year,CreationTime)


   Select
   OrderID,CreationTime,EOMONTH(CreationTime) As end_month,
   DateTrunc(month,CreationTime) As start_of_month
   From Sales.Orders

   Select
   year(OrderDate),
   count(*) NrofOrders
   From Sales.Orders
   Group By year(OrderDate)

      Select
   Datename(month,OrderDate),
   count(*) NrofOrders
   From Sales.Orders
   Group By Datename(month,OrderDate)

   Select
   *
   From Sales.Orders
   Where Month(OrderDate)=2

   Select
   OrderID,
   CreationTime,
   Format(CreationTime,'MM-dd-yyyy') USA_format,
   Format(CreationTime,'dd-MM-yyyy' ) EURO_format,
   Format(CreationTime,'dd') dd,
   Format(CreationTime,'ddd') ddd,
   Format(CreationTime,'dddd') dddd,
   Format(CreationTime,'MM')  MM,
   Format(CreationTime,'MMM')  MMM,
   Format(CreationTime,'MMMM') MMMM
   From Sales.Orders


   Select
   OrderID,
   CreationTime,
   'Day' + Format(CreationTime,'ddd MMM')+'Q'+Datename(quarter, CreationTime) +''+Format(CreationTime,'yyy hh:mm::ss tt') As CustomeFormat
   From Sales.Orders


   Select
   Format(OrderDate,'MMM yy') As order_date,
   count(*)
   From Sales.Orders
   Group By OrderDate

   Select
   CreationTime,
   Convert(Date, CreationTime) As date_time,
   CONVERT(VARCHAR,CreationTime,32) AS USA_standard,
   Convert(VARCHAR,CreationTime,34) AS europe_standard
   From Sales.Orders


   Select
   Cast('123' as int) AS stng_to_int,
   Cast('123' as varchar)  as varchar_sng,
   Cast('2025-08-20' as date) as ste_change,
   cast('2025-08-20' as datetime2) as smh,
   Creationtime,
   Cast(Creationtime as Date),
   dateadd(year,3,Creationtime),
   dateadd(month,2,Creationtime),
     dateadd(month,-2,Creationtime),
     OrderDate,
     datediff(day,Creationtime,OrderDate)
   
   From Sales.Orders

   Select
   Month(OrderDate),
   AVG(DATEDIFF(day,OrderDate,ShipDate))
   From Sales.Orders
   Group by  Month(OrderDate) 


   Select
   OrderID,
   OrderDate,
   LAG(OrderDate) over (Order by OrderDate ),
   --Time Gap Analysis
   Datediff(day,LAG(OrderDate) over (Order by OrderDate ),OrderDate),
   isdate(OrderDate)
   From Sales.Orders

   -- Check?
   Select
   OrderDate,
   ISDATE(OrderDate)
   From Sales.Orders




   Select
   Format(OrderDate,'MMM yy') OrderDate,
   Count(*)
   From Sales.Orders 
   Group By Format(OrderDate,'MMM yy') 



   Select 
   Creationtime,
   Convert(INT,'123'),
   Convert(Date,'2025-08-03'),
   Convert(Date,CreationTime),
   Convert(Varchar,CreationTime,32),
   convert(varchar,CreationTime,34)
   From Sales.orders

   Select
   CreationTime,
   Cast(CreationTime as date),
   cast('123' as int)
   From Sales.orders

   Select
   CreationTime,
   Orderdate,
   dateadd(year,2,CreationTime),
   dateadd(month,-2,CreationTime),
   datediff(day,CreationTime,OrderDate)
   From Sales.orders 


   -- find the average score for custosmers
   Select
   CustomerID,
   Score,
   Coalesce(Score,0),
   Avg(Score)  over(),
   Avg(Coalesce(Score,0)) over()
   From Sales.Customers

   Select
   CustomerID,
   FirstName,
   Lastname,
   Coalesce(Lastname,'') As lastname2,
   FirstName+''+Coalesce(Lastname,'') As fullname,
   Score,
   Coalesce(Score,'')+10 As score_bounus
   From Sales.Customers

   Select
   CustomerID,
   score,
   case when score is null then 1 else 0 end as flag
   From Sales.Customers
   Order by case when score is null then 1 else 0 end,score


  Select
   CustomerID,
   sales,
   Quantity,
   sales/Nullif(Quantity,0)  as price
   From Sales.Orders


   Select*
   From Sales.Customers
   where Score is not Null


   Select
   c.*,
   o.OrderID
   From Sales.Customers c
   left join sales.Orders o
   on c.CustomerID=o.CustomerID 
   where o.CustomerID is Null


   with Orders As (
   select 1 Id, 'A' category union
   select 2, NUll union
   select 3, '' union
   select 4, ' '
   )
   Select*,
   Trim (category),
   Nullif(Trim (category),'') policy_2,
   coalesce ( Nullif(Trim (category),''),'unknown') policy_3
   From Orders


   Select
   CustomerID,
   Score,
   Avg(Score) over() Avg_score,
   Avg(Coalesce(score,0)) over() Avg_score2
   From Sales.Customers

   Select
   CustomerID,
   FirstName,
   LastName,
   Coalesce(LastName,'') As last_2,
   Firstname+' '+Coalesce(LastName,'') AS full_name,
   Score,
   Coalesce(Score,0)+10 As score_bonus
   From Sales.Customers


   Select
   CustomerID,Score
   From Sales.Customers
   Order by  case when Score is Null then 1 else 0 end ,score
   
   Select 
   OrderID,Sales ,Quantity,
   Sales/Nullif(Quantity,0) AS price
   
   From Sales.Orders


   Select*
   From Sales.Customers
   Where Score is not Null




   Select c.*,
   o.orderID
   From Sales.Customers c
   left join Sales.Orders o
   on c.CustomerID=o.CustomerID
   where o.CustomerID is Null

   with Orders As (
   Select 1 Id, 'A' Category UNION
   Select 2, Null UNION
   Select 3, '' UNION
   Select 4, ' '
   )
   Select*,
   Trim(Category) as policy1,
   Nullif(Trim(Category),'') as policy2,
   Coalesce(Nullif(Trim(Category),''),'unknown') as policy3,
   datalength ( Trim(Category))
   From Orders

   Select
   Category,
   Sum(Sales)
   From (
   Select
   OrderID,
   Sales,
   case
   when Sales>50 then 'High'
   when Sales>20 then 'Medium'
   else 'low'
   end Category
   From Sales.Orders
   )t
   Group by Category
   Order by Sum(Sales) DESC




   Select
   EmployeeID,
   FirstName,
   LastName,
   Gender,
   Case
   When Gender='F'  then 'female'
   when Gender='M' then 'Male'
   else 'Not Avaliable'
   end
   From Sales.Employees


   Select
   CustomerID,
   FirstName,
   LastName,
   Country,
   Case
   when Country='Germany' then 'De'
   when Country= 'USA'  then 'US'
   Else 'Unknown'
   end AS country_abe
   From Sales.Customers
   




      Select
   CustomerID,
   FirstName,
   LastName,
   Country,
   Case  Country
   when 'Germany' then 'De'
   when 'USA'  then 'US'
   Else 'Unknown'
   end AS country_abe
   From Sales.Customers



   Select
   CustomerID,
   LastName,
   Score,
   Case
       When Score is Null then 0
       else Score
   end Score_clean,
   AVG(Case
       When Score is Null then 0
       else Score
   end) over() As AVG_score_clean,
   AVG(Score) over() As Origional_score
   From Sales.Customers


   Select
  
   CustomerID,
  
   SUM(Case
   When Sales > 30 Then 1
   Else 0
   end) AS SalesFlag,
   count(*) total_orders
   From Sales.Orders
   group By CustomerID



   Select
   COUNT(*),
   SUM(Sales) AS total_sales,
   AVG(Sales) AS average_sales,
   MAX(sales)   AS highest_sale,
   Min(sales)  AS lowest_sales
   From orders
   Group By customer_id

   Use SalesDB
   Select
   OrderID,Orderdate,
   ProductID,
   Sum(Sales) Over(Partition by ProductID)
   From Sales.Orders
 
   
   
Select
OrderID,
OrderDate,
ProductID,
OrderStatus,
Sales,
SUM(Sales) over() AS total_sales,
SUM(Sales) over(partition by ProductID)  As total_sales_by_product,
SUM(Sales)  over(partition by ProductID, OrderStatus) As sales_by_product_status
From Sales.Orders


 Select
 OrderID,
 OrderDate,
 OrderStatus,
 Sales,
 Sum(Sales) Over (Partition By OrderStatus Order By OrderDate  Rows Between Current Row And 2 Following)  As total_sale
 From Sales.Orders

  Select
  OrderID,
  OrderDate,
  OrderStatus,
  Sales,
  Sum(Sales)  Over (Partition by OrderStatus Order by OrderDate
  Rows between 2 preceding and current row)  As total_sales
  From Sales.Orders

  Select
  OrderID,
  OrderDate,
  OrderStatus,
  Sales,
  Sum(Sales) Over (Partition by OrderStatus Order by OrderDate  rows between unbounded preceding and current row) As total_sale
  From Sales.Orders
  where ProductID in (101,102)



    Select
 CustomerID,
  Sum(Sales)  As totalSales,
  Rank() over(order by Sum(Sales) DESC)  AS Rank_customer
  From Sales.Orders
  Group By CustomerID


  Select
  OrderID,
  OrderDate,
  CustomerID,
  Count(*) Over(),
  count(*) Over (Partition By CustomerID)  AS Orderbycustomers
  from Sales.Orders



  Select*,
  count(*) over()  totalCustomers,
  count(Score) Over()  as totalscore,
  count(Country) Over()  as totalcountries
  From Sales.Customers


  Select
  OrderID,
  count(*) over (partition by orderID) as Check_ID
  From Sales.Orders
  
  
  Select
  *
  From(
  Select
  OrderID,
  count(*) over (partition by OrderID) as Check_ID
  from Sales.OrdersArchive
  ) t where Check_ID >1


  Select
  OrderID,
  OrderDate,
  Sales,
  ProductID,
  Sum(Sales) over()  As total_sales,
  Sum(Sales) over(Partition By ProductID)
  from sales.Orders


  Select
  OrderID,
  ProductID,
  Sales,
  Sum(Sales) Over() as TotalSalee,
  round(Cast(Sales as float)/ Sum(Sales) over() *100,2) as percentageoftotal 
  From Sales.Orders

  select
  OrderID,
  OrderDate,
  Sales,
  ProductID,
  AVG(Sales) Over()  as AVGSales,
  AVG(Sales) Over(partition by ProductID)  as avg_sales
  From Sales.Orders



  Select
  CustomerID,
  LastName,
  Score,
  Coalesce(Score,0)  as customersScore,
  AVG(Score) over () as avg_score,
  AVG( Coalesce(Score,0)) over () as avg_score_withoutnull
  From Sales.Customers

  Select*
  from(

  Select
  OrderID,
  ProductID,
  Sales,
  AVG(Sales) Over() as AVGSales
  From sales.Orders
  )t where Sales> AVGSales




  Select
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  Max(Sales)  over(Partition by ProductID) as hightsales,
  min(Sales)  over(Partition by ProductID) as  lowersales
  from Sales.Orders

  Select*
  from(
  Select
 Salary,
  Max(Salary) over() as new_salary
  from Sales.Employees
  )t where Salary=new_salary



    Select
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  Max(Sales)  over(Partition by ProductID) as hightsales,
  min(Sales)  over(Partition by ProductID) as  lowersales,
  sales-min(Sales) over()  as deviationfrommin,
  max(Sales) over() - sales    as deviationofmax
  from Sales.Orders




  Select
  OrderID,
  ProductID,
  OrderDate,
  Sales,
  AVG(Sales) over(Partition By ProductID)  as avg_product,
  AVG(Sales) over(Partition By ProductID order by OrderDate)  as moving_avg,
  AVG(Sales)  over(Partition By ProductID order by OrderDate rows between current row and 1 following)  as moving_avg2

  From Sales.Orders

