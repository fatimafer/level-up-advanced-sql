-- Ej 1
WITH cte AS (SELECT strftime('%Y', soldDate) AS soldYear, salesAmount 
              FROM Sales)
SELECT soldYear, FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales
FROM cte
GROUP BY soldYear
ORDER BY soldYear;

-- Ej 2
SELECT e.employeeId, e.firstName, e.lastName,
      CASE
          WHEN strftime('%m', soldDate) = '01' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS January,
            CASE
          WHEN strftime('%m', soldDate) = '02' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS Februrary,      CASE
          WHEN strftime('%m', soldDate) = '03' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS March,      CASE
          WHEN strftime('%m', soldDate) = '04' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS April,      CASE
          WHEN strftime('%m', soldDate) = '05' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS May,      CASE
          WHEN strftime('%m', soldDate) = '06' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS June,      CASE
          WHEN strftime('%m', soldDate) = '07' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS July,      CASE
          WHEN strftime('%m', soldDate) = '08' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS August,      CASE
          WHEN strftime('%m', soldDate) = '09' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS September,      CASE
          WHEN strftime('%m', soldDate) = '10' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS October,      CASE
          WHEN strftime('%m', soldDate) = '11' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS November,      CASE
          WHEN strftime('%m', soldDate) = '12' THEN FORMAT("$%.2f", SUM(salesAmount)) 
      ELSE 0
      END AS December
FROM employee e
LEFT JOIN sales s
ON e.employeeId = s.employeeId
WHERE strftime('%Y', soldDate) = '2021'
GROUP BY strftime('%m', soldDate), e.employeeId, e.firstName, e.lastName
ORDER BY salesAmount DESC;

-- Ej 3
SELECT s.soldDate, s.salesAmount, e.colour, e.year
FROM sales s
  JOIN(SELECT m.EngineType, i.inventoryId, i.colour, i.year
        FROM inventory i
          JOIN model m
          ON i.modelId = m.modelId
        WHERE m.EngineType = 'Electric') as e
  ON s.inventoryId = e.inventoryId;
