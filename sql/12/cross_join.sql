-- CROSS JOIN（交差結合）
-- ２つのテーブルを全ての組み合わせで紐づけて結合する。

-- CROSS JOINを使わない書き方
SELECT * FROM employees AS emp1, employees AS emp2;

-- CROSS JOINを使う書き方
SELECT * FROM employees AS emp1
CROSS JOIN employees AS emp2;

-- emp1.idよりemp2.idが大きいものだけを紐付ける
SELECT * FROM employees AS emp1
CROSS JOIN employees AS emp2
ON emp1.id < emp2.id;

-- 計算結果とCASEで紐づけ
SELECT
*,
CASE
  WHEN cs.age > summary_customers.avg_age THEN "o"
  ELSE "x"
END AS "平均年齢よりも年齢が高いか"
FROM customers AS cs
CROSS JOIN(
  SELECT AVG(age) AS avg_age FROM customers
) AS summary_customers;

-- employeesとsalariesを内部結合して、さらにavg_paymentを交差結合する。
-- employeeごとの平均にするためemp.idでGROUP BY
-- CASE文で全体の平均月収（summary.avg_payment）と個人の平均月収（AVG(payment)）を比べる
SELECT
emp.id,
AVG(payment) AS "個人の平均月収",
summary.avg_payment AS "全体の平均月収",
CASE
  WHEN AVG(payment) >= summary.avg_payment THEN "o"
  ELSE "x"
END AS "平均月収以上か"
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id
CROSS JOIN
(SELECT AVG(payment) AS avg_payment FROM salaries) AS summary
GROUP BY emp.id, summary.avg_payment;
