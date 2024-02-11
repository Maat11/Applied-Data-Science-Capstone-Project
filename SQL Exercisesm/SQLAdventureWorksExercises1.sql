--EXERCISES RETRIEVED FROM https://www.w3resource.com/sql-exercises/adventureworks/adventureworks-exercises.php,
--and solved by Bianca Diana Smalbelgher in Microsoft SQL Server Management Studio

/*1. From the following table write a query in SQL to retrieve all rows and columns 
from the employee table in the Adventureworks database. 
Sort the result set in ascending order on jobtitle.
Sample table: HumanResources.Employee*/

SELECT *

FROM HumanResources.Employee

ORDER BY [JobTitle];


/*2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using. 
Sort the output in ascending order on lastname.

Sample table: Person.Person*/

SELECT *

FROM Person.Person

ORDER BY [LastName];


/*3. From the following table write a query in SQL to return all rows and a subset of
the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. 
The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.

Sample table: Person.Person*/

SELECT [FirstName], [LastName], [BusinessEntityID] AS [Employee_id]

FROM Person.Person

ORDER BY [LastName];



/*4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL
and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.

Sample table: production.Product*/

SELECT [ProductID], [ProductNumber], [Name]

FROM Production.Product

WHERE [SellStartDate] IS NOT NULL

AND [ProductLine] = 'T'

ORDER BY [Name];


/*5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database 
and calculate the percentage of tax on the subtotal have decided. 
Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. 
Arranged the result set in ascending order on subtotal.

Sample table: sales.salesorderheader*/

SELECT [SalesOrderID], [CustomerID], [OrderDate], [SubTotal], 
([TaxAmt]*100)/[SubTotal] AS [TaxPercent]

FROM Sales.SalesOrderHeader

ORDER BY [SubTotal];


/*6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table 
in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.

Sample table: HumanResources.Employee*/

SELECT DISTINCT [JobTitle]

FROM HumanResources.Employee

ORDER BY [JobTitle];


/*7. From the following table write a query in SQL to calculate the total freight paid by each customer. 
Return customerid and total freight. Sort the output in ascending order on customerid.

Sample table: sales.salesorderheader*/

SELECT [CustomerID], SUM([Freight]) AS [TotalFreight]

FROM Sales.SalesOrderHeader

GROUP BY [CustomerID]

ORDER BY [CustomerID];


/*8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. 
Sort the result on customerid column in descending order.

Sample table: sales.salesorderheader*/

SELECT [CustomerID], AVG([SubTotal]) AS AvgSubTotal, SUM([SubTotal]) AS SumSubTotal

FROM Sales.SalesOrderHeader

GROUP BY [CustomerID], [SalesPersonID]

ORDER BY [CustomerID] DESC;


/*9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf 
of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order.

Sample table: production.productinventory*/

SELECT [ProductID], SUM([Quantity]) AS [TotalQuantity]

FROM Production.ProductInventory

WHERE [Shelf] IN ('A','C','H')

GROUP BY [ProductID]

HAVING SUM([Quantity]) > 500

ORDER BY [ProductID];


/*10. From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.

Sample table: production.productinventory*/

SELECT SUM([Quantity]) AS [TotalQuantity]

FROM Production.ProductInventory

GROUP BY ([LocationID]*10);
