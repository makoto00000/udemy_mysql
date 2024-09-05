-- SUM（合計値） 数値型のみ
SELECT SUM(salary) FROM employees;

-- MIN（最小値） 文字列型-昇順で最初のデータ 日付-最も古い日付
-- MAX（最大値） 文字列型-昇順で最後のデータ 日付-最も新しい日付
SELECT MAX(age), MIN(age) FROM users WHERE birth_place="日本";

-- AVG（平均値） 数値型のみ
SELECT AVG(salary) FROM employees;

-- NULLは無視される。NULLを0として扱いたいとき
-- AVG(COALESCE(num, 0))とする。


-- COUNT（行数）

-- 何行データが入っているか 
SELECT COUNT(*) FROM customers;

-- この列にNULL以外のデータが何行入っているか
SELECT COUNT(name) FROM customers;

SELECT COUNT(name) FROM customers WHERE id > 80;


-- NULLの扱いについて
-- SUM, MIN, MAX, AVGはNULLは無視。全行NULLだった場合はNULLになる。
-- COUNTはカラムを指定した場合、NULLは無視、全行NULLなら0。*指定した場合、NULLを含んでカウント、全行NULLなら全行数をカウントする。