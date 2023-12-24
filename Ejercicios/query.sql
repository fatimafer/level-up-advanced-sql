SELECT firstName, lastname, title
FROM employee
LIMIT 5;

SELECT model, EngineType
FROM model
LIMIT 5;

SELECT sql
FROM sqlite_schema
WHERE name = 'employee';

SELECT sql
FROM sqlite_schema
WHERE name = 'sales';


select column_name 
from information_schema.columns
where table_name = 'sales';
