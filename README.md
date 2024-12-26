# SQL notes

## Aggregation Execution Order

### Query
```sql
SELECT book_name
FROM book_sales
WHERE book_name LIKE 'A%'
GROUP BY book_name
HAVING SUM(copies_sold) > 100
ORDER BY book_name
LIMIT 1;
```

### Execution Steps

Step 1: FROM `book_sales`
The `FROM` executes first since we need to specify which table we are querying.

Step 2: WHERE `book_name` LIKE 'A%'
The `WHERE` clause is executed next. It filters the rows to only include books that start with 'A'.

Step 3: GROUP BY `book_name`
The `GROUP BY` clause is executed next. It groups the rows by the `book_name` column.

Step 4: `HAVING SUM(copies_sold) > 100`
The `HAVING` clause is executed next. It filters the groups to only include groups that have sold more than 100 copies in total.

Step 5: ORDER BY `book_name`
The `ORDER BY` clause is executed next. It sorts the rows by the `book_name` column.

Step 6: `LIMIT 1`
The `LIMIT` clause is executed last. It limits the rows to only include the first 1 row.

Step 7: `SELECT book_name`
The `SELECT` clause is executed last. It returns only the `book_name` column from the table that we have filtered, grouped, and sorted.

## Inner Join

The `INNER JOIN` clause is used to combine rows from tables based on matching values in a specified column. By default, it will only return rows where there is a match, so we don't need to specify any additional conditions in the WHERE clause.

In PostgreSQL and most other SQL databases, the `INNER JOIN` clause is equivalent to the `JOIN` clause.

## Table Alias

When performing a join, you can use an alias for each table to make queries more readable.

```bash
SELECT s.name, c.course_name
FROM students AS s
INNER JOIN course_registrations AS c ON s.id = c.student_id;
```

In the above example, the `students` table is aliased as `s` and the `course_registrations` table is aliased as `c`. We use the `AS` keyword to alias the tables, similar to how we use it to rename columns in the output result.

We can also omit the `AS` keyword and just place the alias directly after the table name.

```bash
SELECT s.name, c.course_name
FROM students s
INNER JOIN course_registrations c ON s.id = c.student_id;
```

The above example, is equivalent to the previous example.

## Left Join

We can use the `LEFT JOIN` clause to combine rows from two tables based on a condition, but unlike `INNER JOIN`, it will also include all rows from the left table, even if there is no matching row in the right table.

## Right Join

We can use a `RIGHT JOIN` to join two tables, similar to a `LEFT JOIN`. The result will include all rows from the right table, and the matching rows from the left table. If there is no match, the result will include `NULL` for the columns from the left table.

That means it's equivalent to a `LEFT JOIN` with the order of the tables swapped.

For example the following `LEFT JOIN`:

```bash
SELECT u.name, e.company_name, e.job_title
FROM users u
LEFT JOIN employment_records e ON u.id = e.employee_id
```
is equivalent to the following `RIGHT JOIN`:

```bash
SELECT e.company_name, e.job_title, u.name
FROM employment_records e
RIGHT JOIN users u ON e.employee_id = u.id
```

## Full Join

A FULL JOIN is like a combination of a LEFT JOIN and a RIGHT JOIN. It all rows from both tables, matching rows where possible and filling in with NULLs where there's no match.

If we had a `FOREIGN KEY` constraint on `NULL`  column in the table, it would not be possible.

## Multi Join

We can also join more than two tables at once. In fact, this is very common in real-world applications.

## Normalized Tables

Relational databases promote the idea of **Normalization**. This is a process of organizing data in a way that eliminates redundant data and ensures data is consistent.

We can normalize this data by creating separate tables for each **entity**.

### Example dataset
```sql
CREATE TABLE orders (
    user_id INTEGER,
    user_name TEXT,
    product_id INTEGER,
    product_name TEXT,
    order_id INTEGER
);
```

Example of **normalisation**:
```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    product_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```
