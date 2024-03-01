/*171. From the following table write a query in SQL to return all customers with BirthDate values after January 1, 1970 
and the last name 'Smith'. Return businessentityid, jobtitle, and birthdate. Sort the result set in ascending order on birthday.

Sample table: HumanResources.Employee*/

SELECT e.[BusinessEntityID], e.[JobTitle], e.[BirthDate]

FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p
		ON e.[BusinessEntityID] = p.[BusinessEntityID]

WHERE e.[BirthDate] > '1970-01-01'
	AND p.[LastName] LIKE 'Smith'

ORDER BY e.[BirthDate];



/*172. From the following table write a query in SQL to return the rows with different firstname values from Adam. 
Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

Sample table: Person.Person*/

SELECT [BusinessEntityID], [PersonType], [FirstName], [MiddleName], [LastName]

FROM Person.Person

WHERE [FirstName] <> 'Adam'

ORDER BY [FirstName];



/*173. From the following table write a query in SQL to find the rows where firstname doesn't differ from Adam's firstname. 
Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

Sample table: Person.Person*/

SELECT [BusinessEntityID], [PersonType], [FirstName], [MiddleName], [LastName]

FROM Person.Person

WHERE [FirstName] = 'Adam'

ORDER BY [FirstName];



/*174. From the following table write a query in SQL to find the rows where middlename differs from NULL. 
Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

Sample table: Person.Person*/

SELECT [BusinessEntityID], [PersonType], [FirstName], [MiddleName], [LastName]

FROM Person.Person

WHERE [MiddleName] <> 'NULL'

ORDER BY [FirstName];



/*175. From the following table write a query in SQL to identify the rows with a middlename that is not NULL. 
Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

Sample table: Person.Person*/


SELECT [BusinessEntityID], [PersonType], [FirstName], [MiddleName], [LastName]

FROM Person.Person

WHERE [MiddleName] IS NOT NULL

ORDER BY [FirstName];



/*176. From the following table write a query in SQL to fetch all products with a weight of less than 10 pounds or unknown color. 
Return the name, weight, and color for the product. Sort the result set in ascending order on name.

Sample table: Production.Product*/

SELECT [Name], [Weight], [Color]

FROM Production.Product

WHERE [Weight] < 10
	OR [Color] IS NULL

ORDER BY [Name];



/*177. From the following table write a query in SQL to list the salesperson whose salesytd begins with 1. 
Convert SalesYTD and current date in text format.

Sample table: Sales.SalesPerson*/

SELECT 
    CONVERT(NVARCHAR(50), SalesYTD) AS SalesYTD,
    CONVERT(NVARCHAR(50), GETDATE(), 121) AS CurrentDate
FROM 
    Sales.SalesPerson
WHERE 
    CAST(SalesYTD AS NVARCHAR(50)) LIKE '1%';
--asked ChatGPT on this one



/*178. From the following table write a query in SQL to return the count of employees by Name and Title, Name, and company total. 
Filter the results by department ID 12 or 14. For each row, identify its aggregation level in the Title column.

Sample table: HumanResources.Employee
Sample table: HumanResources.EmployeeDepartmentHistory
Sample table: HumanResources.Department*/

SELECT COUNT(e.[BusinessEntityID]) AS [EmployeeCount], p.[LastName], e.[JobTitle],
-- from here:
    CASE 
        WHEN GROUPING(p.[LastName]) = 1 THEN 'Company Total'
        WHEN GROUPING(e.[JobTitle]) = 1 THEN 'Department Total'
        ELSE 'Individual Employee'
    END AS AggregationLevel
-- until here, I asked ChatGPT

FROM HumanResources.Employee AS e
	INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
		ON e.[BusinessEntityID] = edh.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]
	INNER JOIN Person.Person AS p
		ON e.[BusinessEntityID] = p.[BusinessEntityID]

WHERE d.[DepartmentID] IN (12, 14)

GROUP BY p.[LastName], e.[JobTitle];



/*179. From the following tables write a query in SQL to return only rows with a count of employees by department. 
Filter the results by department ID 12 or 14. Return name, jobtitle, grouping level and employee count.

Sample table: HumanResources.Employee
Sample table: HumanResources.EmployeeDepartmentHistory
Sample table: HumanResources.Department*/

SELECT d.[Name], e.[JobTitle],
	COUNT(e.[BusinessEntityID]) AS [EmployeeCount]

FROM HumanResources.Employee AS e
	INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
		ON e.[BusinessEntityID] = edh.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]

WHERE d.[DepartmentID] IN (12, 14)

GROUP BY ROLLUP(d.[Name], e.[JobTitle]);



/*180. From the following tables write a query in SQL to return only the rows that have a count of employees by title. 
Filter the results by department ID 12 or 14. Return name, jobtitle, grouping level and employee count.

Sample table: HumanResources.Employee
Sample table: HumanResources.EmployeeDepartmentHistory
Sample table: HumanResources.Department*/

SELECT d.[Name], e.[JobTitle],
	COUNT(e.[BusinessEntityID]) AS [EmployeeCount]

FROM HumanResources.Employee AS e
	INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
		ON e.[BusinessEntityID] = edh.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]

WHERE d.[DepartmentID] IN (12, 14)
	AND e.[JobTitle] IS NOT NULL

GROUP BY ROLLUP(d.[Name], e.[JobTitle]);