#let exp_name = "实验八 视图、索引、序列和同义词的创建和使用"
#let exp_date = datetime(year: 2025, month: 12, day: 10)
#let lab_name = "云计算研究中心实验室520"
#let course_name = "数据库"
#let author = "匿名"
#let stu_num = "20XXXXXXXX"
#let class = "数据科学与大数据技术"

#set document(author: author, date: exp_date, title: exp_name)
#set image(height: 250pt)

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

  PostgreSQL 18
][
  = 实验目的

  + 掌握视图和索引的创建及使用方法
  + 掌握序列和同义词的创建及使用方法
  + 掌握用Oracle数据字典查看用户创建的视图、索引、序列和同义词的方法
][
  = 实验结果提交方式

  + 实验8-3：自行完成本补充实验，记录实验结果。
  + 将本实验报告存放在“XXXXXXXXXX-8.docx”文件中, 其中“XXXXXXXXXX”是学号，并在教师规定的时间内通过BB系统提交该文件。
][
  = 实验8-3的实验结果

  自行完成补充实验，并记录实验结果。


  + 创建一个名为"EmpIncome"的视图，其中包含所有雇员的编号、姓名和工资，其中，工资=薪金（SAL）+ 奖金（COMM）；
    - #image("/assets/image-31.png")
  + 创建一个名为"Employee10_30"的视图，其中包含部门"10"和"30"的所有雇员的编号、部门编号、姓名、雇佣日期、工作和薪金等信息；
    - #image("/assets/image-32.png")
  + 利用视图"Employee10_30"，将部门30的所有销售员的薪金增加25% ；
    - #image("/assets/image-33.png")
  + 创建一个名为"EmpMgr"的视图，其中包含雇员的编号、姓名、部门名称和上级姓名的视图；
    - #image("/assets/image-34.png")
  + 创建一个名为"deptSumSal"的视图，其中包含各部门的名称和雇员总薪金；
    - #image("/assets/image-35.png")
  + 创建一个名为"JobSal"的视图，其中包含公司提供的各种工作的名称、平均薪金、最高薪金和最低薪金；
    - #image("/assets/image-36.png")
  + 创建一个名为"SeqDeptNo"的序列，该序列的起始值是50，步长为10；
    - #image("/assets/image-37.png")
  + 在 DEPT 表中插入2个新部门，见下表，其中部门编号使用序列"SeqDeptNo"生成；
    - #figure(
        table(
          columns: 3,
          [DEPTNO], [DNAME], [LOC],
          [50], [PURCHASING], [BOSTON],
          [60], [PERSONNEL], [NEW YORK],
        ),
        caption: "新部门信息",
      )
  + #image("/assets/image-38.png")
  + 创建一个名为"部门"的同义词，该同义词代表的是DEPT表；
    - _注：PostgreSQL不支持同义词，使用视图代替_
    - #image("/assets/image-39.png")
  + 利用同义词"部门"，查询部门10和50的部门名称；
    - #image("/assets/image-40.png")
  + 利用同义词"部门"，在DEPT表中删除"PERSONNEL"部门；
    - #image("/assets/image-47.png")
  + 在EMP表的ENAME字段上创建一个名为"idxEname"的索引；
    - #image("/assets/image-41.png")
  + 在EMP表的DEPTNO和SAL字段上创建一个名为"idxDnoSal"的索引；
    - #image("/assets/image-45.png")
  + 分别查看相应的系统视图，显示自己所创建的全部视图、同义词、序列和索引；
    - #image("/assets/image-42.png")
    - #image("/assets/image-43.png")
    - #image("/assets/image-44.png")
  + 删除上面创建的Employee10_30视图和所有同义词、序列和索引。
    - _这里有一点操作失误，一开始"idxDnoSal"打错了，重新运行了一次_
    - #image("/assets/image-46.png")

][
  = 实验思考

  1. 既然企业业务活动中产生的数据是存放在基本表中的，为什么还要创建视图呢？
  2. 简述只读视图的创建方法及其作用。
  3. 举例说明用带有“WITH CHECK OPTION”子句的CREATE VIEW语句创建检查视图的作用。
  4. 什么样的视图是不能更新的？
  5. 如何利用Oracle系统的数据字典，查看用户所拥有的视图的相关信息？
  6. 简述创建惟一性索引的作用。
  7. 如何利用Oracle系统的数据字典，查看用户所拥有的索引的相关信息？
  8. 简述序列和同义词的作用。
][
  = 思考结果

  + *既然企业业务活动中产生的数据是存放在基本表中的，为什么还要创建视图呢？*

    创建视图的主要原因包括：
    - *简化复杂查询*：对于涉及多表连接或复杂计算的查询，可以通过视图封装，使用户只需简单查询视图即可；
    - *提高安全性*：可以通过视图限制用户对某些列或行的访问，隐藏敏感数据，实现细粒度的权限控制；
    - *数据独立性*：当基本表结构发生变化时，可以通过修改视图定义来保持应用程序接口的稳定性；
    - *提供不同视角*：不同用户可能需要以不同方式查看同一数据，视图可以为不同用户提供定制化的数据视角；
    - *逻辑数据重组*：可以将来自多个表的数据组合成一个虚拟表，便于数据分析和报表生成。

  + *简述只读视图的创建方法及其作用。*

    *创建方法*：在PostgreSQL中，可以使用`CREATE VIEW`语句创建视图。如果视图包含以下特征，则自动成为只读视图：
    - 包含聚合函数（如SUM、AVG、COUNT等）
    - 包含DISTINCT、GROUP BY、HAVING子句
    - 包含UNION、INTERSECT、EXCEPT等集合操作
    - 包含子查询在FROM子句中

    也可以使用安全屏障视图或规则系统明确限制更新操作。

    *作用*：
    - 防止通过视图误修改基础数据；
    - 保护统计汇总数据的一致性；
    - 提供纯查询接口，确保数据安全性。

  + *举例说明用带有"WITH CHECK OPTION"子句的CREATE VIEW语句创建检查视图的作用。*

    示例：
    ```sql
    CREATE VIEW emp_dept30 AS
    SELECT * FROM emp WHERE deptno = 30
    WITH CHECK OPTION;
    ```

    *作用*：`WITH CHECK OPTION`确保通过视图进行的INSERT和UPDATE操作必须满足视图定义的WHERE条件。在上例中：
    - 不能通过`emp_dept30`视图插入deptno不为30的员工记录；
    - 不能将现有员工的deptno修改为30以外的值；
    - 如果违反条件，操作将被拒绝并返回错误。

    这保证了数据完整性，防止用户通过视图绕过业务规则修改数据。

  + *什么样的视图是不能更新的？*

    以下类型的视图通常不能更新：
    - 包含聚合函数（SUM、AVG、COUNT、MAX、MIN等）的视图；
    - 使用GROUP BY或HAVING子句的视图；
    - 使用DISTINCT关键字的视图；
    - 包含UNION、INTERSECT、EXCEPT等集合操作的视图；
    - FROM子句中包含多个表（多表连接）且未明确指定更新规则的视图；
    - SELECT列表中包含表达式、常量或子查询的视图；
    - 包含窗口函数的视图；
    - FROM子句中包含不可更新视图的视图。

  + *如何利用Oracle系统的数据字典，查看用户所拥有的视图的相关信息？*

    在Oracle中可以查询以下数据字典视图：
    ```sql
    -- 查看用户创建的所有视图
    SELECT view_name, text FROM user_views;

    -- 查看视图的列信息
    SELECT * FROM user_tab_columns WHERE table_name = '视图名';

    -- 查看所有可访问的视图
    SELECT * FROM all_views WHERE owner = 'USER_NAME';
    ```

    在PostgreSQL中对应的查询方式：
    ```sql
    SELECT table_name, view_definition
    FROM information_schema.views
    WHERE table_schema = 'public';
    ```

  + *简述创建惟一性索引的作用。*

    唯一性索引的作用：
    - *保证数据唯一性*：确保索引列或列组合中不存在重复值，维护数据完整性；
    - *提高查询性能*：与普通索引一样，可以加速基于索引列的查询操作；
    - *自动用于约束*：主键和UNIQUE约束会自动创建唯一性索引；
    - *优化器提示*：数据库优化器知道该列值唯一，可以做出更优的查询计划。

    创建示例：
    ```sql
    CREATE UNIQUE INDEX idx_unique_empno ON emp(empno);
    ```

  + *如何利用Oracle系统的数据字典，查看用户所拥有的索引的相关信息？*

    在Oracle中查询索引信息：
    ```sql
    -- 查看用户的所有索引
    SELECT index_name, table_name, uniqueness
    FROM user_indexes;

    -- 查看索引的列信息
    SELECT index_name, column_name, column_position
    FROM user_ind_columns
    WHERE index_name = '索引名';
    ```

    在PostgreSQL中对应的查询：
    ```sql
    SELECT indexname, tablename, indexdef
    FROM pg_indexes
    WHERE schemaname = 'public';
    ```

  + *简述序列和同义词的作用。*

    *序列的作用*：
    - 生成唯一的数字序列，通常用作主键值；
    - 确保多用户并发环境下获取不重复的数字；
    - 提供自动递增机制，简化ID生成逻辑；
    - 支持缓存提高性能。

    *同义词的作用*（Oracle）：
    - 为数据库对象（表、视图等）提供别名；
    - 简化对象引用，隐藏对象的实际名称和位置；
    - 提供位置透明性，当对象位置改变时无需修改应用代码；
    - 实现对象访问的抽象层，便于数据库重构。

    _注：PostgreSQL不直接支持同义词，可以使用视图、模式或外部表来实现类似功能。_
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
