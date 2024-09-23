-- NOT NULL制約

-- CREATE DATABASE day15_18_db;
-- USE day15_18_db;

-- CREATE TABLE users(
--   id INT PRIMARY KEY,
--   first_name VARCHAR(255),
--   last_name VARCHAR(255) DEFAULT '' NOT NULL
-- );

-- INSERT INTO users(id) VALUES(1);

-- SELECT * FROM users;

-- CREATE TABLE users_2(
--   id INT PRIMARY KEY,
--   first_name VARCHAR(255),
--   last_name VARCHAR(255) NOT NULL,
--   age INT DEFAULT 0
-- );

-- INSERT INTO users_2(id, first_name) VALUES (1, "Taro");
-- ERROR 1364 (HY000): Field 'last_name' doesn't have a default value


-- CREATE TABLE login_users(
--   id INT PRIMARY KEY,
--   name VARCHAR(255) NOT NULL,
--   email VARCHAR(255) NOT NULL UNIQUE
-- );

-- INSERT INTO login_users VALUE(1, "Shingo", "abc@mail.com");
-- INSERT INTO login_users VALUE(2, "Shingo", "abc@mail.com");
-- ERROR 1062 (23000): Duplicate entry 'abc@mail.com' for key 'login_users.email'


-- CREATE TABLE tmp_names(
--   name VARCHAR(255) UNIQUE
-- );

-- INSERT INTO tmp_names VALUE(NULL);
-- INSERT INTO tmp_names VALUE(NULL);
-- NULLは重複とはみなされないためUNIQUE制約をつけてもデータを格納できる。（DB2やSQL ServerではNULLは重複とみなされる）


-- CHECK制約

-- CREATE TABLE customers(
--   id INT PRIMARY KEY,
--   name VARCHAR(255),
--   age INT CHECK(age >= 20)
-- );

-- INSERT INTO customers VALUES(1, "Taro", 21);
-- INSERT INTO customers VALUES(1, "Jiro", 19);
-- ERROR 3819 (HY000): Check constraint 'customers_chk_1' is violated.



-- 複数のカラムに対するCHECK制約

-- CREATE TABLE students(
--   id INT PRIMARY KEY,
--   name VARCHAR(255),
--   age INT,
--   gender CHAR(1),
--   CONSTRAINT chk_students CHECK((age >= 15 AND age <= 20) AND (gender = "F" OR gender = "M"))
-- );

-- INSERT INTO students VALUES(1, "Taro", 18, "M");

-- INSERT INTO students VALUES(2, "Jiro", 18, "U");
-- INSERT INTO students VALUES(2, "Jiro", 21, "F");
-- ERROR 3819 (HY000): Check constraint 'chk_students' is violated.


-- PRIMARY KEY
-- NOT NULL制約、UNIQUE制約、INDEXが付与される

-- 複数のPRIMARY KEYを設定した場合
-- CREATE TABLE employees(
--   company_id INT,
--   employee_code CHAR(8),
--   name VARCHAR(255),
--   age INT,
--   PRIMARY KEY (company_id, employee_code)
-- );

-- company_id、employee_codeそれぞれの重複は許されるが、両方が重複することは許されない。NULLはどちらも許されない。

-- INSERT INTO employees VALUES
-- (1, "00000001", "Taro", 19);
-- INSERT INTO employees VALUES
-- (NULL, "00000001", "Taro", 19);
-- ERROR 1048 (23000): Column 'company_id' cannot be null
INSERT INTO employees VALUES
(1, "00000002", "Taro", 19);
-- company_idは重複しているが、employee_codeが異なるため（組み合わせが一意のため）エラーにならない。



-- UNIQUEを複数のカラムに設定する
CREATE TABLE tmp_employees (
  company_id INT,
  employee_code CHAR(8),
  name VARCHAR(255),
  UNIQUE (company_id, employee_code)
)

-- ２つの組み合わせが重複することはできない。（それぞれが重複するのはOK）