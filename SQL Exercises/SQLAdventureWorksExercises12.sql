/*110. From the following query write a query in SQL to compare year-to-date sales between employees for specific terrotery. 
Return TerritoryName, BusinessEntityID, SalesYTD, and the salesquota coming in next row.

Sample table: Sales.vSalesPerson*/

SELECT [TerritoryName], [BusinessEntityID], [SalesYTD],
	LEAD ([SalesYTD], 1, 0) OVER (PARTITION BY [TerritoryName] ORDER BY [SalesYTD] DESC) AS [UpcomingSales]  


FROM Sales.vSalesPerson

GROUP BY [TerritoryName], [BusinessEntityID], [SalesYTD];



/*111. From the following table write a query in SQL to obtain the difference in sales quota values for a specified employee 
over subsequent calendar quarters. Return year, quarter, sales quota, next sales quota, and the difference in sales quota. 
Sort the result set on year and then by quarter, both in ascending order.

Sample table: Sales.SalesPersonQuotaHistory*/

SELECT YEAR([QuotaDate]) AS [Year],
	((MONTH([QuotaDate]) - 1) / 3 + 1) AS [Quarter],
	[SalesQuota] AS [SalesQuota],
    COALESCE([SalesQuota], 0) AS [NextSalesQuota],
    COALESCE([SalesQuota], 0) - [SalesQuota] AS [DifferenceSalesQuota]

FROM Sales.SalesPersonQuotaHistory

ORDER BY [Year], [Quarter];



/*112. From the following table write a query in SQL to compute the salary percentile for each employee within a given department. 
Return Department, LastName, Rate, CumeDist, and percentile rank. Sort the result set in ascending order on department and 
descending order on rate.

N.B.: The cumulative distribution calculates the relative position of a specified value in a group of values.

Sample table: HumanResources.vEmployeeDepartmentHistory*/

SELECT d.[Name], p.[LastName], eph.[Rate], 
	CUME_DIST() OVER (PARTITION BY d.[Name] ORDER BY eph.[Rate]) AS [CumeDist],
	PERCENT_RANK() OVER (PARTITION BY d.[Name] ORDER BY eph.[Rate]) AS [PercentileRank]

FROM HumanResources.EmployeeDepartmentHistory AS edh
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]
	INNER JOIN Person.Person AS p
		ON edh.[BusinessEntityID] = p.[BusinessEntityID]
	INNER JOIN HumanResources.EmployeePayHistory AS eph
		ON edh.[BusinessEntityID] = eph.[BusinessEntityID]

ORDER BY d.[Name] ASC, eph.[Rate] DESC;



/*113. From the following table write a query in SQL to add two days to each value in the OrderDate column, 
to derive a new column named PromisedShipDate. Return salesorderid, orderdate, and promisedshipdate column.

Sample table: sales.salesorderheader*/

SELECT [SalesOrderID], [OrderDate],
	DATEADD(DAY, 2, [OrderDate]) AS [PromisedShipDate]

FROM Sales.SalesOrderHeader;
-- I used ChatGPT to solve this one



/*114. From the following table write a query in SQL to obtain a newdate by adding two days with current date for each salespersons.
Filter the result set for those salespersons whose sales value is more than zero.

Sample table: Sales.SalesPerson
Sample table: Person.Person
Sample table: Person.Address*/

SELECT sp.[BusinessEntityID], p.[LastName], sp.[ModifiedDate],
	DATEADD(DAY, 2, GETDATE()) AS [NewDates]

FROM Sales.SalesPerson AS sp
	INNER JOIN Person.Person AS p
		ON sp.[BusinessEntityID] = p.[BusinessEntityID]

WHERE (sp.[SalesYTD] + sp.[SalesLastYear]) > 0;




/*115. From the following table write a query in SQL to find the differences between the maximum and minimum orderdate.

Sample table: Sales.SalesOrderHeader*/

SELECT DATEDIFF(DAY, MIN([OrderDate]), MAX([OrderDate])) AS [DifferenceBetwDate]

FROM Sales.SalesOrderHeader;



/*116. From the following table write a query in SQL to rank the products in inventory, by the specified inventory locations, 
according to their quantities. Divide the result set by LocationID and sort the result set on Quantity in descending order.

Sample table: Production.ProductInventory*/

SELECT [LocationID], [ProductID], [Quantity],
    RANK() OVER (PARTITION BY [LocationID] ORDER BY [Quantity] DESC) AS [ProductRank]

FROM 
    Production.ProductInventory

ORDER BY [LocationID], [Quantity] DESC;




/*117. From the following table write a query in SQL to return the top ten employees ranked by their salary.

Sample table: HumanResources.EmployeePayHistory*/

SELECT TOP 10 [BusinessEntityID], [Rate], [PayFrequency],
    RANK() OVER (ORDER BY [Rate] * [PayFrequency] DESC) AS [SalaryRank]

FROM 
    HumanResources.EmployeePayHistory

ORDER BY [Rate] * [PayFrequency] DESC;



/*118. From the following table write a query in SQL to divide rows into four groups of employees based on their year-to-date sales.
Return first name, last name, group as quartile, year-to-date sales, and postal code.

Sample table: Sales.SalesPerson
Sample table: Person.Person
Sample table: Person.Address*/

SELECT  p.[FirstName], p.[LastName], 
	NTILE(4) OVER(ORDER BY [SalesYTD] DESC) AS [Quartile],
	CAST([SalesYTD] AS VARCHAR(20)) AS [SalesYTD],
	pa.PostalCode 

FROM Sales.SalesPerson AS sp
	INNER JOIN Person.Person AS p
		ON sp.[BusinessEntityID] = p.[BusinessEntityID]
	INNER JOIN Person.Address AS pa
		ON sp.[TerritoryID] = pa.[AddressID];



/*119. From the following tables write a query in SQL to rank the products in inventory the specified inventory locations 
according to their quantities. The result set is partitioned by LocationID and logically ordered by Quantity. 
Return productid, name, locationid, quantity, and rank.

Sample table: production.productinventory
Sample table: production.Product*/

SELECT i.[ProductID], p.[Name], i.[LocationID], i.[Quantity],
	RANK() OVER (PARTITION BY i.[LocationID] ORDER BY i.[Quantity] DESC) AS [Rank]

FROM Production.ProductInventory AS i
	INNER JOIN Production.Product AS p
		ON i.[ProductID] = p.[ProductID]

ORDER BY i.[LocationID], i.[Quantity] DESC;



/*120. From the following table write a query in SQL to find the salary of top ten employees.
Return BusinessEntityID, Rate, and rank of employees by salary.

Sample table: HumanResources.EmployeePayHistory*/

SELECT TOP 10 [BusinessEntityID], [Rate], 
    RANK() OVER (ORDER BY [Rate] * [PayFrequency] DESC) AS [SalaryRank]

FROM HumanResources.EmployeePayHistory

ORDER BY [Rate] * [PayFrequency] DESC;