-- INNNER JOIN
SELECT * FROM employees AS emp
INNER JOIN departments AS dt
ON emp.department_id = dt.id;

-- 特定のカラムだけ取り出す
SELECT emp.id, emp.first_name, emp.last_name, dt.id AS department_id, dt.name AS department_name FROM employees AS emp
INNER JOIN departments AS dt
ON emp.department_id = dt.id;

-- 複数の条件で紐付ける
SELECT * FROM students AS student_id
INNER JOIN
users AS usr
ON std.first_name = usr.first_name AND std.last_name = usr.last_name;

-- =以外で紐付ける（emp.idよりもstd.idが大きいレコードを全て紐付ける（1対多））
SELECT * FROM employees AS emp
INNER JOIN
  students AS std
ON emp.id < std.id LIMIT 100;