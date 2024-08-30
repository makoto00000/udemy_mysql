-- IS NULL でないと取り出せない
SELECT * FROM customers WHERE name IS NULL;

SELECT NULL=NULL; -- -> NULL
SELECT NULL IS NULL; -- -> 1 (TRUE)

-- 比較演算子では、NULLと比較した段階でunknownになるため比較ができない。（whereは評価結果がTRUEでないと絞り込めない）
-- 一方IS句は、unknown同士を比較するとTRUEを返すため、WHERE句などで用いることができる。

-- NULL OR true、true OR NULLの場合は、trueになる。
-- NULL AND false、false AND NULLの場合は、falseになる。

-- （boolenがtrue、false、NULLの３つあるイメージ）

-- IS NOT NULL 
SELECT * FROM customers WHERE name IS NOT NULL;

-- NULLを取り出す（空白は取り出せない）
SELECT * FROM prefectures WHERE name IS NULL;

-- NULLではなく空白
SELECT * FROM prefectures WHERE name = '';


-- IN + NULL

-- nameがNULLの人
SELECT * FROM customers WHERE name IS NULL;

-- nameがINのいずれか、またはNULLの人
SELECT * FROM customers WHERE name IN ("河野 文典", "稲田 季雄") OR name IS NULL;


-- NOT IN
-- NOT IN → name != "河野 文典" name != "稲田 季雄" name != NULL

-- NG例
SELECT * FROM customers WHERE name NOT IN ("河野 文典", "稲田 季雄", NULL);
-- OK例
SELECT * FROM customers WHERE name NOT IN ("河野 文典", "稲田 季雄") AND name IS NOT NULL;


-- ALL

-- customersテーブルからid<10の人の誕生日よりも古い誕生日の人をusersから取り出すSQL

-- birth_dayにNULLのレコードがあるため、ALLの中がNULLになってしまい、取り出せない
SELECT * FROM users WHERE birth_day <= ALL(SELECT birth_day FROM customers WHERE id < 10 AND birth_day)

-- NULLを弾くようにする
SELECT * FROM users WHERE birth_day <= ALL(SELECT birth_day FROM customers WHERE id < 10 AND birth_day IS NOT NULL)

-- ALL, INの場合はNULLには気を付ける

-- ALLの中にNULLがあると、結果がNULLになる（AND演算子が用いられ、NULLが優先されるので）