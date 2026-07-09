#let exp_name = "实验五 SQL单表查询"
#let exp_date = datetime(year: 2025, month: 11, day: 12)
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

  - 熟悉SQL*Plus的启动、退出和Oracle环境参数的设置方法；
  - 掌握对表的投影、选择操作；
  - 掌握简单和复杂查询条件的设置方法；
  - 掌握对查询结果进行排序的方法;
  - 掌握数据分类汇总方法。
][
  = 实验结果提交方式

  - 实验5-2
    - 利用DEPT和EMP表，完成补充实验中要求的所有实验；
    - 用\<ALT\>+\<Print Screen\>快捷键，将实验题目中每个查询所对应的SELECT语句的执行结果屏幕复制下来，记录在本实验报告中；
  - 将本实验报告存放在“XXXXXXXXXX-5.docx”文件中, 其中“XXXXXXXXXX”是学号，并在教师规定的时间内通过Canvas系统提交。
][
  = 实验5-2的实验结果

  记录如下各查询语句的执行结果

  + 查询部门“30”中的雇员的所有信息；
    - `SELECT * FROM EMP WHERE DEPTNO = 30;`
    - #image("image-1.png")
  + 查询薪金大于2000的雇员的编号、姓名、工作和薪金；
    - `SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL > 2000;`
    - #image("image-2.png")
  + 查询所有销售员的姓名、编号和部门编号；
    - `SELECT ENAME, EMPNO, DEPTNO FROM EMP WHERE JOB = 'SALESMAN';`
    - #image("image-3.png")
  + 查询佣金高于薪金的50%的雇员的所有信息；
    - `SELECT * FROM EMP WHERE 2 * COMM > SAL;`
    - #image("image-4.png")
  + 查询第1个字母为“M”的雇员姓名；
    - `SELECT ENAME FROM EMP WHERE ENAME LIKE 'M%';`
    - #image("image-5.png")
  + 查询雇员的姓名和雇佣日期，在显示姓名时只有第1个字母使用大写；
    - `SELECT INITCAP(ENAME), HIREDATE FROM EMP;`
    - #image("image-6.png")
  + 查询姓名包含6个字符的雇员信息；
    - `SELECT * FROM EMP WHERE ENAME LIKE '______';`
    - #image("image-7.png")
  + 查询姓名中不含字母“S”的所有雇员信息；
    - `SELECT * FROM EMP WHERE ENAME NOT LIKE '%S%';`
    - #image("image-8.png")
  + 查询所有雇员的姓名，以及所承担的工作名称的前5个字符；
    - `SELECT ENAME, SUBSTR(JOB, 1, 5) FROM EMP;`
    - #image("image-9.png")
  + 查询没有佣金或佣金低于200的所有雇员的姓名、工作及其佣金；
    - `SELECT ENAME, JOB, COMM FROM EMP WHERE COMM IS NULL OR COMM < 200;`
    - #image("image-10.png")
  + 查询收取佣金的雇员所承担的工作的名称，重复的工作名称应取消；
    - `SELECT UNIQUE(JOB) FROM EMP WHERE COMM IS NOT NULL;`
    - #image("image-11.png")
  + 查询部门“20”中所有分析师和部门“30”中所有办事员的详细信息；
    - `SELECT * FROM EMP WHERE (DEPTNO = 20 AND JOB = 'ANALYST') OR (DEPTNO = 30 AND JOB = 'CLERK');`
    - #image("image-12.png")
  + 查询部门“10”与“30”中所有经理以及部门“20”中所有分析师；
    - `SELECT * FROM EMP WHERE (DEPTNO IN (10, 30)) AND JOB = 'MANAGER' OR (DEPTNO = 20 AND JOB = 'ANALYST');`
    - #image("image-13.png")
  + 查询既不是经理又不是办事员但其薪金大于或等于1800的所有雇员的信息；
    - `SELECT * FROM EMP WHERE JOB NOT IN ('MANAGER', 'CLERK') AND SAL >= 1800;`
    - #image("image-14.png")
  + 查询雇员的编号、姓名、部门编号、工作、雇佣日期和薪金，查询结果先按部门编号的升序排列，部门编号相同的雇员再按雇佣日期的降序排列；
    - `SELECT EMPNO, ENAME, DEPTNO, JOB, HIREDATE, SAL FROM EMP ORDER BY DEPTNO, HIREDATE DESC;`
    - #image("image-15.png")
  + 查询所有雇员的姓名、工作和薪金，先按工作的降序排列，具有相同工作的雇员再按薪金的升序排列；
    - `SELECT ENAME, JOB, SAL FROM EMP ORDER BY JOB DESC, SAL;`
    - #image("image-16.png")
  + 查询所有在5月份雇佣的雇员的信息；
    - `SELECT * FROM EMP WHERE EXTRACT(MONTH FROM HIREDATE) = 5;`
    - #image("image-17.png")
  + 查询在各月的最后一天被雇佣的雇员的编号、姓名和雇佣日期；
    - `SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE LAST_DAY(HIREDATE) = HIREDATE;`
    - #image("image-18.png")
  + 查询雇员的编号、姓名，以及加入公司以来的总工作天数；
    - `SELECT EMPNO, ENAME, TRUNC(SYSDATE - HIREDATE) AS DAYS_EMPLOYED FROM EMP;`
    - #image("image-19.png")
  + 查询所有雇员的编号、姓名，以及加入公司的年份和月份；要求按年份的升序排列，年份相同的，按月份的升序排列；
    - `SELECT EMPNO, ENAME, EXTRACT(YEAR FROM HIREDATE) AS HIREYEAR, EXTRACT(MONTH FROM HIREDATE) AS HIREMONTH FROM EMP ORDER BY HIREYEAR, HIREYEAR;`
    - #image("image-20.png")
  + 查询所有雇员的姓名和年薪，要求按年薪的降序排列查询结果；
    - `SELECT ENAME, 12 * (NVL(SAL, 0) + NVL(COMM, 0)) AS ANNUAL_COMPENSATION FROM EMP ORDER BY ANNUAL_COMPENSATION DESC;`
    - #image("image-21.png")
  + 查询已经在公司工作了三十多年的雇员的姓名、部门号、雇佣日期和工作年数；
    - `SELECT ENAME, DEPTNO, HIREDATE, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE) AS YEARS_EMPLOYED FROM EMP WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE) > 30;`
    - #image("image-22.png")
  + 假设一个月为 30 天，计算所有雇员的日薪金（以元为单位）；
    - `SELECT FLOOR(SAL / 30) AS DAILY_SALARY FROM EMP;`
    - #image("image-23.png")
  + 查询各类别工作的平均薪金和最高薪金，以及承担各项工作的雇员人数；
    - `SELECT JOB, AVG(SAL) AS AVG_SALARY, MAX(SAL) AS MAX_SALARY, COUNT(*) AS EMP_COUNT FROM EMP GROUP BY JOB;`
    - #image("image-24.png")
  + 查询最低薪金大于1400的工作的最低薪金；
    - `SELECT JOB, MIN(SAL) AS MIN_SALARY FROM EMP GROUP BY JOB HAVING MIN_SALARY > 1400;`
    - #image("image-25.png")
  + 查询部门“20”和“30”中的雇员人数和平均工资；
    - `SELECT DEPTNO, COUNT(*) AS EMP_COUNT, AVG(SAL) AS AVG_SALARY FROM EMP GROUP BY DEPTNO HAVING DEPTNO IN (20, 30);`
    - #image("image-26.png")
  + 查询办事员的最高、最低、平均和总薪金。
    - `SELECT JOB, MAX(SAL) AS MAX_SALARY, MIN(SAL) AS MIN_SALARY, AVG(SAL) AS AVG_SALARY, SUM(SAL) AS TOTAL_SALARY FROM EMP GROUP BY JOB HAVING JOB = 'CLERK';`
    - #image("image-27.png")
][
  = 实验思考

  == SET PAGESIZE 和 SET LINESIZE 语句的作用

  #strong[SET PAGESIZE]：设置每页显示的行数

  ```sql
  SET PAGESIZE 50  -- 每页显示50行后暂停
  ```

  #strong[SET LINESIZE]：设置每行的字符宽度

  ```sql
  SET LINESIZE 100  -- 每行最多显示100个字符
  ```

  #strong[作用]：优化SQL\*Plus或其他命令行工具的显示效果，避免数据换行或分页混乱。

  == COLUMN语句的作用示例

  #strong[作用]：格式化列的输出显示

  ```sql
  -- 设置ENAME列格式：宽度15，居中对齐
  COLUMN ENAME FORMAT A15 HEADING '员工姓名' JUSTIFY CENTER

  -- 设置SAL列格式：数字格式，显示货币符号
  COLUMN SAL FORMAT $999,999.00 HEADING '薪资'

  -- 设置HIREDATE列格式：日期格式
  COLUMN HIREDATE FORMAT A10 HEADING '入职日期'

  -- 执行查询
  SELECT ENAME, SAL, HIREDATE FROM EMP;
  ```

  == 数据分类汇总的设置方法

  使用GROUP BY子句进行数据分类汇总：

  ```sql
  SELECT
      分类字段1, 分类字段2,           -- 设置分类字段
      汇总方式(被汇总字段) AS 别名     -- 设置汇总方式和被汇总字段
  FROM 表名
  GROUP BY 分类字段1, 分类字段2;       -- 指定分类字段
  ```

  #strong[示例]：

  ```sql
  -- 按部门和职位分类，汇总薪资
  SELECT
      DEPTNO, JOB,                    -- 分类字段：部门、职位
      COUNT(*) AS 人数,               -- 汇总方式：计数
      AVG(SAL) AS 平均薪资,           -- 汇总方式：平均值
      SUM(SAL) AS 总薪资              -- 汇总方式：求和
  FROM EMP
  GROUP BY DEPTNO, JOB;               -- 设置分类字段
  ```

  == WHERE子句和HAVING子句的区别
  #figure(
    align(center)[#table(
      columns: 3,
      align: (auto, auto, auto),
      table.header([特性], [WHERE子句], [HAVING子句]),
      table.hline(),
      [#strong[执行时机]], [在分组前过滤记录], [在分组后过滤分组结果],
      [#strong[使用对象]], [针对原始记录], [针对分组后的结果集],
      [#strong[可用的字段]], [表中所有字段], [GROUP BY中的字段或聚合函数],
      [#strong[聚合函数]], [不能直接使用], [可以直接使用],
    )],
    kind: table,
  )

  #strong[示例对比]：

  ```sql
  -- WHERE：分组前过滤，筛选薪资>2000的员工
  SELECT DEPTNO, AVG(SAL)
  FROM EMP
  WHERE SAL > 2000                    -- 先过滤个体记录
  GROUP BY DEPTNO;

  -- HAVING：分组后过滤，筛选平均薪资>2500的部门
  SELECT DEPTNO, AVG(SAL)
  FROM EMP
  GROUP BY DEPTNO
  HAVING AVG(SAL) > 2500;             -- 后过滤分组结果

  -- 组合使用
  SELECT DEPTNO, AVG(SAL)
  FROM EMP
  WHERE JOB != 'MANAGER'              -- 先排除经理
  GROUP BY DEPTNO
  HAVING AVG(SAL) > 2000;             -- 再筛选高平均薪资部门
  ```

  == 需要注意字符大小写问题的场景
  + #strong[表名和列名]：在Oracle中默认不区分大小写，但创建时如果使用双引号则区分

    ```sql
    CREATE TABLE "Employee"  -- 创建时必须用"Employee"引用
    SELECT * FROM Employee   -- 错误：表不存在
    SELECT * FROM "Employee" -- 正确
    ```

  + #strong[字符串比较]：WHERE子句中的字符串值区分大小写

    ```sql
    SELECT * FROM EMP WHERE ENAME = 'smith'   -- 可能无结果
    SELECT * FROM EMP WHERE ENAME = 'SMITH'   -- 正确
    ```

  + #strong[函数处理]：使用UPPER()或LOWER()统一大小写

    ```sql
    SELECT * FROM EMP WHERE UPPER(ENAME) = UPPER('Smith')
    ```

  + #strong[LIKE模糊查询]：区分大小写

    ```sql
    SELECT * FROM EMP WHERE ENAME LIKE 'S%'   -- 只匹配大写S开头
    ```

  + #strong[ORDER
      BY排序]：字符串排序基于字符的ASCII码，大小写会影响排序结果

][
  = 思考结果

  数据库单表查询实验让我对数据检索有了更深刻的认识。首先，我体会到精确理解业务需求是编写有效查询的前提，只有明确要解决什么问题，才能选择合适的查询条件和排序方式。查询语句的每个组成部分都承载着特定的语义功能，它们相互配合共同完成数据筛选任务。

  其次，条件表达式的构造需要兼顾准确性与完整性。特别是在处理边界值和空值时，必须考虑各种可能出现的情况，避免因条件不周全而导致数据遗漏或包含冗余信息。这种严谨性的培养对后续的数据分析工作具有重要意义。

  在实验过程中，我逐渐建立了查询优化的意识。虽然单表查询的性能问题不太显著，但已经能够感受到不同写法可能带来的效率差异。选择恰当的查询条件顺序和避免不必要的计算，这些习惯的养成对处理大规模数据很有帮助。

  调试能力的提升是另一个重要收获。当查询结果不符合预期时，需要系统地分析可能的原因，从语法错误到逻辑错误，从数据理解偏差到条件设置不当，这种问题分解的思维方式适用于各种编程场景。

  最后，这次实验让我认识到数据库查询不仅是技术操作，更是思维训练。它要求我们同时保持逻辑的严谨性和思维的灵活性，在遵循语法规则的前提下创造性地解决实际问题。这种能力将在未来的学习和工作中持续发挥价值。

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
