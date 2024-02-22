/*81 From the following table write a query in SQL to calculate by dividing the total year-to-date sales (SalesYTD) 
by the commission percentage (CommissionPCT). Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.

Sample table: Sales.SalesPerson*/

SELECT [SalesYTD], [CommissionPct], ROUND([SalesYTD] / NULLIF([CommissionPct], 0),0) AS [RoundedValue]

FROM Sales.SalesPerson

ORDER BY [ModifiedDate];



/*82 From the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. 
Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID.

Sample table: Person.Person*/

SELECT p.[FirstName], p.[LastName], sp.[SalesYTD], p.[BusinessEntityID]

FROM Person.Person AS p
	INNER JOIN Sales.SalesPerson AS sp
		ON p.[BusinessEntityID] = sp.[BusinessEntityID]

WHERE sp.[SalesYTD] LIKE '2%';



/*83 From the following table write a query in SQL to convert the Name column to a char(16) column. 
Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.

Sample table: production.Product*/

SELECT CAST([Name] AS CHAR(16)) AS [name], [ListPrice]

FROM Production.Product

WHERE [Name] LIKE 'Long-Sleeve Logo Jersey%';



/*84 From the following table write a SQL query to determine the discount price for the salesorderid 46672. 
Calculate only those orders with discounts of more than.02 percent. 
Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).

Sample table: Sales.SalesOrderDetail*/

SELECT [ProductID], [UnitPrice], [UnitPriceDiscount], ([UnitPrice]*[UnitPriceDiscount]) AS [DiscountPrice]

FROM Sales.SalesOrderDetail

WHERE [SalesOrderID] = 46672
	AND [UnitPriceDiscount] > 0.02;



/*85 From the following table write a query in SQL to calculate the average vacation hours, and the sum of sick leave hours, 
that the vice presidents have used.

Sample table: HumanResources.Employee*/

SELECT AVG([VacationHours]) AS [avgVacantionHrs], SUM([SickLeaveHours]) AS [totalSickLeaveHrs]

FROM HumanResources.Employee

WHERE [JobTitle] LIKE '%Vice president%';



/*86 From the following table write a query in SQL to calculate the average bonus received and the sum of year-to-date 
sales for each territory. Return territoryid, Average bonus, and YTD sales.

Sample table: Sales.SalesPerson*/

SELECT [TerritoryID], AVG([Bonus]) AS [avgBonus], SUM([SalesYTD]) AS [totalSalesYTD]

FROM Sales.SalesPerson

GROUP BY [TerritoryID];



/*87 From the following table write a query in SQL to return the average list price of products. 
Consider the calculation only on unique values.

Sample table: production.Product*/

SELECT DISTINCT [Name], AVG([ListPrice]) AS [avgPrice]

FROM Production.Product

GROUP BY [Name];



/*88 From the following table write a query in SQL to return a moving average of yearly sales for each territory. 
Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

Sample table: Sales.SalesPerson*/

SELECT [BusinessEntityID], [TerritoryID], 
    YEAR([ModifiedDate]) AS [SalesYear], 
    [SalesYTD],
    AVG([SalesYTD]) OVER (PARTITION BY [TerritoryID] ORDER BY YEAR([ModifiedDate])) AS [MovingAvg],
    SUM([SalesYTD]) OVER (PARTITION BY [TerritoryID] ORDER BY YEAR([ModifiedDate])) AS [CumulativeTotal]
FROM Sales.SalesPerson
ORDER BY [BusinessEntityID], [TerritoryID], [SalesYear];



/*89 From the following table write a query in SQL to return a moving average of sales, by year, for all sales territories. 
Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

Sample table: Sales.SalesPerson*/

SELECT [BusinessEntityID], [TerritoryID], 
    YEAR([ModifiedDate]) AS [SalesYear], 
    [SalesYTD],
    AVG([SalesYTD]) OVER (PARTITION BY [TerritoryID] ORDER BY YEAR([ModifiedDate])) AS [MovingAvg],
    SUM([SalesYTD]) OVER (PARTITION BY [TerritoryID] ORDER BY YEAR([ModifiedDate])) AS [CumulativeTotal]

FROM Sales.SalesPerson

GROUP BY [BusinessEntityID], YEAR([ModifiedDate]), [TerritoryID], [SalesYTD]

ORDER BY [BusinessEntityID], [TerritoryID], [SalesYear];



/*90 From the following table write a query in SQL to return the number of different titles that employees can hold.

Sample table: HumanResources.Employee*/

SELECT COUNT(DISTINCT [JobTitle]) AS [noDifTitles]

FROM HumanResources.Employee;