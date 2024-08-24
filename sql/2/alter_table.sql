USE my_db;

-- テーブル名の変更
ALTER TABLE users RENAME TO users_table;

-- カラムの削除
ALTER TABLE users DROP COLUMN message;

-- カラムの追加 （場所を指定しないと一番下に追加）
ALTER TABLE users_table
ADD post_code CHAR(8);

-- カラムの追加 （指定したカラムの後）
ALTER TABLE users_table
ADD gender CHAR(1) AFTER age;

-- カラムの追加 （一番最初に追加）
-- ALTER TABLE users_table
-- ADD new_id INT(1) FIRST;

-- カラムの定義変更
ALTER TABLE users_table MODIFY name VARCHAR(50);

-- カラムの名前変更
-- ALTER TABLE users_table CHANGE COLUMN NEW_name VARCHAR(50);

-- カラムの並びを変更
ALTER TABLE users_rable CHANGE COLUMN gender gender CHAR(1) AFTER post_code;

-- 主キーの削除
-- ALTER TABLE users_table DROP PRIMARY KEY;

DESCRIBE users_table;
