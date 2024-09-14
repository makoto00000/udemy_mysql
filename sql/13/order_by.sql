
-- ageで昇順に並び替えて、一番若い人から自分のレコードの年齢までの人の人数を取得
SELECT
*,
COUNT(*) OVER (ORDER BY age) AS tmp_count
FROM
employees;

-- その日付までの注文金額の小計を出力
SELECT *,
SUM(order_price) OVER(ORDER BY order_date) FROM orders;

-- その年代以下の合計人数
SELECT
DISTINCT CONCAT(FLOOR(age/10) * 10, "代") AS "年代",
COUNT(*) OVER(ORDER BY FLOOR(age/10) * 10) AS "年代以下の合計"
FROM employees;