-- customers, orders, items, stores を紐付ける（INNER JOIN）
-- customers.idで並び替える（ORDER BY）
SELECT
  ct.id, ct.last_name, od.item_id, od.order_amount, od.order_price, od.order_date, it.name, st.name
FROM 
  customers AS ct
INNER JOIN orders AS od
ON ct.id = od.customer_id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN stores AS st
ON it.store_id = st.id
ORDER BY ct.id;

-- customers.idが10で、orders.order_dateが2020-08-01よりあとに絞り込む
SELECT
  ct.id, ct.last_name, od.item_id, od.order_amount, od.order_price, od.order_date, it.name, st.name
FROM 
  customers AS ct
INNER JOIN orders AS od
ON ct.id = od.customer_id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN stores AS st
ON it.store_id = st.id
WHERE ct.id = 10 AND od.order_date > "2020-08-01"
ORDER BY ct.id;

-- 別解: サブクエリで書く
SELECT
  ct.id, ct.last_name, od.item_id, od.order_amount, od.order_price, od.order_date, it.name, st.name
FROM
  (SELECT * FROM customers WHERE id = 10) AS ct
INNER JOIN (SELECT * FROM orders WHERE order_date > "2020-08-01") AS od
ON ct.id = od.customer_id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN stores AS st
ON it.store_id = st.id
ORDER BY ct.id;

-- GROUP BY の紐づけ
SELECT * FROM customers AS ct
INNER JOIN
  (SELECT customer_id, SUM(order_amount * order_price) AS summary_price
  FROM orders
  GROUP BY customer_id) AS order_summary
ON ct.id = order_summary.customer_id
ORDER BY ct.age
LIMIT 5;