-- EXISTS（サブクエリのレコードが取得できたらメインクエリを取得する）
-- employeesのdepartment_idが、departmentsに存在していれば表示
SELECT * FROM employees AS em
WHERE NOT EXISTS(
  SELECT * FROM departments AS dt
  WHERE em.department_id = dt.id
);

-- INで書くこともできるがEXISTSの方がパフォーマンスが良い
SELECT * FROM employees AS em
WHERE em.department_id IN (SELECT id FROM departments);


-- 営業部か開発部の人のデータだけを取得する
-- departmentsからnameが営業部か開発部で、employees.department_idがdepartment.idと一致したときだけ、メインクエリのレコードを表示する。
SELECT * FROM employees AS em
WHERE EXISTS (
  SELECT 1 FROM departments AS dt WHERE dt.name IN ("営業部", "開発部") AND em.department_id = dt.id
)

-- 2020-12-31に注文をしていて、そのordersのcustomer_idと一致するcustomersのレコードを出力する。
SELECT * FROM customers AS ct 
WHERE EXISTS (
  SELECT * FROM orders AS od WHERE ct.id = od.customer_id AND od.order_date = "2020-12-31"
);

-- manager_idがemployees.idに存在するレコードのみ出力
SELECT * FROM employees AS em1 WHERE EXISTS (
  SELECT * FROM employees AS em2 WHERE em1.manager_id = em2.id
);

-- NULL = NULLはNULLなので、EXISTSでとりだせない（TRUE(1)のみ）
SELECT * FROM customers AS c1
WHERE EXISTS
(SELECT * FROM customers_2 AS c2
WHERE c1.first_name = c2.first_name
AND c1.last_name = c2.last_name
AND c1.phone_number = c2.phone_number);

-- TRUEでなければ取り出すので、NULLも取得できる
SELECT * FROM customers AS c1
WHERE NOT EXISTS
(SELECT * FROM customers_2 AS c2
WHERE c1.first_name = c2.first_name
AND c1.last_name = c2.last_name
AND c1.phone_number = c2.phone_number);

-- NOT IN は NULL != NULLで評価し、これはNULLとなるため取り出さない
SELECT * FROM customers AS c1
WHERE (first_name, last_name, phone_number) IN
(SELECT first_name, last_name, phone_number FROM customers_2);



-- EXCEPT で書く場合
SELECT * FROM customers
EXCEPT
SELECT * FROM customers_2 ORDER BY id;

-- NOT EXISTSでEXCEPTを表現（NULLの値がある場合は注意）
SELECT * FROM customers AS c1
WHERE NOT EXISTS(
  SELECT * FROM customers_2 AS c2
  WHERE
    c1.id = c2.id AND
    c1.first_name = c2.first_name AND
    c1.last_name = c2.last_name AND
    (c1.phone_number = c2.phone_number OR (c1.phone_number IS NULL AND c2.phone_number IS NULL)) AND
    c1.age = c2.age
);


-- INTERSECT
SELECT * FROM customers
INTERSECT
SELECT * FROM customers_2 ORDER BY id;

-- EXISTSでINTERSECT表現（NULLの値がある場合は注意）
SELECT * FROM customers AS c1
WHERE EXISTS(
  SELECT * FROM customers_2 AS c2
  WHERE
    c1.id = c2.id AND
    c1.first_name = c2.first_name AND
    c1.last_name = c2.last_name AND
    (c1.phone_number = c2.phone_number OR (c1.phone_number IS NULL AND c2.phone_number IS NULL)) AND
    c1.age = c2.age
);
