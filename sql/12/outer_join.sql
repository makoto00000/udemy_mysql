-- LEFT JOIN（departments.idがNULLの場合もemployeesのレコードは取得する
SELECT * FROM employees AS emp
LEFT JOIN departments AS dt
ON emp.department_id = dt.id;

-- COALESCE（引数からNULLでない最初の値を返す->dt.idがNULLでなければdt.idを、NULLなら該当なしを返す）
SELECT emp.id, emp.first_name, emp.last_name, COALESCE(dt.id, "該当なし") AS department_id, dt.name AS department_name FROM employees AS emp
LEFT JOIN departments AS dt
ON emp.department_id = dt.id;

-- enrollmentsを中間テーブルとしてLEFT JOIN
SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN classes AS cs
ON enr.class_id = cs.id;

-- RIGHT JOIN（左側のレコードが存在しない場合はNULLになる）
SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN classes AS cs
ON enr.class_id = cs.id;

-- FULL JOIN（MysqlではできないがLEFT JOINとRIGHT JOINを組み合わせれば実現できる）
SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN classes AS cs
ON enr.class_id = cs.id
UNION
SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN classes AS cs
ON enr.class_id = cs.id;
