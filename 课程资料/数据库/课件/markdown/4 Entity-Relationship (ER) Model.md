# Entity-Relationship (ER) Model

![](images/534d7007c177875bf5fc8f789f88a3ca9189e646ba828e6045009c1f30e81724.jpg)

# What will you learn?

■ Semantic modeling  
ER Model Concept  
Database Design with the E/R Model

# Semantic modeling

■ Semantic features of relational data model

Codd: Capturing the meaning of data is a never-ending task

■ Semantic modeling: the overall activity of attempting to represent meaning

data modeling, E/R modeling, entity modeling, object modeling

# Four broad steps of semantic modeling

Identify useful semantic concepts  
Devise symbolic objects  
Devise integrity rules  
Devise operators

The ultimate objective of semantic modeling: make database system a little more intelligent

A more immediate objective of semantic modeling: provide a basis for database design

E/R approach—most commonly used, not the only

# 1. ER Model Concept

■ First introduced by P.P.S.Chen(陈平山 美籍华人) in 1976 and has been popular in relational DB design and made part of a number of CASE tools.  
A database can be modeled as:

a collection of entities  
■ relationship among entities.

ER Model includes the following semantic objects

Entities  
Properties  
Relationships  
Entity subtypes and supertypes

E-R 模型最早由 Peter Chen（陈品山）于 1976 年提出，它在数据库设计领域得到了广泛的认同，被誉为全世界最具计算机软件开发技术的 16 位科学家之一。

![](images/bb743ac65630e5cd2a50c8b3c3712255b723e5910916abdc49b756d44bb25cb7.jpg)

陈品山博士于 1976 年 3 月 ACM Transactionson Database Systems 上发表了《The Entity-Relationship Model—Toward a Unified View of Data》一文。由于大众广泛使用实体联系模型, 而这篇文章已成为计算机科学 38 篇被广泛引用的论文中之一。

# 陈品山

1947年生，1968年，陈品山于国立台湾大学毕业，之后赴美国深造。1970年获哈佛大学计算机科学和应用数学硕士学位，1973年获哈佛大学计算机科学和应用数学博士学位。之后，他曾先后在麻省理工学院（1974-1978，1986-1987），加州大学洛杉矶分校（1978-1984），哈佛大学（1990-1991）等学府从事教学和研究，从1983年至今任路易斯安纳州立大学计算机科学系MurphyJ.Foster杰出讲座教授（DistinguishedChairProfessor）。

此外，陈品山博士还曾在 IBM（6/1970-8/1970），Honeywell（6/1973-5/1974），迪吉多（6/1974-8/1974），以及其他政府机构从事研究和顾问。

![](images/ab65e0fa05cedcc271350956177749f1bc1959932532cb46e1e8ab6be00ac84a.jpg)

# ER Diagram…

![](images/8915cb5bf1855366df52b273d1db8b9546248de479c081e9872bae447578f098.jpg)  
Fig. 13.2 Entity/relationship diagram

# An introduction to Database Systems

E-R Diagram : a technique for representing the logical structure of a database in a pictorial manner

E-R Diagram Components

- Rectangles represent entity sets.  
Ellipses represent attributes  
Diamonds represent relationship sets.  
Lines link attributes to entity sets and entity sets to relationship sets.  
Double ellipses represent multivalued attributes.  
Dashed ellipses denote derived attributes.  
Primary key attributes are underlined.

# Entity

Entity:A thing which can be distinctly identified.

e.g. specific student, company, event, plant

An entity set is a set of entities of the same type that share the same properties.

e.g. set of all student, companies, trees, holidays

# Entity …

# Entity type:

regular entities:

DEPARTMENT

EMPLOYEE

- weak entities: existence-dependent on some other entity, in the sense that it cannot exist if that other entity does not also exist. DEPENDENT

![](images/2ec0c077178d53f8dd4848543bb1d47bafb180544703294e87b5aa36b423a6ae.jpg)

# Properties

Properties: All entities or relationships of a given type have certain kinds of properties in common;  
Properties can be

$\checkmark$  Simple or composite:

![](images/215c63edc015409bf4801af81c074a6bf5b9fda20ca5f2d9df86e393027af94e.jpg)

![](images/6fe9acac8d44982dd8c1d20d4de339ed51d683ca5247bcf486b6b0d77a423fbd.jpg)

# Properties …

$\checkmark$  Key:  $\underline{\mathrm{EMP}\#}$  
✓ Single- or multi-valued  
Missing  
✓ Base or derived

![](images/21d6e742b810b8a6a734e3448badb7098bf5440a561d4fe889784b67863a73ed.jpg)

# Relationships

A relationship is an association among several entities.

![](images/a8824c894d1c32651ceb04c3ce49855b3c3d16b036e9623dcdd593f09d1ed7be.jpg)

an attribute can also be property of a relationship set.  
Relationship set , relationship type

# Relationships …

Entity sets of a relationship need not be distinct.

![](images/098f2ad66c99a3c33a6c1319ed1de1d06288b676d5325b228f3b9bcf092b506c.jpg)

# Relationships …

The entities involved in a given relationship are said to be participants in that relationship.  
A relationship can include many entities; The number of participants in a given relationship is called the degree of that relationship.

Binary relationship  
Ternary relationship  
N-ary relationship

# Relationships …

Three types of Relationships

one-to-one (1:1)  
one-to-many (1:n)  
many-to-many (n:m)

→or 1 : signifying “one”  
—or m :signifying “many”

# Relationships …

![](images/2326fb41571e1a0cfc2cede5d6ffe358f4ebbf050c9bd30b2a06f08f427e4699.jpg)

One-To-One Relationship

A customer is associated with at most one loan via the relationship borrower  
A loan is associated with at most one customer via borrower.

# An introduction to Database Systems

In the one-to-many relationship (a), a loan is associated with at most one customer via borrower, a customer is associated with several (including 0) loans via borrower  
In the many-to-one relationship (b), a loan is associated with several (including 0) customers via borrower, a customer is associated with at most one loan via borrower

![](images/e833ac9e4e99352a30f5d0caca959956dc50d310e06e25fefc7b1e8ce5b4e358.jpg)  
(a)

![](images/8821a5642420637064fdc8ca95c8eb455cbdb19319334015edaef6340da07772.jpg)  
(b)

# Relationships …

![](images/df5ee509307941f2914e928b990d42755b703168e9e31ad5c8b5dbb39c32a56e.jpg)

# Many-To-Many Relationship

A customer is associated with several (possibly 0) loans via borrower  
A loan is associated with several (possibly 0) customers via borrower

# Relationships …

Participation constraints

■ total participation: Every entity in entity type must be related to a related entity via a relationship type.  
■ partial participation: Some or part of the set of entities are related to a related entity via a relationship type, but not necessarily all.

# Entity Subtypes and Supertypes

![](images/a655327fc82c070993c1ffaf2f5d0950feb80cc756759e4a5ebb52d2053d5dad.jpg)

如果某个实体型中的所有实体同时又是另一个实体型中的实体，那么前一实体型称为子类(Subtypes)，后一实体型称为超类(Supertypes)。

# Entity Subtypes and Supertypes

![](images/7992cf1d9ca1c502628026a6a88a6e384c45e3a37e135217a18d5639af2bca79.jpg)

Properties and relationships that apply to the supertype are inherited by the subtype

ISA relationship

# 2. Database Design with the E/R Model

Regular Entities  $\rightarrow$  base relvar

Properties  $\rightarrow$  attributes  
Identity  $\rightarrow$  primary key

E.G.

VAR DEPT BASE RELATION  
{DEPT# DEPT#,DNAME NAME#,...}  
PRIMARY KEY {DEPT#};

# Database Design with the E/R Model…

Many-to-Many Relationships:  $\rightarrow$  base relvar

■ Participants's primary keys and properties of relationship → attributes  
Combination of the participant-identifying foreign keys → Primary key  
Participants's primary keys  $\rightarrow$  Foreign keys

E.G.

VAR SP BASE RELATION

{S# S#,P# P#,...}

PRIMARY KEY  $\{\mathrm{S}\# ,\mathrm{P}\# \}$

FOREIGN KEY{S#} REFERENCES S

FOREIGN KEY{P#} REFERENCES P;

# Database Design with the E/R Model…

Many-to-One Relationships (involve only regular entity)

Does not cause the introduction of any new relvars  
Just introduce a foreign key in the relvar on the 'many' side of the relationship that reference the relvar on the 'one' side

E.G.

VAR EMP BASE RELATION

{EMP#..,ENAME..,DEPT#..,}

PRIMARY KEY {EMP#}

FOREIGN KEY {DEPT#} REFERENCES DEPT;

# Database Design with the E/R Model…

Weak Entities  $\rightarrow$  base relvar

Foreign key and properties of weak entity set  $\rightarrow$  attributes  
Combination of the foreign key and weak entity key  $\rightarrow$  primary key

E.g.

VAR DEPENDENT BASE RELATION

{DEP_NAME..., EMP#...}

PRIMARY KEY {DEP_NAME, EMP#}

FOREIGN KEY {EMP#} REFERENCES EMP;

# Database Design with the E/R Model…

Entity Subtypes and Supertypes

Supertype  $\rightarrow$  base relvar  
Subtype  $\rightarrow$  base relvar with primary key the same as supertype relvar and with other properties of subtype, furthermore, its primary key is also foreign key

VAR PGRM BASE RELATION

{EMP#,LANG...}

PRIMARY KEY {EMP#}

FOREIGN KEY {EMP#} REFERENCES EMP;

![](images/496128e474e990c602c48cb8239f2e16bae4176f28373e800dac567b4cac2312.jpg)

The join of subtype and supertype (ISA)  $\rightarrow$  view the join is one to one or zero to one

Var EMP_PGMR VIEW
EMP JOIN PGMR

the view thus contains just those employees who are programmers

If you can access properties

$\checkmark$  that apply to all employees by....  
$\checkmark$  that apply only to programmers by …  
$\checkmark$  that apply to programmers by…

Insert employees

✓ who are not programmers by…  
✓ who are programmers by…

# ER 模型转关系模型实例 (含拓展)

# ER模型向关系模型的转换

□ 2 联系类型转换

2.1 二元联系

示例

![](images/3a96a974d4192d38aa63cba5e3582079d11ae1caf1585446efa664a878e9f6be.jpg)

![](images/4d589a000c6b8a778af4d89cfb1e7e193ccd89dcac28592017e4d70fe913a562.jpg)

![](images/9e3e253fd4ec7bf16f30eac2e24c6a3e5dd4af4afcbf75fcdc7d6e1896898ee1.jpg)

学校（ ）

校长（姓名，性别，年龄，职称，所在学校，任职年月）

或

学校（校名，地址，电话，校长姓名，任职年月）

校长（ ）

学生（ ）

课程（ ）

选课（学号，课程号，成绩）

系（ ）

教师（工号，姓名，性别，年龄，所在系号，聘期）

# ER模型向关系模型的转换

□ 2 联系类型转换  
2.2 一元联系  
与二元联系相同  
□示例

![](images/299103eea5e49bb27d02a51b5de81e2edabd513670c027fef5a7499725cd9019.jpg)

![](images/ca902e47dae212461ee9fd3d8aefadd9fc9fc9a53e179627b3fb97739ebd1706.jpg)

零件（）

组成（零件号，子零件号，数量）

职工（工号，姓名，性别，年龄，经理工号）

运动员（编号，姓名，性别，名次，上一名次编号）

![](images/64fa91e0836a5a32641c43527a48ff6ab7a5ed5d64be4a8a04e26dc03a8f1719.jpg)

# ER模型向关系模型的转换

# □2联系类型转换

# 2.3 三元联系

1:1:1, 转换成的三个关系模式中, 在任一个关系模式中加入另两个关系模式的键 (作为外键) 和联系的属性  
1:1:N, 在N端实体类型转换成的关系模式中, 加入两个1端实体类型的键（作为外键）和联系的属性  
1: M:N, 联系类型需转换为关系模式, 属性为M端和N端实体类型的键（分别作为外键）加上联系的属性, 而键为 M端和N端实体键的组合 (特殊情况下, 需要扩展)  
M:N:P, 联系类型需转换为关系模式, 属性为三端实体类型的键（分别作为外键）加上联系的属性, 而键为三端实体键的组合 (特殊情况下, 需要扩展)

# ER模型向关系模型的转换

□ 2 联系类型转换

2.3 三元联系

示例

仓库（ ）

商店（ ）

商品（ ）

![](images/64fcb193fec3fff14e3180be3442a4b7518c38cedb66599459f604fe5ac4e040.jpg)

进货（商店号，商品名，仓库号，日期，数量）

注

M:N的联系类型，转成关系模式时，相关实体键组合有时不足以表达主键，需要扩展主键的属性构成

# ER模型向关系模型的转换

示例

![](images/f1f7c7d4f5a9c429ac4278e81ed31d167d3bded3ea927c2b5edf68138938152c.jpg)

系（系编号，系名，电话，主管人的教工号）

教师（教工号，姓名，性别，职称，系编号，聘期）

课程（课程号，课程名，学分，系编号）

任教（教工号，课程号，教材）

# ER建模案例补充

案例 1 有一家名为 “阿里巴巴”的酒店, 希望用计算机来进行酒店的管理。该酒店所管理的信息如下:

■酒店客户的个人信息：如客户的身份证号、姓名、性别、年龄、工作单位等。  
■酒店客房的状态信息：如某间客房是否有空，某间客房住了哪位客户？该客户是何时入住的？等等。  
■酒店客户的历史入住客房信息：即在过去的一年内，所有曾入住过该酒店的客户的每次入住的客房号、入住时间和退房时间等等。由此可以推算该客户在一年内入住酒店的天数，根据该信息可以决定客户在订房间时是否可以享受酒店的优惠政策。

问题:

1. 该酒店应该用文件系统还是数据库系统来进行管理？简述其原因。  
2. 如果用数据库应用系统来进行酒店的管理，你准备选择具有何种数据模型的数据库管理系统？为什么？

# An introduction to Database Systems

在案例 1 所给出的关于 “阿里巴巴” 酒店所要管理的信息的基础上, 再增加如下的一些信息要求:

■ 客房信息：包括每间客房的客房号和客房类型（标准房、双人房、商务房）。  
定价信息：每种类型客房的定价。  
■客房后勤服务信息：每间客房都有相应的雇员负责打扫，如果雇员的服务质量有问题的话，客户可以投诉，因此负责打扫客房的雇员信息包括雇员号、姓名、雇佣日期和被投诉次数等。另外，还应保存雇员及所负责的客房对照表，其中包括雇员号和客房号信息。  
■酒店飞机订票服务信息：客户可以通过电话向该酒店的订票中心订票，订票中心需记下客户订购机票的时间，并询问客户所订机票的起始地、目的地和起飞时间。然后，通过网络向航空公司订票，订票成功就出票，即在预先准备好的空白机票上打印出如下的信息：机票号码、航空公司名称、客户姓名、起始承运人（即起始机场）、目的承运人（即目的机场）、航班号、座位等级、起飞时间、到达时间和机票价格等信息。出票后，订票中心需通知客户来取票。订票中心应保存每个客户的订票信息，如客户所订机票是否已经出票，已出票的机票是否已被客户取走等等。另外，订票中心还需保留各航空公司的名称和电话。

试根据上述信息要求，设计“阿里巴巴”酒店系统的E-R模型。

![](images/96d640ff7853416cc9a7ba273b006659438e78c4e7d8e1191fa55e801f77126c.jpg)  
An introduction to Database Systems

案例2 EFG公司的销售业务围绕着如图所示的销售记录的保存与处理而展开，现该公司要求创建一个为销售业务服务数据库，试提供关于该数据库的设计资料

EFG公司销售记录样本  
原始销售记录  

<table><tr><td>订单代号</td><td>订购日期</td><td>客户</td><td>发货日期</td><td>产品</td><td>单价</td><td>数量</td><td>金额</td><td>经手人</td></tr><tr><td rowspan="3">11022</td><td rowspan="3">3/5/98</td><td rowspan="3">皮鞋厂</td><td rowspan="3">3/7/98</td><td>笔记本</td><td>3</td><td>20</td><td>60</td><td rowspan="3">于静</td></tr><tr><td>台灯</td><td>20</td><td>30</td><td>600</td></tr><tr><td>灯泡</td><td>4</td><td>25</td><td>100</td></tr><tr><td rowspan="2">11023</td><td rowspan="2">3/5/98</td><td rowspan="2">自行车厂</td><td rowspan="2">3/6/98</td><td>磁盘</td><td>40</td><td>35</td><td>1400</td><td rowspan="2">李燕</td></tr><tr><td>灯泡</td><td>4</td><td>42</td><td>168</td></tr><tr><td rowspan="4">11024</td><td rowspan="4">3/5/98</td><td rowspan="4">缝纫机厂</td><td rowspan="4">3/6/98</td><td>笔记本</td><td>3</td><td>9</td><td>27</td><td rowspan="4">王雷</td></tr><tr><td>钢笔</td><td>30</td><td>14</td><td>420</td></tr><tr><td>花盆</td><td>6</td><td>3</td><td>18</td></tr><tr><td>磁盘</td><td>40</td><td>55</td><td>2200</td></tr><tr><td>11025</td><td>3/6/98</td><td>自行车厂</td><td>3/8/98</td><td>钢笔</td><td>30</td><td>25</td><td>750</td><td>王雷</td></tr></table>

![](images/bd037023f43f229f7e785b53d54ef09e3034e7a8e597e447aa3f12babbfd2781.jpg)  
An introduction to Database Systems

![](images/a5d023aac7bd6ca7cacfdfe8aeff84aad5335d7ab1211afdac01c6f32939b620.jpg)  
An introduction to Database Systems

# 客户关系

客户编号

客户名称

# 雇员关系

雇员编号

雇员名称

# 订单关系

订单编号

定购日期

客户编号

发货日期

雇员编号

# 产品关系

产品编号

产品名称

单价

库存量

# 订购关系

订单编号

产品编号

数量

# Case 3

One toy producer produces toys of car, van, ambulance, truck and tractor. Each product comprises of several parts, the same parts could be used for different products. The parts are placed in two warehouses according to type of parts. Please draw the E-R diagram for the above background, identify the fields in each relation and define the key field for each relation.

![](images/e57de7c36c723c1e51771b1977c1d57287d3e3ba4661d9ee205cef947b2fb558.jpg)  
An introduction to Database Systems

# Case 4: a traffic accidents management branch Redesign the following ER model

![](images/32d5d838d38705d5fd2b2c42b4d07ecea1e203a630049ac913137d6d44351d89.jpg)

![](images/caf1ff87b127f35d693232765fd60bf7dc9ccbf52eb3c862533c3b9d63471fa3.jpg)  
An introduction to Database Systems

<table><tr><td>social security#</td><td>name</td><td>address</td><td>age</td><td>......</td></tr></table>

car

<table><tr><td>License tag</td><td>type</td><td>social security#</td><td>Date of bought</td><td>......</td></tr></table>

accident

<table><tr><td>Accident number</td><td>level</td><td>type</td><td>......</td></tr></table>

involve

<table><tr><td>License tag</td><td>Accident number</td><td>date</td><td>location</td><td>amage/amou</td><td>......</td></tr></table>

have

<table><tr><td>License tag</td><td>social security#</td><td>Number of drivers</td><td>......</td></tr></table>

driver

<table><tr><td>social security#</td><td>name</td><td>Licence number</td><td>date</td><td>......</td></tr></table>

licence

<table><tr><td>Licence number</td><td>type</td><td>......</td></tr></table>

![](images/280a07eb54161688bf1f9b086bcb82d7744d563f47843e71458033d3630f5c30.jpg)  
Case 5

customer

<table><tr><td>customer-name</td><td>cust-social-security</td><td>customer-street</td><td>customer-city</td></tr></table>

loan

<table><tr><td>loan-number</td><td>amount</td></tr></table>

borrower

<table><tr><td>cust-social-security</td><td>loan-number</td></tr></table>

payment

<table><tr><td>loan-number</td><td>payment-number</td><td>payment-date</td><td>payment-amount</td></tr></table>

branch

<table><tr><td>branch-name</td><td>branch-city</td><td>assets</td></tr></table>

Loan-branch

<table><tr><td>branch-name</td><td>loan-number</td></tr></table>

account

<table><tr><td>account - number</td><td>balance</td><td>account - type</td></tr></table>

savings-account

<table><tr><td>account - number</td><td>interest-rate</td></tr></table>

checking-account

<table><tr><td>account - number</td><td>overdraft - amount</td></tr></table>

employee

<table><tr><td>emp-social-security</td><td>employee-name</td><td>phone-number</td><td>Start-date</td></tr></table>

dependent

<table><tr><td>e-social-security</td><td>dependent-name</td></tr></table>

#

# group project—section 2

■ design an E-R model for your application  
■ design the tables in the database