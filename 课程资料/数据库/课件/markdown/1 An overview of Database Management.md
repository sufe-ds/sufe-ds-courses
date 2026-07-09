# An overview of Database Management

![](images/c5acc92f7cc4910852cb8755306175963141036f75261fc023805d7d35ab069a.jpg)  
Chapter 1

# Today, Organizations Need…

Information to compete effectively  
Information just to stay alive in the information age  
Information organized in such a way that you can easily and quickly get to it  
■ Information-processing tools that help you work with information

# Applications of Database Systems

# Supermarket:

bar code reader, price of the item, products database

# Credit Card:

the purchases, credit limit, list of stolen or lost cards

# Travel Agent:

holiday, flight and hotel details

# University Library:

books, users and reservations

# An introduction to Database Systems

# What you will learn

1 What is a database system?  
2 Why are database systems desirable?  
3 Simple Operations on database  
4 Components of the Database System  
5 Types of data models and the differences between them  
6 Data Independence  
7 Others

# 1 What is Database system?

(1)

A database system is basically just a computerized record-keeping system.

Electronic filing cabinet

![](images/d28334f21b83a8f79db0df388d7789daf8aa8b0f1670985558fadc9a47881609.jpg)  
Fig. 1.4 Simplified picture of a database system

computerized record-keeping system  
store information  
□ allow users to retrieve and update that information on demand

# (2)

A database system is a shared collection of logically related data (and a description of this data), designed to meet the information needs of an organization.

Data and information ?

Logical deals with how knowledge workers view their information needs, and includes such terms as:

CHARACTER - our smallest unit of information.  
■ FIELD - group of related characters.  
RECORD - group of related fields.  
FILE - group of related records.  
DATABASE - group of logically associated files.  
DATA WAREHOUSE - information from many databases.

# An introduction to Database Systems

EMPLOYEE  

<table><tr><td>EMPNO</td><td>FIRSTNME</td><td>MID INIT</td><td>LASTNAME</td><td>WORK DEPT</td><td>...</td></tr><tr><td>000010</td><td>CHRISTINE</td><td>I</td><td>HAAS</td><td>A00</td><td></td></tr><tr><td>000020</td><td>MICHAEL</td><td>L</td><td>THOMPSON</td><td>B01</td><td></td></tr><tr><td>000030</td><td>SALLY</td><td>A</td><td>KWAN</td><td>C01</td><td></td></tr><tr><td>000050</td><td>JOHN</td><td>B</td><td>GEYER</td><td>E01</td><td></td></tr><tr><td>000060</td><td>IRVING</td><td>F</td><td>STERN</td><td>D11</td><td></td></tr><tr><td>000070</td><td>EVA</td><td>D</td><td>PULASKI</td><td>D21</td><td></td></tr></table>

DEPARTMENT  

<table><tr><td>DEPT
NO</td><td>DEPTNAME</td><td>...</td></tr><tr><td>A00</td><td>SPIFFY COMPUTER SERVICE DIV.</td><td></td></tr><tr><td>B01</td><td>PLANNING</td><td></td></tr><tr><td>C01</td><td>INFORMATION CENTER</td><td></td></tr><tr><td>D01</td><td>DEVELOPMENT CENTER</td><td></td></tr><tr><td>D11</td><td>MANUFACTURING SYSTEMS</td><td></td></tr><tr><td>D21</td><td>ADMINISTRATION SYSTEMS</td><td></td></tr></table>

![](images/925b214f2a273b06e9d6a2e9802225fbdaf4d5c1748093e99010127ff966a926.jpg)

PROJECT  

<table><tr><td>PROJNO</td><td>PROJNAME</td><td>DEPT
NO</td><td>...</td></tr><tr><td>AD3100</td><td>ADMIN SERVICES</td><td>D01</td><td></td></tr><tr><td>AD3110</td><td>GENERAL ADMIN SYSTEMS</td><td>D21</td><td></td></tr><tr><td>AD3111</td><td>PAYROLL PROGRAMMING</td><td>D21</td><td></td></tr><tr><td>AD3112</td><td>PERSONNEL PROGRAMMING</td><td>D21</td><td></td></tr><tr><td>AD3113</td><td>ACCOUNT PROGRAMMING</td><td>D21</td><td></td></tr><tr><td>IF1000</td><td>QUERY SERVICES</td><td>C01</td><td></td></tr></table>

Relational Table: EMPLOYEE  

<table><tr><td>EMPNO</td><td>FIRSTNME</td><td>MIDINIT</td><td>LASTNAME</td><td>...</td><td>BIRTHDATE</td><td>COMM</td></tr><tr><td>000010</td><td>CHRISTINE</td><td>I</td><td>HAAS</td><td>...</td><td>1933-08-24</td><td>9220</td></tr><tr><td>000020</td><td>MICHAEL</td><td>L</td><td>THOMSON</td><td>...</td><td>1948-02-02</td><td>0</td></tr><tr><td>000030</td><td>SALLY</td><td>A</td><td>KWAN</td><td>...</td><td>1941-05-11</td><td>-----</td></tr><tr><td>000050</td><td>JOHN</td><td>B</td><td>GEYER</td><td>...</td><td>1925-09-15</td><td>3214</td></tr><tr><td>......</td><td>......</td><td>......</td><td>......</td><td>...</td><td>......</td><td>......</td></tr><tr><td>000330</td><td>WING</td><td></td><td>LEE</td><td>...</td><td>1941-07-18</td><td>2030</td></tr></table>

# An introduction to Database Systems

Table : file  
Rows: records  
Columns : fields  
Column data types: domain  
Primary key

# (3)

A database is a collection of persistent data that is used by the application systems of some given enterprise

persistent data: be removed from the database only by some explicit request to the DBMS.

Student  

<table><tr><td>Sno</td><td>Sname</td><td>Sage</td><td>Ssex</td><td>Sdept</td></tr><tr><td>020101</td><td>Chris</td><td>20</td><td>M</td><td>MIS</td></tr><tr><td>020102</td><td>Raman</td><td>19</td><td>M</td><td>MIS</td></tr><tr><td>020201</td><td>Lin Wang</td><td>20</td><td>F</td><td>GS</td></tr><tr><td>020202</td><td>Ming Zhang</td><td>19</td><td>M</td><td>GS</td></tr></table>

# Enterprise examples:

A manufacturing company  
A bank  
A hospital  
A university  
A government department  
A single individual with a small personal database

Data examples:

Product data

Customer data

Patient data

Student data

Planning data

Account data

# (4)

A database system is really a collection of true propositions

Data is given facts, from which additional fact can be inferred.

A given fact is called true proposition by logician.

# 2 Why database?

From point of view of development of data management technology

# Computerless Data Storage

![](images/92b5ee13a0f83957b6a82bcf2f0e9624600352f54af43029968e871704ae15c5.jpg)

![](images/38ae5ca684918efa84798f4aa9de9bf882658dd16544fa1a88b9f08619f64af3.jpg)

![](images/09eb8a6209ede0131a462ff5c424cf3b5c9962d7b97f9f0c34b769e2748bb591.jpg)

![](images/9b7bfa8a3a96f0398c3fb819146d93deabce9c75f62084319a778b19f22a5896.jpg)

![](images/720999dc587a3a4171b2f9ac3f4aa9bc6c8d6ce266b8bfa777be5160d9473a63.jpg)

![](images/088ed7aa2fb9a2e949e180e81a977fcb0f653540c616774e06efa5583eb930a3.jpg)

![](images/526e03b0cbcf78b878c617f6df1ad12dccc6aad634eae653ac79351d72e46167.jpg)

# Traditional File-Based approach

A file-based system is a collection of application programs that performs services for the end-users such as the production of reports, but each program defines and manages its own data.

![](images/5d06787a5755117fdaf78c624c51b1365bea9211675d5473d433bf7bf67e65c8.jpg)  
订货部门

![](images/a1d310d8a35cbe4ed8d184597992593aca42580a9b8188c91f609d577b7a05bb.jpg)  
会计部门

![](images/d63b31f42638d1047bc5607d56d44732d60fb8e810973d9752d5a2e45dfb0a20.jpg)  
工资部门

# An introduction to Database Systems

# Limitations:

Data are separated and isolated  
Data are often duplicated  
Application programs are dependent on file formats Need to write a new program to carry out each new task E.g. get the balance of accounts whose balance are less than 1000  
□ Files are often incompatible with one another  
It is difficult to represent data in the user's perspectives  
□ Integrity problems Integrity constraints (e.g. account balance  $>0$ ) become part of program code, Hard to add new constraints or change existing ones  
It is difficult to impose security on data  
Concurrent access by multiple users Concurrent access needed for performance Uncontrolled concurrent accesses can lead to inconsistencies E.g. two people reading a balance and updating it at the same time

Database systems offer solutions to all the above problems

# The Database Approach

The database approach: considering the data, instead of the application programs, of major importance in the design of systems -- i.e. look first at the design of the application's data and then write programs to process it!

![](images/b99416817d343bcdfdbe87dd5477f6b2352d1e6a87cd846cfa8a8b5da01d462e.jpg)

Schemas define the structure of records within the database

Maintenance and utility offer application-independent services, e.g. report generator

# Asking for Information - RDBMS

Return a list of

employees in

department D11

sorted by last name

RDBMS

EMPLOYEE  

<table><tr><td>EMPNO</td><td>LASTNAME</td><td>MID INIT</td><td>FIRSTNME</td><td>WORKDEPT</td><td>PHONENO</td></tr><tr><td>000150</td><td>ADAMSON</td><td></td><td>BRUCE</td><td>D11</td><td>4510</td></tr><tr><td>000200</td><td>BROWN</td><td></td><td>DAVID</td><td>D11</td><td>4501</td></tr><tr><td>000050</td><td>GEYER</td><td>B</td><td>JOHN</td><td>E01</td><td>6789</td></tr><tr><td>000340</td><td>GOUNOT</td><td>R</td><td>JASON</td><td>E21</td><td>5698</td></tr><tr><td>000010</td><td>HAAS</td><td>T</td><td>CHRISTINE</td><td>A00</td><td>3978</td></tr></table>

![](images/659e87a3258f6f0df94553009546a2473e9db37e52fdf76998dcc4cf1a3947a5.jpg)

![](images/48b3eb637af7c775c47adde9067b6292a1b5cd68d3c3032ae2d38c090ebde2c5.jpg)

# Benefits of the database approach

The data can be shared  
Redundancy can be reduced  
■ Inconsistent can be avoided propagating updates  
Transaction support can be provided transaction is a logical unit of work  
■ Integrity can be maitained (ensuring the data in database is correct)

redundancy  $\rightarrow$  inconsistency +other incorrect

Security can be enforced  
Conflicting requirements can be balanced  
Standards can be enforced

standardizing data representation is desirable as an aid to data interchange or movement between systems  
data naming and documentation standards ---data sharing and understandability

You only see what you should  

<table><tr><td>EMPNO</td><td>FIRSTNAME</td><td>MIDINIT</td><td>LASTNAME</td><td>WORKDEPT</td><td>PHONO</td></tr><tr><td>000150</td><td>BRUCE</td><td></td><td>ADAMSON</td><td>D11</td><td>4510</td></tr><tr><td>000200</td><td>DAVID</td><td></td><td>BROWN</td><td>D11</td><td>4501</td></tr><tr><td>000050</td><td>JOHN</td><td>B</td><td>GEYER</td><td>E01</td><td>6789</td></tr><tr><td>000340</td><td>JASON</td><td>R</td><td>GOUNOT</td><td>E21</td><td>5698</td></tr><tr><td>000010</td><td>CHRISTINE</td><td>T</td><td>S</td><td>A00</td><td>3978</td></tr></table>

# The advantages of a database system over file-based system

Compactness  
Speed  
Less drudgery  
Current

Provides the enterprise with centralized control of its data- ---- overriding advantage

# 3 Simple Operations on database (SQL)

File---

adding removing

Record---

Insert Delete Select Update

(SQL)

# Structured Query Language--SQL

![](images/5a6be0de3b64f3d5ee6a63c96a6a380549637f06be6c85468e278ceb3901c402.jpg)

1986年10月，美国ANSI采用SQL作为关系数据库管理系统的标准语言(ANSI

X3. 135-1986), 后为国际标准化组织 (ISO) 采纳为国际标准。

SQL has become one of the most important elements of modern database technology. It is used very extensively by virtually all database systems and is a major vehicle in facilitating inter-database communication

# DDL

# DDL:Specification notation for defining the database

E.g.

create table account (

account-number char(10),

balance integer)

# DML

■ Language for accessing and manipulating the data

DML also known as query language

Two classes of languages

Procedural – user specifies what data is required and how to get those data  
Nonprocedural – user specifies what data is required without specifying how to get those data

SQL is the most widely used non-procedural language

# DCL

GRANT SELECT ON PROJECT TO SALLY

![](images/b77d4a72c6d674f1d5541678f2ed9d7e137f7317f57bfe1dd385e207e805c437.jpg)

REVOKE SELECT ON PROJECT FROM SALLY

# 4 Components of the Database System

![](images/85202c4ba775ef3fbaf5e00531ccccaf3b018e6cd9cf32510409d6dd45542b5d.jpg)

# An introduction to Database Systems

![](images/e8ec3c4d9cc9e0133cf716ab13cda119109f620427dbee35e8f5a61e79aa30fb.jpg)  
Database System

# ----Data

Data: refer to what is actually stored in the database information refer to the meaning of that data as understood by some user.

The terms “data” and “information” are treated as synonymous (同义的) in this book.

![](images/94f6442815b1044036b1fb231df6e11c8c0864fa2f627d297cbc7f08eb24082a.jpg)  
Fig. 1.5 The EMPLOYEE and ENROLLMENT files

Single-user system is a system in which at most one user can access the database at any given time.

Muti-user system is a system in which many users can access the database at the same time.

Two assumptions in our book: multi-user system, data store in a single DB

The data in database is

$\checkmark$  Integrated.

(database can be thought of as a unification of distinct files with redundancy eliminated)

$\checkmark$  shared  $\Leftrightarrow$  personal or application-specific  
$\checkmark$  persistent  $\Leftrightarrow$  ephemeral

# ----Hardware

# Consisting of :

■magnetic disks, disk drives: store information (the secondary storage)  
■ Hardware processor(s) and associated main memory: running DBS software

# ----Software

Database Management System (DBMS).---the most important software

component

Eg., Sybase 、 Oracle 、 SQL

Server 、 Informix 、 FoxBase 、 FoxPro 、 Access…

database package is used to refer to a DBMS implementation offered by a particular vendor

Application development tools

Design aids

Report writer

Transaction manager or TP monitor

Database Management System (DBMS) is the software that manages and controls access to the database -- an integrated part of our day-to-day life that often we are not aware we are using one.

A DBMS contains 5 software components:

DBMS engine  
Data definition subsystem  
Data manipulation subsystem  
Application generation subsystem  
Data administration subsystem

# An introduction to Database Systems

# -----Users

■ Application programmers COBOL,PL/I,PB,JAVA…

![](images/61dfc762581f452b0deca4d2225fa147e764dd77f291c12b5ab242545d4aaccd.jpg)

# An introduction to Database Systems

# End user

interacting with system from online workstations or terminals.

access data by: online applications

interface (Query language processor)

menu or forms-driven interfaces

command -driven interfaces

![](images/df347a5477e69fdbb86f0ce440694f162ae4ebef92af14372bb7bb7d50333926.jpg)

# An introduction to Database Systems

Database administrator(DBA)-- IT technician

1 responsible for implementing the data administrator's decisions.  
2 create the actual database and to implement the technical controls needed to enforce the various policy decisions made by the data administrator.

DBA is responsible for administrating the DB and DB system in accordance with policies established by data administrator

Data Administrator (DA, 数据管理员) --manager

1 decide what data should be stored in the database in the first place  
2 establish policies for maintaining and dealing with that data once it has been stored.

Data administrator –has central responsibility for data, understand the data and needs of enterprise

# An introduction to Database Systems

![](images/19d0c0d56217f0dd7cdc70e5f25bc35216855b44d31042f7972bfb455e9e4eac.jpg)

# Database Administrator

![](images/6e354f4ebefced1f6e5438b022e8e4cda0a1955c2d8c766046545d422c865b0c.jpg)

# 5 Types of data models and the differences between them

# Data model

A data model is an abstract, self-contained, logical definition of the objects, operators and so forth. That together constitute the abstract machine with which users interact

the object allow us to model data structure the operators allow us to model its behavior

# Types of data models

database system are categorized according to data structures and operators they present to the user

1 Hierarchical Model

such as IBM's IMS traversing points

![](images/01ac2e65a0484b647085d61da7170c317947f9b2b1bb0f634110f604decd1b4c.jpg)

2 Network Model

Limitations:

Complex programs have to be written to answer even simple queries

There is minimal data independence

There is no widely accepted theoretical foundation 40

![](images/2551adc275adefb0158ff3455f3b7eb6f282142431cac9884ec523b2ffd2227d.jpg)

# 3 Relational model

data is represented as rows in tables( it is a true proposition) Operators are provided for operating on rows in tables is based on logic and mathematics (Why so dominant?)

4 object/relational model such as DB2 and informix  
5 object model entirely different such as Gemstone and Versant ODBMS

Others are ad hoc, relational model is based on formal logic

# 层次模型的例子

![](images/366a536dffd9b22620ce964b0fa61fd837d57db6dffc90f87660204539bc6506.jpg)  
层次模型 (树的形式)

![](images/823fd01dfb3775134445b16fb8e1be8938fd42a25c1ba5a53256ce2bc8121c7f.jpg)  
层次模型的模式

![](images/3310cf19eb2cc6e3f36313a806bdcd7ad9edda8316d3d93d773b1160a8efa4da.jpg)  
层次模型的数据

# 层次模型：

1. 有且只有一个节点没有双亲节点，称为根节点；  
2. 根以外的其他节点有且只有一个双亲节点；  
3. 每个结点表示一个记录类型。

层次数据库系统只能处理一对多的实体联系。

层次结构采用关键字来访问其中每一层次的每一部分。

1973年，Charles W. Bachman：“网状数据库/DBTG之父”

![](images/3b53663f412f3d9d49988b950f4e2e9c79fe80caad215d69840d847145fbd62b.jpg)  
网状模型  
（图的形式）

![](images/e04cca405437b265626219685afaf70cbbd5b4d0a89ebfeda22f1ec3464470f3.jpg)  
网状模型的模式

![](images/0e1d42027dbf2d7a58e8d1083f9a10c8478c57e8944dd63486362d7707fd3576.jpg)  
网状模型的数据

![](images/7177ad16a0840e61d695009c0cd02f68017585c3916489df02228e2170a4865c.jpg)

# 网状模型：

1. 一个结点可以有多个双亲；  
2. 结点直接可以有多种联系。

具有多对多类型的数据组织方式。

用连接指令或指针来确定数据间的显示连接关系。

应用发展要求实现数据模拟和行为模拟，传统数据库技术开始表现出明显不足：  
(1) 数据对象简单，只能检索一组记录和由同质记录共同组合的集合，无复杂的嵌套数据和复杂数据。  
(2) 对象之间的关系简单，不能实现实体间聚合、继承等复杂联系。  
(3) 一致约束不完全，只能预定时机检查。  
(4) 事务短寿，并发控制机制简单。

20世纪90年代来，在关系型数据库基础上，引入面向对象技术，从而使关系型数据库发展成为一种新型的面向对象关系型数据库。它始于工程和设计领域的应用，并且成为广受金融、电信和万维网应用欢迎的系统。它适用于多媒体应用以及复杂的、很难在关系DBMS里模拟和处理的关系。

# 面向对象的模型

采用面向对象的方法来设计数据库。面向对象的数据库存储对象是以对象为单位，每个对象包含对象的属性和方法，具有类和继承等特点。Jasmine就是面向对象模型的数据库系统。

面向对象数据模型的数据结构是非常容易变化的。对象模型没有单一固定的数据结构。编程人员可以给类或对象类型定义任何有用的结构，如链表、集合、数组等。此外，对象可以包含可变的复杂度，利用多重类型和多重结构。  
√ 对象模型可以用二维表来表示，称为对象表。但对象表是用一个类（对象类型）表定义的。一个对象表用来存储这个类的一组对象。对象表的每一行存储该类的一个对象（对象的一个实例），对象表的列则与对象的各个属性相对应。因此，在面向对象数据库中，表分为关系表和对象表，虽然都是二维表的结构，但却是基于两种不同的数据模型。

# 了解对象

对象是面向对象编程中重要概念，用对象来表示现实世界中的实体。一个学生、一门课程、一次考试记录都可以看作对象。每个对象包含一组属性和一组方法。

属性用来描述对象的状态、组成和特性，是对象的静态特征。一个简单对象如整数，其本身就是状态的完全描述，不需要其他属性，这样的对象称为原子对象。属性的值可以是复杂对象。一个复杂对象包含若干属性，而这些属性作为一种对象，又可能包含多个属性，这样就形成了对象的递归引用，从而组成各种复杂对象。

每一个对象都是其属性和方法的封装。用户只能见到对象封装界面上的信息，对象内部对用户是隐蔽的。封装的目的是为了使对象的使用和实现分开，使用者不必知道行为实现的细节，只需用消息来访问对象，这种数据与操作统一的建模方法有利于程序的模块化，增强了系统的可维护性和易修改性。

# 各模型优缺点

<table><tr><td></td><td>层次模型</td><td>网状模型</td><td>关系模型</td><td>面向对象模型</td></tr><tr><td>优点</td><td>1、简单，命令少，易操作。2、实体间联系固定的应用系统，层次模型性能优于关系模型，不次于网状模型。3、良好完整性支持。</td><td>1、能更直接的描述现实世界。
2、具有良好性能，存取效率高。</td><td>1、建立在严格数学概念基础上。2、概念单一数据结构简单清晰。3、存取路径透明，数据独立性更高。</td><td>存储数据和操作。
能定义嵌套结构，很强的模型扩展能力，节省开销。</td></tr><tr><td>缺点</td><td>表示非层次性不利。插入删除限制较多，查询子女结点须通过双亲结点，命令趋于程序比。</td><td>其DDL语言极其复杂，数据独立性差。</td><td>查询效率不如非关系模型，需要对查询优化。</td><td>技术尚不成熟，无完全支持的DBMS产品。</td></tr></table>

# An implementation of a data model

--- is a physical realization on a real machine of the components of the abstract machine that together constitute that model

The model is what users have to know about but the implementation is what users do not have to know about.

the distinguish of model and implementation is a special case of Logical and physical.

Gap between database principle (ought to be) and database practice(actually are)

# 6 Data Independence

# An introduction to Database Systems

Logical Data Independence  
Physical Data Independence

Change the data physical representation and access technique without affecting the application.  
Data physical representation: how the data is physically represented in storage

Eg1. EMPLOYEE file:

- indexed on its "employee name" field
- Eg2. SALARY field of EMPLOYEE file:decimal or binary

Data access technique: how the data is physically accessed

# Index

- Assists in finding the right indexes

- Based on Workload  
- Virtual indexes

- Reduce complexity of performance analysis and tuning

![](images/36829c11d5448ab6548e1e6b85f0eb382d26a9e99a7d437a79783a06a60318ce.jpg)

PHONEBOOK  

<table><tr><td>LASTNAME</td><td>FIRSTNME</td><td>MIDINT</td><td>ADDRESS</td><td>PHONENO</td></tr><tr><td>Smith</td><td>Diana</td><td>A</td><td>2253 Dahlia St.</td><td>555-1111</td></tr><tr><td>Gaines</td><td>Lois</td><td>B</td><td>6094 Beaker St.</td><td>555-1221</td></tr><tr><td>Brown</td><td>Terry</td><td>S</td><td>45 River Walk</td><td>555-2168</td></tr><tr><td>Adams</td><td>Sandy</td><td>A</td><td>26 Cisco Lane</td><td>555-1311</td></tr><tr><td>Friedrich</td><td>John</td><td>P</td><td>5 Beaumont Rd.</td><td>555-1411</td></tr><tr><td>Jones</td><td>Larry</td><td>R</td><td>1921 Hill Rd.</td><td>555-3242</td></tr><tr><td>Wise</td><td>Sara</td><td>J</td><td>25 Rawlings St.</td><td>555-2345</td></tr><tr><td>Jones</td><td>Laverne</td><td>G</td><td>504 1st Ave</td><td>555-1777</td></tr><tr><td>Adams</td><td>Bobby</td><td>D</td><td>1426 Maple Dr.</td><td>555-1423</td></tr><tr><td>Jones</td><td>Larry</td><td>R</td><td>240 Boswell Dr.</td><td>555-5390</td></tr><tr><td>Smith</td><td>Grace</td><td>G</td><td>983 Famous Rd.</td><td>555-8764</td></tr><tr><td>Caldwell</td><td>Simone</td><td>B</td><td>122 42nd St.</td><td>555-5367</td></tr></table>

# Index-Only Access

SELECT LASTNAME, FIRSTNAME, PHONENO

FROM PHONEBOOK

WHERE LASTNAME LIKE 'S%'

![](images/ae08d75d11023b029f800b6e957e06f3cf05edabde5667de730863c9fa28e50b.jpg)

# An introduction to Database Systems

# Non-Clustered index

Root Page

Howell, Thurston (1)  
Peters, Joan (2)  
Zidler, Bob (3)

# L P e a ag f e s

Adams,Mark (2,1),(5,2)  
Alviani, Carl (7,2)  
Bennett, Barb (2,3)  
Chapman, Mike (5,1)  
Davis, Mac (3,1)  
Howell, Thurston (3,2)

Jefferson, Tom (4,1)  
Jones, Bob (1,1)  
Lee, Spike (8,1)  
Lincoln, Abe (8,2)  
Mitchell, David (2,2)  
Peters, Joan (1,3)

Quinn, Tony (6,2)  
Reeves, Susan (1,2)  
Smith, Stanley (7,1)  
Smith, Steve (4,2)  
Thompson, Tommy (6,3)  
Zidler, Bob (6,1)

# D P a a t g a e s

<table><tr><td>Jones, Bob</td><td>Adams,Mark</td><td>Davis,Mac</td><td>Jefferson,Tom</td></tr><tr><td>Reeves,Susan</td><td>Mitchell,David</td><td>Howell,Thurston</td><td>Smith,Steve</td></tr><tr><td>Peters, Joan</td><td>Bennett, Barb</td><td></td><td></td></tr><tr><td>Chapman,Mike</td><td>Zidler,Bob</td><td>Smith,Stanley</td><td>Lee,Spike</td></tr><tr><td>Adams, Mark</td><td>Quinn,Tony</td><td>Alviani, Carl</td><td>Lincoln,Abe</td></tr><tr><td></td><td>Thompson,Tommy</td><td></td><td></td></tr></table>

# Clustered index

Root Page

Howell, Thurston (1)

Peters, Joan (2)

Zidler, Bob (3)

<table><tr><td>L P
e a
a g
f e
s</td><td>Adams,Mark (1,1),(1,2)
Alviani, Carl (1,3)
Bennett, Barb (2,1)
Chapman, Mike (2,2)
Davis, Mac (2,3)
Howell, Thurston (3,1)</td><td>Jefferson, Tom (3,2)
Jones, Bob (3,3)
Lee, Spike (4,1)
Lincoln, Abe (4,2)
Mitchell, David (4,3)
Peters, Joan (5,1)</td><td>Quinn, Tony (5,2)
Reeves, Susan (5,3)
Smith, Stanley (6,1)
Smith, Steve (6,2)
Thompson,Tommy(6,3)
Zidler, Bob (7,1)</td></tr></table>

<table><tr><td>Adams,Mark</td><td>Bennett,Barb</td><td>Howell,Thurston</td><td>Lee,Spike</td></tr><tr><td>Adams,Mark</td><td>Chapman,Mike</td><td>Jefferson,Tom</td><td>Lincoln,Abe</td></tr><tr><td>Alviani,Carl</td><td>Davis,Mac</td><td>Jones,Bob</td><td>Mitchell,David</td></tr><tr><td>Peters,Joan</td><td>Smith,Stanley</td><td>Zidler,Bob</td><td></td></tr><tr><td>Quinn,Tony</td><td>Smith,Steve</td><td></td><td></td></tr><tr><td>Reeves,Susan</td><td>Thompson,Tommy</td><td></td><td></td></tr></table>

# Clustered and Non-Clustered Index Access

![](images/f49e648974cd9222ddbc4a514f5315302ec1934d8f952fd95e237ff4e2178553.jpg)  
Clustered Index  
Non-clustered Index

# Data-independence is a major objective for Database system

For the following two reasons:

> Different applications will require different views of the same data  
The DBA must have the freedom to change the physical representation or access technique in response to changing requirements without having to modify existing applications. eg:new kinds of data,new standards,application priorities,new storage devices.......year 2000

Data-independence can be defined as the immunity of applications to change in physical representation and access technique

# Stored representation of data

Representation of numeric data: decimal, character string,... (base, scale, mode, precision)  
■ Representation of character data: several distinct coded character sets—e.g., ASCII(American Standard Code for Information Interchange, EBCDIC(Extended Binary Coded Decimal Interchange Code), Unicode (统一码、万国码、单一码、标准万国码)。  
Units for numeric data: inches/centimeters  
Data coding: (part color="Red" or "Blue" or "Green" ...)  $1 =$  "Red,"  $2 =$  "Blue," ...

# An introduction to Database Systems

# Stored representation of data

Data materialization: constructing an occurrence of the logical field from the corresponding stored field occurrence and presenting it to the application

![](images/175a036820d357da6ce087c2077efa0397bb5a47c390a1e30339af4412e759f2.jpg)

![](images/9b7fdd6dc812d8341c70f23d53efb669ddf30164b0f34992cb0f923b7a16ecb4.jpg)

# Stored representation of data

Structure of stored records:

Two existing stored records might be combined into one.

![](images/76b716fa73cc61d0abaf9094e41a8478d207f37ab8783c8919e6bcf5ac731dd8.jpg)

a single stored record type might be split into two.

# Stored representation of data

Structure of stored files :

A given stored file can be physically implemented in storage in a wide variety of ways.

a single disk

several different device

one or more indexes ,one or more embedded pointer chains (or both)

some hashing scheme

DBA choose the stored representation of data.  
Won't affect applications, but performance

# Physical data independence

Physical data independence : DBA make changes the stored representation of data while the data as seen by applications does not change.  
Basic way to provide data independence : three-level architecture

An introduction to Database Systems

# 7 Others.....

# When not to use a database system?

DBMS requires additional overhead!

High initial investment in hardware, software and training.  
Overhead for providing security, concurrency control, recovery and integrity functions.

There are still a lot of applications that use files.

- The database and application are simple, well-defined, and not expected to change -- usually dealing with small size of data (better either in a file or main memory!)  
- There are stringent real-time requirements for some programs that may not be met because of DBMS overhead.  
- Multiple-user access to data is not required.

# The major events in the database systems history

1961 The first generalized DBMS-GEs IDS by Bachman  
1967 : IBM 开发出 ICS/DL/I, 信息控制系统与数据语言/界面, 这是阿波罗 (Apollo) 项目的分级数据库。ICS 随后变成了 IMS, 信息管理系统, 与 IBM 的 System360 主机整合到一起。  
1970 The relational model is developed by Codd at IBM research Lab  
1975 Entity-Relationship (ER) model introduced by Chen  
- Research projects: System R (IBM), INGRES (UCBerkeley), System2000(UT-austin)  
80's and 90's Micro-DBMS family: Dbase, Foxpro, Access Mainframe DBMS: DB2 Client-server DBMSs: ORACLE, Sybase, SQL server...

The System R project at IBM (1970s) led to two major developments:

1,SQL,  
2,Commercial relational DBMS products (1980s) such as DB2 and SQL/DS from IBM and ORACLE from

ORACLE

# An introduction to Database Systems

1979年：第一个公开可用版本的Oracle数据库发布。  
1984年：雷奥兹（Ray Ozzie）成立Iris Associates，创造了一个受PLATO Notes启发的组合件系统。  
1988年：由文件数据库提供支持的LotusAgenda发布。  
1989年：Lotus Notes发布。  
1990年：Objectivity发布了期间对象数据库。  
1991年：Key-value类型数据库Berkeley DB发布。  
1991：W.H.Inmon发表了《构建数据仓库》。  
2003年：LiveJournal开放最初版本Memcached的源码。  
2005年：达米安卡茨（Damien Katz）开放CouchDB源码。  
2006年：Google发表BigTable论文。  
2007年：亚马逊发表Dynamo论文。10gen开始编制MongoDB代码。Powerset开放BigTableclone克隆版Hbase的源码。  
2008年：Facebook开放Cassandra源码。  
2009年：科技博客ReadWriteWeb提出一个问题：“关系型数据库是否已注定灭亡？”Redis发布。首次NoSQL会议在旧金山召开。  
2010年：Memcached项目的一些负责人与社交游戏公司Zynga开放Membase源码。

# Group(Semester) project- section 1

Survey and describe database requirements of an organization (company, enterprise or department), briefly introduce its background,

If they have information systems?  
If YES, how to use information systems? What roles that database are playing?  
If NO, is there any plan to implement a database system, in which what functions that database will have?  
Describe main business processes of the surveyed object.