USE day_10_14_db;


-- employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。
-- 両テーブルのfirst_name, last_name, ageカラムを取り出し、行方向に連結します。
-- 連結の際は、重複を削除するようにしてください。


SELECT first_name, last_name, age FROM employees WHERE id < 10
UNION
SELECT first_name, last_name, age FROM customers WHERE id < 10;



-- departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
-- employeesテーブルのdepartment_idとdepartmentsテーブルのidが紐づけられ
-- salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられます。
-- 月収はsalariesテーブルのpaymentカラムに格納されています

SELECT
SUM(sa.payment),
MAX(sa.payment),
MIN(sa.payment),
AVG(sa.payment)
FROM salaries AS sa
INNER JOIN employees AS emp
ON sa.employee_id = emp.id
INNER JOIN departments AS dp
ON emp.department_id = dp.id
WHERE dp.id = 2;


-- classesテーブルのidが、5よりも小さいレコードとそれ以外のレコードを履修している生徒の数を計算してください。
-- classesテーブルのidとenrollmentsテーブルのclass_id、enrollmentsテーブルのstudent_idとstudents.idが紐づく
-- classesにはクラス名が格納されていて、studentsと多対多で結合される

SELECT
CASE
    WHEN cl.id < 5 THEN "class1"
    ELSE "class2"
END AS "class",
COUNT(st.id)
FROM students AS st
INNER JOIN enrollments AS en
ON st.id = en.student_id
INNER JOIN classes AS cl
ON en.class_id = cl.id
GROUP BY
CASE
    WHEN cl.id < 5 THEN "class1"
    ELSE "class2"
END;



-- ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算してください。
-- employeesテーブルのidとsalariesテーブルのemployee_idが紐づけでき、salariesテーブルのpaymentに月収が格納されています

SELECT
emp.id,
emp.first_name,
emp.last_name,
SUM(sa.payment),
AVG(sa.payment)
FROM salaries AS sa
INNER JOIN employees AS emp
ON sa.employee_id = emp.id
INNER JOIN departments AS dp
ON emp.department_id = dp.id
WHERE age < 40
GROUP BY emp.id
HAVING AVG(payment) > 7000000;


-- customer毎に、order_amountの合計値を計算してください。
-- customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができ
-- ordersテーブルのorder_amountの合計値を取得します。
-- SELECTの対象カラムに副問い合わせを用いて値を取得してください。


SELECT
*,
(SELECT SUM(order_amount) FROM orders AS od WHERE od.customer_id = cst.id) AS sum_payment
FROM customers AS cst;


-- customersテーブルからlast_nameに田がつくレコード、
-- ordersテーブルからorder_dateが2020-12-01以上のレコード、
-- storesテーブルからnameが山田商店のレコード同士を連結します
-- customersとorders, ordersとitems, itemsとstoresが紐づきます。
-- first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。

SELECT
    CONCAT(cs.last_name, cs.first_name) AS full_name,
    COUNT(*)
FROM
    (SELECT * FROM customers WHERE last_name LIKE "%田%") AS cs
INNER JOIN (SELECT * FROM orders WHERE order_date > "2020-12-01") AS od
ON cs.id = od.customer_id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN (SELECT * FROM stores WHERE name = "山田商店") AS st
ON it.store_id = st.id
GROUP BY CONCAT(cs.last_name, cs.first_name);



-- salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
-- employeesテーブルとsalariesテーブルを紐づけます。
-- EXISTSとINとINNER JOIN、それぞれの方法で記載してください


SELECT * FROM employees AS emp
WHERE EXISTS(SELECT * FROM salaries AS sa WHERE emp.id = sa.employee_id AND payment > 9000000);

SELECT * FROM employees
WHERE id IN (SELECT employee_id FROM salaries WHERE payment > 9000000);

SELECT DISTINCT emp.* FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id
WHERE payment > 9000000;


-- employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
-- EXISTSとINとLEFT JOIN、それぞれの方法で記載してください


SELECT * FROM employees AS emp
WHERE NOT EXISTS(
    SELECT id FROM salaries AS sa
    WHERE emp.id = sa.employee_id);

SELECT * FROM employees AS emp
WHERE id NOT IN (
    SELECT employee_id FROM salaries
);

SELECT emp.* FROM employees AS emp
LEFT JOIN salaries AS sa
ON emp.id = sa.employee_id
WHERE sa.id IS NULL; 



-- employeesテーブルとcustomersテーブルのage同士を比較します
-- customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
-- employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
-- 平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
-- WITH句を用いて記述します


WITH tmp_customers AS(
SELECT
MIN(age) AS min_age,
AVG(age) AS avg_age,
MAX(age) AS max_age
FROM customers
)
SELECT
*,
CASE
    WHEN emp.age < tmp_customers.min_age  THEN "最小未満"
    WHEN emp.age < tmp_customers.avg_age  THEN "平均未満"
    WHEN emp.age < tmp_customers.max_age  THEN "最大未満"
    ELSE "その他"
END AS "比較結果"
FROM employees AS emp
CROSS JOIN tmp_customers;


-- customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
-- customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
-- 合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
-- 7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。


WITH tmp_customers AS(
  SELECT * FROM customers WHERE age > 50
), tmp_customers_orders AS(
    SELECT
        tc.id, od.order_date, SUM(od.order_amount * od.order_price) AS payment,
    ROW_NUMBER() OVER(PARTITION BY tc.id ORDER BY od.order_date) AS row_num
    FROM tmp_customers AS tc
    INNER JOIN orders AS od
    ON tc.id = od.customer_id
    GROUP BY tc.id, od.order_date
)
SELECT id, order_date, payment,
CASE 
    WHEN row_num < 7 THEN ""
    ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
END AS "7日間平均",
CASE
    WHEN row_num < 15 THEN ""
    ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW)
END AS "15日間平均",
CASE
    WHEN row_num < 30 THEN ""
    ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW)
END AS "30日間平均"
FROM tmp_customers_orders LIMIT 20;


