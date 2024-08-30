-- LIKE, NOT LIKE 
-- していしたパターンに一致するか

SELECT * FROM users WHERE name LIKE "村%"; -- 前方一致

SELECT * FROM users WHERE name LIKE "%郎"; -- 後方一致

SELECT * FROM users WHERE name LIKE "%ed%"; -- 中間一致（大文字小文字は区別しない）

SELECT * FROM prefectures WHERE name LIKE "_岡_%" ORDER BY name; -- _は任意の一文字

-- +----+-----------+
-- | id | name      |
-- +----+-----------+
-- | 40 | 福岡県    |
-- | 22 | 静岡県    |
-- +----+-----------+