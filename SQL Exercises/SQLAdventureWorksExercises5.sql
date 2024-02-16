/*41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. 
The result set includes all salespeople, regardless of whether or not they are assigned a territory.

Sample table: Sales.SalesTerritory
Sample table: Sales.SalesPerson*/

SELECT st.[Name], sp.[BusinessEntityID]

FROM Sales.SalesTerritory AS st
	RIGHT OUTER JOIN Sales.SalesPerson AS sp
		ON st.[TerritoryID] = sp.[TerritoryID];



/*42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. 
Order the result set on lastname then by firstname.

Sample table: Person.Person
Sample table: HumanResources.Employee
Sample table: Person.Address
Sample table: Person.BusinessEntityAddress*/

SELECT CONCAT(pp.[FirstName], ' ', pp.[LastName]) AS [FullName], pa.[City]

FROM Person.Person AS pp
	INNER JOIN Person.BusinessEntityAddress AS bea
		ON pp.[BusinessEntityID] = bea.[BusinessEntityID]
	INNER JOIN Person.Address AS pa
		ON pa.[AddressID] = bea.[AddressID]

ORDER BY pp.[LastName], pp.[FirstName];


/*43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table 
(derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. 
A SELECT statement after the FROM clause is a derived table.

Sample table: Person.Person*/

SELECT [BusinessEntityID], [FirstName], [LastName]

FROM Person.Person

WHERE [PersonType] = 'IN'
	AND [LastName] = 'Adams'

ORDER BY [FirstName];



/*44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, 
a lastname starting with 'Al', and a firstname starting with 'M'.

Sample table: Person.Person*/

SELECT [BusinessEntityID], [FirstName], [LastName]

FROM Person.Person

WHERE [BusinessEntityID] <= '1500'
	AND [LastName] LIKE 'Al%'
	AND [FirstName] LIKE 'M%';


/*45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' 
using a derived table with multiple values.

Sample table: Production.Product*/

SELECT [ProductID], [Name], [Color]

FROM Production.Product

WHERE [Name] IN ('Blade', 'Crown Race', 'AWC Logo Cap');
-- I have chosen to not use a derived table due to the simplicity of the task

/*46. Create a SQL query to display the total number of sales orders each sales representative receives annually. 
Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. 
Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.

Sample table: Sales.SalesOrderHeader*/

SELECT Year([OrderDate]) AS [OrderYear], [SalesPersonID], COUNT([SalesOrderID]) AS TotalOrders

FROM Sales.SalesOrderHeader

GROUP BY Year([OrderDate]), [SalesPersonID]

ORDER BY [SalesPersonID], [OrderYear];


/*47. From the following table write a query in SQL to find the average number of sales orders for all the years of the 
sales representatives.

Sample table: Sales.SalesOrderHeader*/

/*SELECT AVG(1.0 * [SalesOrderID]) AS [AvgSales], [SalesPersonID], Year([OrderDate]) AS [OrderYear]

FROM Sales.SalesOrderHeader

GROUP BY [SalesPersonID], Year([OrderDate])

ORDER BY [SalesPersonID], [OrderYear];*/
-- this was how I solved the exercise, but i knew i did a mistake somewhere

SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM (
    SELECT 
        SalesPersonID,
        COUNT(*) AS NumberOfOrders
    FROM 
        Sales.SalesOrderHeader
    WHERE 
        SalesPersonID IS NOT NULL
    GROUP BY 
        SalesPersonID
) AS Sales_CTE;
-- therefore I used ChatGPT to correct the query I have written and it gave me the above query



/*48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. 
The following table's columns must all be returned.

Sample table: Production.ProductPhoto*/

SELECT *

FROM Production.ProductPhoto

WHERE [LargePhotoFileName] LIKE 'green_%';



/*49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and 
in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.

Sample table: Person.Address
Sample table: Person.StateProvince*/

SELECT pa.[AddressLine1], pa.[AddressLine2], pa.[City], pa.[PostalCode], sp.[CountryRegionCode]

FROM Person.Address AS pa
	INNER JOIN Person.StateProvince AS sp
		ON pa.[StateProvinceID] = sp.[StateProvinceID]

WHERE sp.[CountryRegionCode] <> 'US'
	AND pa.[City] LIKE 'Pa%';



/*50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. 
Order the result set on hiredate column in descending order.

Sample table: HumanResources.Employee*/

SELECT TOP 20 [JobTitle], [HireDate]

FROM HumanResources.Employee

ORDER BY [HireDate] DESC;