/*51. From the following tables write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount 
less than 1000, and totaldues greater than 100. Return all the columns from the tables.

Sample table: Sales.SalesOrderHeader
Sample table: Sales.SalesOrderDetail*/

SELECT *

FROM Sales.SalesOrderHeader AS soh
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON soh.[SalesOrderID] = sod.[SalesOrderID]

WHERE soh.[TotalDue] > 100
	AND (sod.[OrderQty] > 5 OR sod.[UnitPriceDiscount] < 1000);



/*52. From the following table write a query in SQL that searches for the word 'red' in the name column. 
Return name, and color columns from the table.

Sample table: Production.Product*/

SELECT [Name], [Color]

FROM Production.Product

WHERE [Name] LIKE '%red%';



/*53. From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain.
Return name, and listprice columns from the table.

Sample table: Production.Product*/

SELECT [Name], [ListPrice]

FROM Production.Product

WHERE [ListPrice] = 80.99
	AND [Name] LIKE '%Mountain%';



/*54. From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road.
Return name, and color columns.

Sample table: Production.Product*/


SELECT [Name], [Color]

FROM Production.Product

WHERE [Name] LIKE '%Mountain%' 
	OR [Name] LIKE '%Road%';



/*55. From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'.
Return Name and color.

Sample table: Production.Product*/

SELECT [Name], [Color]

FROM Production.Product

WHERE [Name] LIKE '%Mountain%'
	AND [Name] LIKE '%Black%';



/*56. From the following table write a query in SQL to return all the product names with at least one word starting with the 
prefix chain in the Name column.

Sample table: Production.Product*/

SELECT [Name]

FROM Production.Product

WHERE [Name] LIKE 'chain%';



/*57. From the following table write a query in SQL to return all category descriptions containing strings with prefixes 
of either chain or full.

Sample table: Production.Product*/

SELECT [Name]

FROM Production.Product

WHERE [Name] LIKE 'chain%'
	OR [Name] LIKE 'full%';



/*58. From the following table write a SQL query to output an employee's name and email address, separated by a new line character.

Sample table: Person.Person
Sample table: Person.EmailAddress*/

SELECT CONCAT(pp.[FirstName], ' ', pp.[LastName], ' \n ', pea.[EmailAddress]) AS [Full Name and email]

FROM Person.Person AS pp
	INNER JOIN Person.EmailAddress AS pea
		ON pp.[BusinessEntityID] = pea.[BusinessEntityID];



/*59. From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.

Sample table: production.product*/

SELECT [Name]

FROM Production.Product

WHERE CHARINDEX('yellow', [Name]) > 0;

-- I used ChatGPT to solve this exercise, because I haven't previously seen this type of query



/*60 From the following table write a query in SQL to concatenate the name, color, and productnumber columns.

Sample table: production.product*/

SELECT CONCAT([Name],', ', ' Color: ', [Color], ', ', 'ProdNumb: ', [ProductNumber]) AS [Name, Color, ProdNumb]

FROM Production.Product;