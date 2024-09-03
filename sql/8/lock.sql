START TRANSACTION;
-- TRANSACTION中で主キーを指定してUPDATEで行ロックとなる
UPDATE customers SET age=43 WHERE id=1;
ROLLBACK;
-- 別のセッションから同一行をUPDATEしようとしても処理が止まる
-- COMMIT or ROLLBACKをすることで、別のセッションから更新できるようになる。
-- ロック解除待ちで速度低下が起こるので、同じ行の更新が何度も起こらないような設計にする。


-- UPDATE
START TRANSACTION;
-- TRANSACTION中で主キー以外を指定してUPDATEで表ロックとなる
UPDATE customers SET age=42 WHERE name="河野 文典";
ROLLBACK;


-- DELETE
START TRANSACTION;
-- 主キー指定なので行ロック
DELETE FORM custmers WHERE id=1;
ROLLBACK;


-- INSERT
START TRANSACTION;
-- 行ロック
INSERT INTO customers VALUES(1, "田中 一郎", 21, "1999-01-01");


-- SELECT
-- FOR SHARE(共有ロック) 参照できるが更新できない
START TRANSACTION;
SELECT * FROM customers WHERE id=1 FOR SHARE;
ROLLBACK;

-- FOR UPDATE(排他ロック) 参照も更新もできない
START TRANSACTION;
SELECT * FROM customers WHERE id=1 FOR UPDATE;
ROLLBACK;


-- 明示的なロック

-- 読み取りのみ許可。
LOCK TABLE customers READ;
UNLOCK TABLES;

-- 読み取りと書き込みの両方をロック。
LOCK TABLE customers WRITE;
UNLOCK TABLES;


-- デッドロック
-- section1でcustomers → usersの順でトランザクション
-- section2でusers