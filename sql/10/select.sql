-- SELECTで取得した結果を新しく作成したTABLEにデータとして挿入する。
-- このとき、PRIMARY KEYの設定はつかない。

CREATE TABLE tmp_students
SELECT * FROM students WHERE id < 10;

SELECT * FROM tmp_students;
DESCRIBE tmp_students;

DROP TABLE tmp_students;


-- INSERT INTO

INSERT INTO tmp_students
SELECT id+9, first_name, last_name, 2 AS grade FROM users;

SELECT * FROM tmp_students;


-- UNION

-- students, employees, customersテーブルから名前を取得して、namesテーブルを作成して、データを入れる。

CREATE TABLE names
SELECT first_name, last_name FROM students
UNION
SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;

SELECT * FROM names;