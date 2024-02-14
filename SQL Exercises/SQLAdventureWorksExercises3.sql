/*21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to 
a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.

Sample table: Sales.SalesPerson
Sample table: Person.Person
Sample table: Person.Address*/

SELECT ROW_NUMBER() OVER (PARTITION BY [PostalCode] ORDER BY [SalesYTD] DESC) AS [RowNumber], 
[LastName], [SalesYTD], [PostalCode]

FROM Sales.SalesPerson AS sales

	INNER JOIN Person.Person AS pers 
		
		ON sales.[BusinessEntityID] = pers.[BusinessEntityID]

	INNER JOIN Person.Address AS adress
		ON pers.[BusinessEntityID] = adress.[AddressID]

WHERE [TerritoryID] IS NOT NULL

AND [SalesYTD] <> 0

ORDER BY [PostalCode] ASC, [SalesYTD] DESC;


/*22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. 
Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contacts.

Sample table: Person.BusinessEntityContact
Sample table: Person.ContactType*/

SELECT contactTy.[ContactTypeID], contactTy.[Name], COUNT(*) AS [No_Contacts]

FROM Person.BusinessEntityContact AS bcontact

	INNER JOIN Person.ContactType AS contactTy
		ON bcontact.[ContactTypeID] = contactTy.[ContactTypeID]

GROUP BY contactTy.[ContactTypeID], contactTy.[Name]

HAVING COUNT(*) >= 100

ORDER BY COUNT(*) DESC;


/*23. From the following table write a query in SQL to retrieve the RateChangeDate, 
full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. 
In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.

Sample table: HumanResources.EmployeePayHistory
Sample table: Person.Person*/

SELECT FORMAT(emplHist.[RateChangeDate], 'yyyy-MM-dd') AS [RateChangeDate],
	pers.[FirstName] + ' ' + ISNULL(pers.[MiddleName] + ' ','') + pers.[LastName]  AS [NameInFull],
	([Rate] * 40) AS [WeeklySalary]

FROM HumanResources.EmployeePayHistory AS emplHist
	INNER JOIN Person.Person AS pers
		ON emplHist.[BusinessEntityID] = pers.[BusinessEntityID]

ORDER BY [NameInFull];


/*24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. 
Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees 
Sort the output in ascending order on NameInFull.

Sample table: Person.Person
Sample table: HumanResources.EmployeePayHistory*/

SELECT FORMAT(emplHist.[RateChangeDate], 'yyyy-MM-dd') AS [RateChangeDate],
	pers.[FirstName] + ' ' + ISNULL(pers.[MiddleName] + ' ','') + pers.[LastName]  AS [NameInFull],
	([Rate] * 40) AS [WeeklySalary]

FROM HumanResources.EmployeePayHistory AS emplHist
	INNER JOIN Person.Person AS pers
		ON emplHist.[BusinessEntityID] = pers.[BusinessEntityID]

WHERE emplHist.[RateChangeDate] = (SELECT MAX([RateChangeDate])
								FROM HumanResources.EmployeePayHistory
								WHERE [BusinessEntityID] = emplHist.[BusinessEntityID])

ORDER BY [NameInFull];


/*25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity 
for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min 
order quantity.

Sample table: Sales.SalesOrderDetail*/

SELECT [SalesOrderID], [ProductID], [OrderQty],
	SUM([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [SumQty],
	AVG([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [AvgQty], 
	COUNT([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [CountQty], 
	MIN([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [MinQty],
	MAX([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [MaxQty]

FROM Sales.SalesOrderDetail

WHERE [SalesOrderID] IN (43659, 43664);


/*26. From the following table write a query in SQL to find the sum, average, and number of order quantity 
for those orders whose ids are 43659 and 43664 and product id starting with '71'. 
Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

Sample table: Sales.SalesOrderDetail*/

SELECT [SalesOrderID], [SalesOrderDetailID], [ProductID], [OrderQty],
	SUM([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [SumQty],
	AVG([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [AvgQty], 
	COUNT([OrderQty]) OVER (PARTITION BY [SalesOrderID], [ProductID]) AS [CountQty]

FROM Sales.SalesOrderDetail

WHERE [SalesOrderID] IN (43659, 43664)
AND [ProductID] LIKE '71%';


/*27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. 
Return SalesOrderID, total cost.

Sample table: Sales.SalesOrderDetail*/

SELECT [SalesOrderID], SUM([OrderQty] * [UnitPrice]) AS [OrderCost]

FROM Sales.SalesOrderDetail

GROUP BY [SalesOrderID]

HAVING SUM([OrderQty] * [UnitPrice]) > 100000

ORDER BY [SalesOrderID];


/*28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. 
Return product ID, and name and order the result set in ascending order on product ID column.

Sample table: Production.Product*/

SELECT [ProductID], [Name]

FROM Production.Product

WHERE [Name] LIKE 'Lock Washer%'

ORDER BY [ProductID];


/*29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. 
Return product ID, name, and color of the product.

Sample table: Production.Product*/

SELECT [ProductID], [Name], [Color]

FROM Production.Product

ORDER BY [ListPrice];


/*30. From the following table write a query in SQL to retrieve records of employees. 
Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.

Sample table: HumanResources.Employee*/

SELECT [BusinessEntityID], [JobTitle], [HireDate]

FROM HumanResources.Employee

ORDER BY YEAR([HireDate]);