-- バインド変数
SET @ costomer_id = 3;
SELECT * FROM customers WHERE id = @customer_id;
