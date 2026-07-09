#let exp_name = "实验九 表的变更和删除及完整性约束定义"
#let exp_date = datetime(year: 2025, month: 12, day: 17)
#let lab_name = "云计算研究中心实验室520"
#let course_name = "数据库"
#let author = "匿名"
#let stu_num = "20XXXXXXXX"
#let class = "数据科学与大数据技术"

#set document(author: author, date: exp_date, title: exp_name)
// #set image(height: 250pt)

#set text(font: "Source Han Serif SC", lang: "zh")
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
    [*实#h(1fr)验#h(1fr)项#h(1fr)目#h(1fr)名#h(1fr)称*], exp_name,
    grid.hline(start: 1, stroke: 0.5pt),
    [*实#h(1fr)验#h(1fr)室*], lab_name,
    grid.hline(start: 1, stroke: 0.5pt),
    [*所#h(1fr)属#h(1fr)课#h(1fr)程#h(1fr)名#h(1fr)称*], course_name,
    grid.hline(start: 1, stroke: 0.5pt),
    [*实#h(1fr)验#h(1fr)日#h(1fr)期*], exp_date.display("[year].[month].[day]"),
    grid.hline(start: 1, stroke: 0.5pt),
  )
  #block(height: 2em)
  #grid(
    columns: (7em, 20em),
    inset: 5pt,
    [*班#h(1fr)级*], class,
    grid.hline(start: 1, stroke: 0.5pt),
    [*姓#h(1fr)名*], author,
    grid.hline(start: 1, stroke: 0.5pt),
    [*学#h(1fr)号*], stu_num,
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

  PostgreSQL 18
][
  = 实验目的

  - 掌握表结构的变更和删除表的方法
  - 掌握完整性约束的定义、添加和删除方法
][
  = 实验结果提交方式

  + 实验 9-3：自行完成本补充实验，记录实验结果。
  + 将本实验报告存放在“XXXXXXXXXX-9.docx”文件中, 其中“XXXXXXXXXX”是学号，并在教师规定的时间内通过BB系统提交该文件。
][
  = 实验9-3的实验结果

  自行完成补充实验，并记录实验结果。

  - 创建EMP_Info表。
    - #image("/assets/image-48.png")
  - 在EMP_Info表中定义一个外码DEPTNO，其被参照表是DEPT表。
    - #image("/assets/image-49.png")
  - 创建Prod_Info表。
    - #image("/assets/image-50.png")
  - 从Prod_Info表中删除对颜色字段的约束，然后再将约束添加回去。
    - #image("/assets/image-51.png")
  - 创建Supplier表。
    - #image("/assets/image-52.png")
  - 创建SP表
    - #image("/assets/image-53.png")
  - 在SP表中定义一个外码ProductNO，其被参照表是Prod_Info表；定义另一个外码SupplierNO，其被参照表是Supplier表。
    - #image("/assets/image-54.png")
  - 给SP表添加PRICE（采购价格）属性列，数据类型为数值型，宽度为5，小数位数为2。
    - #image("/assets/image-55.png")
  - 给SP表的PRICE属性添加一个约束，规定采购价格必须大于0。
    - #image("/assets/image-56.png")
  - 将SP表中PRICE属性的宽度增加到6位，小数位数不变。
    - #image("/assets/image-57.png")
  - 从SP表中将PRICE属性删除。
    - #image("/assets/image-58.png")
][
  = 实验思考

  + 举例说明如何在一个表中新增多个属性列？
  + 举例说明如何从一个表中删除多个属性列？
  + 举例说明如何修改一个表中多个属性列的定义？
  + 总结一下完整性约束的分类及其创建方法，并举例说明。
][
  = 思考结果

  + *在一个表中新增多个属性列*

    使用 `ALTER TABLE` 语句，并用逗号分隔多个 `ADD COLUMN` 子句。
    ```sql
    ALTER TABLE EMP_Info
    ADD COLUMN email VARCHAR(50),
    ADD COLUMN phone VARCHAR(20);
    ```

  + *从一个表中删除多个属性列*

    使用 `ALTER TABLE` 语句，并用逗号分隔多个 `DROP COLUMN` 子句。
    ```sql
    ALTER TABLE EMP_Info
    DROP COLUMN email,
    DROP COLUMN phone;
    ```

  + *修改一个表中多个属性列的定义*

    使用 `ALTER TABLE` 语句，并用逗号分隔多个 `ALTER COLUMN ... TYPE` 子句。
    ```sql
    ALTER TABLE EMP_Info
    ALTER COLUMN ename TYPE VARCHAR(30),
    ALTER COLUMN deptno TYPE INT;
    ```

  + *完整性约束的分类及其创建方法*

    完整性约束主要分为三类：
    - *实体完整性*：通过 `PRIMARY KEY` 定义，保证主键唯一且非空。
    - *参照完整性*：通过 `FOREIGN KEY` 定义，保证外键值必须在被参照表中存在或为空。
    - *用户定义完整性*：包括 `NOT NULL`（非空）、`UNIQUE`（唯一）、`CHECK`（检查条件）。

    创建方法主要有三种：
    1. *列级定义*：在创建表时，紧跟列定义之后。
      ```sql
      CREATE TABLE T1 (id INT PRIMARY KEY, age INT CHECK (age > 0));
      ```
    2. *表级定义*：在创建表时，所有列定义之后单独定义。
      ```sql
      CREATE TABLE T2 (
        id INT,
        dept_id INT,
        CONSTRAINT pk_t2 PRIMARY KEY (id),
        CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES DEPT(deptno)
      );
      ```
    3. *追加定义*：表创建后，使用 `ALTER TABLE ADD CONSTRAINT` 语句。
      ```sql
      ALTER TABLE T1 ADD CONSTRAINT unique_age UNIQUE (age);
      ```
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
