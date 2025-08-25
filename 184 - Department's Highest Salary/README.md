## 184. Department's Highest Salary

### Schema

Employee

```
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
```

Department

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
```

- id in both tables is the primary key.
- `departmentId` in `Employee` references `Department(id)`.

### Task
Write a query to find employees who have the highest salary in each department. Return the result in any order with the columns:
- `Department`
- `Employee`
- `Salary`

### Example

Input

Employee

```
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
```

Department

```
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
```

Output

```
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
```

Explanation: Max and Jim both have the highest salary in IT; Henry has the highest salary in Sales.

---

### Solution 1: Window function (ANSI SQL)

```sql
WITH ranked AS (
  SELECT
    e.id,
    e.name,
    e.salary,
    e.departmentId,
    DENSE_RANK() OVER (
      PARTITION BY e.departmentId
      ORDER BY e.salary DESC
    ) AS salary_rank
  FROM Employee e
)
SELECT
  d.name AS Department,
  r.name AS Employee,
  r.salary AS Salary
FROM ranked r
JOIN Department d ON d.id = r.departmentId
WHERE r.salary_rank = 1;
```

### Solution 2: Correlated subquery

```sql
SELECT
  d.name AS Department,
  e.name AS Employee,
  e.salary AS Salary
FROM Employee e
JOIN Department d ON d.id = e.departmentId
WHERE e.salary = (
  SELECT MAX(e2.salary)
  FROM Employee e2
  WHERE e2.departmentId = e.departmentId
);
```

### Solution 3: Join with aggregated max per department

```sql
SELECT
  d.name AS Department,
  e.name AS Employee,
  e.salary AS Salary
FROM Employee e
JOIN (
  SELECT departmentId, MAX(salary) AS max_salary
  FROM Employee
  GROUP BY departmentId
) m
  ON m.departmentId = e.departmentId AND m.max_salary = e.salary
JOIN Department d
  ON d.id = e.departmentId;
```

Any of the above solutions returns all employees tied for the highest salary within their department.


