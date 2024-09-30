-- 1. インデックスを用いたチューニング

-- 1-1
/* 絞り込める件数が全体の15%以下であること。逆に言えばこのWHERE句で全体の15%以下に絞り込めないなら、INDEXを作成しても速度向上は見込めない */
CREATE INDEX idx_employees_name ON employees(name)
SELECT * FROM employees WHERE name="Taro";

-- 1-2
/* 複合インデックスの場合インデックスが利用されない場合がある */
CREATE INDEX idx_employees_name_age ON employees(name, age)
SELECT * FROM employees WHERE name="Taro" AND age=21;  -- OK
CREATE INDEX idx_employees_name_age ON employees(name, age)
SELECT * FROM employees WHERE name="Taro" OR age=21;  -- NG
CREATE INDEX idx_employees_name_age ON employees(name, age)
SELECT * FROM employees WHERE name="Taro";  -- OK
CREATE INDEX idx_employees_name_age ON employees(name, age)
SELECT * FROM employees WHERE age=21;  -- NG
/* 複合ではなくそれぞれ単独でインデックスを作成すればいずれもOK */

-- 1-3
/* ORDER BY, GROUP BYの対象カラムにインデックスを付与することで処理速度向上*/
CREATE INDEX idx_employees_name_age ON employees(name, age)
SELECT * FROM employees ORDER BY name, age
/* 複数カラムを対象とするなら複合インデックスが必要 */
/* 大量のデータに対してORDER BYやGROUP BYを使用すると時間がかかるので、絞り込んでから使うほうが良い */


-- 1-4
/* 外部キーにはインデックスを作成する */
/* ネステッドループの外部表とない分表をオプティマイザが適切に選択するようになる */



-- インデックスが利用されない

-- 2-1
/* 関数をつけている場合 */
CREATE INDEX idx_employees_name_lower ON employees((LOWER(name)))
SELECT * FROM employees WHERE LOWER(name)="taro";
/* 関数インデックスを作成すればよいが万能ではないので注意が必要 */
/* 最初から登録するときに、すべて大文字、すべて小文字に変換してから登録するのが良い */

-- 2-2
/* インデックス対象カラムを数値演算した場合 */
SELECT * FROM employees WHERE age + 2 = 20;
/* この場合はインデックスを利用できない */
SELECT * FROM employees WHERE age = 18; -- このように計算は右辺に移す

-- 2-3
/* 文字列カラムにインデックスをつけているのに数値と比較している場合 */
SELECT * FROM employees WHERE prefecture_code = 21;
/* この場合、左辺を数値変換することになるのでフルスキャンになる */
SELECT * FROM employees WHERE prefecture_code = '21';  -- 右辺も文字列にする

-- 2-4
/* LIKE句で中間一致、後方一致を使った場合 */
SELECT * FROM employees WHERE name LIKE "田中%";  -- 前方一致 OK
SELECT * FROM employees WHERE name LIKE "%太郎";  -- 後方一致 NG
SELECT * FROM employees WHERE name LIKE "%田%";  -- 中間一致 NG

/* 後方一致については、名前を逆順に格納したカラムを用意して前方一致検索をする */
SELECT * FROM employees WHERE name_reverse LIKE "郎太%";

/* 中間一致は難しい */
SELECT * FROM (SELECT * FROM customers LIMIT 50000) AS tmp WHERE first_name LIKE "%田%";
/* これなら50000件に絞り込んだ中から検索するので早くなる。実際のことを考えると画面に表示させるレコードの件数はそこまで多くないはずなので、この方法も有効かも。 */


-- 3.意味のない並べ替えを避ける
/* 
・ORDER BY
・GROUP BY
・集計関数（SUM, COUNT, AVG, MIN, MAX)
・DISTINCT
・UNION, INTERSECT, EXCEPT
・ウィンドウ関数
 */

-- 3-1
/* JOINするテーブルを並び替えても意味がない */
SELECT * FROM employees AS employees
INNER JOIN (SELECT * FROM departments ORDER BY name) AS dp
ON emp.department_id = dp.id;

/* HAVINGはGROUP BYした結果に対して絞り込む
WHEREを使って先に絞りこんでからGROUP BYしたほうが高速 */
SELECT department_name, COUNT(*) FROM employees
GROUP BY department_name
HAVING department_name IN ("経営企画部", "営業部");

-- 3-2
/* MAX, MINはインデックスで高速化 */
CREATE INDEX idx_users_age ON users(age);
SELECT MAX(age), MAX(age) FROM users;

-- 3-3
/* DISTINCTは重複削除の前に並び替えがされるので時間がかかる。 */

/* historiesテーブルのproduct_idカラムに一致するものがあるproductsテーブルのレコードを取得したい場合 */

/* DISTINCTはproduct_idで並び替えて、前の行と同じならスキップするというアルゴリズム */
SELECT DISTINCT p.product_id FROM products AS p
INNER JOIN histories AS h
ON p.product_id = h.product_id;

/* 同様の処理をEXISTSを使えば、並び替えが不要のため高速 */
/* EXISTSでもINNER JOINの代わりになる処理を記述できる */
SELECT p.product_id FROM products AS p
WHERE EXISTS (SELECT 1 FROM histories AS h WHERE h.product_id = s.product_id)

-- 3-4
/* UNIONの代わりにUNION ALLを利用する */

/* UNIONは重複の削除を行うため遅くなる。UNION ALLなら結合するだけなので高速 */



-- 4.同じ処理を何度も行わない（ムダを無くす）

-- 4-1 副問合せで同じテーブルを見る回数は1回にする
SELECT * FROM employees WHERE
department_id IN (SELECT id FROM departments WHERE name="営業部")
OR
department_id IN (SELECT id FROM departments WHERE name="総務部");

/*1回にまとめる*/
SELECT * FROM employees
WHERE
department_id IN (SELECT id FROM departments WHERE name IN("営業部", "総務部"))


-- 4-2 SELECT内の副問合せをやめて、JOINを使う

/* カラムごとに副問合せが実行されるので処理コストがかかる */
SELECT emp.*, (SELECT name FROM departments AS sp WHERE dp.id = emp.department_id)
FROM employees AS emp;

/* LEFT JOINで */
SELECT emp.*, dp.name
FROM employees AS emp
LEFT JOIN departments AS dp
ON emp.department_id == dp.id;


-- 4-3 WHEREの絞りこみを何度も行わない

/* 2016年のsales_historyに、その日のsales_amountの合計値をカラムとして追加 */
/* WHEREで2回絞り込んでいる。 */
SELECT sh.*, sales_summary.sales_daily_amount
FROM sales_history AS sh
LEFT JOIN
(SELECT sales_day, SUM(sales_amount) AS sales_daily_amount
FROM sales_history
WHERE sales_day BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY sales_day) AS sales_summary  -- 2016年の日ごとの売上の合計
ON sh.sales_day = sales_summary.sales_day
WHERE sh.sales_day BETWEEN '2016-01-01' AND '2016-12-31'; -- sales_historyも絞り込む

/* 2016年に絞り込んだあとで、ウィンドウ関数で集計 */
SELECT sh.*, SUM(sh.sales_amount) OVER(PARTITION BY sh.sales_day)
FROM sales_history AS sh
WHERE sh.sales_day BETWEEN '2016-01-01' AND '2016-12-31';

/* sales_dayにインデックスを貼ればもっと早くなる。 パーティショニングもさらに有効*/



-- 5.効率の良いSQLの使い方をする（INかEXISTSか）

/* レコード数が、T1 > T2のとき */
SELECT * FROM T1 WHERE id IN (SELECT id FROM T2);
/* ただし、これは、副問合せが毎回実行されるときの話。
データベースによるが、副問合せはこの場合1回だけ実行されることが多い */

/* 
その場合は、
例えば、products(2000000レコード), stores（10000レコード）のとき、
副問合せは1回だけ実行され、WHEREの絞りこみはインデックスによるので、時間がかからない。
つまり、以下のクエリは、2000000回に対し、
EXPLAIN ANALYZE SELECT * FROM products WHERE store_id IN (SELECT id FROM stores);
以下のクエリは、10000回で終わる。
EXPLAIN ANALYZE SELECT * FROM stores WHERE id IN (SELECT store_id FROM products);
単純に両方に存在するidを抽出したいだけなら、校舎のほうが速くなる。
 */

/* T1 < T2 */
SELECT * FROM T1 WHERE EXISTS (SELECT id FROM T2 WHERE T1.id = T2.id)
/* T1を順にみて行って、副問合せでレコードが取得できたら表示するので、実行回数はT1のレコード分 */



-- 6.その他ありがちなチューニング事例

-- 6-1 実行されるSQLの回数を減らす
SELECT * FROM  products WHERE id IN (100, 200, 300)

-- 6-2 INSERTの実行回数を減らす
INSERT INTO
  projects(name, start_date, end_date)
VALUES
  ('AI for Marketing', '2019-08-01', '2019-12-31'),
  ('ML for Sales', '2019-05-15', '2019-11-20');

-- 6-3 大量INSERTのときは、インデックスを削除してINSERT後にインデックスを追加
/* 
INSERTするたびにINDEXを貼る処理が入り時間がかかる。インデックスを削除している間はデータベースを使われないよう、夜間などに行う。
もしくは、一時テーブルに主キーやインデックスのない状態でINSERTして、本テーブルにSELECT INSERTする。
 */

-- 6-4 あえてカラムを増やす
/* テーブルを結合するのに時間がかかるので、あえて正規化を外してカラムを追加する。 */

-- 6-5 夜間バッチで実行結果を格納する
/* 
リアルタイムで実行結果が必要ない場合
以下のクエリは時間がかかるので、夜間バッチなどでcustomersテーブルなどにUPDATE処理でsales_summaryカラムとして更新する。
*/
SELECT sh.*, SUM(sales_amount) OVER(PARTITION BY customer_id) AS sales_summary
FROM sales_history AS sh;


-- 6-7 ピーク時間をさける
/* ユーザーが利用する時間帯を避けて夜間に重いSQLを実行する */

-- 6-8 LIMITをつけて実行する
/* テーブルの中身を数件確認するときはLIMITをつける。ただし集計関数は全レコードに対して行われるので短くならない。先にLIMITしてから絞り込めば良い */

-- 6-9 レコード全削除はDELETEではなくTRUNCATEを用いる
/* TRUNCATEのほうが時間がかからない */