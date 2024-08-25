USE my_db;

-- CREATE TABLE people(
--   id INT PRIMARY KEY,
--   name VARCHAR(50),
--   birth_day DATE DEFAULT "1990-01-01"
-- );

-- 基本の書き方
-- INSERT INTO people VALUES(1, "Taro", "2001-01-01");

-- カラムを指定（指定しなかったものはDEFAULT設定があればそれが入る）
-- INSERT INTO people(id, name) VALUES(2, "Jiro");

-- 文字列はシングルクォートでも可
INSERT INTO people(id, name) VALUES(3, 'Saburo');

-- シングルクォートの中にシングルクォートを入れるときは２つ重ねる
INSERT INTO people VALUES(4, 'John''s son', '2021-01-01');

-- ダブルクォートは入れても問題ない
INSERT INTO people VALUES(5, 'John"s son', '2021-01-01');

-- ダブルクォートの中にダブルクォートを入れる場合は２つ重ねる
INSERT INTO people VALUES(6, "John""s son", '2021-01-01');

SELECT * FROM people;

-- +----+------------+------------+
-- | id | name       | birth_day  |
-- +----+------------+------------+
-- |  1 | Taro       | 2001-01-01 |
-- |  2 | Jiro       | 1990-01-01 |
-- |  3 | Saburo     | 1990-01-01 |
-- |  4 | John's son | 2021-01-01 |
-- |  5 | John"s son | 2021-01-01 |
-- |  6 | John"s son | 2021-01-01 |
-- +----+------------+------------+