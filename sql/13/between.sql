-- UNBOUNDED PRECEDING 一番頭の行
-- n PRECEDING 現在の行よりn行前の行
-- CURRENT ROW 現在の行（省略可）
-- n FOLLOWING 現在の行よりn行後の行
-- UNBOUNDED FOLLOWING 一番最後の行

-- ROW BETWEEN 集計範囲を設定

-- RANGE BETWEEN ORDER BYの集計範囲を設定（ORDER BYが必須）



-- order_dateごとの注文合計金額の1週間の平均値を求めたい

-- order_dateごとの注文金額をWITHでテーブル化
-- そのテーブルに対して7日間（6日前から今日）までの平均を集計する
WITH daily_summary AS(
SELECT
  order_date,
  SUM(order_price*order_amount) AS sale
FROM
  orders
GROUP BY order_date
)
SELECT *,
AVG(sale) OVER(ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "週間平均"
FROM  daily_summary;


-- 人毎の給料の合計金額の、最初の人から最後の人までの合計金額
SELECT
  *,
  SUM(summary_salary.payment)
  OVER(ORDER BY age RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS p_summary
FROM employees AS emp
INNER JOIN
(SELECT
  employee_id,
  SUM(payment) AS payment
FROM salaries
GROUP BY employee_id) AS summary_salary
ON emp.id = summary_salary.employee_id;
