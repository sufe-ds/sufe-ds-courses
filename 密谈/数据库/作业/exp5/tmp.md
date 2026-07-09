## 1. SET PAGESIZE 和 SET LINESIZE 语句的作用

**SET PAGESIZE**：设置每页显示的行数

```sql
SET PAGESIZE 50  -- 每页显示50行后暂停
```

**SET LINESIZE**：设置每行的字符宽度

```sql
SET LINESIZE 100  -- 每行最多显示100个字符
```

**作用**：优化SQL*Plus或其他命令行工具的显示效果，避免数据换行或分页混乱。

## 2. COLUMN语句的作用示例

**作用**：格式化列的输出显示

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

## 3. 数据分类汇总的设置方法

使用GROUP BY子句进行数据分类汇总：

```sql
SELECT 
    分类字段1, 分类字段2,           -- 设置分类字段
    汇总方式(被汇总字段) AS 别名     -- 设置汇总方式和被汇总字段
FROM 表名
GROUP BY 分类字段1, 分类字段2;       -- 指定分类字段
```

**示例**：

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

## 4. WHERE子句和HAVING子句的区别

| 特性 | WHERE子句 | HAVING子句 |
|------|-----------|------------|
| **执行时机** | 在分组前过滤记录 | 在分组后过滤分组结果 |
| **使用对象** | 针对原始记录 | 针对分组后的结果集 |
| **可用的字段** | 表中所有字段 | GROUP BY中的字段或聚合函数 |
| **聚合函数** | 不能直接使用 | 可以直接使用 |

**示例对比**：

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

## 5. 需要注意字符大小写问题的场景

1. **表名和列名**：在Oracle中默认不区分大小写，但创建时如果使用双引号则区分

   ```sql
   CREATE TABLE "Employee"  -- 创建时必须用"Employee"引用
   SELECT * FROM Employee   -- 错误：表不存在
   SELECT * FROM "Employee" -- 正确
   ```

2. **字符串比较**：WHERE子句中的字符串值区分大小写

   ```sql
   SELECT * FROM EMP WHERE ENAME = 'smith'   -- 可能无结果
   SELECT * FROM EMP WHERE ENAME = 'SMITH'   -- 正确
   ```

3. **函数处理**：使用UPPER()或LOWER()统一大小写

   ```sql
   SELECT * FROM EMP WHERE UPPER(ENAME) = UPPER('Smith')
   ```

4. **LIKE模糊查询**：区分大小写

   ```sql
   SELECT * FROM EMP WHERE ENAME LIKE 'S%'   -- 只匹配大写S开头
   ```

5. **ORDER BY排序**：字符串排序基于字符的ASCII码，大小写会影响排序结果
