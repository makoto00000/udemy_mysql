
-- CONCAT（文字の連結）

SELECT CONCAT(department, ":", name) AS "部署: 名前" FROM employees LIMIT 3;
SELECT CONCAT(name, "(", age, ")") AS "名前(年齢)" FROM users LIMIT 3;


-- NOW, CURDATE, DATE_FORMAT

SELECT NOW();
SELECT NOW(), name, age FROM users LIMIT 3;

SELECT DATE_FORMAT(NOW(), "%Y-%m-%d %H:%i:%s")
