
-- 営業部の人の年齢を+2する。

-- UPDATE 
--   employees AS emp
-- SET 
--   emp.age = emp.age+2
-- WHERE
--   emp.department_id = (SELECT id FROM departments WHERE name = "営業部");


-- employeesテーブルに部署名を追加する。（部署名はdepartmentsテーブルにnameとして存在する）

-- カラムを追加
-- ALTER TABLE employees
-- ADD department_name VARCHAR(255);

-- SELECTしてみる
-- SELECT emp.*, COALESCE(dp.name, "不明") FROM employees AS emp
-- LEFT JOIN departments AS dp
-- ON emp.department_id = dp.id;

-- UPDATEにする
-- UPDATE employees AS emp
-- LEFT JOIN departments AS dp
-- ON emp.department_id = dp.id
-- SET emp.department_name = COALESCE(dp.name, "不明");


-- storesに店の全ての売上を表すall_salesを追加する

-- カラムを追加
-- ALTER TABLE stores
-- ADD all_sales INT;

-- 店の全ての売上を取得して、storesにINNER JOIN
-- WITH tmp_sales AS(
--   SELECT
--   it.store_id,
--   SUM(od.order_amount * od.order_price) AS summary
--   FROM items AS it
--   INNER JOIN orders AS od
--   ON it.id = od.item_id
--   GROUP BY it.store_id
-- )
-- SELECT * FROM stores AS st
-- INNER JOIN tmp_sales AS ts
-- ON st.id = ts.store_id;

-- UPDATE文に変換
-- WITH tmp_sales AS(
--   SELECT
--   it.store_id,
--   SUM(od.order_amount * od.order_price) AS summary
--   FROM items AS it
--   INNER JOIN orders AS od
--   ON it.id = od.item_id
--   GROUP BY it.store_id
-- )
-- UPDATE stores AS st
-- INNER JOIN tmp_sales AS ts
-- ON st.id = ts.store_id
-- SET st.all_sales = ts.summary;


-- 開発部の人だけ削除する
-- DELETE FROM employees
-- WHERE department_id IN(
--   SELECT id FROM departments WHERE name = "開発部"
-- );



-- customer_ordersテーブルを作成し、人ごとのその日付までの購入金額の合計をINSERTする。

-- 人毎にその日付までの合計金額を出力
-- SELECT
--   CONCAT(ct.last_name, ct.first_name) AS A,
--   od.order_date AS B,
--   od.order_amount*od.order_price AS C,
--   SUM(od.order_amount*od.order_price) OVER(PARTITION BY CONCAT(ct.last_name, ct.first_name) ORDER BY od.order_date) AS D
-- FROM customers AS ct
-- INNER JOIN orders AS od
-- ON ct.id = od.customer_id;

-- テーブルを作成
-- CREATE TABLE customer_orders(
--   name VARCHAR(255),
--   order_date DATE,
--   sales INT,
--   total_sales INT
-- );

-- INSERT
INSERT INTO customer_orders
SELECT
  CONCAT(ct.last_name, ct.first_name) AS A,
  od.order_date AS B,
  od.order_amount*od.order_price AS C,
  SUM(od.order_amount*od.order_price) OVER(PARTITION BY CONCAT(ct.last_name, ct.first_name) ORDER BY od.order_date) AS D
FROM customers AS ct
INNER JOIN orders AS od
ON ct.id = od.customer_id;