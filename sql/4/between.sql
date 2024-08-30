-- BETWEEN, NOT BETWEEN
-- 指定したパターンに一致するか

-- ageが5以上、10以下
SELECT * FROM users WHERE age BETWEEN 5 AND 10;

-- ageが5より小さいか、10より大きい（5,10は含まない）
SELECT * FROM users WHERE age NOT BETWEEN 5 AND 10;