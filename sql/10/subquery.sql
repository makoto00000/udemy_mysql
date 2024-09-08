-- 副問合せ

-- 1. INで利用する

-- 経営企画部と営業部のidを取得して、employeesテーブルのdepartment_idがそれに一致するものを取得する。
SELECT * FROM employees WHERE department_id IN
(SELECT id FROM departments WHERE name IN("経営企画部", "営業部")
);

-- 2. WHEREで利用する

-- usersテーブルのfirst_name, last_name一覧に一致する、studentsテーブルのfirst_name, last_nameを取得する。
SELECT first_name, last_name FROM students
WHERE (first_name, last_name) IN (
  SELECT first_name, last_name FROM users
);

--  3. 集計関数と使う

-- employeesテーブルのageが最大の人のレコードを取得する
SELECT * FROM employees WHERE age = (SELECT MAX(age) FROM employees);

-- 4. FROMの取得先に用いる

-- 部署ごとの平均年齢の最大、最小
SELECT
MAX(avg_age) AS "部署平均年齢の最大",
MIN(avg_age) AS "部署平均年齢の最小"
FROM
(SELECT department_id, AVG(age) AS avg_age FROM employees GROUP BY department_id) AS tmp_emp;


-- 年代ごとの人数をカウントして、その最大数と最小数を取得する。
SELECT
  age_group * 10,
  MAX(age_count),
  MIN(age_count)
FROM
(SELECT FLOOR(age/10) AS age_group, COUNT(*) AS age_count FROM employees GROUP BY FLOOR(age/10)) AS age_summary GROUP BY age_group;


-- customersテーブルのidに一致するordersテーブルから、注文日が最新、最古の日付、これまでの全ての支払額を取得する。
SELECT
  cs.id,
  cs.first_name,
  cs.last_name,
  (
    SELECT MAX(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id
  ) AS "最近の注文日",
  (
    SELECT MIN(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id
  ) AS "古い注文日",
  (
    SELECT SUM(order_amount * order_price) FROM orders AS tmp_order WHERE cs.id = tmp_order.customer_id
  ) AS "全支払い金額"
FROM customers AS cs;


-- CASEと使う

-- departmentテーブルから経営企画部のidを取得して、employeesテーブルのdepartment_idが取得した値(1)だったら経営層と表示、それ以外はその他と表示する役割カラムを追加する。
SELECT
  emp.*,
  CASE
    WHEN emp.department_id = (SELECT id FROM departments WHERE name = "経営企画部") THEN "経営層"
    ELSE "その他"
  END AS "役割"
FROM employees AS emp;


-- paymentがpaymentの平均より多い人のidをsalariesから取得して、そのidの人の場合はoを付ける「給料がへいきんより高いか」カラムを追加する。
SELECT
  emp.*,
  CASE
    WHEN emp.id IN(
      SELECT DISTINCT employee_id FROM salaries WHERE payment > (SELECT AVG(payment) FROM salaries)) THEN "o"
    ELSE "x"
  END AS "給料が平均より高いか"
FROM employees AS emp;