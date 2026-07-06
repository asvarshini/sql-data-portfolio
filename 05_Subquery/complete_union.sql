# SQL Set Operations (UNION, UNION ALL, INTERSECT & EXCEPT)

## What are Set Operations?

Set Operations** are SQL operators used to combine the results of two or more `SELECT` queries into a single result set.

**Note:** Each `SELECT` statement must have:
- The **same number of columns**
- The **same order of columns**
- **Compatible data types**

---

# Syntax

```sql
SELECT column1, column2
FROM table1

UNION | UNION ALL | INTERSECT | EXCEPT

SELECT column1, column2
FROM table2;
```

# Types of Set Operations

## 1. UNION

The `UNION` operator combines the results of two or more `SELECT` statements and **removes duplicate rows**.

### Example

### Students_2024

| ID | Name |
|----|------|
|1|Alice|
|2|Bob|
|3|Charlie|

### Students_2025

| ID | Name |
|----|------|
|2|Bob|
|3|Charlie|
|4|David|

### Query

```sql
SELECT name
FROM Students_2024

UNION

SELECT name
FROM Students_2025;
```

### Output

| Name |
|------|
|Alice|
|Bob|
|Charlie|
|David|

**Duplicate rows (Bob and Charlie) are removed automatically.**


# 2. UNION ALL

The `UNION ALL` operator combines the results of two or more `SELECT` statements **without removing duplicates**.

### Query

```sql
SELECT name
FROM Students_2024

UNION ALL

SELECT name
FROM Students_2025;
```

### Output

| Name |
|------|
|Alice|
|Bob|
|Charlie|
|Bob|
|Charlie|
|David|

**All rows, including duplicates, are returned.**

---

# Difference Between UNION and UNION ALL

| UNION | UNION ALL |
|--------|-----------|
| Removes duplicate rows | Keeps duplicate rows |
| Slightly slower | Faster |
| Returns unique records | Returns all records |

---

# 3. INTERSECT

The `INTERSECT` operator returns **only the rows that are common in both SELECT statements**.

### Query

```sql
SELECT name
FROM Students_2024

INTERSECT

SELECT name
FROM Students_2025;
```

### Output

| Name |
|------|
|Bob|
|Charlie|

**Only common records are returned.**


# 4. EXCEPT

The `EXCEPT` operator returns rows from the **first query that do not exist in the second query**.

### Query

```sql
SELECT name
FROM Students_2024

EXCEPT

SELECT name
FROM Students_2025;
```

### Output

| Name |
|------|
|Alice|

Only **Alice** exists in the first table but not in the second.

> **Note:** `EXCEPT` is order-sensitive.
>
> `A EXCEPT B` ≠ `B EXCEPT A`

Example:

```sql
SELECT name
FROM Students_2025

EXCEPT

SELECT name
FROM Students_2024;
```

Output

| Name |
|------|
|David|

---

# Conditions for Set Operations

Before using any set operation:

- Both queries must return the **same number of columns**.
- Corresponding columns must have **compatible data types**.
- Columns should be in the **same order**.
- Column names do not need to be the same.

---

# Execution Order

SQL executes set operations in the following order:

```
SELECT

↓

Set Operation (UNION / UNION ALL / INTERSECT / EXCEPT)

↓

ORDER BY

↓

LIMIT
```

Example

```sql
SELECT name
FROM table1

UNION

SELECT name
FROM table2

ORDER BY name;
```

The `ORDER BY` is applied **after** combining the result sets.

---

# Advantages

- Combines multiple result sets into one.
- Eliminates duplicate records using `UNION`.
- Helps compare data between tables.
- Makes reports easier to generate.
- Reduces the need for multiple queries.

---

# Disadvantages

- All queries must return the same number of columns.
- Data types should be compatible.
- `UNION` is slower because it removes duplicates.
- Some databases do not support `INTERSECT` and `EXCEPT`.

---

# When to Use Which Operator?

| Operator | Use Case |
|----------|----------|
| UNION | Combine results and remove duplicates |
| UNION ALL | Combine results and keep duplicates |
| INTERSECT | Find common records |
| EXCEPT | Find records present only in the first query |

---

# Key Points

- Set operations combine the results of multiple `SELECT` statements.
- All queries must have the same number of columns.
- Corresponding columns should have compatible data types.
- `UNION` removes duplicates.
- `UNION ALL` keeps duplicates.
- `INTERSECT` returns common rows.
- `EXCEPT` returns rows from the first query that are not in the second.
- `ORDER BY` should be written only once, at the end of the final query.

---

# Quick Revision

- **UNION** → Combines results and removes duplicates.
- **UNION ALL** → Combines results and keeps duplicates.
- **INTERSECT** → Returns common rows.
- **EXCEPT** → Returns rows only in the first query.
- **Requirements** → Same number of columns, same order, compatible data types.
- **Execution Order** → SELECT → Set Operation → ORDER BY → LIMIT.