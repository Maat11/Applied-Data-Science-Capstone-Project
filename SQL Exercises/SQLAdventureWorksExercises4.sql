/*31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.

Sample table: Person.Person*/

SELECT [LastName], [FirstName]

FROM Person.Person

WHERE [LastName] LIKE 'R%'

ORDER BY [FirstName] ASC, [LastName] DESC;


/*32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set 
to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.

Sample table: HumanResources.Employee*/

SELECT [BusinessEntityID], [SalariedFlag]

FROM HumanResources.Employee

ORDER BY 
CASE WHEN [SalariedFlag] = 'true' THEN [BusinessEntityID] END DESC,
CASE WHEN [SalariedFlag] = 'false' THEN [BusinessEntityID] END ASC;


/*33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column 
CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.

Sample table: Sales.SalesPerson*/

SELECT p.[BusinessEntityID], t.[TerritoryID], t.[Name], t.[CountryRegionCode]

FROM Sales.SalesTerritory AS t
	INNER JOIN Sales.SalesPerson AS p
		ON t.[TerritoryID] = p.[TerritoryID]

WHERE t.[TerritoryID] IS NOT NULL

ORDER BY
	CASE WHEN t.[CountryRegionCode] = 'US' THEN t.[TerritoryID]
	ELSE 0 END, t.[CountryRegionCode];



/*34. From the following table write a query in SQL to find those persons who lives in a territory and the value of 
salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', 
salesytd and postalcode. Order the output on postalcode column.

Sample table: Sales.SalesPerson
Sample table: Person.Person
Sample table: Person.Address*/

SELECT pp.[FirstName], pp.[LastName],
ROW_NUMBER() OVER (ORDER BY pa.[PostalCode]) AS [Row Number],
RANK() OVER (ORDER BY pa.[PostalCode]) AS [Rank],
DENSE_RANK() OVER (ORDER BY pa.[PostalCode]) AS [Dense Rank],
NTILE(4) OVER (ORDER BY pa.[PostalCode]) AS [Quartile],
sp.[SalesYTD], pa.[PostalCode]

FROM Sales.SalesPerson AS sp
	INNER JOIN Person.Person AS pp
		ON sp.[BusinessEntityID] = pp.[BusinessEntityID]
	INNER JOIN Person.Address AS pa
		ON pp.[BusinessEntityID] = pa.[AddressID]

WHERE sp.[TerritoryID] IS NOT NULL
	AND sp.[SalesYTD] <> 0;


/*35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set 
and return all remaining rows.

Sample table: HumanResources.Department*/

SELECT [DepartmentID], [Name], [GroupName], [ModifiedDate]

FROM HumanResources.Department

ORDER BY [DepartmentID] OFFSET 10 ROWS;


/*36. From the following table write a query in SQL to skip the first 5 rows and return the next
5 rows from the sorted result set.

Sample table: HumanResources.Department*/

SELECT [DepartmentID], [Name], [GroupName], [ModifiedDate]

FROM HumanResources.Department

ORDER BY [DepartmentID] OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;



/*37. From the following table write a query in SQL to list all the products that are Red or Blue in color. 
Return name, color and listprice.Sorts this result by the column listprice.

Sample table: Production.Product*/

SELECT [Name], [Color], [ListPrice]

FROM Production.Product

WHERE [Color] IN ('Red', 'Blue')

ORDER BY [ListPrice];


/*38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. 
Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products 
that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on 
product name column.

Sample table: Production.Product
Sample table: Sales.SalesOrderDetail*/

SELECT pp.[Name], sod.[SalesOrderID]

FROM Production.Product AS pp
	FULL OUTER JOIN Sales.SalesOrderDetail AS sod
		ON pp.[ProductID] = sod.[ProductID]

ORDER BY pp.[Name];


/*39. From the following table write a SQL query to retrieve the product name and salesorderid. 
Both ordered and unordered products are included in the result set.

Sample table: Production.Product
Sample table: Sales.SalesOrderDetail*/

SELECT pp.[Name], sod.[SalesOrderID]

FROM Production.Product AS pp
	LEFT OUTER JOIN Sales.SalesOrderDetail AS sod
		ON pp.[ProductID] = sod.[ProductID]

ORDER BY pp.[Name];


/*40. From the following tables write a SQL query to get all product names and sales order IDs. 
Order the result set on product name column.

Sample table: Production.Product
Sample table: Sales.SalesOrderDetail*/

SELECT pp.[Name], sod.[SalesOrderID]

FROM Production.Product AS pp
	FULL JOIN Sales.SalesOrderDetail AS sod
		ON pp.[ProductID] = sod.[ProductID]

ORDER BY pp.[Name];