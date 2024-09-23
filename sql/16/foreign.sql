-- USE day15_18_db;

-- DROP TABLE students;

-- CREATE TABLE schools(
--   id INT PRIMARY KEY,
--   name VARCHAR(255)
-- );

-- CREATE TABLE students(
--   id INT PRIMARY KEY,
--   name VARCHAR(255),
--   age INT,
--   school_id INT,
--   FOREIGN KEY(school_id) REFERENCES schools(id)
-- );


-- 参照整合性エラー
-- INSERT INTO students VALUES(1, "Taro", 18, 1);
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`day15_18_db`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`))


-- 成功
-- INSERT INTO schools VALUES(1, "北高校");
-- INSERT INTO students VALUES(1, "Taro", 18, 1);


-- 参照整合性エラー
-- UPDATE schools SET id=2;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`day15_18_db`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`))


-- 参照整合性エラー
-- DELETE FROM schools;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`day15_18_db`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`))


-- CREATE TABLE salaries(
--   id INT PRIMARY KEY,
--   company_id INT,
--   employee_code CHAR(8),
--   payment INT,
--   paid_date DATE,
--   FOREIGN KEY (company_id, employee_code) REFERENCES employees(company_id, employee_code)
-- );

-- employeesテーブル
-- +------------+---------------+------+------+
-- | company_id | employee_code | name | age  |
-- +------------+---------------+------+------+
-- |          1 | 00000001      | Taro |   19 |
-- |          1 | 00000002      | Taro |   19 |
-- +------------+---------------+------+------+

-- 参照整合性エラー
INSERT INTO salaries VALUES(1, 1, "00000003", 1000, "2020-01-01");
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`day15_18_db`.`salaries`, CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`company_id`, `employee_code`) REFERENCES `employees` (`company_id`, `employee_code`))
-- employeesテーブルにemployee_codeが00000003のデータがないため


-- 成功
INSERT INTO salaries VALUES(1, 1, "00000001", 1000, "2020-01-01");