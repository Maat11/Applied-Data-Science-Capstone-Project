/*191. From the following table write a query in SQL to concatenate character and date data types for the order ID 50001.

Sample table: sales.SalesOrderHeader*/

SELECT CONCAT(CAST([OrderDate] AS NVARCHAR), CAST([SalesOrderID] AS NVARCHAR)) AS [ConcatenatedData]

FROM Sales.SalesOrderHeader

WHERE [SalesOrderID] = 50001;
-- debugged with ChatGPT



/*192. From the following table write a query in SQL to form one long string to display the last name and the first initial 
of the vice presidents. Sort the result set in ascending order on lastname.

Sample table: HumanResources.Employee*/

SELECT CONCAT(p.[LastName], ' ', LEFT(p.[FirstName], 1)) AS [OneLongString]

FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p
		ON e.[BusinessEntityID] = p.[BusinessEntityID]

WHERE e.[JobTitle] LIKE '%Vice President%'

ORDER BY p.[LastName];



/*193. From the following table write a query in SQL to return only the rows for Product that have a product line of R and 
that have days to manufacture that is less than 4. Sort the result set in ascending order on name.

Sample table: Production.Product*/

SELECT *

FROM Production.Product

WHERE [ProductLine] LIKE 'R%'
	AND [DaysToManufacture] <4

ORDER BY [Name];



/*194. From the following tables write a query in SQL to return total sales and the discounts for each product. 
Sort the result set in descending order on productname.

Sample table: Production.Product
Sample table: Sales.SalesOrderDetail*/

SELECT p.[Name], SUM(sod.[UnitPrice]) AS [TotalSales], SUM(sod.[UnitPriceDiscount]) AS [TotalDiscounts]

FROM Production.Product AS p
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON p.[ProductID] = sod.[ProductID]

GROUP BY p.[Name]

ORDER BY p.[Name] DESC;



/*195. From the following tables write a query in SQL to calculate the revenue for each product in each sales order. 
Sort the result set in ascending order on productname.

Sample table: Production.Product
Sample table: Sales.SalesOrderDetail*/

SELECT p.[Name], sod.[SalesOrderID],
    SUM(sod.[OrderQty] * sod.[UnitPrice]) AS [ProductRevenueBySalesOrder]

FROM Production.Product AS p
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON p.[ProductID] = sod.[ProductID]

GROUP BY p.[Name], sod.[SalesOrderID]

ORDER BY p.[Name];



/*196. From the following tables write a query in SQL to retrieve one instance of each product name whose product model is a 
long sleeve logo jersey, and the ProductModelID numbers match between the tables.

Sample table: Production.Product
Sample table: Production.ProductModel*/

SELECT *

FROM Production.Product AS p
	INNER JOIN Production.ProductModel AS pm
		ON p.[ProductModelID] = pm.[ProductModelID]

WHERE pm.[Name] LIKE '%long%sleeve%logo%jersey%'
	AND p.[ProductModelID] = pm.[ProductModelID];



/*197. From the following tables write a query in SQL to retrieve the first and last name of each employee whose bonus in 
the SalesPerson table is 5000.

Sample table: Person.Person
Sample table: HumanResources.Employee
Sample table: Sales.SalesPerson*/

SELECT p.[FirstName], p.[LastName]

FROM Person.Person AS p	
	INNER JOIN HumanResources.Employee AS e
		ON p.[BusinessEntityID] = e.[BusinessEntityID]
	INNER JOIN Sales.SalesPerson AS sp
		ON p.BusinessEntityID = sp.[BusinessEntityID]

WHERE sp.[Bonus] = 5000;



/*198. From the following table write a query in SQL to find product models where the maximum list price is more than 
twice the average.

Sample table: Production.Product*/

SELECT [Name]

FROM Production.Product

GROUP BY [Name]
HAVING MAX([ListPrice]) > 2* AVG([ListPrice]);



/*199. From the following table write a query in SQL to find the names of employees who have sold a particular product.

Sample table: Person.Person
Sample table: sales.SalesOrderHeader
Sample table: Sales.SalesOrderDetail
Sample table: Production.Product*/

SELECT DISTINCT pe.[FirstName], pe.[MiddleName], pe.[LastName], pr.[Name]

FROM Person.Person AS pe
	INNER JOIN Sales.SalesOrderHeader AS soh
		ON pe.[BusinessEntityID] = soh.[SalesPersonID]
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON soh.[SalesOrderID] = sod.[SalesOrderID]
	INNER JOIN Production.Product AS pr
		ON sod.[ProductID] = pr.[ProductID]

ORDER BY pr.[Name], pe.[FirstName], pe.[MiddleName], pe.[LastName];



/*200. Create a table public.gloves from Production.ProductModel for the ProductModelID 3 and 4.
From the following table write a query in SQL to include the contents of the ProductModelID and Name columns of both the tables.

Sample table: Production.ProductModel*/

CREATE TABLE [public.gloves]
([ProductModelID] INT,
[Name] NVARCHAR(50));

INSERT INTO [public.gloves] ([ProductModelID], [Name])
SELECT [ProductModelID], [Name]
FROM Production.ProductModel
WHERE [ProductModelID] IN (3, 4);

SELECT *
FROM [public.gloves];