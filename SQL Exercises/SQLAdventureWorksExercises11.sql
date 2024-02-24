/*101. From the following table write a query in SQL to calculate the salary percentile for each employee within a given department.
Return department, last name, rate, cumulative distribution and percent rank of rate. 
Order the result set by ascending on department and descending on rate.

Sample table: HumanResources.vemployeedepartmenthistory
Sample table: HumanResources.EmployeePayHistory*/

SELECT d.[Name] AS [Department], p.[LastName], eph.[Rate],
	CUME_DIST() OVER (PARTITION BY edh.[DepartmentID] ORDER BY eph.[Rate] DESC) AS Cumulative_Distribution,
	PERCENT_RANK() OVER (PARTITION BY edh.[DepartmentID] ORDER BY eph.[Rate] DESC) AS Percent_Rank

FROM HumanResources.EmployeeDepartmentHistory AS edh
	INNER JOIN HumanResources.EmployeePayHistory AS eph
		ON edh.[BusinessEntityID] = eph.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]
	INNER JOIN Person.Person AS p
		on edh.[BusinessEntityID] = p.[BusinessEntityID]

ORDER BY edh.[DepartmentID] ASC, eph.[Rate] DESC;



/*102. From the following table write a query in SQL to return the name of the product that is the least expensive in 
a given product category. Return name, list price and the first value i.e. LeastExpensive of the product.

Sample table: production.Product*/

SELECT [Name], [ListPrice], 
	FIRST_VALUE([Name]) OVER (ORDER BY [ListPrice] ASC) AS [LeastExpensive]

FROM Production.Product;



/*103. From the following table write a query in SQL to return the employee with the fewest number of vacation hours
compared to other employees with the same job title. Partitions the employees by job title and apply the first value 
to each partition independently.

Sample table: HumanResources.Employee
Sample table: Person.Person*/

SELECT [JobTitle], [LastName],
	FIRST_VALUE([LastName]) OVER (PARTITION BY [JobTitle] ORDER BY [VacationHours] ASC) AS [FewestVacantionHours]

FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p
		ON e.[BusinessEntityID] = p.[BusinessEntityID]

ORDER BY [JobTitle];



/*104. From the following table write a query in SQL to return the difference in sales quotas for a specific employee 
over previous years. Returun BusinessEntityID, sales year, current quota, and previous quota.

Sample table: Sales.SalesPersonQuotaHistory*/

SELECT [BusinessEntityID], YEAR([QuotaDate]) AS [SalesYear], [SalesQuota],
	LAG([SalesQuota]) OVER (PARTITION BY [BusinessEntityID] ORDER BY YEAR([QuotaDate])) AS [PreviousQuota]

FROM Sales.SalesPersonQuotaHistory

ORDER BY [BusinessEntityID], [SalesYear];



/*105. From the following table write a query in SQL to compare year-to-date sales between employees. 
Return TerritoryName, BusinessEntityID, SalesYTD, and sales of previous year i.e.PrevRepSales. 
Sort the result set in ascending order on territory name.

Sample table: Sales.vSalesPerson*/

SELECT st.[Name] AS [TerritoryName], sp.[BusinessEntityID], sp.[SalesYTD],
	LAG(sp.[SalesYTD]) OVER (PARTITION BY st.[Name] ORDER BY sp.[SalesYTD] DESC) AS [PrevRepSales]


FROM Sales.SalesPerson AS sp
	INNER JOIN Sales.SalesTerritory AS st
		ON sp.[TerritoryID] = st.[TerritoryID]

ORDER BY st.[Name];



/*106. From the following tables write a query in SQL to return the hire date of the last employee in each department 
for the given salary (Rate). Return department, lastname, rate, hiredate, and the last value of hiredate.

Sample table: HumanResources.vEmployeeDepartmentHistory
Sample table: HumanResources.EmployeePayHistory
Sample table: HumanResources.Employee*/

SELECT Department, LastName, Rate, HireDate,
	LAST_VALUE(HireDate) OVER (PARTITION BY Department ORDER BY Rate) AS LastValue
FROM HumanResources.vEmployeeDepartmentHistory AS edh
INNER JOIN HumanResources.EmployeePayHistory AS eph
    ON eph.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Employee AS e
    ON e.BusinessEntityID = edh.BusinessEntityID;
-- I had to look at the solution for this exercise because I have tried many ways and couldn't solve it



/*107. From the following table write a query in SQL to compute the difference between the sales quota value for the 
current quarter and the first and last quarter of the year respectively for a given number of employees. 
Return BusinessEntityID, quarter, year, differences between current quarter and first and last quarter. 
Sort the result set on BusinessEntityID, SalesYear, and Quarter in ascending order.

Sample table: Sales.SalesPersonQuotaHistory*/

SELECT 
    [BusinessEntityID],
    (MONTH([QuotaDate]) - 1) / 3 + 1 AS [Quarter],
    YEAR([QuotaDate]) AS [Year],
    [SalesQuota] AS [CurrentQuarterSalesQuota],
    [SalesQuota] - FIRST_VALUE([SalesQuota]) OVER (PARTITION BY [BusinessEntityID], YEAR([QuotaDate])
              ORDER BY (MONTH([QuotaDate]) - 1) / 3 + 1) AS [DifferenceFromFirstQuarter],
	[SalesQuota] - LAST_VALUE([SalesQuota]) OVER (PARTITION BY [BusinessEntityID], YEAR([QuotaDate])
              ORDER BY (MONTH([QuotaDate]) - 1) / 3 + 1) AS [DifferenceFromLastQuarter]
FROM 
    Sales.SalesPersonQuotaHistory
ORDER BY 
    [BusinessEntityID], [Year], [Quarter];
--I solved this exercise debugging with ChatGPT what I have tried 



/*108. From the following table write a query in SQL to return the statistical variance of the sales quota values 
for a salesperson for each quarter in a calendar year. Return quotadate, quarter, SalesQuota, and statistical variance. 
Order the result set in ascending order on quarter.

Sample table: Sales.SalesPersonQuotaHistory*/

SELECT [QuotaDate],
    (MONTH([QuotaDate]) - 1) / 3 + 1 AS [Quarter],
    [SalesQuota],
    VAR([SalesQuota]) OVER (PARTITION BY YEAR([QuotaDate]), ((MONTH([QuotaDate]) - 1) / 3 + 1)) AS [StatisticalVariance]

FROM Sales.SalesPersonQuotaHistory

ORDER BY [Quarter], [QuotaDate];


/*109. From the following table write a query in SQL to return the difference in sales quotas for a specific employee 
over subsequent years. Return BusinessEntityID, year, SalesQuota, and the salesquota coming in next row.

Sample table: Sales.SalesPersonQuotaHistory*/

SELECT [BusinessEntityID], YEAR([QuotaDate]) AS [Year], [SalesQuota],
	LEAD([SalesQuota]) OVER (PARTITION BY [BusinessEntityID] ORDER BY YEAR([QuotaDate])) AS [NextYearSalesQuota]

FROM Sales.SalesPersonQuotaHistory

ORDER BY [BusinessEntityID], [Year];
--I got help from ChatGPT for this one as well



/*110. From the following query write a query in SQL to compare year-to-date sales between employees for specific terrotery. 
Return TerritoryName, BusinessEntityID, SalesYTD, and the salesquota coming in next row.

Sample table: Sales.vSalesPerson*/

SELECT [TerritoryName], [BusinessEntityID], [SalesYTD],
    LEAD([SalesYTD]) OVER (PARTITION BY [TerritoryName] ORDER BY [BusinessEntityID]) AS [NextSalesYTD],
    [SalesQuota]

FROM Sales.vSalesPerson

WHERE [TerritoryName] = 'NorthWest'

ORDER BY [TerritoryName], [BusinessEntityID];
