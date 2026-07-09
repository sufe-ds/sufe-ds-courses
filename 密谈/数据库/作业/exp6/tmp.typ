
== 表的自身连接
#strong[什么是表的自身连接？]
自身连接是指一个表与自身进行连接查询，通常用于查询表中具有层次关系或比较关系的记录。

#strong[示例：] 查询员工及其经理信息

```sql
SELECT e.emp_name AS "员工", m.emp_name AS "经理"
FROM employees e, employees m
WHERE e.manager_id = m.emp_id;
```

#strong[书写注意事项：]

- 必须使用表别名来区分同一个表的不同实例
- 明确连接条件，避免产生笛卡尔积
- 合理设计查询逻辑，确保连接条件有意义

== 内连接与外连接的区别
#strong[内连接（INNER JOIN）：]

- 只返回两个表中连接条件匹配的记录
- 不匹配的记录不会出现在结果中
- 是默认的连接方式

#strong[外连接（OUTER JOIN）：]

- 返回连接条件匹配的记录 + 某个表中不匹配的记录
- 分为左外连接、右外连接、全外连接

#strong[Oracle中的外连接操作：]

#strong[标准SQL语法：]

```sql
-- 左外连接
SELECT * FROM table1 LEFT JOIN table2 ON condition;

-- 右外连接
SELECT * FROM table1 RIGHT JOIN table2 ON condition;

-- 全外连接
SELECT * FROM table1 FULL JOIN table2 ON condition;
```

#strong[Oracle传统语法（+运算符）：]

```sql
-- 左外连接（table1为主表）
SELECT * FROM table1, table2
WHERE table1.id = table2.id(+);

-- 右外连接（table2为主表）
SELECT * FROM table1, table2
WHERE table1.id(+) = table2.id;
```

== 需要加表名的字段
在连接查询中，以下情况需要在字段名前加表名：

#strong[必须加表名的情况：]

- 多个表中有相同名称的字段
- 使用表别名时，需要用别名限定字段
- 为了增强SQL语句的可读性

#strong[示例：]

```sql
-- 必须加表名（两个表都有id字段）
SELECT employees.id, employees.name, departments.name
FROM employees, departments
WHERE employees.dept_id = departments.id;

-- 使用表别名
SELECT e.id, e.name, d.name AS dept_name
FROM employees e, departments d
WHERE e.dept_id = d.id;
```

== 子查询结果多行时的WHERE条件
当子查询返回多行结果时，父查询的WHERE条件需要使用特定的操作符：

#strong[主要操作符：]

- #strong[IN]：匹配子查询结果中的任意值
- #strong[ANY/SOME]：与子查询结果中的任一值比较
- #strong[ALL]：与子查询结果中的所有值比较

#strong[示例：]

```sql
-- 使用IN操作符
SELECT * FROM employees
WHERE dept_id IN (SELECT dept_id FROM departments WHERE location = '北京');

-- 使用ANY操作符
SELECT * FROM employees

-- 使用ALL操作符
SELECT * FROM employees
```

== EXISTS谓词子查询的特点
#strong[EXISTS子查询与其他子查询的区别：]

#figure(
  align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    table.header([特性], [EXISTS子查询], [其他子查询]),
    table.hline(),
    [#strong[返回值]], [布尔值(true/false)], [具体的数据值],
    [#strong[执行方式]], [相关子查询，逐行判断], [非相关子查询，先执行子查询],
    [#strong[效率]], [找到第一条匹配记录即返回], [需要处理所有结果],
    [#strong[结果集]], [不关心具体数据，只关心是否存在], [需要具体的数据进行比较],
  )],
  kind: table,
)

#strong[EXISTS示例：]

```sql
-- 查询有下属员工的经理
SELECT * FROM employees e1
WHERE EXISTS (
    SELECT 1 FROM employees e2
    WHERE e2.manager_id = e1.emp_id
);

-- 等价于IN写法（但执行效率不同）
SELECT * FROM employees
WHERE emp_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);
```

#strong[EXISTS的优势：]

- 处理NULL值更安全
- 通常在大数据量时性能更好
- 语义更清晰，表达”存在”的逻辑
