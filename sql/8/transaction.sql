
-- TRANSACTION

START TRANSACTION;

UPDATE users SET name="奥山 成美" WHERE id=1;

-- 処理をトランザクション開始前に戻す
-- ROLLBACK;

-- トランザクションを確定させる
-- COMMIT;

-- AUTO COMMIT
-- DBはデフォルトでCOMMITされるように設定されている。

-- AUTOCOMMITの設定確認
SHOW VARIABLES WHERE variable_name="autocommit";

-- AUTOCOMMITの設定を変更（0=OFF, 1=ON）
SET AUTOCOMMIT=0;

