/*141. From the following table write a query in SQL to return the ID number, unit price, and the modulus 
(remainder) of dividing product prices. Convert the modulo to an integer value.

Sample table: Sales.SalesOrderDetail*/

SELECT [SalesOrderID], [UnitPrice], CONVERT(INT, ([UnitPrice] % [OrderQty])) AS [Modulo]

FROM Sales.SalesOrderDetail;



/*142. From the following table write a query in SQL to select employees who have the title of Marketing Assistant and 
more than 41 vacation hours.

Sample table: HumanResources.Employee*/

SELECT *

FROM HumanResources.Employee

WHERE [JobTitle] = 'Marketing Assistant'
	AND [VacationHours] > 41;



/*143. From the following tables write a query in SQL to find all rows outside a specified range of rate between 27 and 30. 
Sort the result in ascending order on rate.

Sample table: HumanResources.vEmployee
Sample table: HumanResources.EmployeePayHistory*/

SELECT e.[BusinessEntityID], e.[JobTitle], eph.[Rate]

FROM HumanResources.Employee AS e
	INNER JOIN HumanResources.EmployeePayHistory AS eph
		ON e.[BusinessEntityID] = eph.[BusinessEntityID]

WHERE [Rate] NOT BETWEEN 27 AND 30

ORDER BY eph.[Rate];



/*144. From the follwing table write a query in SQL to retrieve rows whose datetime values are between '20111212' and '20120105'.

Sample table: HumanResources.EmployeePayHistory*/

SELECT *

FROM HumanResources.EmployeePayHistory

WHERE [RateChangeDate] BETWEEN '20111212' AND '20120105';



/*145. From the following table write a query in SQL to return TRUE even if NULL is specified in the subquery. 
Return DepartmentID, Name and sort the result set in ascending order.

Sample table: HumanResources.Department*/

SELECT [DepartmentID], [Name]

FROM HumanResources.Department

WHERE EXISTS (SELECT NULL)

ORDER BY [DepartmentID];
-- I looked at the solution for this one and double checked with ChatGPT



/*146. From the following tables write a query in SQL to get employees with Johnson last names. Return first name and last name.

Sample table: Person.Person
Sample table: HumanResources.Employee*/

SELECT p.[FirstName], p.[LastName]

FROM Person.Person AS p
	INNER JOIN HumanResources.Employee AS e
		ON p.[BusinessEntityID] = e.[BusinessEntityID]

WHERE p.[LastName] LIKE 'Johnson';



/*147. From the following tables write a query in SQL to find stores whose name is the same name as a vendor.

Sample table: Sales.Store
Sample table: Purchasing.Vendor*/

SELECT *

FROM Sales.Store AS store
	INNER JOIN Purchasing.Vendor AS vendor
		ON store.[BusinessEntityID] = vendor.[BusinessEntityID]

WHERE store.[Name] = vendor.[Name];


/*148. From the following tables write a query in SQL to find employees of departments that start with P. 
Return first name, last name, job title.

Sample table: Person.Person
Sample table: HumanResources.Employee
Sample table: HumanResources.Department
Sample table: HumanResources.EmployeeDepartmentHistory*/

SELECT p.[FirstName], p.[LastName], e.[JobTitle]

FROM Person.Person AS p
	INNER JOIN HumanResources.Employee AS e
		ON p.[BusinessEntityID] = e.[BusinessEntityID]
	INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
		ON e.[BusinessEntityID] = edh.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]

WHERE e.[JobTitle] LIKE 'P%';



/*149. From the following tables write a query in SQL to find all employees that do not belong to departments whose names 
begin with P.

Sample table: Person.Person
Sample table: HumanResources.Employee
Sample table: HumanResources.Department
Sample table: HumanResources.EmployeeDepartmentHistory*/

SELECT p.[FirstName], p.[LastName], e.[JobTitle]

FROM Person.Person AS p
	INNER JOIN HumanResources.Employee AS e
		ON p.[BusinessEntityID] = e.[BusinessEntityID]
	INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
		ON e.[BusinessEntityID] = edh.[BusinessEntityID]
	INNER JOIN HumanResources.Department AS d
		ON edh.[DepartmentID] = d.[DepartmentID]

WHERE e.[JobTitle] NOT LIKE 'P%';


/*150. From the following table write a query in SQL to select employees who work as design engineers, tool designers, 
or marketing assistants.

Sample table: Person.Person
Sample table: HumanResources.Employee*/


SELECT p.[FirstName], p.[LastName], e.[JobTitle]

FROM Person.Person AS p
	INNER JOIN HumanResources.Employee AS e
		ON p.[BusinessEntityID] = e.[BusinessEntityID]

WHERE e.[JobTitle] IN ('Design Engineer', 'Tool Designer', 'Marketing Assistant');