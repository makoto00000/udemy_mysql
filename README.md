# MySQL学習用リポジトリ

## 動作方法

1 コンテナ起動

```shell
docker compose up -d
```

2 ターミナル操作

```shell
docker exec -it mysql-container bash
```

3 mysqlへログイン

```shell
mysql -u root -p
password> password
```

4 sqlの実行

```mysql
source /home/sql/test.sql
```
