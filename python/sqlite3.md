# sqlite3模块

## 示例代码
本代码来自官方示例
```python
import sqlite3
conn = sqlite3.connect('example.db')  # 首先必须建立一个对数据库的 connection

c = conn.cursor()  # 创建 cursor 才能调用 execute()执行 sql 语句

# 创建数据表
c.execute('''CREATE TABLE stocks
             (date text, trans text, symbol text, qty real, price real)''')

# 插入一行数据
c.execute("INSERT INTO stocks VALUES ('2006-01-05','BUY','RHAT',100,35.14)")

# Save (commit) the changes
conn.commit()

# We can also close the connection if we are done with it.
# 关闭之前要确保数据已经保存，否则会丢失掉
conn.close()
```
上面是简单的建表和插入数据，下面是查询语句
```python
# 永远不用这么用——不安全
symbol = 'RHAT'
c.execute("SELECT * FROM stocks WHERE symbol = '%s'" % symbol)

# 这么写才好的
t = ('RHAT',)
c.execute('SELECT * FROM stocks WHERE symbol=?', t)
print(c.fetchone())

# 一次插入多组数据
purchases = [('2006-03-28', 'BUY', 'IBM', 1000, 45.00),
             ('2006-04-05', 'BUY', 'MSFT', 1000, 72.00),
             ('2006-04-06', 'SELL', 'IBM', 500, 53.00),
            ]
c.executemany('INSERT INTO stocks VALUES (?,?,?,?,?)', purchases)
```
上面涉及到了PEP 249规范中的paramstyle，相关内容如下：

1. 问号风格：where name=?
2. 数字&位置样式：where name=:1
3. 命名样式：where name=:name
4. ANSI C printf格式代码：where name=%s
5. Python 扩展格式代码：where name=%(name)s
### bug 解释
```
代码为
cursor.execute(sql, row)
错误为
sqlite3.InterfaceError: Error binding parameter 2 - probably unsupported type
```
上面的 bug 是因为在 sql 中有需要外部替换的字段，而第3个变量的类型有问题。