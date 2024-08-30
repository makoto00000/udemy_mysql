-- IN

-- ageが12か24か36の人
SELECT * FROM users WHERE age IN(12, 24, 36);

-- birth_placeが"France", "Germany", "Italy"のいずれでもない人
SELECT * FROM users WHERE birth_place NOT IN("France", "Germany", "Italy");


-- SELECT + IN

-- receiptsテーブルからcustomer_idを取り出して、そのcustomer_idとidが一致するレコードをcustomersテーブルから習得
SELECT * FROM customers WHERE id  IN (SELECT customer_id FROM receipts);

-- receiptsテーブルから10未満のcustomer_idを取り出して、そのcustomer_idとidが一致しないレコードをcustomersテーブルから習得（customer_idが1~9と、receiptsテーブルにcustomer_idが存在しない人を取得）
SELECT * FROM customers WHERE id  NOT IN (SELECT customer_id FROM receipts WHERE id<10);


-- ALL, ANY

-- salaryが5000000より大きい人のいずれよりも大きい人（一番大きい人より大きい人）
SELECT * FROM users WHERE age > ALL(SELECT age FROM employees WHERE salary > 5000000);

-- salaryが5000000より大きい人
SELECT * FROM users WHERE age > ANY(SELECT age FROM employees WHERE salary > 5000000);
SELECT * FROM users WHERE age = ANY(SELECT age FROM employees WHERE salary > 5000000);


-- AND, OR

SELECT * FROM employees;

SELECT * FROM employees WHERE department = " 営業部 " AND name LIKE "%田%"

SELECT * FROM employees WHERE department = " 営業部 " AND name LIKE "%田%" AND age < 35

SELECT * FROM employees WHERE department = " 営業部 " AND (name LIKE "%田%"  OR name LIKE "%西%")AND age < 35

-- 以下２つは同じ意味
SELECT * FROM employees WHERE department = " 営業部 " OR department  = " 開発部 ";
SELECT * FROM employees WHERE department IN (" 営業部 ", " 開発部 ");

-- NOT
SELECT * FROM employees WHERE NOT department = " 営業部 "
