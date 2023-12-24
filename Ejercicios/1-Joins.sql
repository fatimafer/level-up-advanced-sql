-- Ej 1
SELECT e.firstName as employee_firstname, e.lastName as employee_lastname, 
        m.firstName as manager_firstname, m.lastName as manager_lastname
FROM employee e
LEFT JOIN employee m 
-- En el vídeo se usaba una inner join, pero yo prefiero una left join para que salga el manager
ON e.managerId = m.employeeId
LIMIT 20;

-- Ej 2
SELECT e.employeeId, e.firstName, e.lastName, count(s.salesId) as sales
FROM employee e
LEFT JOIN sales s
ON e.employeeId = s.employeeId
WHERE e.title = 'Sales Person'
GROUP BY e.employeeId, e.firstName, e.lastName
HAVING sales = 0;

-- Ej 3
SELECT c.firstName, c.lastName, c.email, s.salesId, s.salesAmount, s.soldDate
FROM sales s
FULL OUTER JOIN customer c
    ON c.customerId = s.customerId
WHERE c.customerId IS NULL
OR s.salesId IS NULL;