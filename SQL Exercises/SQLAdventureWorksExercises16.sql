/*151. From the following tables write a query in SQL to identify all SalesPerson IDs for employees with sales quotas over
$250,000. Return first name, last name of the sales persons.

Sample table: Person.Person
Sample table: Sales.SalesPerson*/

SELECT p.[FirstName], p.[LastName]

FROM Person.Person AS p
	INNER JOIN Sales.SalesPerson AS sp
		ON p.[BusinessEntityID] = sp.[BusinessEntityID]

WHERE sp.[SalesQuota] > 250000;



/*152. From the following tables write a query in SQL to find the salespersons who do not have a quota greater than $250,000. 
Return first name and last name.

Sample table: Person.Person
Sample table: Sales.SalesPerson*/

SELECT p.[FirstName], p.[LastName]

FROM Person.Person AS p
	INNER JOIN Sales.SalesPerson AS sp
		ON p.[BusinessEntityID] = sp.[BusinessEntityID]

WHERE sp.[SalesQuota] < 250000;



/*153. From the following tables write a query in SQL to identify salesorderheadersalesreason and SalesReason tables 
with the same salesreasonid.

Sample table: Sales.salesorderheadersalesreason
Sample table: sales.SalesReason*/

SELECT *

FROM Sales.SalesOrderHeaderSalesReason AS osr
	INNER JOIN Sales.SalesReason AS sr
		ON osr.[SalesReasonID] = sr.[SalesReasonID]

WHERE osr.[SalesReasonID] = sr.[SalesReasonID];



/*154. From the following table write a query in SQL to find all telephone numbers that have area code 415. 
Returns the first name, last name, and phonenumber. Sort the result set in ascending order by lastname.

Sample table: Person.Person
Sample table: Person.PersonPhone*/

SELECT p.[FirstName], p.[LastName], pp.[PhoneNumber]

FROM Person.Person AS p
	INNER JOIN Person.PersonPhone AS pp
		ON p.[BusinessEntityID] = pp.[BusinessEntityID]

WHERE pp.[PhoneNumber] LIKE '415%'

ORDER BY p.[LastName];



/*155. From the following tables write a query in SQL to identify all people with the first name 'Gail' with area codes 
other than 415. Return first name, last name, telephone number. Sort the result set in ascending order on lastname.

Sample table: Person.Person
Sample table: Person.PersonPhone*/

SELECT p.[FirstName], p.[LastName], pp.[PhoneNumber]

FROM Person.Person AS p
	INNER JOIN Person.PersonPhone AS pp
		ON p.[BusinessEntityID] = pp.[BusinessEntityID]

WHERE p.[FirstName] LIKE 'Gail%'
	AND pp.PhoneNumber NOT LIKE '415%'

ORDER BY p.[LastName];



/*156. From the following tables write a query in SQL to find all Silver colored bicycles with a standard price under $400. 
Return ProductID, Name, Color, StandardCost.

Sample table: Production.Product*/

SELECT [ProductID], [Name], [Color], [StandardCost]

FROM Production.Product

WHERE [Color] LIKE '%silver%'
	AND [StandardCost] < 400;



/*157. From the following table write a query in SQL to retrieve the names of Quality Assurance personnel working the 
evening or night shifts. Return first name, last name, shift.

Sample table: HumanResources.EmployeeDepartmentHistory*/

SELECT p.[FirstName], p.[LastName], edh.[ShiftID]

FROM HumanResources.EmployeeDepartmentHistory AS edh
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]
	INNER JOIN Person.Person AS p
		ON edh.[BusinessEntityID] = p.[BusinessEntityID]

WHERE d.[Name] LIKE 'Quality Assurance'
	AND edh.[ShiftID] IN (2, 3);



/*158. From the following table write a query in SQL to list all people with three-letter first names ending in 'an'. 
Sort the result set in ascending order on first name. Return first name and last name.

Sample table: Person.Person*/

SELECT [FirstName], [LastName]

FROM Person.Person

WHERE [FirstName] LIKE '_an'

ORDER BY [FirstName];



/*159. From the following table write a query in SQL to convert the order date in the 'America/Denver' time zone. 
Return salesorderid, order date, and orderdate_timezoneade.

Sample table: Sales.SalesOrderHeader*/

SELECT [SalesOrderID], [OrderDate], 
    [OrderDate] AT TIME ZONE 'UTC' AT TIME ZONE 'Mountain Standard Time' AS [OrderDate_TimezoneAdjusted]

FROM Sales.SalesOrderHeader;
-- I used ChatGPT to solve this one



/*160. From the following table write a query in SQL to convert order date in the 'America/Denver' time zone and also 
convert from 'America/Denver' time zone to 'America/Chicago' time zone.

Sample table: Sales.SalesOrderHeader*/

SELECT [SalesOrderID], [OrderDate], 
    [OrderDate] AT TIME ZONE 'UTC' AT TIME ZONE 'Mountain Standard Time' AS [America/Denver_Timezone],
	[OrderDate] AT TIME ZONE 'UTC' AT TIME ZONE 'Central Standard Time' AS [America/Chicago_Timezone]

FROM Sales.SalesOrderHeader;