--EXERCISES RETRIEVED FROM https://www.w3resource.com/sql-exercises/adventureworks/adventureworks-exercises.php,
--and solved by Bianca Diana Smalbelgher in Microsoft SQL Server Management Studio


/*11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'.
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.

Sample table: Person.PersonPhone*/

SELECT PersPh.[BusinessEntityID], Pers.[FirstName], Pers.[LastName], PersPh.[PhoneNumber]

FROM Person.Person AS Pers, Person.PersonPhone AS PersPh

WHERE Pers.[BusinessEntityID] = PersPh.[BusinessEntityID]

AND Pers.[LastName] LIKE 'L%'

ORDER BY Pers.[LastName], Pers.[FirstName];


/*12. From the following table write a query in SQL to find the sum of subtotal column.
Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total.
Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.

Sample table: sales.salesorderheader*/

SELECT [SalesPersonID], [CustomerID], SUM([SubTotal]) AS sum_subtotal

FROM Sales.SalesOrderHeader

WHERE [SalesPersonID] IS NOT NULL

GROUP BY [SalesPersonID], [CustomerID] WITH ROLLUP;


/*13. From the following table write a query in SQL to find the sum of the quantity of all combination of 
group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.

Sample table: production.productinventory*/

SELECT [LocationID], [Shelf], SUM([Quantity]) AS TotalQuantity

FROM Production.ProductInventory

GROUP BY [LocationID], [Shelf] WITH CUBE;

/*14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
Group the results for all combination of distinct locationid and shelf column. 
Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.

Sample table: production.productinventory*/

SELECT [LocationID], [Shelf], SUM([Quantity]) AS TotalQuantity

FROM Production.ProductInventory

GROUP BY [LocationID], [Shelf] WITH ROLLUP;
--Incomplete exercise. Must look further on how to solve it in the future


/*15. From the following table write a query in SQL to find the total quantity for each locationid and 
calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.

Sample table: production.productinventory*/

SELECT [LocationID], SUM([Quantity]) AS [TotalQuantity]

FROM Production.ProductInventory

GROUP BY [LocationID] WITH ROLLUP;


/*16. From the following table write a query in SQL to retrieve the number of employees for each City. 
Return city and number of employees. Sort the result in ascending order on city.

Sample table: Person.BusinessEntityAddress*/

SELECT ad.[City], COUNT(empl.[BusinessEntityID]) AS [nr_of_employees]

FROM Person.BusinessEntityAddress AS empl, Person.Address AS ad

WHERE empl.[AddressID] = ad.[AddressID]

GROUP BY ad.[City]

ORDER BY ad.[City];


/*17. From the following table write a query in SQL to retrieve the total sales for each year. 
Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.

Sample table: Sales.SalesOrderHeader*/

SELECT Year([OrderDate]) AS [OrderYear], SUM([TotalDue]) AS total_due_amount

FROM Sales.SalesOrderHeader

GROUP BY Year([OrderDate])

ORDER BY Year([OrderDate]);


/*18. From the following table write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016.
Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.

Sample table: Sales.SalesOrderHeader*/

SELECT Year([OrderDate]) AS [OrderYear], SUM([TotalDue]) AS total_due_amount

FROM Sales.SalesOrderHeader

GROUP BY Year([OrderDate])

HAVING Year([OrderDate]) <= 2016

ORDER BY Year([OrderDate]);


/*19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. 
Returns ContactTypeID, name. Sort the result set in descending order.

Sample table: Person.ContactType*/

SELECT [ContactTypeID], [Name]

FROM Person.ContactType

WHERE [Name] LIKE '%Manager%'

ORDER BY [Name] DESC;


/*20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.

Sample table: Person.BusinessEntityContact
Sample table: Person.ContactType
Sample table: Person.Person*/

SELECT pp.[BusinessEntityID], [LastName], [FirstName]

FROM Person.BusinessEntityContact AS pbec
INNER JOIN Person.ContactType AS pct ON pbec.[ContactTypeID] = pct.[ContactTypeID]
INNER JOIN Person.Person AS pp ON pbec.[BusinessEntityID] = pp.[BusinessEntityID]

WHERE LOWER(pct.[Name]) = 'purchasing manager'

ORDER BY [LastName], [FirstName];
