# Note how defining `total_medals` as the return variable
# for `SUM(gold + silver + bronze)`, you cannot use that
# as the reference when using `HAVING()` or `ORDERY BY`.
# You have to use the initial `SUM()` agg func, pasing
# in `gold, silver` and `bronze`.

SELECT country, year, SUM(gold + silver + bronze) AS total_medals
FROM olympic_medals
WHERE category != 'Gymnastics'
GROUP BY country, year
HAVING SUM(gold + silver + bronze) > 20
ORDER BY SUM(gold + silver + bronze) DESC
LIMIT 5;
