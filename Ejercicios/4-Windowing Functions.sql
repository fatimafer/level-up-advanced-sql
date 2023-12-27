-- Ej 1
SELECT e.firstName, e.lastName, m.model, count(m.model) AS NumSales,
       Rank() OVER (PARTITION BY e.employeeID ORDER BY count(m.model) DESC) AS Rank
FROM sales s
 JOIN employee e
 ON s.employeeID = e.employeeID
 JOIN inventory i 
 ON s.InventoryID = i.InventoryID
 JOIN model m 
 ON i.ModelID = m.ModelID
GROUP BY e.firstName, e.lastName, m.model


-- Ej 2
WITH monthly_sales AS (SELECT strftime('%m', soldDate) as month, 
                      strftime('%Y', soldDate) as year, SUM(salesAmount) AS MonthAmount
                      FROM sales 
                      GROUP BY month, year)
SELECT month, year, FORMAT("$%.2f", MonthAmount) AS MonthAmount, 
                    FORMAT("$%.2f", SUM(MonthAmount) OVER (PARTITION BY year ORDER BY year, month)) AS YearAmount
FROM monthly_sales


-- Ej 3
SELECT s.current_year, s.current_month, s.current_MonthAmount, p.past_month, p.past_MonthAmount
FROM (SELECT ROW_NUMBER() OVER (ORDER BY strftime('%Y', soldDate), strftime('%m', soldDate)) as row_number,
              strftime('%m', soldDate) as current_month, strftime('%Y', soldDate) as current_year, 
              COUNT(SalesId) AS current_MonthAmount
      FROM sales
      GROUP BY current_month, current_year
      ORDER BY row_number)s
  JOIN (SELECT 1 AS row_number, '' as past_month, '' as year_of_past_mt, '' AS past_MonthAmount
        UNION ALL
        SELECT (ROW_NUMBER() OVER (ORDER BY strftime('%Y', soldDate), strftime('%m', soldDate))+1) as row_number, 
                strftime('%m', soldDate) as past_month, strftime('%Y', soldDate) as year_of_past_mt, COUNT(SalesId) AS past_MonthAmount
        FROM sales 
        WHERE soldDate < (SELECT DATETIME(strftime('%Y-%m-01', soldDate)) as last_month
                          FROM sales 
                          ORDER BY soldDate DESC
                          LIMIT 1)
        GROUP BY past_month, year_of_past_mt
        ORDER BY row_number)p
  ON s.row_number = p.row_number


