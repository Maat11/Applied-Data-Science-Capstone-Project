/*61 Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following table,
each separated by a specified character.

Sample table: production.product*/

SELECT CONCAT([Name], ', ', [ProductNumber], '\n ', [Color]) AS [Name, ProductNumber \n Colour]

FROM Production.Product;



/*62 From the following table write a query in SQL to return the five leftmost characters of each product name.

Sample table: production.product*/

SELECT LEFT([Name], 5) AS Name5char

FROM Production.Product;



/*63 From the following table write a query in SQL to select the number of characters and the data in FirstName 
for people located in Australia.

Sample table: Sales.vindividualcustomer*/


SELECT LEN([FirstName]) AS [firstNameLength], [FirstName]

FROM Sales.vIndividualCustomer

WHERE [CountryRegionName] = 'Australia';



/*64 From the following tables write a query in SQL to return the number of characters in the column FirstName and 
the first and last name of contacts located in Australia.

Sample table: Sales.vstorewithcontacts
Sample table: Sales.vstorewithaddresses*/

SELECT LEN([FirstName]) AS [firstNameLength], [FirstName], [LastName]

FROM Sales.vStoreWithContacts AS vsc
	INNER JOIN Sales.vStoreWithAddresses AS vsa
		ON vsc.[BusinessEntityID] = vsa.[BusinessEntityID]

WHERE [CountryRegionName] = 'Australia';



/*65 From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00. 
Return product name as Lower, Upper, and also LowerUpper.

Sample table: production.Product*/

SELECT LOWER(SUBSTRING([Name], 1, 25)) AS Lower,
    UPPER(SUBSTRING([Name], 1, 25)) AS Upper,
    LOWER(UPPER(SUBSTRING([Name], 1, 25))) AS LowerUpper

FROM Production.Product

WHERE [StandardCost] BETWEEN 1000.00 AND 1220.00;

-- For this exercise I checked the suggested solution because I didn't understand what they request me to return and how to do it



/*66 Write a query in SQL to remove the spaces from the beginning of a string.*/

SELECT '     some text here' AS [OriginalText],
LTRIM('     some text here') AS [TrimmedText];



/*67 From the following table write a query in SQL to remove the substring 'HN' from the start of the column productnumber. 
Filter the results to only show those productnumbers that start with "HN". 
Return original productnumber column and 'TrimmedProductnumber'.

Sample table: production.Product*/


SELECT [ProductNumber], LTRIM([ProductNumber], 'HN') AS [TrimmedProductnumber]

FROM Production.Product

WHERE [ProductNumber] LIKE 'HN%';



/*68 From the following table write a query in SQL to repeat a 0 character four times in front of a 
production line for production line 'T'.

Sample table: production.Product*/


SELECT [ProductLine], CONCAT('0000', [ProductLine]) AS [ModifiedProdLine]

FROM Production.Product

WHERE [ProductLine] LIKE 'T%';



/*69 From the following table write a SQL query to retrieve all contact first names with the characters 
inverted for people whose businessentityid is less than 6.

Sample table: Person.Person*/

SELECT [FirstName], REVERSE([FirstName]) AS [ReversedFirstName]

FROM Person.Person

WHERE [BusinessEntityID] < 6;



/*70 From the following table write a query in SQL to return the eight rightmost characters of each name of the product. 
Also return name, productnumber column. Sort the result set in ascending order on productnumber.

Sample table: production.Product*/

SELECT RIGHT([Name], 8) AS [righTrim8charName], [Name], [ProductNumber]

FROM Production.Product

ORDER BY [ProductNumber];