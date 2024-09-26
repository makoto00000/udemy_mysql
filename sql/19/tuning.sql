USE day_19_21_db;

-- 統計情報の確認
SELECT * FROM mysql.innodb_table_stats WHERE database_name="day_19_21_db";

-- 手動で統計情報を更新（急激なデータの増加時など）
ANALYZE TABLE prefectures;

-- SQLを実行せずに実行計画だけを表示
EXPLAIN SELECT * FROM customers;

-- SQLを実行して実行計画を表示
EXPLAIN ANALYZE SELECT * FROM customers;
-- 0.924..308 1行あたり0.924ms 全体で308ms

-- type const
EXPLAIN SELECT * FROM customers WHERE id=1;

-- type range
EXPLAIN SELECT * FROM customers WHERE id<10;

-- INDEXを貼るとデータ数が増えれば増えるほど、フルスキャンよりも早い。

-- MかFしかないカラムにインデックスを貼る
CREATE INDEX idx_customers_gender ON customers(gender);
-- このほうが時間がかかる
EXPLAIN ANALYZE SELECT * FROM customers WHERE gender="F";
-- ヒント句(正しく反映されない場合もあるので注意)
EXPLAIN ANALYZE SELECT /* + NO_INDEX(ct) */ * FROM customers AS ct WHERE ct.gender="F";



-- customersの50000個のデータをループしている。
EXPLAIN ANALYZE
SELECT * FROM customers AS ct
INNER JOIN prefectures AS pr
ON ct.prefecture_code = pr.prefecture_code;

/*
-> Nested loop inner join  (cost=224021 rows=496168) (actual time=2.39..665 rows=500000 loops=1)
  -> Filter: (ct.prefecture_code is not null)  (cost=50362 rows=496168) (actual time=1.03..263 rows=500000 loops=1)
    -> Table scan on ct  (cost=50362 rows=496168) (actual time=0.649..226 rows=500000 loops=1)
  -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=613e-6..643e-6 rows=1 loops=500000)
*/


/*
チューニングのポイント

1. SELECTで取得するカラムは必要なものだけにする
2. テーブル結合時は別名を省略せずにつける（AS句）


チューニングの流れ
1. 処理速度の遅いSQLを出力して、実行計画を調べる
2. SQLの改善案を作成する
3. 改善案に効果があるのか、他のSQLに影響はないか確認する
4. 改善案を適用して、実際に改善されたか確認する

リリースしていないシステムの場合、DBに十分なデータ量（想定されるMAXのデータ量）を積んで処理を実行してみる
*/
