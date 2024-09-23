
-- CREATE TABLE students(
--   id INT PRIMARY KEY,
--   name VARCHAR(255),
--   age INT,
--   school_id INT,
--   FOREIGN KEY(school_id) REFERENCES schools(id)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );



-- schoolsテーブルのid1のレコードと紐づいている。
-- INSERT INTO students VALUES(1, "Taro", 18, 1);

-- schoolsテーブルのidの値が変わると、studentsテーブルのschool_idも強制的に変更される。
-- UPDATE schools SET id=3 WHERE id=1;


-- 紐づいた先（schools）が消えると、studentsも消える。
DELETE FROM schools WHERE id = 3;


-- ON UPDATE, ON DELETEの設定一覧
-- CASCADE: 参照元が削除/更新されると、それに依存する行も削除/更新される。
-- SET NULL: 参照元が削除/更新されると、外部キーの値が NULL になる。
-- RESTRICT: 参照元の行が削除/更新されるのを防ぐ。
-- SET DEFAULT: 参照元の削除/更新されるとデフォルトの値が設定される。

-- ※ SET DEFAULTは MySQL パーサーによって認識されますが、InnoDB と NDB はどちらも、ON DELETE SET DEFAULT または ON UPDATE SET DEFAULT 句を含むテーブル定義を拒否します。