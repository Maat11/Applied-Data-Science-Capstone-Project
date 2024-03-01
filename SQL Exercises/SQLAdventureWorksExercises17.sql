/*161. From the following table wirte a query in SQL to search for rows with the 'green_' character in the LargePhotoFileName 
column. Return all columns.

Sample table: Production.ProductPhoto*/

SELECT *

FROM Production.ProductPhoto

WHERE [LargePhotoFileName] LIKE '%green%';




/*162. From the following tables write a query in SQL to obtain mailing addresses for companies in cities that begin with PA, 
outside the United States (US). Return AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode.

Sample table: Person.Address
Sample table: Person.StateProvince*/

SELECT a.[AddressLine1], a.[AddressLine2], a.[City], a.[PostalCode], sp.[CountryRegionCode]

FROM Person.Address AS a
	INNER JOIN Person.StateProvince AS sp
		ON a.[StateProvinceID] = sp.[StateProvinceID]

WHERE a.[City] LIKE 'PA%'
	AND sp.[CountryRegionCode] <> 'US';



/*163. From the following table write a query in SQL to specify that a JOIN clause can join multiple values. 
Return ProductID, product Name, and Color.

Sample table: Production.Product*/

SELECT p.[ProductID], p.[Name], p.[Color]

FROM Production.Product AS p
	INNER JOIN (VALUES ('Silver'), ('Black'), ('White')) AS joined([Color])
		ON p.[Color] = joined.[Color];
--debugged with ChatGPT



/*164. From the following table write a query in SQL to find the SalesPersonID, salesyear, totalsales, salesquotayear, 
salesquota, and amt_above_or_below_quota columns. Sort the result set in ascending order on SalesPersonID, and SalesYear columns.

Sample table: Sales.SalesOrderHeader
Sample table: Sales.SalesPersonQuotaHistory*/

SELECT soh.[SalesPersonID],
	YEAR(soh.[OrderDate]) AS [salesyear], 
	SUM(spqh.[SalesQuota]) AS [totalsales],
	YEAR(spqh.[QuotaDate])AS [salesquotayear], 
	spqh.[SalesQuota],
	
	CASE 
		WHEN spqh.[SalesQuota] != '7000.00' 
		THEN 1 
		ELSE 0 
	END AS [amt_above_or_below_quota]

FROM Sales.SalesOrderHeader AS soh
	INNER JOIN Sales.SalesPersonQuotaHistory AS spqh
		ON soh.[ModifiedDate] = spqh.[ModifiedDate]

GROUP BY soh.[SalesPersonID], YEAR(soh.[OrderDate]), YEAR(spqh.[QuotaDate]), spqh.[SalesQuota]

ORDER BY soh.[SalesPersonID], YEAR(soh.[OrderDate]);
-- got help from ChatGPT to solve [amt_above_or_below_quota] column



/*165. From the following tables write a query in SQL to return the cross product of BusinessEntityID and Department columns.

The following example returns the cross product of the two tables Employee and Department in the AdventureWorks2019 database. 
A list of all possible combinations of BusinessEntityID rows and all Department name rows are returned.

Sample table: HumanResources.Employee
Sample table: HumanResources.Department*/

SELECT e.[BusinessEntityID], d.[GroupName]

FROM HumanResources.Employee AS e
	CROSS JOIN HumanResources.Department AS d;



/*166. From the following tables write a query in SQL to return the SalesOrderNumber, ProductKey, and EnglishProductName columns.

Sample table: Sales.SalesOrderDetail
Sample table: Production.Product*/

SELECT od.[SalesOrderID] AS [SalesOrderNumber], od.[ProductID] AS [ProductKey], p.[Name] AS [EnglishProductName]

FROM Sales.SalesOrderDetail AS od
	INNER JOIN Production.Product AS p
		ON od.[ProductID] = p.[ProductID];



/*167. From the following tables write a query in SQL to return all orders with IDs greater than 60000.

Sample table: Sales.SalesOrderDetail
Sample table: Production.Product*/

SELECT *

FROM Sales.SalesOrderDetail AS sod
	INNER JOIN Production.Product AS p
		ON sod.[ProductID] = p.[ProductID]

WHERE sod.[SalesOrderID] > 60000;



/*168. From the following tables write a query in SQL to retrieve the SalesOrderid. A NULL is returned if no orders exist 
for a particular Territoryid. Return territoryid, countryregioncode, and salesorderid. 
Results are sorted by SalesOrderid, so that NULLs appear at the top.

Sample table: sales.salesterritory
Sample table: sales.salesorderheader*/

SELECT st.[TerritoryID], st.[CountryRegionCode], soh.[SalesOrderID]

FROM Sales.SalesTerritory AS st
	LEFT JOIN Sales.SalesOrderHeader AS soh
		ON st.[TerritoryID] = soh.[TerritoryID]

ORDER BY COALESCE(soh.[SalesOrderID], 0), st.[TerritoryID];
--got help from ChatGPT for the last line



/*169. From the following table write a query in SQL to return all rows from both joined tables but returns NULL for values 
that do not match from the other table. 
Return territoryid, countryregioncode, and salesorderid. Results are sorted by SalesOrderid.

Sample table: sales.salesterritory
Sample table: sales.salesorderheader*/

SELECT st.[TerritoryID], st.[CountryRegionCode], soh.[SalesOrderID]

FROM Sales.SalesTerritory AS st
	FULL OUTER JOIN Sales.SalesOrderHeader AS soh
		ON st.[TerritoryID] = soh.[TerritoryID]

ORDER BY soh.[SalesOrderID];



/*170. From the following tables write a query in SQL to return a cross-product. Order the result set by SalesOrderid.

Sample table: sales.salesterritory
Sample table: sales.salesorderheader*/

SELECT TOP 1 *

FROM Sales.SalesTerritory AS st
	CROSS JOIN Sales.SalesOrderHeader AS soh

ORDER BY soh.[SalesOrderID];