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
The FROM executes first since we need to specify which table we are querying.

Step 2: WHERE `book_name` LIKE 'A%'
The WHERE clause is executed next. It filters the rows to only include books that start with 'A'.

Step 3: GROUP BY `book_name`
The GROUP BY clause is executed next. It groups the rows by the `book_name` column.

Step 4: `HAVING SUM(copies_sold) > 100`
The HAVING clause is executed next. It filters the groups to only include groups that have sold more than 100 copies in total.

Step 5: ORDER BY `book_name`
The ORDER BY clause is executed next. It sorts the rows by the `book_name` column.

Step 6: `LIMIT 1`
The LIMIT clause is executed last. It limits the rows to only include the first 1 row.

Step 7: `SELECT book_name`
The SELECT clause is executed last. It returns only the book_name column from the table that we have filtered, grouped, and sorted.
