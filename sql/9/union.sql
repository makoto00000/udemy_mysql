-- UNION 和集合（重複はまとめる）

-- studentsとnew_students
SELECT * FROM new_students
UNION
SELECT * FROM students
ORDER BY id;

-- UNION ALL 和集合（重複は重複したまま）
-- UNIONに比べて処理が早いので理由がなければこっちを使う方が良い
SELECT * FROM new_students
UNION ALL
SELECT * FROM students
ORDER BY id;

-- WHEREと組み合わせる
SELECT * FROM students WHERE id < 10
UNION
SELECT * FROM new_students WHERE id > 250;

-- カラムの型が同じならUNIONできる
SELECT id, name FROM students WHERE id < 10
UNION
SELECT age, name FROM users WHERE id < 10
ORDER BY id; -- １つ目のカラムを指定する！


-- 選択するカラムの数を合わせる（以下はエラーになる）
SELECT id, name, height FROM students
UNION
SELECT age, name FROM users;


-- EXCEPT 差集合（１から２を差し引いたもの →1にしか存在しないデータを取得できる）

-- new_studentsにしか存在しないデータ
SELECT * FROM new_students
EXCEPT
SELECT * FROM students;

-- studentsにしか存在しないデータ
SELECT * FROM students
EXCEPT
SELECT * FROM new_students;

-- 重複していないデータを全て取り出す（NOT INTERCECT）
(SELECT * FROM new_students
EXCEPT
SELECT * FROM students)
UNION ALL
(SELECT * FROM students
EXCEPT
SELECT * FROM new_students)
ORDER BY id;


-- INTERSECT 積集合（両方に存在するものを取り出す）
-- カラム数は同じにする
SELECT * FROM new_students
INTERSECT
SELECT * FROM students;
