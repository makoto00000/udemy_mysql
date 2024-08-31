-- REPLACE
SELECT REPLACE("I like an apple", "apple", "lemon");

-- 名前がMrsで始まる人を取得し、Msに置換する
SELECT REPLACE(name, "Mrs", "Ms") FROM users WHERE name LIKE 'Mrs%';
-- 取得してUPDATEする
-- UPDATE users SET name=REPLACE(name, "Mrs", "Ms") WHERE name LIKE 'Mrs%';

-- UPPER, LOWER(大文字、小文字)

SELECT UPPER("apple");
SELECT LOWER("APPLE");

SELECT name, UPPER(name), LOWER(name) FROM users LIMIT 3;


-- SUBSTRING, SUBSTR 一部取り出し（どちらも同じ使い方）

-- nameの2文字目から3文字を切り取る
SELECT SUBSTRING(name, 2, 3), name FROM employees LIMIT 3;

-- nameの2文字目から1文字切り取ってそれが「田」である人を取得
SELECT * FROM employees WHERE SUBSTR(name, 2, 1) = "田";


-- REVERSE 逆順

SELECT REVERSE(name), name FROM employees LIMIT 3;