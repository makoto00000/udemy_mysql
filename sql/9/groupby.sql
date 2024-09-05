-- GROUP BY

-- 日本の各年齢ごとのデータ数を取得
SELECT age, COUNT(*), MAX(birth_day), MIN(birth_day) FROM users
WHERE birth_place="日本"
GROUP BY age
ORDER BY age;

40歳以上の人の部署ごとの給与情報を表示
SELECT department, SUM(salary), FLOOR(AVG(salary)), MIN(salary) FROM employees
WHERE age > 40
GROUP BY department;


-- 日本人とその他にグループ分けをして、それぞれのデータ数と最年長の年齢を取得
SELECT 
  CASE
    WHEN birth_place="日本" THEN "日本人"
    ELSE "その他"
  END,
  COUNT(*),
  MAX(age)
FROM
  users
GROUP BY
  CASE
    WHEN birth_place="日本" THEN "日本人"
    ELSE "その他"
  END;


-- 四国かその他でグループ分けして、それぞれのデータ数を取得する 
SELECT 
CASE
  WHEN name IN ("香川県", "高知県", "愛媛県", "徳島県") THEN "四国"
  ELSE "その他"
  END AS "地域名",
  COUNT(*)
FROM prefectures
GROUP BY
CASE
  WHEN name IN ("香川県", "高知県", "愛媛県", "徳島県") THEN "四国"
  ELSE "その他"
END;


-- ageごとにグループ分けして、年齢が20未満かどうかで未成年か成人か分類名を表示しつつ、データ数を表示する。

SELECT 
  age,
  CASE
    WHEN age < 20 THEN "未成年"
    ELSE "成人"
  END AS "分類",
  COUNT(*)
FROM users
GROUP BY age;
