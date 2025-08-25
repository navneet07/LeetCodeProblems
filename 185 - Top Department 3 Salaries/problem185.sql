# Write your MySQL query statement below
WITH ranked AS (
    SELECT
    e.id,
    e.name,
    e.salary,
    e.departmentId,
    DENSE_RANK() OVER (
        PARTITION BY e.departmentId
        ORDER BY e.salary DESC
    ) AS rk
    FROM Employee e
)
SELECT 
d.name AS Department,
r.name AS Employee,
r.salary AS Salary
FROM ranked r
JOIN Department d
ON d.id = r.departmentId
WHERE r.rk <=3