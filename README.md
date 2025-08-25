## LeetCode SQL Solutions

This repository contains SQL solutions for selected LeetCode database problems. Each problem lives in its own folder with the SQL solution and a short problem description.

### Included Problems

#### 184. Department's Highest Salary
- **What is asked**: For each department, return the employee(s) who earn the highest salary in that department.
- **Expected columns**: `Department`, `Employee`, `Salary`.
- **Key idea**: Use window functions (e.g., `RANK()` over salaries partitioned by department) and filter to the top rank per department.
- **Folder**: `184 - Department's Highest Salary/`
  - `problem184.sql`: Solution using `RANK()` window function.
  - `README.md`: Full schema and example input/output.

#### 185. Department Top Three Salaries
- **What is asked**: For each department, return all employees whose salary is in the top three unique salaries for that department.
- **Expected columns**: `Department`, `Employee`, `Salary`.
- **Key idea**: Use `DENSE_RANK()` over salaries partitioned by department and keep rows with rank ≤ 3.
- **Folder**: `185 - Top Department 3 Salaries/`
  - `problem185.sql`: Solution using `DENSE_RANK()` window function.

### Repository Structure

```
LeetCode Problems/
  ├─ 184 - Department's Highest Salary/
  │  ├─ problem184.sql
  │  └─ README.md
  └─ 185 - Top Department 3 Salaries/
     └─ problem185.sql
```

### Running the SQL

These solutions are written for MySQL (window functions are required). You can:
- Run them directly in MySQL 8.0+ against the example schema, or
- Adapt to other SQL dialects that support equivalent window functions.

### Notes
- Window functions like `RANK()` and `DENSE_RANK()` are crucial for per-department top-N logic.
- Examples and schemas are included in each problem folder.


