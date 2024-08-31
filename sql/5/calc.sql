--  算術演算子

SELECT 1 + 1;

SELECT name, age, age+3 AS age_3 FROM users LIMIT 10;

SELECT 10 - 5;

SELECT age-1 AS age_1 FROM users;

SELECT birth_day, birth_day+3 FROM users;

SELECT 3*5;

SELECT * FROM employees LIMIT 3;

SELECT department, name, salary*1.1 AS salary_next_year FROM employees LIMIT 3;

SELECT 10/3;

SELECT salary / 10 FROM employees;

SELECT 10 % 3;

SELECT age % 12 FROM users;

