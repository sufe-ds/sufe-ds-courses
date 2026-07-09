#let exp_name = "实验七 基本表的创建、插入、更新和删除"
#let exp_date = datetime(year: 2025, month: 12, day: 2)
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

  学会基本表的创建；
  掌握插入记录、更新记录和删除记录的操作。
][
  = 实验结果提交方式

  实验7-3
  按实验要求完成各个实验，并将各命令的执行过程以及执行成功后相应表的结构和数据屏幕复制下来，记录在本实验报告中。
  将本实验报告存放在“XXXXXXXXXX-7.docx”文件中, 其中“XXXXXXXXXX”是学号，并在教师规定的时间内通过BB系统提交该文件。
][
  = 实验7-3的实验结果
  记录各命令的执行过程以及执行成功后相应表的结构或数据。

  （注意：自己创建下列题目涉及的表结构，插入的数据可参考7-11至7-22）

  - 在 Payment和Ptype表中插入数据。
    - #image("/assets/image.png")
    - #image("/assets/image-1.png")
  - 利用INSERT语句在Orders表中直接插入5个记录。
    - #image("/assets/image-2.png")
    - #image("/assets/image-3.png")
    - #image("/assets/image-4.png")
    - #image("/assets/image-5.png")
    - #image("/assets/image-6.png")
  - 利用INSERT语句在Orders表中用交互方式插入3个记录。
    - #image("/assets/image-7.png")
    - #image("/assets/image-8.png")
    - #image("/assets/image-9.png")
  - 设置Orders表前5行数据中的PAYMENT_TNO和STATUS属性的值。
    - #image("/assets/image-10.png")
    - #image("/assets/image-11.png")
    - #image("/assets/image-12.png")
    - #image("/assets/image-13.png")
    - #image("/assets/image-14.png")
  - 在Product和Order_items表中插入数据。
    - #image("/assets/image-15.png")
      - 后略
    - #image("/assets/image-16.png")
      - 后略
  - 参阅表7-18给出的数据，修改Product表的产品库存。
    - #image("/assets/image-17.png")
  - 删除与 “1001”号产品有关的所有信息。
    - #image("/assets/image-18.png")
  - 使用“CREATE TABLE … AS”语句从Product表创建另一个名称为Product1的表，其中包含所有库存小于100的产品信息。
    - #image("/assets/image-19.png")
  - 将Product1表中库存小于50的产品的库存增加200。
    - #image("/assets/image-20.png")
  - 将Employee表中所有办事员（CLERK）的薪金提高5%。
    - #image("/assets/image-21.png")
  - 将Employee表中部门“30”的销售员（SALESMAN）的薪金增加300元。
    - #image("/assets/image-22.png")
  - 在Employee表中将“7369”号雇员从部门“20”转到部门“30”。
    - #image("/assets/image-23.png")
  - 在Employee表中，将2000年以前雇佣的职员的薪金提高1000元。
    - #image("/assets/image-24.png")
  - 在Employee表中删除佣金为0的销售员（SALESMAN）的信息。
    - #image("/assets/image-25.png")
  - 删除部门“10”的部门信息，以及其中雇员的信息。
    - #image("/assets/image-26.png")
  - 删除Employee表中1995年之前雇佣的雇员的信息。
    - #image("/assets/image-27.png")
  - 查看“user_tables”和“user_tab_columns”视图的内容，了解当前用户中创建了哪些基本表以及表中属性列的相关信息。
    - 因为我使用的是 system 用户，所以我创建了哪些基本表会比较乱。
      - #image("/assets/image-29.png")
    - #image("/assets/image-30.png")
][
  = 实验思考

  1. *设置默认日期格式*：
    可以使用 `ALTER SESSION` 命令来修改当前会话的日期格式。例如，要将日期格式设置为 "YYYY-MM-DD"，可以执行以下 SQL 语句：
    ```sql
    ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
    ```

  2. *一次插入多行数据*：
    在 Oracle 中，可以使用 `INSERT ALL` 语句来实现一次插入多行。例如：
    ```sql
    INSERT ALL
      INTO my_table (id, val) VALUES (1, 'A')
      INTO my_table (id, val) VALUES (2, 'B')
    SELECT 1 FROM DUAL;
    ```
    或者，如果数据来源于另一个表，可以使用 `INSERT INTO ... SELECT ...` 语句。

  3. *表复制操作*：
    可以使用 `CREATE TABLE ... AS SELECT` (CTAS) 语句来复制表。
    - *复制表结构和数据*：
      ```sql
      CREATE TABLE new_table AS SELECT * FROM old_table;
      ```
    - *仅复制表结构（不复制数据）*：
      ```sql
      CREATE TABLE new_table AS SELECT * FROM old_table WHERE 1=0;
      ```
][
  = 思考结果

  通过本次实验，我深入理解并掌握了数据库基本表的操作方法。
  1. 熟练运用 `CREATE TABLE` 语句创建表结构，并掌握了 `INSERT`、`UPDATE`、`DELETE` 等 DML 语句的使用，能够灵活地对数据进行增删改操作。
  2. 在实践中体会到了 `WHERE` 子句在数据更新和删除中的关键作用，避免了因条件缺失导致的数据误操作。
  3. 掌握了利用 `CREATE TABLE ... AS SELECT` 语句进行表复制的技巧，这对于数据备份和测试环境搭建非常有帮助。
  4. 通过对 `user_tables` 等数据字典视图的查询，了解了如何查看数据库元数据，加深了对 Oracle 体系结构的理解。
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
