# 关于 Pandas 中数据库的使用
个人使用过程中觉得，pandas 将数据库的部分工作做的不错，日常使用过程中用 pandas 挺简洁的。但也有一些劣势存在。
另一方面，pandas 支持多种数据库，个人再用的有 MySQL, Sqlite3。下文中主要使用这两个展示功能。

## 插入数据
`to_sql()`函数就是用于实现这一功能的，该功能无法去重。如果想要去重，需要用 python 的 sqlite3模块自行用[sql语句操作][sql]。参数如下：

* name：数据表名。如果没有这个表也没有关系，pandas 会按照 DataFrame 的格式创建这个表。
* con：connection。
* if_exists：有三个属性值（fail, replace, append），默认是 fail。
    - fail：存在表就抛出异常；
    - replace：存在表就替换该表；
    - append：存在表就添加数据，该操作不会去重；
* index：默认为 True；

## 查询数据
`read_sql_query`函数用来查询数据库，并将结果保存为 DataFrame 形式然后返回。参数如下：

* sql：要查询的 select 语句；
* con
* index_col：默认为 None。这个用来设定谁是 index 的；
* params：默认为 None。如果 sql 属性里面有需要外部补充的参数，就要用到这个了，格式是[sql的 PEP 249规范][sql]
* parse_dates：日期格式化，例如{column_name: format string}

## 出现过的问题
MySQL 的字符集是
```
+----------------------+--------------------+
| Variable_name        | Value              |
+----------------------+--------------------+
| collation_connection | utf8mb4_general_ci |
| collation_database   | utf8mb4_general_ci |
| collation_server     | utf8mb4_general_ci |
+----------------------+--------------------+
```
python以及 pandas 读取得到的都是 [bytes-like][bytes-like]，打印出来的结果需要解码，代码如下
```
Series.str.decode('utf-8')
```


[sql]: 
[bytes-like]: https://stackoverflow.com/questions/606191/convert-bytes-to-a-python-string