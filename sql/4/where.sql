-- = で絞り込む
SELECT * FROM users WHERE name = "奥村 成美";

SELECT * FROM users WHERE birth_place="日本";

-- FROM → WHERE（<>は≒） → ORDER BY → LIMITの順で実行される
SELECT * FROM users WHERE birth_place<>"日本" ORDER BY age LIMIT 10;

-- <, >, <=, >=, <>
SELECT * FROM users WHERE age<=50 LIMIT 10

-- 日付の取り出し
SELECT * FROM users WHERE birth_day < "2011-04-03";

-- tinyint 1 or 0
SELECT * FROM users WHERE is_admin=0;


-- UPDATE
UPDATE users SET name="奥山 成美" WHERE id=1;

SELECT * FROM users WHERE id=1;


-- DELETE

SELECT * FROM users ORDER BY id DESC LIMIT 1;

DELETE FROM users WHERE id>190;