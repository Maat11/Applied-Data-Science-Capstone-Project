/*121. From the following table write a query in SQL to calculate a row number for the salespeople based on their 
year-to-date sales ranking. Return row number, first name, last name, and year-to-date sales.

Sample table: Sales.vSalesPerson*/

SELECT ROW_NUMBER() OVER (ORDER BY [SalesYTD] DESC) AS ROW,
	[FirstName], [LastName], [SalesYTD]

FROM Sales.vSalesPerson;



/*122. From the following table write a query in SQL to calculate row numbers for all rows between 50 to 60 inclusive. 
Sort the result set on orderdate.

Sample table: Sales.SalesOrderHeader*/

/*SELECT ROW_NUMBER() OVER (ORDER BY [OrderDate] DESC) AS [ROW], [OrderDate]

FROM Sales.SalesOrderHeader

WHERE ROW_NUMBER() OVER (ORDER BY [OrderDate] DESC) BETWEEN 50 AND 60

ORDER BY [OrderDate];*/

-- I used ChatGPT because I didn't know how to solve this exercise, here is the solution:

WITH NumberedRows AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY [OrderDate] DESC) AS [ROW], [OrderDate]
    FROM Sales.SalesOrderHeader)

SELECT [ROW], [OrderDate]

FROM NumberedRows

WHERE [ROW] BETWEEN 50 AND 60

ORDER BY [OrderDate];



/*123. From the following table write a query in SQL to return first name, last name, territoryname, salesytd, and row number. 
Partition the query result set by the TerritoryName. Orders the rows in each partition by SalesYTD. 
Sort the result set on territoryname in ascending order.

Sample table: Sales.vSalesPerson*/

SELECT [FirstName], [LastName], [TerritoryName], [SalesYTD], 
	ROW_NUMBER() OVER (PARTITION BY [TerritoryName] ORDER BY [SalesYTD]) AS ROW

FROM Sales.vSalesPerson

ORDER BY [TerritoryName];



/*124. From the following table write a query in SQL to order the result set by the column TerritoryName when the column 
CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows. 
Return BusinessEntityID, LastName, TerritoryName, CountryRegionName.

Sample table: Sales.vSalesPerson*/

SELECT [BusinessEntityID], [LastName], [TerritoryName], [CountryRegionName]

FROM Sales.vSalesPerson

ORDER BY
	CASE
		WHEN [CountryRegionName] = 'United States' 
		THEN[TerritoryName]
		ELSE[CountryRegionName]
	END;
--I got help from ChatGPT to solve this one as well



/*125. From the following tables write a query in SQL to return the highest hourly wage for each job title. 
Restricts the titles to those that are held by men with a maximum pay rate greater than 40 dollars or 
women with a maximum pay rate greater than 42 dollars.

Sample table: HumanResources.Employee
Sample table: HumanResources.EmployeePayHistory*/

SELECT MAX(eph.[Rate]) AS [MaxHourlyWage], e.[JobTitle]

FROM HumanResources.Employee AS e
	INNER JOIN HumanResources.EmployeePayHistory AS eph
		ON e.[BusinessEntityID] = eph.[BusinessEntityID]

WHERE (e.[Gender] = 'M' AND eph.[Rate] > 40)
	OR (e.[Gender] = 'F' AND eph.[Rate] > 42)

GROUP BY e.[JobTitle];
-- Debugged with ChatGPT



/*126. From the following table write a query in SQL to sort the BusinessEntityID in descending order for those employees 
that have the SalariedFlag set to 'true' and in ascending order that have the SalariedFlag set to 'false'. 
Return BusinessEntityID, and SalariedFlag.

Sample table: HumanResources.Employee*/

SELECT [BusinessEntityID], [SalariedFlag]

FROM HumanResources.Employee

ORDER BY
	CASE
		WHEN [SalariedFlag] = 'true'  
		THEN [BusinessEntityID]
	END DESC,

	CASE	
		WHEN [SalariedFlag] = 'false'
		THEN [BusinessEntityID]
	END ASC;
-- Debugged with ChatGPT


/*127. From the following table write a query in SQL to display the list price as a text comment based on the price range 
for a product. Return ProductNumber, Name, and listprice. Sort the result set on ProductNumber in ascending order.

Sample table: production.Product*/

SELECT [ProductNumber], [Name], 
	[ListPrice] = 
        CASE 
            WHEN [ListPrice] < 50 THEN 'Low Price: $' + CONVERT(NVARCHAR(50), [ListPrice])
            WHEN [ListPrice] >= 50 AND [ListPrice] <= 100 THEN 'Medium Price: $' + CONVERT(NVARCHAR(50), [ListPrice])
            WHEN [ListPrice] > 100 THEN 'High Price: $' + CONVERT(NVARCHAR(50), [ListPrice])
        END

FROM Production.Product

ORDER BY [ProductNumber];
-- Solved with ChatGPT's help



/*128. From the following table write a query in SQL to change the display of product line categories to make 
them more understandable. Return ProductNumber, category, and name of the product. 
Sort the result set in ascending order on ProductNumber.

Sample table: production.Product*/

/*SELECT [ProductNumber], [ProductSubcategoryID], 
	[Name]

FROM Production.Product;*/
--I didn't know how to solve it, so I looked at the solution and adapted it to my style.

SELECT [ProductNumber],

CASE [ProductLine]
	WHEN 'R' THEN 'Road Bikes'
	WHEN 'M' THEN 'Mountain Bikes'
	WHEN 'T' THEN 'Touring Bikes'
	ELSE 'Other'
END [Category], 

	[Name]

FROM Production.Product

ORDER BY [ProductNumber];



/*129. From the following table write a query in SQL to evaluate whether the values in the MakeFlag and 
FinishedGoodsFlag columns are the same.

Sample table: production.Product*/

SELECT *

FROM Production.Product

WHERE [MakeFlag] = [FinishedGoodsFlag];



/*130. From the following table write a query in SQL to select the data from the first column that has a nonnull value. 
Retrun Name, Class, Color, ProductNumber, and FirstNotNull.

Sample table: production.Product*/

SELECT [Name], [Class], [Color], [ProductNumber], 
	(SELECT TOP 1 [Name] 
	FROM Production.Product 
	WHERE [Name] IS NOT NULL) AS [FirstNotNull]

FROM Production.Product

WHERE [Name] IS NOT NULL;