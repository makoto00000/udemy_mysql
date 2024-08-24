-- STUDENTSテーブルの作成
CREATE TABLE students(
  id INT PRIMARY KEY,
  name CHAR(10)
);

INSERT INTO students VALUES(1, "ABCDEF ");
SELECT * FROM students;

-- CHAR型からVARCHAR型に変更
ALTER TABLE students MODIFY name VARCHAR(10);

INSERT INTO students VALUES(2, "ABCDEF ");
SELECT * FROM students;

SELECT name, CHAR_LENGTH(name) FROM students;


-- CHAR型（固定長文字列）
-- 指定されたbyteによって、あらかじめディスクの領域が確保される
-- パフォーマンスは良いが、ディスク使用量は多くなる
-- 末尾のスペースが削除される
-- データの長さがある程度固定されていて、変化が少ない場合に用いる（電話番号、銀行コード）

-- VARCHAR（可変長文字列）
-- byteに応じて、ディスク領域を確保する
-- ディスク使用量は節約できるが、パフォーマンスは悪い
-- 末尾のスペースが削除されない
-- データの長さが、格納するデータに応じて大きく変わる場合に用いる（住所、テキスト）