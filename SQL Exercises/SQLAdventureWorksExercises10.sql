/*91 From the following table write a query in SQL to find the total number of employees.

Sample table: HumanResources.Employee*/

SELECT COUNT([BirthDate]) AS [NoOfEmployees]

FROM HumanResources.Employee;



/*92 From the following table write a query in SQL to find the average bonus for the salespersons who achieved the 
sales quota above 25000. Return number of salespersons, and average bonus.

Sample table: Sales.SalesPerson*/

SELECT COUNT([BusinessEntityID]) AS [NoOfEmployees], AVG([Bonus]) AS [avgBonus]

FROM Sales.SalesPerson;



/*93 From the following tables wirte a query in SQL to return aggregated values for each department. 
Return name, minimum salary, maximum salary, average salary, and number of employees in each department.

Sample table: HumanResources.employeepayhistory
Sample table: HumanResources.employeedepartmenthistory
Sample table: HumanResources.Department*/

SELECT [Name], MIN(eph.[Rate]) OVER (PARTITION BY d.[DepartmentID]) AS [Minimum Salary],
	MAX(eph.[Rate]) OVER (PARTITION BY d.[DepartmentID]) AS [Maximum Salary],
	AVG(eph.[Rate]) OVER (PARTITION BY d.[DepartmentID]) AS [Average Salary],
	COUNT(edh.[BusinessEntityID]) OVER (PARTITION BY d.[DepartmentID]) AS [NoOfEmployeesByDep]

FROM HumanResources.EmployeeDepartmentHistory AS edh
	INNER JOIN HumanResources.EmployeePayHistory eph
		ON edh.[BusinessEntityID] = eph.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON d.[DepartmentID] = edh.[DepartmentID]

ORDER BY d.[Name];



/*94 From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.

Sample table: humanresources.employee*/

SELECT [JobTitle], COUNT([BusinessEntityID]) AS [NoOfEmployees]

FROM HumanResources.Employee

GROUP BY [JobTitle]

HAVING COUNT([JobTitle]) > 15;



/*95 From the following table write a query in SQL to find the number of products that ordered in each of the specified sales orders.

Sample table: Sales.SalesOrderDetail*/

SELECT [SalesOrderID], COUNT([ProductID]) AS [NoOfProducts]

FROM Sales.SalesOrderDetail

GROUP BY [SalesOrderID];



/*96 From the following table write a query in SQL to compute the statistical variance of the sales quota values for each quarter 
in a calendar year for a sales person. Return year, quarter, salesquota and variance of salesquota.

Sample table: sales.salespersonquotahistory*/

SELECT YEAR([QuotaDate]) AS [Year], 
	DATEPART(QUARTER, [QuotaDate]) AS [Quarter],
	[SalesQuota] AS [SalesQuota],
	VAR([SalesQuota]) OVER (PARTITION BY YEAR([QuotaDate]), DATEPART(QUARTER, [QuotaDate])) AS [SalesQuotaVariance]

FROM Sales.SalesPersonQuotaHistory

ORDER BY YEAR([QuotaDate]), DATEPART(QUARTER, [QuotaDate]);




/*97 From the following table write a query in SQL to populate the variance of all unique values as well as all values, 
including any duplicates values of SalesQuota column.

Sample table: sales.salespersonquotahistory*/

SELECT VAR(DISTINCT [SalesQuota]) AS [UniqueValuesVar], VAR([SalesQuota]) AS [TotalValuesVar]

FROM Sales.SalesPersonQuotaHistory;



/*98 From the following table write a query in SQL to return the total ListPrice and StandardCost of products for each color. 
Products that name starts with 'Mountain' and ListPrice is more than zero. Return Color, total list price, total standardcode. 
Sort the result set on color in ascending order.

Sample table: production.Product*/

SELECT [Color], SUM([ListPrice]) AS [TotalListPrice], SUM([StandardCost]) AS [TotalStCost]

FROM Production.Product

WHERE [Name] LIKE ('Mountain%')
	AND [ListPrice] > 0

GROUP BY [Color]

ORDER BY [Color];


/*99 From the following table write a query in SQL to find the TotalSalesYTD of each SalesQuota. 
Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.

Sample table: Sales.SalesPerson*/

SELECT [SalesQuota], SUM([SalesYTD]) AS [TotalSalesYTD]

FROM Sales.SalesPerson

GROUP BY [SalesQuota];


/*100 From the following table write a query in SQL to calculate the sum of the ListPrice and StandardCost for each color.
Return color, sum of ListPrice.

Sample table: production.Product*/

SELECT [Color], SUM([ListPrice]) AS [TotalListPrice], SUM([StandardCost]) AS [TotalStCost]

FROM Production.Product

GROUP BY [Color]

ORDER BY [Color];