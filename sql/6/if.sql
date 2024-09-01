-- IF(条件式, 真の値, 偽の値)

SELECT IF(10>20, "A", "B");

SELECT * FROM users;

-- birth_placeが日本なら日本人、そうでないならその他と表示する
SELECT *, IF(birth_place="日本", "日本人", "その他") AS "国籍" FROM users LIMIT 3;

SELECT name, age, IF(age<20, "未成年", "成人") FROM users;

SELECT *, IF(class_no=6 AND height > 170, "6組の170cm以上の人", "その他") AS "分類" FROM students;

-- LIKE句と組み合わせる
SELECT name, IF(name LIKE "%田%", "名前に田を含む", "その他") AS name_check FROM users;