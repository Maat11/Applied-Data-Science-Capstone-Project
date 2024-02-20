/*71 Write a query in SQL to remove the spaces at the end of a string.*/

CREATE TABLE [ToTrim] ([OriginalText] nvarchar(50))
INSERT INTO ToTrim ([OriginalText]) VALUES ('some text here     ');

SELECT [OriginalText], RTRIM([OriginalText]) AS [trimmedText]
FROM ToTrim

DROP TABLE ToTrim;



/*72 From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. 
Return productnumber and name.

Sample table: production.Product*/

SELECT [ProductNumber], [Name]

FROM Production.Product

WHERE RIGHT([Name],1) IN ('S', 'M', 'L');



/*73 From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas
in a single row.

Sample table: Person.Person*/

SELECT CONCAT(COALESCE([FirstName], 'N/A'), ', ', 
	COALESCE([MiddleName],'N/A'), ', ', 
	COALESCE([LastName], 'N.A'))
	AS [FullName]

FROM Person.Person;



/*74 From the following table write a query in SQL to return the names and modified date separated by commas in a single row.

Sample table: Person.Person*/

SELECT CONCAT([FirstName], ', ', [MiddleName], ', ', [LastName], ', ', [ModifiedDate]) AS [FullName, ModifiedDate]

FROM Person.Person;



/*75 From the following table write a query in SQL to find the email addresses of employees and groups them by city. 
Return top ten rows.

Sample table: Person.BusinessEntityAddress
Sample table: Person.Address
Sample table: Person.EmailAddress*/

SELECT TOP 10 pea.[EmailAddress], pa.[City]

FROM Person.BusinessEntityAddress AS bea
	INNER JOIN Person.Address AS pa
		ON bea.[AddressID] = pa.[AddressID]
	INNER JOIN Person.EmailAddress AS pea
		ON bea.[BusinessEntityID] = pea.[BusinessEntityID];

--when I try to group them by city I get an error. I queried chatGPT on this, here is its answer:
/*WITH RankedEmails AS (
    SELECT
        pea.[EmailAddress],
        pa.[City],
        ROW_NUMBER() OVER (PARTITION BY pa.[City] ORDER BY pea.[EmailAddress]) AS RowNum
    FROM
        Person.BusinessEntityAddress AS bea
        INNER JOIN Person.Address AS pa ON bea.[AddressID] = pa.[AddressID]
        INNER JOIN Person.EmailAddress AS pea ON bea.[BusinessEntityID] = pea.[BusinessEntityID]
)
SELECT
    [EmailAddress],
    [City]
FROM RankedEmails
WHERE RowNum <= 10;
*/



/*76 From the following table write a query in SQL to create a new job title called "Production Assistant" in place of 
"Production Supervisor".

Sample table: HumanResources.Employee*/

UPDATE HumanResources.Employee

SET [JobTitle] = 'Production Assistant'

WHERE [JobTitle] = 'Product Supervisor';




/*77 From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales".
Return firstname, middlename, lastname and jobtitle column.

Sample table: Person.Person
Sample table: HumanResources.Employee*/

SELECT [FirstName], [MiddleName], [LastName], [JobTitle]

FROM Person.Person AS p
	INNER JOIN HumanResources.Employee AS e
		ON p.[BusinessEntityID] = e.[BusinessEntityID]

WHERE [JobTitle] LIKE 'Sales%';



/*78 From the following table write a query in SQL to return the last name of people so that it is in uppercase, trimmed, 
and concatenated with the first name.

Sample table: Person.Person*/

SELECT [FirstName], [LastName], TRIM(UPPER(CONCAT([FirstName], [LastName]))) AS [FullName]

FROM Person.Person;



/*79 From the following table write a query in SQL to show a resulting expression that is too small to display. 
Return FirstName, LastName, Title, and SickLeaveHours. The SickLeaveHours will be shown as a small expression in text format.

Sample table: HumanResources.Employee
Sample table: Person.Person*/

SELECT [FirstName], [LastName], [Title], [SickLeaveHours], CAST([SickLeaveHours] AS VARCHAR(10)) AS [TextSickLeaveHours]

FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p
		ON e.[BusinessEntityID] = p.[BusinessEntityID];



/*80 From the following table write a query in SQL to retrieve the name of the products. 
Product, that have 33 as the first two digits of listprice.

Sample table: production.Product*/

SELECT [Name], [ListPrice]

FROM Production.Product

WHERE [ListPrice] LIKE '33%';