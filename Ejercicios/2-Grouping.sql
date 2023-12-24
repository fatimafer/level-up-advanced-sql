-- Ej 1
SELECT e.employeeId, e.firstName, e.lastName, count(*) as NumSales
FROM employee e
LEFT JOIN sales s
ON e.employeeId = s.employeeId
GROUP BY e.employeeId, e.firstName, e.lastName
ORDER BY NumSales DESC;

-- Ej 2
SELECT max.employeeId, e.firstName, e.lastName, 
      max.model as maxModel, max.MaxSales, min.model as MinModel, min.MinSales
FROM(SELECT employeeId, model,MaxSales
      FROM (SELECT inventoryId, employeeId,MAX(salesAmount) as MaxSales
            FROM sales
            WHERE strftime('%Y', soldDate) = '2023'
            GROUP BY employeeId) AS s
              JOIN inventory i 
              ON s.inventoryId = i.inventoryId
              JOIN model m
              ON i.modelId = m.modelId) as max
  JOIN(SELECT employeeId, model,MinSales
        FROM (SELECT inventoryId, employeeId,MIN(salesAmount) as MinSales
              FROM sales
              WHERE strftime('%Y', soldDate) = '2023'
              GROUP BY employeeId) AS s
                JOIN inventory i 
                ON s.inventoryId = i.inventoryId
                JOIN model m
                ON i.modelId = m.modelId) as min
  ON max.employeeId = min.employeeId
  JOIN employee e
  ON max.employeeId = e.employeeId
ORDER BY max.employeeId ASC;

-- Ej 3
SELECT e.employeeId, e.firstName, e.lastName, count(*) as NumSales
FROM employee e
LEFT JOIN sales s
ON e.employeeId = s.employeeId
GROUP BY e.employeeId, e.firstName, e.lastName
HAVING NumSales > 5
ORDER BY NumSales DESC;
