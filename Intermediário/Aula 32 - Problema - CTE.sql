/*
	[AdventureWorks2016].[Sales].[SalesOrderHeader]
	Clientes que compraram mais de 5 vezes e quais as compras durante os anos

	* Tabela de variável
	* Tabela Temporária
	* Sub Select
	* CTE

	1° - Clientes com mais de 5 compras
*/
--============= * Tabela de variável ==================

/*SELECT
	*
FROM (
	-- Subselect
	SELECT 
		CustomerID,
		COUNT(*) As Quantidade
	FROM 
		[AdventureWorks2016].[Sales].[SalesOrderHeader]
	GROUP BY
		CustomerID
) Dados
WHERE
	Quantidade > 5


DECLARE @Dados TABLE (
	CustomerID INT,
	Quantidate INT
)


INSERT INTO @Dados
SELECT
	CustomerID,
	COUNT(*) as Quantidade
FROM
	[AdventureWorks2016].[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID
HAVING
	COUNT(*) > 5

-- Join 
/*SELECT
	S.*
FROM
	[AdventureWorks2016].[Sales].[SalesOrderHeader] S INNER JOIN @Dados D ON D.CustomerID = S.CustomerID*/
	


-- SUBSELECT
SELECT
	S.*
FROM
	[AdventureWorks2016].[Sales].[SalesOrderHeader] S
WHERE
	CustomerID IN (
		Select DISTINCT CustomerID FROM @Dados
	)

--============= * Tabela de variável - Fim ==================*/

/*--============= * Tabela Temporária - Início ==================

/*CREATE TABLE #Dados (
	CustomerID INT,
	Quantidade INT
)*/


SELECT
	CustomerID,
	COUNT(*) as Quantidade
INTO #Dados
FROM
	[AdventureWorks2016].[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID
HAVING
	COUNT(*) > 5

-- Join
	/*SELECT S.*
FROM
	Sales.SalesOrderHeader S INNER JOIN #Dados D ON S.CustomerID = D.CustomerID*/

-- Subselect
SELECT *
FROM
	Sales.SalesOrderHeader 
WHERE
	CustomerID IN (
		Select CustomerID FROM #Dados
	)

DROP TABLE #Dados

--============= * Tabela Temporária - Fim ==================*/

--============= * Subselect - Início ==================

-- SUbselect
/*SELECT
	*
FROM
	Sales.SalesOrderHeader
WHERE
	CustomerID IN (
		SELECT
			CustomerID
		FROM
			[AdventureWorks2016].[Sales].[SalesOrderHeader]
		GROUP BY
			CustomerID
		HAVING
			COUNT(*) > 5
	)

-- JOIN
SELECT
	S.*
FROM
	Sales.SalesOrderHeader S INNER JOIN (
		SELECT DISTINCT
			CustomerID
		FROM
			[AdventureWorks2016].[Sales].[SalesOrderHeader]
		GROUP BY
			CustomerID
		HAVING
			COUNT(*) > 5
	) Dados ON S.CustomerID = Dados.CustomerID

--============= * Subselect - Fim ==================*/

--============= * CTE - Início ==================

WITH ClienteMaisDeCincoCompras AS (
	SELECT 
		CustomerID
	FROM
		[AdventureWorks2016].[Sales].[SalesOrderHeader]
	GROUP BY
		CustomerID
	HAVING
		COUNT(*) > 5
), Resultado AS (
	SELECT
		S.*
	FROM
		Sales.SalesOrderHeader S INNER JOIN ClienteMaisDeCincoCompras C5 ON S.CustomerID = C5.CustomerID
)

SELECT * From Resultado