
SELECT *, AVG(age) OVER()
FROM employees;
-- (actual time=0.214..0.233 rows=20 loops=1)
-- (cost=2.25 rows=20) (actual time=0.0813..0.0985 rows=20 loops=1)


-- CROSS JOINで同じ書き方
SELECT * FROM employees
CROSS JOIN
(SELECT AVG(age) AS avg_age FROM employees) AS avg;
-- (cost=2.25 rows=20) (actual time=0.024..0.0317 rows=20 loops=1)


-- WITHで同じ書き方
WITH avg_age_table AS(
  SELECT AVG(age) AS age FROM employees
)
SELECT *,
(SELECT age FROM avg_age_table) AS avg_age
FROM employees;
-- (cost=2.25 rows=20) (actual time=0.0231..0.0306 rows=20 loops=1)
-- (cost=0..0 rows=1) (actual time=249e-6..332e-6 rows=1 loops=1)


-- department_idでグループ化して集計した平均年齢と部署毎の合計
SELECT *, AVG(age) OVER(PARTITION BY department_id) AS avg_age,
COUNT(*) OVER(PARTITION BY department_id) AS count_department
FROM employees;


-- 各年代ごとに人がそれぞれ何人いるか
SELECT DISTINCT
FLOOR(age/10) * 10 AS "年代",
CONCAT(COUNT(*) OVER(PARTITION BY FLOOR(age/10)), "人") AS age_count
FROM employees;


-- 月ごとの売上の合計値を取得（formatで2020/02の形式になっているのでグループ化できる）
SELECT *,
DATE_FORMAT(order_date, '%Y/%m'),
SUM(order_amount*order_price) OVER(PARTITION BY DATE_FORMAT(order_date, '%Y/%m'))
FROM orders;
