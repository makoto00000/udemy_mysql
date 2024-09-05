-- 部署ごとに分類し、給与の平均が3980000より多い部署だけ表示する。
SELECT department, AVG(salary) FROM employees GROUP BY department HAVING AVG(salary) > 3980000;


-- -- 国ごとにグループ分けして、さらに年齢ごとに分ける。そのときのデータ数が1より多いデータをデータ数で昇順に並べる。
SELECT birth_place, age, COUNT(*) FROM users
GROUP BY birth_place, age
HAVING COUNT(*) > 1
ORDER BY COUNT(*);


-- nameの重複なしのレコード数と、そのままのレコード数が同じなら最初から重複がないということなので"重複なし"を表示する。
SELECT
  "重複なし" AS "check"
FROM
  users
HAVING
  COUNT(DISTINCT name) = COUNT(name);


-- WHEREはGROUP BYする前に絞り込む
-- HAVINGはGROUP BYした後に絞り込む