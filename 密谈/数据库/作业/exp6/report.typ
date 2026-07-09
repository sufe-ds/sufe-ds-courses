#let exp_name = "实验六 SQL连接查询和嵌套查询"
#let exp_date = datetime(year: 2025, month: 11, day: 26)
#let lab_name = "云计算研究中心实验室520"
#let course_name = "数据库"
#let author = "匿名"
#let stu_num = "20XXXXXXXX"
#let class = "数据科学与大数据技术"

#set document(author: author, date: exp_date, title: exp_name)


#set text(font: "Source Han Serif SC")
#set par(justify: true, first-line-indent: (amount: 2em, all: true))

#set page(
  header: align(right)[
    #set par(spacing: 10pt)
    #text(exp_name, fill: gray)
    #line(length: 100%, stroke: gray)
  ],
  paper: "a4",
  numbering: "1",
)

#align(center)[
  #block(height: 1fr)
  #text(size: 30pt, weight: "bold")[实验报告]
  #block(height: 5em)
  #grid(
    columns: (7em, 20em),
    inset: 5pt,
    [*实验项目名称*], exp_name,
    grid.hline(start: 1, stroke: 0.5pt),
    [*实验室*], lab_name,
    grid.hline(start: 1, stroke: 0.5pt),
    [*所属课程名称*], course_name,
    grid.hline(start: 1, stroke: 0.5pt),
    [*实验日期*], exp_date.display("[year].[month].[day]"),
    grid.hline(start: 1, stroke: 0.5pt),
  )
  #block(height: 2em)
  #grid(
    columns: (7em, 20em),
    inset: 5pt,
    [*班级*], class,
    grid.hline(start: 1, stroke: 0.5pt),
    [*姓名*], author,
    grid.hline(start: 1, stroke: 0.5pt),
    [*学号*], stu_num,
    grid.hline(start: 1, stroke: 0.5pt),
  )
  #block(height: 1.5fr)
]

#pagebreak()

#table(
  columns: 1fr,
  rows: auto,
  inset: 1em,
  stroke: 0.5pt
)[
  = 实验环境

  Oracle11g 以上，不限
][
  = 实验目的

  - 掌握基本的连接查询操作
  - 熟悉自身连接操作
  - 熟悉外连接操作
  - 掌握带有比较运算符的子查询
  - 掌握带有IN谓词的子查询
  - 掌握带有ANY或ALL谓词的子查询
  - 熟悉带有EXISTS谓词的子查询
][
  = 实验结果提交方式

  - 实验6-2
    - 利用DEPT和EMP表，完成补充实验中要求的所有实验；
    - 用\<ALT\>+\<Print Screen\>快捷键，将实验题目中每个查询所对应的SELECT语句的执行结果屏幕复制下来，记录在本实验报告中；
  - 将本实验报告存放在“XXXXXXXXXX-6.docx”文件中, 其中“XXXXXXXXXX”是学号，并在教师规定的时间内通过Canvas系统提交。
][
  = 实验6-2的实验结果

  记录如下各查询语句的执行结果

  + 查询所有雇员的姓名、工作和部门名称；
    - #image("assets/image.png")
  + 查询所有雇员的姓名及其经理的姓名；
    - #image("assets/image-1.png")
  + 查询所有销售员（SALESMAN）的雇员编号、姓名、薪金和部门名称；
    - #image("assets/image-2.png")
  + 查询雇用日期早与其经理的所有雇员的编号、姓名和雇佣日期，以及其经理的编号、姓名和雇佣日期；
    - #image("image-3.png")
  + 查询薪金比“SCOTT”高的所有雇员的信息；
    - #image("assets/image-3.png")
  + 查询与“ALLEN”从事相同工作的所有雇员的雇员编号、姓名、雇佣日期和薪金；
    - #image("assets/image-4.png")
  + 查询薪金高于公司平均水平的所有雇员的编号、姓名和薪金；
    - #image("assets/image-5.png")
  + 查询部门名称及其雇员姓名，若有些部门还没有雇员的话只要显示其部门名称即可；
    - #image("assets/image-6.png")
  + 查询薪金高于部门 20所有雇员薪金的雇员的姓名和薪金；
    - #image("assets/image-7.png")
  + 查询薪金高于部门10中某个雇员薪金的雇员的姓名和薪金；
    - #image("assets/image-8.png")
  + 查询部门10和30的所有雇员的姓名、部门名称和薪金，并将查询结果按部门名称的升序排序；
    - #image("assets/image-9.png")
  + 查询在各月的最后一天被雇佣的雇员的编号、姓名、雇佣日期和部门名称；
    - #image("assets/image-10.png")
  + 查询各部门的名称，以及雇员的数量和平均薪金；
    - #image("image.png")
  + 查询薪金处于第四位的雇员的姓名、部门名称、工作和薪金；
    + #image("image-1.png")
  + 查询每个部门中工资排在前2名的员工信息。
    - #image("image-2.png")
][
  = 实验思考


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

][
  = 思考结果

  通过本次实验，我对SQL的连接查询和嵌套查询有了更深入的理解：

  == 连接查询方面

  #strong[自身连接：] 在查询员工及其经理信息时，关键是使用表别名区分同一表的不同角色。实际操作中发现，自身连接特别适合处理层次关系数据。

  #strong[外连接应用：] 第8题要求显示所有部门（包括无员工的部门），必须使用外连接。通过对比发现，内连接关注"交集"，外连接保留基准表的完整数据。Oracle的(+)语法简洁，但标准SQL的LEFT/RIGHT JOIN更直观。

  #strong[性能考虑：] 多表连接时，先筛选再连接往往比先连接再筛选效率更高。

  == 嵌套查询方面

  #strong[子查询选择：]
  - 比较单值用比较运算符
  - 匹配多值用IN谓词
  - 范围比较用ANY/ALL
  - 关心存在性用EXISTS

  #strong[EXISTS优势：] 在处理大表时，EXISTS一旦找到匹配立即返回，效率更高；NOT EXISTS比NOT IN处理NULL更安全。

  #strong[相关子查询：] 第12题中使用相关子查询引用外层字段，虽然效率较低，但逻辑清晰易维护。

  == 实践经验

  #strong[复杂查询：] 第15题采用分步思考——分组、排序、筛选，使用RANK()或ROW_NUMBER()可优雅解决。

  #strong[编程习惯：] 使用表别名提高可读性、避免SELECT \*、合理使用索引字段连接、复杂查询考虑WITH子句。

  #strong[调试方法：] 先验证子查询、逐步添加条件、使用EXPLAIN PLAN分析、检查NULL值处理。

  == 总结

  本次实验让我掌握了连接和嵌套查询的语法，更重要的是学会根据需求选择合适的查询方式。数据库查询需要兼顾正确性、性能和可维护性。理论需要实践巩固，同一问题有多种解决方案，良好的编程习惯对团队协作至关重要。

][
  #grid(
    columns: (5em, 1fr, 5em, 1fr, 5em, 1fr),
    inset: 5pt,
    [*实验成绩*],
    grid.hline(start: 1, end: 2, stroke: 0.5pt),
    [],
    [*批阅老师*],
    grid.hline(start: 3, end: 4, stroke: 0.5pt),
    [],
    [*批阅日期*],
    grid.hline(start: 5, end: 6, stroke: 0.5pt),
    [],
  )
]
