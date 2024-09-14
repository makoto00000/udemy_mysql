
-- ROW_NUMBER 行番号
-- RANK 2位が二人いた場合は二人とも3位になる
-- DENSE_RANK 2位が二人いた場合は二人とも2位になる

SELECT 
*,
ROW_NUMBER() OVER(ORDER BY age) AS row_num,
RANK() OVER(ORDER BY age) AS row_rank,
DENSE_RANK() OVER(ORDER BY age) AS row_dense
FROM employees;


-- PERCENT_RANK (RANK-1) / (行数-1)
-- CUME_DIST 現在の行の値より小さい行の割合

SELECT 
age,
RANK() OVER(ORDER BY age) AS row_rank,
COUNT(*) OVER() AS cnt,  -- 行数
PERCENT_RANK() OVER (ORDER BY age) AS p_age,
CUME_DIST() OVER (ORDER BY age) AS c_age
FROM employees;

-- LAG 直前の値
-- LEAD 直後の値

SELECT
age,
LAG(age) OVER(ORDER BY age), -- 直前
LAG(age, 3, 0) OVER(ORDER BY age), -- 3つ前、ない場合は0
LEAD(age) OVER(ORDER BY age), -- 直後
LEAD(age, 2, 0) OVER(ORDER BY age) -- ２つ後、ない場合は0
FROM
customers;


-- FIRST_VALUE
-- LAST_VALUE

SELECT
department_id,
FIRST_VALUE(first_name) OVER(PARTITION BY department_id ORDER BY age) AS young, -- 部署毎に分けて年齢の昇順にしたときの最初の人
LAST_VALUE(first_name) OVER(PARTITION BY department_id ORDER BY age RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS old -- 部署ごとに分けて年齢の昇順にしたときの最後の人
FROM employees;

-- LAST_VALUEは現在の行を見ているので、その時点での年齢が高い人が出力される。部署の人全員を対象とするために、RANGE BETWEENが必要。


-- TILE

SELECT
age,
NTILE(2) OVER(ORDER BY age) -- 年齢順に並べて2つに分けたときの番号
FROM
employees;


-- 10個に分けて8番目になるグループを抽出したい

SELECT
*
FROM
(SELECT
  age,
NTILE(10) OVER(ORDER BY age) AS ntile_value
FROM employees) AS tmp
WHERE
tmp.ntile_value = 8;
