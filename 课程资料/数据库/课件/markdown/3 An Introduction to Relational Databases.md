# An Introduction to Relational Databases

![](images/7d294a10647a76f964a683c7c01b50c33fafd4535468ab51c33baaf5eab5f796.jpg)

# What will you learn?

1. Data model  
2. Relational Model Concepts  
3. An Informal Look at the Relational Model  
4. Relvars  
5. Optimization  
6. Data Dictionary  
7. Base Relvars and Views  
8. Transactions

# 1. Data model

A data model is an abstract, self-contained, logical definition of the objects, operators.

■ Objects: model the structure of data (e.g., data type, relationships, and constraints).  
Operators : model the behavior of objects.

A database schema is the description of a database using a data model.  
Data modeling is the process of creating a data model for an application.

# Categories of Data Models

Based on level of data abstraction

Conceptual level (high-level)

■ Provide concepts that are close to the way many users perceive data.  
Approaches: Entity-reationship (ER) model, semantic object model, etc.  
Semantic Object Model : Define semantic objects; Use semantic object diagrams to build data models;

Logical level (DBMS level)

■ Provide concepts that are close to the way data is organized but still may be understood by end users.  
Approaches: relational, object-oriented, network, and hierarchical model.

Physical level (low-level)

■ Provide concepts that describe the details of how data is stored in the computer.

# 2. Relational Model Concepts

Relational data model: represents the data in a database as a collection of relations (tables).

First introduced by Codd in 1970  
Based on mathematical notion of domain and relation  
A relation can be easily represented in a table format although they are not the same.

![](images/b3d9f03af507306fe4f59450eb2b6bf1067ce56fbf58259ade11d77e0030aa5a.jpg)  
1981年图灵奖获得者：埃德加·科德  
(Edgar Frank Codd)  
“关系数据库之父”

Relational data model is just one data modeling technique for a database.  
Relational systems are based on the relational model.

# 在 IBM 加州圣何塞硅谷实验室里工作的数学家兼计算机科学家 Edgar Frank Codd--- 数据库产业的祖师爷

![](images/315fa877fae7d854d76c4b19aff55a34befc4d7871e5c7559a06729d14d9d6ef.jpg)

英格兰人，二战时候是飞行员，后来到美国给IBM服务。再后来，因为美国麦卡锡风潮辗转去了加拿大。之后又回美国IBM工作，顺便去密西根大学拿了一个PhD。Edgar Codd的PhD做的是冯诺依曼架构计算模型的扩展，非常的理论。

# An introduction to Database Systems

1970年，在加州圣何塞硅谷实验室里工作的Edgar Frank Codd公开发表了一篇论文：A Relational Model of Data for Large Shared Data Banks。翻译成中文就是一个为大容量共享数据银行设计的数据的关系模型。提出了数据的关系模型，也就是著名的关系代数。

这篇论文是基于 1969 年他在 IBM 的内部工作报告的基础上修改的。所以关系模型到底诞生于哪一年，是一个有争论的事情。很多人通常认为 1970 年是它诞生的时候。

从此以后，他就开启了关系数据库长达50多年至今屹立不倒的整个产业。他1981年获得计算机界最高奖图灵奖，2003年年去世。2004年为了他，SIGMOD把其最高奖改名为SIGMOD Edgar F. Codd Innovations Award。

SIGMOD, 全称数据管理国际会议 (Special Interest Group on Management Of Data), 是由美国计算机协会 (ACM) 数据管理专业委员会 (SIGMOD) 发起、在数据库领域具有最高学术地位的国际性学术会议

# An introduction to Database Systems

![](images/4e502de0fe2dd137684f68c3be6ce97a4a71dc9460047f28cc3450b20ba1833e.jpg)  
Relational Model Concepts(Continued)  
Fig. 5.1 Structural terminology

# Relational Model Concepts(Continued)

Attribute (field or column)  
Relation (table)

e.g., person, emp ,course, etc.

Tuple (record or row)

The set of attribute values for an object.

Cardinality

The number of tuples

# Relational Model Concepts(Continued)

# Degree

The number of attributes

# Domain (type with some constraints)

The set of all possible values an attribute can have.  
It is a description of the format (type, length, etc.) and the semantics of an attribute.  
Domains are data types  
Domains are object classes

# Relational Model Concepts(Continued)

s

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr><tr><td>S5</td><td>Adams</td><td>30</td><td>Athens</td></tr></table>

SP

<table><tr><td>S#</td><td>P#</td><td>QTY</td></tr><tr><td>S1</td><td>P1</td><td>300</td></tr><tr><td>S1</td><td>P2</td><td>200</td></tr><tr><td>S1</td><td>P3</td><td>400</td></tr><tr><td>S1</td><td>P4</td><td>200</td></tr><tr><td>S1</td><td>P5</td><td>100</td></tr><tr><td>S1</td><td>P6</td><td>100</td></tr><tr><td>S2</td><td>P1</td><td>300</td></tr><tr><td>S2</td><td>P2</td><td>400</td></tr><tr><td>S3</td><td>P2</td><td>200</td></tr><tr><td>S4</td><td>P2</td><td>200</td></tr><tr><td>S4</td><td>P4</td><td>300</td></tr><tr><td>S4</td><td>P5</td><td>400</td></tr></table>

P

<table><tr><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td><td>CITY</td></tr><tr><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>P2</td><td>Bolt</td><td>Green</td><td>17.0</td><td>Paris</td></tr><tr><td>P3</td><td>Screw</td><td>Blue</td><td>17.0</td><td>Rome</td></tr><tr><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td><td>London</td></tr><tr><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td><td>Paris</td></tr><tr><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td><td>London</td></tr></table>

Fig. 3.8. The Suppliers and parts database(sample values)

# Relational Model Concepts(Continued)

# Primary key

is an attribute, or a collection of attributes, whose values uniquely identify each tuple in a relation.

# Relationship

is the related information between relations. Relationship can be represented by common attribute (s) between relations.

# Foreign key

is the common attribute (s) between relations and that is a primary key in other related relation.

![](images/b90930d7886fad62ec3cd03bfa42b48743debee4dc9bf379d9b3e02a8c30ea41.jpg)

# An introduction to Database Systems

# Relational Model Concepts(Continued)

# A precise definition of the term relation

Given a collection of  $n$  types or domains  $T_i$  ( $i = 1, 2, \dots, n$ ), not necessarily all distinct,  $r$  is a relation on those types if it consists of two parts, a heading and a body, where:

The heading is a set of n attributes of the form Ai:Ti, where the Ai (which must all be distinct) are the attribute names of r and the Ti are the corresponding type names (i = 1, 2, ..., n);  
The body is a set of m tuples t, where t in turn is a set of components of the form Ai:vi in which vi is a value of type Ti—the attribute value for attribute Ai of tuple t (i = 1, 2, ..., n).

The values  $m$  and  $n$  are called the cardinality and the degree, respectively, of relation  $r$ .

Table=relation?

# Properties of relations

1 There are no duplicate tuples; Column names must be unique;

ENGINE_1 ENGINE_2 ENGINE_3 ENGINE_4

Column names must be unique

AIRCRAFT  

<table><tr><td>SERIAL_NUMBER</td><td>ACQUIRED</td><td>ENGINE</td><td>ENGINE</td><td>ENGINE</td><td>ENGINE</td></tr><tr><td>B238725737</td><td>1994-07-21</td><td>P0102313</td><td>P0102314</td><td></td><td></td></tr><tr><td>B238768737</td><td>1997-05-12</td><td>R0942497</td><td>R0942498</td><td></td><td></td></tr><tr><td>B167029747</td><td>1992-10-20</td><td>G0015237</td><td>G0015240</td><td>G0025635</td><td>G0025678</td></tr><tr><td>A11599320</td><td>1994-02-19</td><td>R0307023</td><td>R0307025</td><td></td><td></td></tr><tr><td>A11599320</td><td>1994-02-19</td><td>R0307023</td><td>R0307025</td><td></td><td></td></tr><tr><td>A203623340</td><td>1996-08-01</td><td>R0346723</td><td>R0346724</td><td>R0346743</td><td>R0346744</td></tr></table>

# Properties of relations

2 Tuples are unordered, top to bottom;  
3 Attributes are unordered, left to right;

<table><tr><td>TYPE</td><td>MODEL</td><td>CATEGORY</td><td>MANUFACTURER</td><td>ENGINEES</td></tr><tr><td>A340</td><td>100</td><td>JET</td><td>AIRBUS</td><td>4</td></tr><tr><td>B737</td><td>500</td><td>JET</td><td>BOEING</td><td>2</td></tr><tr><td>B737</td><td>700</td><td>JET</td><td>BOEING</td><td>2</td></tr><tr><td>A320</td><td>200</td><td rowspan="2" colspan="3">Unordered Retri</td></tr><tr><td>B747</td><td>400</td></tr></table>

Next time, rows may be returned in a different sequence  
Next ti

Next time

First time  

<table><tr><td>TYPE</td><td>MODEL</td><td>CATEGORY</td><td>ENGINEES</td><td>MANUFACTURER</td></tr><tr><td>A320</td><td>200</td><td>JET</td><td>2</td><td>AIRBUS</td></tr><tr><td>A340</td><td>100</td><td>JET</td><td>4</td><td>AIRBUS</td></tr><tr><td>B737</td><td>500</td><td>JET</td><td>2</td><td>BOEING</td></tr><tr><td>B737</td><td>700</td><td>JET</td><td>2</td><td>BOEING</td></tr><tr><td>B747</td><td>400</td><td>JET</td><td>4</td><td>BOEING</td></tr></table>

# Properties of relations

4 Each tuple contains exactly one value for each attribute.

A relation that satisfies this fourth property is said to be normalized, or equivalently to be in first normal form.

# 3. An Informal Look at the Relational Model

Structural aspect: tables  
■ Integrity aspect: Those tables satisfy certain integrity constraints (IC)  
■ Manipulative aspect: operators restrict, project, and join.

# Structural aspect: Table

DEPT

<table><tr><td>DEPT#</td><td>DNAME</td><td>BUDGET</td></tr><tr><td>D1</td><td>Marketing</td><td>10M</td></tr><tr><td>D2</td><td>Development</td><td>12M</td></tr><tr><td>D3</td><td>Research</td><td>5M</td></tr></table>

EMP

<table><tr><td>EMP#</td><td>ENAME</td><td>DEPT#</td><td>SALARY</td></tr><tr><td>E1</td><td>Lopez</td><td>D1</td><td>40K</td></tr><tr><td>E2</td><td>Cheng</td><td>D1</td><td>42K</td></tr><tr><td>E3</td><td>Finzi</td><td>D2</td><td>30K</td></tr><tr><td>E4</td><td>Saito</td><td>D2</td><td>35K</td></tr></table>

Fig. 3.1 The dept and emp relation in a table format

# Structural aspect: Table (Continued)

Tables are the logical structure in a relational system, not the physical structure.  
At the physical level, in fact, the system is free to store the data any way it likes—using sequential files, indexing, hashing, pointer chains, compression, etc.  
The Information Principle: The entire information content of the database is represented in one and only one way, namely as explicit values in column positions in rows in tables. There are no pointers connecting one table to another.

# integrity constraints

Primary Key constraints

Primary key value must be unique for every tuple in a relation  
No primary key value can be NULL

Domain constraints

The constraints on the domain of attributes. (CHECK clause)

Referential integrity constraint

■ Foreign key constraint, e.g., A tuple in one relation that refers to another relation must refer to an existing tuple in that relation.  
To maintain the consistency among tuples of the two related relations.

Other constraints: functional dependency, assertions, triggers.

# operators

# The property of relational operators

■ Closure property:The result of relational operations is table(set at a time).  
Nested expressions:The output from one operation can become input to another.  
Relational languages are nonprocedural, on the grounds that users specify what, not how—i.e., they say what they want, without specifying a procedure for getting it. (automatic navigation)

An introduction to Database Systems  
Fig 3.5 Automatic vs. manual navigation  
```sql
INSERT INTO SP (S#, P#, QTY) VALUES ('S4', 'P3', 1000);   
MOVE 'S4' TO S# IN S   
FIND CALC S   
ACCEPT S-SP-ADDR FROM S-SP CURRENCY   
FIND LAST SP WITHIN S-SP   
while SP found PERFORM ACCEPT S-SP-ADDR FROM S-SP CURRENCY FIND OWNER WITHIN P-SP GET P IF P# IN P < 'P3' leave loop END-IF FIND PRIOR SP WITHIN S-SP   
END-PERFORM   
MOVE 'P3' TO P# IN P   
FIND CALC P   
ACCEPT P-SP-ADDR FROM F-SP CURRENCY   
FIND LAST SP WITHIN P-SP   
while SP found PERFORM ACCEPT P-SP-ADDR FROM P-SP CURRENCY FIND OWNER WITHIN S-SP GET S IF S# IN S < 'S4' leave loop END-IF FIND PRIOR SP WITHIN P-SP   
END-PERFORM   
MOVE 1000 TO QTY IN SP   
FIND DB-KEY IS S-SP-ADDR   
FIND DB-KEY IS P-SP-ADDR   
STORE SP   
CONNECT SP TO S-SP   
CONNECT SP TO P-SP
```

# 4. Relvars

Relvar:relational variables

E.g. Customer, Product, Type, DEPT, EMP

The values of Relvar is relation values.  
The relation values is different at different times.

delete  $\rightarrow$  relational assignment operation

# Relations and Relvars (Continued)

# Relational assignment

EMP:=EMP MINUS (EMP WHERE E#=“E4”);

![](images/ddf73176f04c12c4993b437cac4c8b03c615060b3a35bc1b72a02745707f0805.jpg)

DELETE EMP WHERE E#="E4";

EMP

<table><tr><td>EMP#</td><td>ENAME</td><td>DEPT#</td><td>SALARY</td></tr><tr><td>E1</td><td>Lopez</td><td>D1</td><td>40K</td></tr><tr><td>E2</td><td>Cheng</td><td>D1</td><td>42K</td></tr><tr><td>E3</td><td>Finzi</td><td>D2</td><td>30K</td></tr></table>

# 5. Optimization

Relational systems are sometimes said to perform automatic navigation.  
For each relational request from the user, it is the job of the optimizer to choose an efficient way to implement that request.

RESULT:=(EMP WHERE EMP#='e4'){SALARY};

two ways of performing the necessary data access:

■ By doing a physical sequential scan of (the stored version of) relvar EMP until the required data is found;  
If there is an index on (the stored version of) the EMP# column, use that index and going directly to the required data.

# Optimization (Continued)

The basis of considerations of optimization:

Which relvars are referenced in the request;  
How big those relvars currently are;  
What indexes exist;  
How selective those indexes are;  
How the data is physically clustered on the disk;  
What relational operations are involved;

# 6. The Catalog (or Data Dictionary)

- contains detailed information (sometimes called descriptor information or metadata) regarding the various objects that are of interest to the system itself.  
The place where

■ all of the various schemas (external, conceptual, internal)  
■ all of the corresponding mappings (external/conceptual, conceptual/internal)

are kept.

Optimizer uses... security subsystem use...

# The Catalog…

The catalog itself consists of system relvars.

![](images/504433f9068b1fca2dcbd87f8f6f73718ee23f3e274aad8072015087afb49669.jpg)  
Fig. 3.6 Catalog for the departments and employees database

# The Catalog…

■ users can interrogate the catalog in exactly the same way they interrogate their own data.

1. what columns relvar DEPT contains?

(COLUMN WHERE TABNAME='DEPT'){COLNAME};

2. Which relvars include a column called EMP#?

(COLUMN WHERE COLNAME='EMP#'){TABNAME};

3. What does the following do?

((TABLE JOIN COLUMN)

WHERE COLCOUNT<5){TABNAME,COLNAME};

# 7. Base Relvars and Views

P71~75

The original (given) relvars are called base relvars, and their relation values are called base relations (real relvar);  
A relation that is or can be obtained from those base relations by means of some relational expression is called a derived or derivable relation.

# View

A view is a derived relvarvirtual relvar).

e.g. CREATE VIEW TOPEMP AS

(EMP WHERE SALARY >33K){EMP#,ENAME,SALARY};

TOPEMP

<table><tr><td>EMP#</td><td>ENAME</td><td>DEPT</td><td>SALARY</td></tr><tr><td>E1</td><td>Lopez</td><td>D1</td><td>40K</td></tr><tr><td>E2</td><td>Cheng</td><td>D1</td><td>42K</td></tr><tr><td>E3</td><td>Fianz</td><td>D2</td><td rowspan="2">35K</td></tr><tr><td>E4</td><td>Saito</td><td>D2</td></tr></table>

Fig. TOPEMP as a view of EMP(unshaded portions)

# View (Continued)

A view can be derived from several tables or views.

E.g.

CREATE VIEW JOINEX AS

((EMP JOIN DEPT)

WHERE BUDGE>7M){EMP#,DEPT#};

# View (Continued)

The view is effectively just a window into the underlying base relvar.  
Any changes to that underlying relvar will be automatically and instantaneously visible through that window.

# View (Continued)

Changes to TOPEMP will automatically and instantaneously be applied to relvar EMP.

e.g.

(TOPEMP WHERE SALARY<42k){EMP#,SALARY}

![](images/418c3479ebff96dfa2a579230decf1b36ef70e5cd503561a22dc5d2f889a178e.jpg)

((EMP WHERE SALARY>33K){EMP#,ENAME,SALARY})

WHERE SALARY<42k){EMP#,SALARY}

# View (Continued)

e.g.

DELETE TOPEMP WHERE SALARY<42k;

![](images/0de7db4d676017e9630fecccd6e4b0432dd03f2c220007bd1dca1e5ffedcb99f.jpg)

DELETE EMP

WHERE SALARY>33K AND SALARY<42K;

在 SQL 语言中，引入视图机制的主要优点：

简化用户的操作;  
能以多种角度看待同一数据;  
■对重构数据库提供了一定程度的逻辑独立性；  
■对机密数据提供安全保护;  
可以更清晰的表达查询。

# 8. Transactions

A transaction is a logical unit of work, typically involving several database operations.  
BEGIN TRANSACTION, COMMIT, and ROLLBACK

# An introduction to Database Systems

# An example of transaction

BEGIN TRANSACTION

.

/* 读出帐户 Acct1 的余额 Balance1*/

EXEC SQL SELECT balance

INTO :Balance1

FROM Accounts

WHERE AccountNo=:Acct1 ;

/* 从帐户 Acct1 中减去金额 Amount*/

EXEC SQL UPDATE Accounts

SET balance=balance:-Amount

WHERE AccountNo=:Acct1 ;

IF（Balance1<Amount）{printf（“金额不足，不能转帐！”）；/\*恢复事务，撤消所有操作\*/EXEC SQL ROLLBACK;  
}

ELSE

{

/* 对帐户 Acct2 增加金额 Amount*/

EXEC SQL UPDATE Accounts

SET balance=balance+:Amount

WHERE AccountNo=:Acct2 ;

EXEC SQL COMMIT ; /* 提交事务 */

}… 38

# property of transactions

Atomic: Transactions are guaranteed either to execute in their entirety or not to execute at all.  
■ Durability: Once a transaction successfully executes COMMIT, its updates are guaranteed to be applied to the database, even if the system subsequently fails at any point.

# property of transactions (Continued)

■ Isolation: Database updates made by a given transaction T1 are not made visible to any distinct transaction T2 until and unless T1 successfully executes COMMIT.  
■ Serialization: The interleaved execution of a set of concurrent transactions produces the same result as executing those same transactions one at a time in some unspecified serial order.

Example  

<table><tr><td>事务T1</td><td>事务T2</td><td>数据库中的值</td><td>事务T1</td><td>事务T2</td><td>数据库中的值</td></tr><tr><td>read (A)</td><td></td><td>A=50</td><td></td><td>read (A)</td><td>A=50</td></tr><tr><td>A:=A-2</td><td></td><td></td><td></td><td>A:=A-2</td><td></td></tr><tr><td>write (A)</td><td></td><td>A=48</td><td></td><td>write (A)</td><td>A=48</td></tr><tr><td>read (B)</td><td></td><td>B=100</td><td></td><td>read (B)</td><td>B=100</td></tr><tr><td>B:=B-1</td><td></td><td></td><td></td><td>B:=B-1</td><td></td></tr><tr><td>write (B)</td><td></td><td>B=99</td><td></td><td>write (B)</td><td>B=99</td></tr><tr><td></td><td>read (A)</td><td>A=48</td><td>read (A)</td><td></td><td>A=48</td></tr><tr><td></td><td>A:=A-2</td><td></td><td>A:=A-2</td><td></td><td></td></tr><tr><td></td><td>write (A)</td><td>A=46</td><td>write (A)</td><td></td><td>A=46</td></tr><tr><td></td><td>read (B)</td><td>B=99</td><td>read (B)</td><td></td><td>B=99</td></tr><tr><td></td><td>B:=B-1</td><td></td><td>B:=B-1</td><td></td><td></td></tr><tr><td></td><td>write (B)</td><td>B=98</td><td>write (B)</td><td></td><td>B=98</td></tr><tr><td colspan="3">串行调度1:先T1后T2</td><td colspan="3">串行调度2:先T2后T1</td></tr></table>

Result:A=46,B=98

# Example…

<table><tr><td>事务T1</td><td>事务T2</td><td>数据库中的值</td><td>事务T1</td><td>事务T2</td><td>数据库中的值</td></tr><tr><td>read (A)</td><td></td><td>A=50</td><td>read (A)</td><td></td><td>A=50</td></tr><tr><td>A:=A-2</td><td></td><td></td><td>A:=A-2</td><td></td><td></td></tr><tr><td>write (A)</td><td></td><td>A=48</td><td>write (A)</td><td></td><td>A=48</td></tr><tr><td></td><td>read (A)</td><td></td><td>read (B)</td><td></td><td>B=100</td></tr><tr><td></td><td>A:=A-2</td><td></td><td></td><td>read (A)</td><td>A=48</td></tr><tr><td></td><td>write (A)</td><td>A=46</td><td></td><td>A:=A-2</td><td></td></tr><tr><td></td><td></td><td>B=100</td><td></td><td>write (A)</td><td>A=46</td></tr><tr><td>read (B)</td><td></td><td></td><td></td><td>read (B)</td><td>B=100</td></tr><tr><td>B:=B-1</td><td></td><td>B=99</td><td>B:=B-1</td><td></td><td></td></tr><tr><td>write (B)</td><td>read (B)</td><td></td><td>write (B)</td><td></td><td>B=99</td></tr><tr><td></td><td>B:=B-1</td><td></td><td></td><td>B:=B-1</td><td></td></tr><tr><td></td><td>write (B)</td><td>B=98</td><td></td><td>write (B)</td><td>B=98</td></tr><tr><td colspan="3">并发调度1</td><td colspan="3">并发调度2</td></tr></table>

Result:

$$
A = 4 6, B = 9 8 \sqrt {}
$$

Result:

$$
A = 4 6, B = 9 8 \sqrt {}
$$

例：设有一个飞机机票订票系统，考虑如下售票活动的并发操作问题：

1、售票员 A 通过网络在数据库中读出某航班的机票余额为 y 张，设  $y = 15$ ；  
2、售票员 B 通过网络在数据库中读出某航班的机票余额为 y 张，设  $y = 15$ ；  
3、售票员 A 卖出一张机票, 然后修改余额为  $y = y - 1$ , 此时,  $y = 14$ , 将 14 写进数据库;  
4、售票员 B 卖出一张机票, 然后修改余额为  $y = y - 1$ , 此时,  $y = 14$ , 将 14 写进数据库;

这个售票活动并发操作的结果是：实际已经卖出 2 张机票，但在数据库中机票余额仅减少 1，从而导致错误。这就是著名的飞机机票订票系统问题。

这个问题之所以会产生错误，其根本原因在于两个用户反复交叉地使用同一个数据库的结果。

# 多事务执行方式

- 事务串行执行（serial）

每个时刻只有一个事务运行，其他事务必须等到这个事务结束以后方能运行。

>不能充分利用系统资源，不能发挥数据库共享资源的特点。

- 交叉并发方式 (interleaved concurrency)

是这些并行事务的并行操作轮流交叉运行，是单处理机系统中的并发方式。

能够减少处理机的空闲时间，提高系统的效率。

- 同时并发方式 (simultaneous concurrency>

多处理机系统中，每个处理机可以运行一个事务，多个处理机可以同时运行多个事务，实现多个事务真正的并行运行。

>最理想的并发方式，但受制于硬件环境。

![](images/0cc459711bfbe36d7ddc00a046a72ead0e94f8a0a4580c727476922610dec924.jpg)

并行 (parallel) : 指在同一时刻, 有多条指令在多个处理器上同时执行。所以无论从微观还是从宏观来看, 二者都是一起执行的。

![](images/4eb5faa9fe71884414c08f7bd55b637b5f35dfd9af3788fc959fc83b7d99613b.jpg)

并发 (concurrency)：指在同一时刻只能有一条指令执行，但多个进程指令被快速的轮换执行，使得在宏观上具有多个进程同时执行的效果，但在微观上并不是同时执行的，只是把时间分成若干段，使多个进程快速交替的执行。

并行在多处理器系统中存在，而并发可以在单处理器和多处理器系统中都存在，并发能够在单处理器系统中存在是因为并发是并行的假象。并行要求程序能够同时执行多个操作，而并发只是要求程序假装同时执行多个操作（每个小时间片执行一个操作，多个操作快速切换执行）。

在数据库管理系统中对事务采用并发机制的主要目的有两个：

# 1、改善系统的资源利用率

对于一个事务来讲，在不同的执行阶段需要的资源不同，有时需要CPU，有时需要访问磁盘，有时需要I/O、有时需要通信。如果事务串行执行，有些资源可能会空闲；如果事务并发执行，则可以交叉利用这些资源，有利于提高系统资源的利用率。

# 2、改善短事务的响应时间

设有两个事务 T1 和 T2，其中 T1 是长事务，交付系统在先；T2 是短事务，交付系统比 T1 稍后。如果串行执行，则须等 T1 执行完毕后才能执行 T2。而 T2 的响应时间会很长。一个长事务的响应时间长一些还可以得到用户的理解，而一个短事务的响应时间过长，用户一般难以接受。

如果 T1 和 T2 并发执行，则 T2 可以和 T1 重叠执行，可以较快地结束，明显地改善其响应时间。