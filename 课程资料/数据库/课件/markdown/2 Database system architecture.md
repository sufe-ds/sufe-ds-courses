# Database system architecture

# Chapter 2

![](images/dcad78cff19443a088e2ce2dbdbd5d41282c5174a306eb0c7fde58fd7512ed42.jpg)

# What will you learn?

1. Features of Current database applications  
2. Hot topics in database field  
3. Database system architecture

From DBMS  
From end user

ANSI/SPARC

Architecture

4. The Database Administrator  
5. DBMS

# An introduction to Database Systems

1 features of Current database applications Integration of the DBMS into the Web environment

- Treat the Web as a database application platform  
- Different integration tools, including CGI(Common Gateway Interface), Java, scripting languages, Active Server pages, and Oracle's Universal data Server

# 2 Hot topics in database field

- Data Warehouse is a subject-oriented, integrated, time-variant, and non-volatile collection of data in support of management's decision-making process  
- Store decision-support data (e.g. customers, products, and sales) rather than application-oriented data (e.g. customer invoicing, stock control and product sales)  
- Data is not updated in real-time, and usually added as an addition rather than a replacement

# An introduction to Database Systems

- OLAP i.e. Online Analytical Processing is the dynamic synthesis, analysis, and consolidation of large volumes of multi-dimensional data, e.g. City, Property type, and Time as three dimensions in a cube  
- Data Mining is the process of extracting valid, previously unknown, comprehensible, and actionable information from large databases and using it to make crucial business decisions.

# 3. Database system architecture ---from DBMS

External level (individual user views)

Conceptual level (community user view)

Internal level (storage view)

Fig. 2.1 The three levels of the architecture

# The Three Levels of the Architecture ANSI/SPARC

(1975) by American National Standard Institute - Standards Planning and requirements Committee(ANSI/SPARC)

■ internal level (Physical level):

the way the data is physically stored

external level (user logical level):

the way the data is seen by individual users (application programmer or end user)

■ conceptual level (community logical level) :

a level of indirection between the other two

# An example of the three levels

![](images/4c0be78254dee6e2fe0ce384b060c3315670289c80a63d20ff33ac67b9c10b91.jpg)  
Fig. 2.2 An example of the three levels

# Conceptual level

The conceptual view is a representation of the entire information content of the database.  
The conceptual view is defined by means of the conceptual schema, which includes the definitions of each of the various conceptual records types  
The "conceptual schema" is really little more than a simple union of all of the individual external schemas, plus certain security and integrity constraints.

# An introduction to Database Systems

# E.g. conceptual schema of Database “Order”

# Table:

Customer(Cno,Company,City,Tel)

Order(Ono,Odate,Freight)

Order_item(Ono,Pno,Quantity)

Product(Pno,Pname,Price)

■ integrity constraints

■security constraints

# The conceptual schema is written using the conceptual DDL---just define information content

# An introduction to Database Systems

# The External Level

External view is the individual user view.  
User and language

■application programmer:

programming language ,e.g., PL/I, C++, Java, Proprietary language-4GLs

end user:

query language

Special-purpose language (supported by application program)

all such languages include a data sublanguage, it include DDL and DML.

第四代语言（4GL）是一个简洁的、高效的非过程编程语言，用来提高DBMS的效率。在第四代语言中，用户定义“做什么”而不是“如何做”。第四代语言依靠更高级的第四代工具，用户可以使用这个工具定义参数来生成应用程序。第四代语言内嵌了如下组件：

查询语言

报表生成器

电子数据表

数据库语言

应用程序生成器

生成应用程序的高级语言

结构化查询语言（SQL）

通过例子查询（QBE）

第四代语言又称为高生产率语言

确定一个语言是否是一个 4GL，主要应从以下标准来进行考察：

（1）生产率标准：4GL一出现，就是以大幅度提高软件生产率为己任的，4GL应比3GL提高生产率一个数量级以上。  
(2) 非过程化标准: 4GL 基本上应该是面向问题的, 即只需告知计算机 “做什么”, 而不必告知计算机 “怎么做”。当然 4GL 为了适应复杂的应用, 而这些应用是无法 “非过程化” 的, 就允许保留过程化的语言成分, 但非过程化应是 4GL 的主要特色。  
（3）用户界面标准：4GL应具有良好的用户界面，应该简单、易学、易掌握，使用方便、灵活。  
(4) 功能标准: 4GL 要具有生命力, 不能适用范围太窄, 在某一范围内应具有通用性。

# 4GL 存在着以下严重不足:

(1) 4GL 虽然功能强大, 但在其整体能力上却与 3GL 有一定的差距。这一方面是语言抽象级别提高以后不可避免地带来的 (正如高级语言不能做某些汇编语言做的事情); 另一方面是人为带来的, 许多 4GL 只面向专项应用。有的 4GL 为了提高对问题的表达能力, 提供了同 3GL 的接口, 以弥补其能力上的不足。如 Oracle 提供了可将 SQL 语句嵌入 C 程序中的工具 PRO*C。  
(2) 4GL 由于其抽象级别较高的原因, 不可避免地带来系统开销庞大, 运行效率低下（正如高级语言运行效率没有汇编语言高一样）, 对软硬件资源消耗严重, 应用受硬件限制。  
（3）由于缺乏统一的工业标准，4GL产品花样繁多，用户界面差异很大，与具体的机器联系紧密，语言的独立性较差（SQL稍好），影响了应用软件的移植与推广。  
（4）4GL主要面向基于数据库应用的领域，不宜于科学计算、高速的实时系统和系统软件开发。

# Data sublanguage (DSL)

Data Definition Language (DDL): supports the definition or declaration of database objects.  
Data Manipulation Language (DML): supports the manipulation or processing of database objects.  
Data sublanguage is embedded within the corresponding host language.

Data sublanguage is responsible for database operations, host language for non database facilities(e.g. user interface,data input and output, computational operations).

# SQL

Tightly coupling  $\Leftrightarrow$ loosely coupling  
External view is defined by means of an external schema. It is written using the external DDL.

# The Internal Level

The internal view is a low-level representation of the entire database.

internal view=storage structure or stored database

Internal level = physical level?

The internal view is described by means of the internal schema.  
The internal schema is written using the internal DDL.

Application operates directly at internal level, recommended?

# An introduction to Database Systems

# How the three levels of the architecture are typically realized in a relational system?

The conceptual level in such a system will definitely be relational:

relational tables  
■ relational operators  $\rightarrow$  result:table

A given external view will typically be relational:  
Table or View  
the internal level will not be relational:  
■ stored records, pointers, indexes, hashes, etc.

# Detailed system architecture

![](images/6f1b64a08f19192ed7a8660cb006ebec13a1a78d2b107472dc9b2fb69c62c439.jpg)  
Fig. 2.3 Detailed system architecture

# Mapping s

# conceptual/internal mapping:

- Defines the correspondence between the conceptual view and the stored database;  
It specifies how conceptual records and fields are represented at the internal level.  
It is the key to physical data independence: If the structure of the stored database is changed, the conceptual/internal mapping must be changed accordingly, so that the conceptual schema can remain invariant.

# Mapings

# external/conceptual mapping

- Defines the correspondence between a particular external view and the conceptual view.  
Fields can have different data types; field and record names can be changed; several conceptual fields can be combined into a single (virtual) external field;  
Any number of external views can exist at the same time;  
Any number of users can share a given external view;  
Different external views can overlap;  
It is the key to logical data independence.

# Mapping

S

# external/external mapping

Most systems support external/external mapping, rather than always requiring an explicit definition of the mapping to the conceptual level.

# Mapping and Data Independence

data independence: the ability to modify a schema definition in one level without affecting a schema definition in the next higher level  
Logical data independence: the capacity to change the conceptual schema without having to change external schemas or application programs.  
Physical data independence: the capacity to change the internal schema without having to change the conceptual (or external) schemas.  
The mapping of three-schema architecture can make it easier to have true data independence.

# An introduction to Database Systems

. Database system architecture(continued) ---from end users

single user  
主从  
Client/Server Architecture  
Distributed Processing

# Single user

The whole database system, including application, DBMS and data is in one computer, used by just one user. No data share

# 主从式结构

一个主机带多个终端  
application, DBMS,data 放在主机上 所有处理任务有主机完成  
各个用户通过主机的终端并发地存取数据库，共享数据资源

优点：

简单 数据易于管理和维护

缺点：

终端用户数目增加到一定程度，主机任务会过分繁重，成为瓶颈，系统性能大幅度下降

系统可靠性不高

# Client/Server Architecture

# Server:

supports all of the basic DBMS functions.

# Client:

the various applications that run on top of the DBMS—both user-written applications and built-in applications, i.e., applications provided by the DBMS vendor or by some third party.

![](images/e1fd78eb22a94049079935e5e9722c67a5b7a94384a4373827270056fac39456.jpg)  
Fig. 2.5 Client/server architecture

# Client/Server Architecture(Cont.)

# ■ User-written applications:

regular application programs  
■written in C ,COBOL ,Java,...

# Vendor-provided applications(tools):

■ assist in the creation and execution of other applications  
E.g. report writer:

allow user to obtain formatted reports through report writer language.

# Vendor-provided tools

- Query language processors;  
Report writers;  
Business graphics subsystems;  
Spreadsheets;  
Natural language processors;  
Statistical packages;  
- Copy management or "data extract" tools;  
- Application generators (including 4GL processors);  
- Other application development tools, including computer-aided software engineering (CASE) products;

# Utilities

are programs designed to help the DBA with various administration tasks

--operate at the external level, perhaps provided by some third party  
--operate at the internal level, provided by DBMS vendor

- Load routines  
- Unload/reload routines  
Reorganization routines  
Statistical routines  
$\bullet$  Analysis routines

# Benefit

Server (database) and client (application) processing are being done in parallel. Response time and throughput should thus be improved.  
The server machine might be a custom-built machine that is tailored to the DBMS function (a "database machine") and might thus provide better DBMS performance.  
The client machine might be a personal workstation, tailored to the needs of the end user and thus able to provide better interfaces, faster responses, and overall improved ease of use to the user.

# Benefit(continued)

Several different client machines might be able (in fact, typically will be able) to access the same server machine. Thus, a single database might be shared across several distinct client systems

![](images/df60cde8b808a1d46779f58c9a0716b1fcc1c35579f838b2a6eb7a077f8a49ef.jpg)  
Fig. 2.7 one server machine, many client machines

# 优点

减少了网络上的数据传输量，提高了系统的性能、吞吐量和负载能力数据库更加开放。

客户机和服务器能在多种不同的硬件和软件平台上运行，可使用不同厂商的数据库应用开发工具，应用程序具有更强的可移植性，可减少软件维护开销

# 缺点

网络中有一台数据库服务器时，为众多的客户服务，容易成为瓶颈，制约系统性能

有多台数据库服务器时，数据处理、管理与维护有困难。

# distributed database system

The client might be able to access many servers simultaneously (i.e., a single database request might be able to combine data from several servers). In this case, the servers look to the client—from a logical point of view—as if they were really a single server, and the user does not have to know which machines hold which pieces of data.

优点：

适应了地理上分散的组织对于数据库应用的需求缺点：

数据分布存放给数据的处理、管理与维护带来了困难系统效率会受到网络交通的制约

![](images/2164d07ab4b7145ae767c4bb98e254f01adacc60725e4f17ab1016c8fe4b4a4d.jpg)  
Each machine runs both client (s) and server  
Fig. 2.8 Each machine runs both client (s) and server

# 4.The Database Administrator

DA(data administrator) is the person who makes the strategic and policy decisions regarding the data of the enterprise.  
DBA is the person who provides the necessary technical support for implementing those decisions.

# Tasks of DBA

Defining the conceptual schema(using conceptual DDL)

DA :decide the content of the database at an abstract level (Logical DB design)  
DBA create the corresponding conceptual schema object form and source form of schema  
SQL: create table

Defining the internal schema (using internal DDL)

The DBA must also decide how the data is to be represented in the stored database (physical database design).  
DBA create the corresponding internal schema  
Define the associated mapping  
Internal schema and mapping exists in both object and source form

Liaising with users

Liaise with users to ensure that the data they need is available.  
■ Consulting on application design, providing technical education, assisting with problem determination and resolution.  
■ write the necessary external schemas and the corresponding external/conceptual mappings using external DDL. (SQL: create view)  
external schema and mapping exists in both object and source form

# Tasks of DBA

Defining security and integrity constraints  
Defining dump and reload policies

DBA define and implement an damage control scheme involving

Periodic unloading or dumping of the database to backup storage  
Reloading the database when necessary from the most recent dump

Monitoring performance and responding to changing requirements

# 数据转储（备份）

增量：DB2 备份自上次完全数据库备份以来所更改的所有数据。  
- delta：DB2 将只备份自上一次成功的完全、增量或差异备份以来所更改的数据。

![](images/56919f99ec6dae5200b2801a99bfb704e07a952ddef6b697d9b1163e897cea07.jpg)

如果星期五进行增量备份之后发生崩溃，那么可以先恢复第一个星期日的完全备份，然后恢复星期五进行的增量备份。  
如果星期五进行 delta 备份之后发生崩溃, 那么可以先恢复第一个星期日的完全备份, 然后恢复从星期一到星期五（包括星期五）所进行的每次 delta 备份。

# 5. DBMS

- Database management system (DBMS) is the software that handles all access to the database.

A user issues an access request, using some particular data sublanguage (typically SQL).  
The DBMS intercepts that request and analyzes it.  
The DBMS inspects the external schema for that user, the corresponding external /conceptual mapping, the conceptual schema, the conceptual/internal mapping, and the storage structure definition.  
The DBMS executes the necessary operations on the stored database.

# An introduction to Database Systems

# How DB2 Handles an SQL “Change” Request

![](images/e4f2d8ce38c12d1ae20dd51a102a7717d421a836f80818fc375e370feb428f7f.jpg)  
User wants to change a SALARY

# Finish the change request

![](images/1d737be8c12e6078f54819a120bc53e82b519145aa086fe1e74409c1a1e2e145.jpg)

# Functions of DBMS

# Data definitions

# DBMS can

accept data definition (external schemas, the conceptual schema, the internal schema and all associated mappings) in source form.  
Convert source form schema to the appropriate object form.  
■Include DDL processor or DDL compiler

# Functions of DBMS (Continued)

# Data manipulation

# DBMS can

■ handle requests to retrieve, update, delete ,insert data to the database  
■ Include DML processor or DML compiler  
DML requests can be

planned request: issued from prewritten application

Characteristic of operational or production applications

■ unplanned request: issued interactively via some query language processor.

Characteristic of decision support applications

# Functions of DBMS (Continued)

Optimization and execution  
optimizer, run-time manager  
Data security and integrity  
Data recovery and concurrency

DBMS and other relative software are called transaction manager or transaction processing monitor

Data dictionary

data about data—metadata

store various schemas, mappings, security and integrity constraints in both source and object form.

Performance: efficiently

# Functions of DBMS (Continued)

# Optimization and execution

![](images/6927233004b4f4c5fe856126f4ae6cacdc33bb9c3379c5344725391efd74704b.jpg)  
SQL STATEMENTS

# An introduction to Database Systems

# Functions of DBMS (Continued)

# Access Plan

![](images/b725b95b8d993671d32c68e51fddf754679a1cd82dfddf218f49b6c10da15424.jpg)

# An introduction to Database Systems

# Functions of DBMS (Continued)

# Security

For COMPANY.DIRECTORY, ensure that USER1 and USER5 can read it and that USER7 can read and change its data.

GRANT SELECT ON COMPANY.DIRECTORY TO USER1,USER5

GRANT SELECT, UPDATE ON COMPANY.DIRECTORY TO USER7

OK, I wrote it down. I'll stop all unauthorized activities!

![](images/e32b58a778ae11a3ea027aac77a49c896c4cab930d1ee817103fdeaba160692b.jpg)  
Security

# An introduction to Database Systems

# Functions of DBMS (Continued)

# Integrity

![](images/390f3d114f0f6228de00883c4ed8b4c8420fec26fa4ebbd18e8c67666964ec69.jpg)

<table><tr><td>LAST NAME</td><td>FIRST NAME</td><td>MI</td><td>DEPT</td><td>PHONE</td></tr><tr><td>JONES</td><td>ANDY</td><td>B</td><td>SALES</td><td>6-3357</td></tr><tr><td>JONES</td><td>ANN</td><td>S</td><td>ACC</td><td>6-9271</td></tr><tr><td>JONES</td><td>BRENDA</td><td>L</td><td>OPER</td><td>6-8956</td></tr><tr><td>JONES</td><td>FRANK</td><td>D</td><td>ENG</td><td>6-7224</td></tr><tr><td>JONES</td><td>LARRY</td><td>R</td><td>SALES</td><td>6-4367</td></tr><tr><td>JONES</td><td>LARRY</td><td>R</td><td>SALES</td><td>6-4588</td></tr><tr><td>JONES</td><td>SANDRA</td><td>D</td><td>OPER</td><td>6-8499</td></tr><tr><td>JONES</td><td>SANDY</td><td></td><td>REPRO</td><td>6-2875</td></tr></table>

# Functions of DBMS (Continued)

![](images/1668d32fc2db0a4c1814270155532f30d0c037910d9214076cb9a620efad0f09.jpg)

# An introduction to Database Systems

![](images/eb3fc089bfead79ab7bc4dd1709a8cbe1d07d8ac1c976de55a7ef0a508b70f3e.jpg)  
Fig. 2.4 Major DBMS functions and components

Data definition

Data manipulation

Optimization and execution

Data security and integrity

Data recovery and concurrency

Data dictionary

The overall purpose of DBMS is to provide the user interface to DB.

Which level?

# DBMS & File management system(FMS)

FMS is the component of the underlying operation system that manages stored files----closer to the disk than the DBMS is.  
DBMS is built on top of some kind of FMS  
Users of FMS can create and destroy stored files and perform simple retrieval and update operations on stored records in such files

# In contrast to DBMS... FMS

Are not aware of the internal structure of stored records and can not handle requests that rely on a knowledge of that structure  
■ Provide little or no support for security and integrity constraints.  
■ Provide little or no support for recovery and concurrency constraints  
No dictionary concept  
■ Provide much less data independence  
- Files are not integrated or shared in the same sense that DB is