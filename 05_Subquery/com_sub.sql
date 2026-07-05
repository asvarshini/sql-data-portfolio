# SQL Subqueries

## What is a Subquery?

A Subquery (also called an **Inner Query** or **Nested Query**) is a query written inside another SQL query. It is enclosed in **parentheses `()`** and executes before the outer query. The result of the subquery is then used by the outer query.

**Syntax**
```sql
SELECT column_name
FROM table_name
WHERE column_name operator (
    SELECT column_name
    FROM table_name
);
```

---

# How a Subquery Works

A subquery follows these steps:

1. SQL executes the **inner query** first.
2. The inner query returns a result (single value, multiple values, or a table).
3. The outer query uses that result.
4. SQL returns the final output.

---

## Example

### Employee Table

| ID | Name | Salary |
|----|------|---------|
| 1 | Alice | 30000 |
| 2 | Bob | 45000 |
| 3 | Charlie | 60000 |
| 4 | David | 25000 |
| 5 | Eva | 50000 |

### Query

```sql
SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
```

### Step 1: Execute the Subquery

```sql
SELECT AVG(salary)
FROM employees;
```

**Output**

```
42000
```

### Step 2: Replace the Subquery Result

SQL internally treats the query as:

```sql
SELECT *
FROM employees
WHERE salary > 42000;
```

### Final Output

| Name | Salary |
|------|--------|
| Bob | 45000 |
| Charlie | 60000 |
| Eva | 50000 |

---

# Why Use Subqueries?

- Simplifies complex SQL queries.
- Eliminates the need to write multiple queries.
- Retrieves data based on calculated values.
- Makes queries more dynamic and readable.
- Useful for comparisons using `AVG()`, `MAX()`, `MIN()`, `COUNT()`, etc.

---

# Where Can Subqueries Be Used?

### 1. WHERE Clause

Used to filter rows.

```sql
SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
```

---

### 2. FROM Clause

Used as a temporary table.

```sql
SELECT AVG(salary)
FROM
(
    SELECT salary
    FROM employees
) AS temp;
```

---

### 3. SELECT Clause

Returns calculated values.

```sql
SELECT
    name,
    (SELECT AVG(salary) FROM employees) AS average_salary
FROM employees;
```

---

### 4. HAVING Clause

Filters grouped records.

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) >
(
    SELECT AVG(salary)
    FROM employees
);
```

---

# Types of Subqueries

## 1. Single-Row Subquery

Returns only **one value**.

Example:

```sql
SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
```

**Common Operators**

- `=`
- `>`
- `<`
- `>=`
- `<=`
- `<>`

---

## 2. Multiple-Row Subquery

Returns **multiple rows**.

Example:

```sql
SELECT *
FROM employees
WHERE department IN
(
    SELECT department
    FROM departments
);
```

**Common Operators**

- `IN`
- `NOT IN`
- `ANY`
- `ALL`
- `EXISTS`
- `NOT EXISTS`

---

## 3. Correlated Subquery

A correlated subquery depends on the outer query and executes **once for each row** of the outer query.

```sql
SELECT e1.name
FROM employees e1
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department = e2.department
);
```

---

# Advantages

- Reduces multiple SQL queries.
- Makes complex queries easier to understand.
- Supports dynamic comparisons.
- Can be used in `SELECT`, `FROM`, `WHERE`, and `HAVING`.

---

# Disadvantages

- Correlated subqueries can be slower.
- Deeply nested subqueries reduce readability.
- JOINs are often more efficient for large datasets.

---

# Subquery vs JOIN

| Subquery | JOIN |
|----------|------|
| Query inside another query | Combines two or more tables |
| Good for filtering and calculations | Good for retrieving related data |
| Easier to write | Usually faster for large datasets |
| Can be slower when nested | Better performance in many cases |

---

# Key Points

- A **Subquery** is a query inside another SQL query.
- It must always be enclosed in **parentheses `()`**.
- The **inner query executes first**, followed by the outer query (except correlated subqueries).
- A subquery can return a **single value**, **multiple values**, or an **entire table**.
- Subqueries can be used in **SELECT**, **FROM**, **WHERE**, and **HAVING** clauses.
- Use **`=`** for a single-row subquery.
- Use **`IN`** for a multiple-row subquery.
- Correlated subqueries execute once for each row of the outer query.

---

# Quick Revision

- **Subquery = Query inside another query**
- **Execution Order:** Inner Query → Outer Query
- **Types:** Single-Row, Multiple-Row, Correlated
- **Clauses:** SELECT, FROM, WHERE, HAVING
- **Single Row:** `=`, `>`, `<`
- **Multiple Rows:** `IN`, `ANY`, `ALL`
- **Correlated:** Executes once for each row
- **Best Used For:** Dynamic filtering and comparisons using aggregate functions like `AVG()`, `MAX()`, `MIN()`, and `COUNT()`.