-- USE day_10_14_db;

-- VIEWの作成
-- CREATE VIEW stores_items_view AS
-- SELECT st.name AS store_name, it.name AS item_name FROM stores AS st
-- INNER JOIN items AS it
-- ON it.store_id = st.id;

-- VIEWからデータを取得
SELECT * FROM stores_items_view;

-- TABLEとVIEWの一覧を表示
SHOW TABLES;

-- 定義されたVIEWを表示
SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA="day_10_14_db";

-- VIEWの詳細情報を表示
SHOW CREATE VIEW sores_items_view;

-- VIEWの定義変更
-- ALTER VIEW stores_items_view AS
-- SELECT st.id AS store_id, st.name AS store_name, it.name AS item_name FROM stores AS st
-- INNER JOIN items AS it
-- ON it.store_id = st.id;

-- VIEWの名前変更
RENAME TABLE stores_items_view TO new_stores_items_view;


-- 名前はVIEWであることがわかるようにする。
-- VIEWの中でWHEREやORDER BYは使わない。VIEWを利用するときに使う。
-- VIEWを使ってさらにVIEWを定義することはしない。