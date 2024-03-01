/*181. From the following table write a query in SQL to return the difference in sales quotas for a specific employee over 
previous calendar quarters. Sort the results by salesperson with businessentity id 277 and quotadate year 2012 or 2013.

Sample table: sales.salespersonquotahistory*/

SELECT DISTINCT [SalesQuota]

FROM Sales.SalesPersonQuotaHistory

WHERE [BusinessEntityID] LIKE 277
	AND YEAR([QuotaDate]) IN ('2012', '2013');



/*182. From the following table write a query in SQL to return a truncated date with 4 months added to the orderdate.

Sample table: sales.salesorderheader*/

SELECT 
    [SalesOrderID], 
    [OrderDate],
    CONVERT(DATE, DATEADD(MONTH, 4, [OrderDate])) AS TruncatedOrderDate
FROM 
    Sales.SalesOrderHeader;
-- I asked ChatGPT on this one




/*183. From the following table write a query in SQL to return the orders that have sales on or after December 2011. 
Return salesorderid, MonthOrderOccurred, salespersonid, customerid, subtotal, Running Total, and actual order date.

Sample table: sales.salesorderheader*/

SELECT [SalesOrderID],
    MONTH([OrderDate]) AS [MonthOrderOccurred],
	[SalesOrderID], [CustomerID], [SubTotal], [TotalDue] AS [RunningTotal], [OrderDate]

FROM Sales.SalesOrderHeader

WHERE [OrderDate] >= 2011-12-01;



/*184. From the following table write a query in SQL to repeat the 0 character four times before productnumber. 
Return name, productnumber and newly created productnumber.

Sample table: Production.Product*/

SELECT [Name], [ProductNumber], CONCAT('0000', [ProductNumber]) AS [NewProductNumber]

FROM Production.Product;



/*185. From the following table write a query in SQL to find all special offers. 
When the maximum quantity for a special offer is NULL, return MaxQty as zero.

Sample table: Sales.SpecialOffer*/

SELECT Description, DiscountPct, MinQty, coalesce(MaxQty, 0.00) AS "Max Quantity" 
FROM Sales.SpecialOffer;
-- I looked at the solution for this one



/*186. From the following table write a query in SQL to find all products that have NULL in the weight column.
Return name and weight.

Sample table: Production.Product*/

SELECT [Name], [Weight]

FROM Production.Product

WHERE [Weight] IS NULL;



/*187. From the following table write a query in SQL to find the data from the first column that has a non-null value. 
Return name, color, productnumber, and firstnotnull column.

Sample table: Production.Product*/

SELECT [Name], [Color], [ProductNumber],
	COALESCE([Name], [Color], [ProductNumber]) AS [firstnotnull]

FROM Production.Product;


/*188. From the following tables write a query in SQL to return rows only when both the productid and startdate values in 
the two tables matches.

Sample table: Production.workorder
Sample table: Production.workorderrouting*/

SELECT *

FROM Production.WorkOrder AS wo
	INNER JOIN Production.WorkOrderRouting AS wor
		ON wo.[ProductID] = wor.[ProductID]

WHERE wo.[ProductID] = wor.[ProductID]
	AND wo.[StartDate] = wor.[ActualStartDate];



/*189. From the following tables write a query in SQL to return rows except both the productid and startdate values in the 
two tables matches.

Sample table: Production.workorder
Sample table: Production.workorderrouting*/

SELECT *

FROM Production.WorkOrder AS wo
	FULL OUTER JOIN Production.WorkOrderRouting AS wor
		ON wo.[ProductID] = wor.[ProductID]

WHERE wo.[ProductID] IS NULL 
	OR wor.[ProductID] IS NULL
	OR wo.[StartDate] <> wor.[ActualStartDate];


/*190. From the following table write a query in SQL to find all creditcardapprovalcodes starting with 1 and the third digit is 6. 
Sort the result set in ascending order on orderdate.

Sample table: sales.salesorderheader*/

SELECT [CreditCardApprovalCode]

FROM Sales.SalesOrderHeader

WHERE [CreditCardApprovalCode] LIKE '1_6%'

ORDER BY [OrderDate];