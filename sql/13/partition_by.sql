-- 部署ごとにグループ化して、部署内でその年齢までの合計人数を集計
SELECT *,
COUNT(*) OVER(PARTITION BY department_id ORDER BY age)
FROM employees;

-- 各個人の月ごとの収入の最大値を集計
SELECT
*,
MAX(payment) OVER(PARTITION BY emp.id)
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id;

-- 月ごとに各人の給与を合計していく
SELECT
*,
SUM(sa.payment) OVER(PARTITION BY sa.paid_date ORDER BY emp.id)
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id;