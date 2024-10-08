SELECT
  *,
  CASE birth_place
    WHEN "日本" THEN "日本人"
    WHEN "Iraq" THEN "イラク人"
    ELSE "外国人"
  END AS "国籍"
FROM users;

SELECT 
  name,
  CASE
    WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN "近畿"
    ELSE "その他"
  END AS "地域名"
FROM prefectures;

-- 計算
SELECT
  name,
  birth_day,
  CASE
    WHEN DATE_FORMAT(birth_day, "%Y") % 4 = 0 AND DATE_FORMAT(birth_day, "%Y") % 100 <> 0 THEN "うるう年"
    ELSE "うるう年でない"
  END AS "うるう年か"
FROM users;

-- student_idを3で割ったときのあまりによって表示するスコアを変える
SELECT
  *,
  CASE
    WHEN student_id % 3 = 0 THEN test_score_1
    WHEN student_id % 3 = 1 THEN test_score_2
    WHEN student_id % 3 = 2 THEN test_score_3
  END AS score
FROM tests_score;


-- ORDER BY（条件に基づいた複雑な並び替え）

SELECT *,
CASE
  WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
  WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN "近畿"
  ELSE "その他"
END AS "地方"
FROM prefectures
ORDER BY
CASE
  WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN 0
  WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN 1
  ELSE 2
END;

-- UPDATE

-- birth_eraカラムを追加する
-- ALTER TABLE users ADD birth_era VARCHAR(2) AFTER birth_day;

-- SELECT *,
-- CASE
--   WHEN birth_day < "1989-01-07" THEN "昭和"
--   WHEN birth_day < "2019-05-01" THEN "平成"
--   WHEN birth_day >= "2019-05-01" THEN "令和"
--   ELSE "不明"
--   END AS "元号"
-- FROM users;

-- birth_eraカラムにCASE文の内容を登録する
-- UPDATE users
-- SET birth_era = CASE
--   WHEN birth_day < "1989-01-07" THEN "昭和"
--   WHEN birth_day < "2019-05-01" THEN "平成"
--   WHEN birth_day >= "2019-05-01" THEN "令和"
--   ELSE "不明"
--   END;


-- NULL

SELECT * FROM customers WHERE name IS NULL;

-- ダメな例（NULLを判定できない）
SELECT *,
CASE name
  WHEN NULL THEN "不明"
  ELSE ""
  END AS "NULL CHECK"
FROM customers WHERE name IS NULL;

-- OKな例
SELECT *,
CASE
  WHEN name IS NULL THEN "不明"
  WHEN name IS NOT NULL THEN "NULL以外"
  ELSE ""
  END AS "NULL CHECK"
FROM customers;
