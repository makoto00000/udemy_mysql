-- SELF JOUN(自己結合)

SELECT * FROM employees AS emp1
INNER JOIN employees AS emp2
ON emp1.manager_id = emp2.id;

-- SELF JOUN(自己結合)

SELECT
  CONCAT(emp1.last_name, emp1.first_name) AS "部下の名前",
  emp1.age AS "部下の年齢",
  COALESCE(CONCAT(emp2.last_name, emp2.first_name), "該当なし") AS "上司の名前",
  emp2.age AS "上司の年齢"
FROM employees AS emp1
LEFT JOIN employees AS emp2
ON emp1.manager_id = emp2.id;