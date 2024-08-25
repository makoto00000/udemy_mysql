USE my_sb;
-- ALTER TABLE people ADD age INT AFTER name;

-- INSERT INTO people VALUES(1, "John", 18,  "2001-01-01");
-- INSERT INTO people VALUES(2, "Alice", 15,  "2003-01-01");
-- INSERT INTO people VALUES(3, "Paul", 19,  "2000-01-01");
-- INSERT INTO people VALUES(4, "Chris", 17,  "2001-01-01");
-- INSERT INTO people VALUES(5, "Vette", 20,  "2001-01-01");
-- INSERT INTO people VALUES(6, "Tsuyoshi", 21,  "2001-01-01");

-- SELECT * FROM people;

-- DISTINCT 指定したカラムから、重複を削除して表示する
SELECT DISTINCT birth_day FROM people ORDER BY birth_day;

-- +------------+
-- | birth_day  |
-- +------------+
-- | 2000-01-01 |
-- | 2001-01-01 |
-- | 2003-01-01 |
-- +------------+

-- ORDER BY 特定のカラムで昇順・降順に並び替える
-- SELECT * FROM people ORDER BY age;
-- SELECT * FROM people ORDER BY age DESC;

  -- 誕生日で昇順、名前で降順、年齢で昇順
-- SELECT * FROM people ORDER BY birth_day, name DESC, age;

-- LIMUT, OFFSET 指定した行数だけ取り出す, 指定した行数だけ飛ばして取り出す

SELECT id, name, age FROM people LIMIT 3;

-- 飛ばして表示(3飛ばし2表示)
SELECT * FROM people LIMIT 3, 2;

-- 飛ばして表示(2飛ばし4表示)
SELECT * FROM people LIMIT 4 OFFSET 2;