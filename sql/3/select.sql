SHOW TABLES;

# 全レコード、全カラム
SELECT * FROM people;

# カラム一部
SELECT name, id, birth_day, name FROM people;

SELECT id AS "番号", name AS "名前" FROM people;

# WHERE句
SELECT * FROM people WHERE name="Jiro";
