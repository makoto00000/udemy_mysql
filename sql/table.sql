USE my_db;

-- テーブルの作成
CREATE TABLE users(
  id INT PRIMARY KEY,
  name VARCHAR(10), -- 可変長文字列
  age INT,
  phone_number CHAR(13), -- 固定長
  message TEXT
);

-- テーブル一覧表示
SHOW TABLES;

-- テーブルのカラム一覧表示
DESCRIBE users;

-- テーブルの削除
-- DROP TABLE users;
