-- LENGTH, CHAR_LENGTH

SELECT LENGTH("ABC"); -- 3 byte
SELECT LENGTH("あいう"); -- 9 byte
SELECT name, LENGTH(name) FROM users;

SELECT CHAR_LENGTH("ABC"); -- 3文字
SELECT CHAR_LENGTH("あいう") AS length; -- 3文字
SELECT name, CHAR_LENGTH(name) FROM users LIMIT 3;

-- TRIM, LTRIM, RTRIM 空白削除

SELECT LTRIM(" A B C "); -- 先頭の空白削除
SELECT RTRIM(" A B C "); -- 最後のの空白削除
SELECT TRIM(" A B C "); -- 両側の空白を削除

-- nameの文字数と、nameから空白を削除した文字数が異なるレコードを取得
-- （nameに空白が入っているユーザーを取得）
SELECT * FROM employees WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));

-- UPDATEして空白を削除したものにする
UPDATE employees
SET name=TRIM(name)
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));
