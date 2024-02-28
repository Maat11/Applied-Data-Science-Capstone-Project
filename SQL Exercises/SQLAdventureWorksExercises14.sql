/*131. From the following table write a query in SQL to check the values of MakeFlag and FinishedGoodsFlag columns and 
return whether they are same or not. Return ProductID, MakeFlag, FinishedGoodsFlag, and the column that are null or not null.

Sample table: production.Product*/

SELECT [ProductID], [MakeFlag], [FinishedGoodsFlag],
	CASE
		WHEN [MakeFlag] = [FinishedGoodsFlag]
		THEN NULL
	ELSE [MakeFlag] END AS [Null if Equal]
		

FROM Production.Product;



/*132. From the following tables write a query in SQL to return any distinct values that are returned by both the query.

Sample table: production.Product
Sample table: production.WorkOrder*/

SELECT DISTINCT p.*, wo.*

FROM Production.Product AS p
	INNER JOIN Production.WorkOrder AS wo
		ON p.[ProductID] = wo.[ProductID];


/*133. From the following tables write a query in SQL to return any distinct values from first query that aren't also found 
on the 2nd query.

Sample table: production.Product
Sample table: production.WorkOrder*/

SELECT *

FROM Production.Product AS p
	LEFT JOIN Production.WorkOrder AS wo
		ON p.[ProductID] = wo.[ProductID];


/*134. From the following tables write a query in SQL to fetch any distinct values from the left query that aren't 
also present in the query to the right.

Sample table: production.Product
Sample table: production.WorkOrder*/

SELECT DISTINCT *

FROM Production.Product AS p
	LEFT JOIN Production.WorkOrder AS wo
		ON p.[ProductID] = wo.[ProductID];


/*135. From the following tables write a query in SQL to fetch distinct businessentityid that are returned by both the 
specified query. Sort the result set by ascending order on businessentityid.

Sample table: Person.BusinessEntity
Sample table: Person.Person*/

SELECT DISTINCT be.[BusinessEntityID] AS [BusinessEntityID(BusinessEntity)], p.[BusinessEntityID] AS [BusinessEntityID(Person)]

FROM Person.BusinessEntity AS be
	INNER JOIN Person.Person AS p
		ON be.[BusinessEntityID] = p.[BusinessEntityID]

ORDER BY be.[BusinessEntityID], p.[BusinessEntityID];



/*136. From the following table write a query which is the combination of two queries. Return any distinct businessentityid 
from the 1st query that aren't also found in the 2nd query. Sort the result set in ascending order on businessentityid.

Sample table: Person.BusinessEntity
Sample table: Person.Person*/

SELECT DISTINCT be.[BusinessEntityID]

FROM Person.BusinessEntity AS be
	LEFT JOIN Person.Person AS p
		ON be.[BusinessEntityID] = p.[BusinessEntityID]

ORDER BY be.[BusinessEntityID];



/*137. From the following tables write a query in SQL to combine the ProductModelID and Name columns. 
A result set includes columns for productid 3 and 4. Sort the results by name ascending.

Sample table: Production.ProductModel
Sample table: Production.Product*/

SELECT CONCAT(p.[ProductModelID], ', ', p.[Name]) AS [ProductModelID&Name]

FROM Production.ProductModel AS pm
	INNER JOIN Production.Product AS p
		ON pm.[ProductModelID] = p.[ProductModelID]

WHERE p.[ProductID] IN (3, 4)

ORDER BY p.[Name];



/*138. From the following table write a query in SQL to find a total number of hours away from work can be calculated by 
adding vacation time and sick leave. Sort results ascending by Total Hours Away.

Sample table: HumanResources.Employee
Sample table: Person.Person*/

SELECT [BusinessEntityID], [VacationHours], [SickLeaveHours], ([VacationHours] + [SickLeaveHours]) AS [TotalHoursAway]

FROM HumanResources.Employee

ORDER BY [TotalHoursAway];



/*139. From the following table write a query in SQL to calculate the tax difference between the highest and lowest
tax-rate state or province.

Sample table: Sales.SalesTaxRate*/

SELECT DIFFERENCE(MAX([TaxRate]), MIN([TaxRate])) AS [DifferenceInTaxRate]

FROM Sales.SalesTaxRate;



/*140. From the following tables write a query in SQL to calculate sales targets per month for salespeople.

Sample table: Sales.SalesPerson
Sample table: HumanResources.Employee
Sample table: Person.Person*/

SELECT e.[BusinessEntityID], e.[JobTitle], p.[LastName], p.[FirstName], sp.[SalesQuota],
	(sp.[SalesQuota] / 12) AS [SalesTargetsPerMonth]

FROM Sales.SalesPerson AS sp
	INNER JOIN HumanResources.Employee AS e
		ON sp.[BusinessEntityID] = e.[BusinessEntityID]
	INNER JOIN Person.Person AS p
		ON sp.[BusinessEntityID] = p.[BusinessEntityID];