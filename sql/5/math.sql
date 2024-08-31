-- ROUND, FLOOR, CEILING

SELECT ROUND(3.14, 1); -- 小数点1桁まで（小数点2桁目を四捨五入）

SELECT FLOOR(3.14); -- 小数点以下を切り捨て

SELECT CEILING(3.14); -- 小数点以下を切り上げ


-- RAND 乱数
SELECT RAND(); -- 0<,  <1の少数をランダムで返す
SELECT FLOOR(RAND() * 10); -- 0~10


-- POWER 累乗
SELECT POWER(3, 4); -- 3の4乗
SELECT name, weight / POWER(height/100, 2) AS BMI FROM students LIMIT 3;


-- COALESCE 最初に登場するNULLでない値を返す

SELECT * FROM tests_score LIMIT 3;

SELECT COALESCE(NULL, NULL, NULL, "A", NULL, "B"); -- A

SELECT COALESCE(test_score_1, test_score_2, test_score_3) AS score
FROM tests_score LIMIT 10;