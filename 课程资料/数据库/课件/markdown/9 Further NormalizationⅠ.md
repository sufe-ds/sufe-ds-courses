# Further Normalization I

![](images/4c9ca8744e5fe84cef151fbc39442e7edba20cd246b1a5fd1463ba412c8c8862.jpg)

# An introduction to Database Systems

# What you will learn

1 Introduction  
2 Nonloss Decomposition  
3 First Normal Form (1NF)  
4 Second Normal Form (2NF)  
5 Third Normal Form (3NF)  
6 Dependency Preservation  
7 Boyce/Codd Normal Form(BCNF)  
8 Procedure for Normalisation  
9 Normalization/Denormalization

# 1.Introduction-example1

CustomerOrder(Ono,Cno,Company,Address,Odate,

Freight,Pno,Quantity)

Ono：订单代号

Cno：客户公司的代号

Company：公司名称

Address：客户的公司地址

Odate 订：购日期

Freight：运货费

Pno：产品代号

Quantity : 数量

1.Introduction-example1  

<table><tr><td>Ono</td><td>Cno</td><td>Company</td><td>Address</td><td>Odate</td><td>Freight</td><td>Pno</td><td>Quantity</td></tr><tr><td>0001</td><td>C001</td><td>好欣</td><td>上海市四川北路1000号</td><td>2000-04-01</td><td>100</td><td>A001</td><td>100</td></tr><tr><td>0001</td><td>C001</td><td>好欣</td><td>上海市四川北路1000号</td><td>2000-04-01</td><td>100</td><td>A002</td><td>50</td></tr><tr><td>0001</td><td>C001</td><td>好欣</td><td>上海市四川北路1000号</td><td>2000-04-01</td><td>100</td><td>A003</td><td>20</td></tr><tr><td>0002</td><td>C002</td><td>兴兴</td><td>上海市南京东路250号</td><td>2000-08-01</td><td>200</td><td>B001</td><td>200</td></tr><tr><td>0002</td><td>C002</td><td>兴兴</td><td>上海市南京东路250号</td><td>2000-08-01</td><td>200</td><td>B002</td><td>20</td></tr><tr><td>0002</td><td>C002</td><td>兴兴</td><td>上海市南京东路250号</td><td>2000-08-01</td><td>200</td><td>B003</td><td>100</td></tr><tr><td>0002</td><td>C002</td><td>兴兴</td><td>上海市南京东路250号</td><td>2000-08-01</td><td>200</td><td>B004</td><td>50</td></tr><tr><td>0002</td><td>C002</td><td>兴兴</td><td>上海市南京东路250号</td><td>2000-08-01</td><td>200</td><td>B005</td><td>150</td></tr><tr><td>0003</td><td>C003</td><td>天乾</td><td>上海市淮海东路300号</td><td>2000-11-01</td><td>150</td><td>C001</td><td>100</td></tr><tr><td>0003</td><td>C003</td><td>天乾</td><td>上海市淮海东路300号</td><td>2000-11-01</td><td>150</td><td>C002</td><td>50</td></tr><tr><td>0003</td><td>C003</td><td>天乾</td><td>上海市淮海东路300号</td><td>2000-11-01</td><td>150</td><td>C003</td><td>50</td></tr><tr><td>0003</td><td>C003</td><td>天乾</td><td>上海市淮海东路300号</td><td>2000-11-01</td><td>150</td><td>C004</td><td>20</td></tr></table>

What is wrong with this design?

(redundancy.insert,delete,update)

# 1.Introduction-example2

<table><tr><td>SCP</td><td>S#</td><td>CITY</td><td>P#</td><td>QTY</td></tr><tr><td></td><td>S1</td><td>London</td><td>P1</td><td>300</td></tr><tr><td></td><td>S1</td><td>London</td><td>P2</td><td>200</td></tr><tr><td></td><td>S1</td><td>London</td><td>P3</td><td>400</td></tr><tr><td></td><td>S1</td><td>London</td><td>P4</td><td>200</td></tr><tr><td></td><td>S1</td><td>London</td><td>P5</td><td>100</td></tr><tr><td></td><td>S1</td><td>London</td><td>P6</td><td>100</td></tr><tr><td></td><td>S2</td><td>Paris</td><td>P1</td><td>300</td></tr><tr><td></td><td>S2</td><td>Paris</td><td>P2</td><td>400</td></tr><tr><td></td><td>S3</td><td>Paris</td><td>P2</td><td>200</td></tr><tr><td></td><td>S4</td><td>London</td><td>P2</td><td>200</td></tr><tr><td></td><td>S4</td><td>London</td><td>P4</td><td>300</td></tr><tr><td></td><td>S4</td><td>London</td><td>P5</td><td>400</td></tr></table>

Fig. 11.1 What is wrong with this design?

# 1. Introduction-Normalization(规范化)

■ Normalization is a progressive process of reducing a set of relations to a “more desirable” form (i.e. containing less redundancy).  
The method of normalization is based on a progression through five increasingly "desirable" levels of forms (concerning some aspects of good design).

1NF (normalized) relvars

2NF relvars

3NF relvars

BCNF relvars

4NF relvars

5NF relvars

![](images/4ba5e0fd0ffa97f12979793493dd40593c73ff613de347d13bb6039116473631.jpg)  
Fig. 11.2 Levels of normalization

![](images/540e203f2d32c5a84c759cdb224292cd1ef84f1f4f64377cf31750737c86aca5.jpg)

![](images/2d34fe8ebb29b6aeffa60c6bcd4732c131ba348fde68f53b0b20c2e27984c554.jpg)

# 1. Introduction- Decomposition (模式分解)

CustomerOrder(Ono,Cno,Company,Address,Odate, Freight,Pno,Quantity)

Order_c(Ono,Cno,Odate,Freight)  
■ Order_item(Ono, Pno ,Quantity)  
Customer(Cno,Company,Address)

SCP (S#, CITY, P#, QTY)

S(S#, CITY)  
SP(S#，P#，QTY)

# 2. Nonloss Decomposition and Functional Dependencies (无损分解和函数依赖)

s

<table><tr><td>S#</td><td>STATUS</td><td>CITY</td></tr><tr><td>S3</td><td>30</td><td>Paris</td></tr><tr><td>S5</td><td>30</td><td>Athens</td></tr></table>

(a)

SST

<table><tr><td>S#</td><td>STATUS</td></tr><tr><td>S3</td><td>30</td></tr><tr><td>S5</td><td>30</td></tr></table>

SC

<table><tr><td>S#</td><td>CITY</td></tr><tr><td>S3</td><td>Paris</td></tr><tr><td>S5</td><td>Athens</td></tr></table>

(b)

SST

<table><tr><td>S#</td><td>STATUS</td></tr><tr><td>S3</td><td>30</td></tr><tr><td>S5</td><td>30</td></tr></table>

STC

<table><tr><td>STATUS</td><td>CITY</td></tr><tr><td>30</td><td>Paris</td></tr><tr><td>30</td><td>Athens</td></tr></table>

Fig. 11.3 Sample value for relvar S and two corresponding decompositions

# 2. Nonloss Decomposition and Functional Dependencies…

The process of "decomposition" is really a process of projection.  
How can we ensure that no information represented in the original relation is lost?  
Heath's theorem:

Given  $R$  with sets of attributes  $A, B$  and  $C$ , then if  $R$  satisfies the FD:  $A \rightarrow B$

then  $R$  is equal to the join of its projections on  $\{A, B\}$  and  $\{A, C\}$ .

Heath's theorem does not explain why this is so.

e.g. Given S{S#, CITY, STATUS}

S is equal to the join of  $\{\mathbf{S}\# ,\mathbf{CITY}\}$  and  $\{\mathbf{S}\# ,\mathbf{STATUS}\}$

-- non-loss decomposition

S is not equal to the join of  $\{\mathrm{S}\# ,\mathrm{STATUS}\}$  and  $\{\mathrm{CITY},$  STATUS\}

# More on Functional Dependencies

Left-irreducible FDs:

$\{\mathrm{S}\# , \mathrm{P}\#\} \rightarrow \mathrm{CITY}$  
• S# → CITY

FD diagrams:

![](images/ec6c7d15b2fc4262b1c1133cfe0d3197efc0922007ec3cbc60e13d94b2ca3718.jpg)  
Fig. 11.4 FD diagrams for relvars S, SP, and P

# 3. First Normal Form (1NF) 第一范式

# A relation is in 1NF if and only if all underlying fields contain atomic(scalar) values only.

A field contains multiple values  

<table><tr><td>Course No.</td><td>Course Title</td><td>Student</td><td>Dept</td></tr><tr><td>C00061</td><td>DB 1</td><td>{Peter Brown, Jenny Wong, Neil Smith}</td><td>Accounts</td></tr></table>

Repeating groups  

<table><tr><td>Course No.</td><td>Course Title</td><td>Student 1</td><td>Student 1 dept</td><td>Student 2</td><td>Student 2 dept</td></tr><tr><td>C00061</td><td>DB 1</td><td>Peter Brown</td><td>Accounts</td><td>Neil Smith</td><td>Accounts</td></tr><tr><td>C00023</td><td>Java</td><td>Jenny Wong</td><td>IT</td><td>Peter Brown</td><td>Computer</td></tr></table>

# 3. 1NF…

# (Eliminate repeating groups)

Unnormalized EMPL  

<table><tr><td>EMP</td><td>LAST</td><td>WORK</td><td>DEPTNAME</td><td>SKILL1</td><td>SKILL2</td><td>SKILLN...</td></tr><tr><td>NO</td><td>NAME</td><td>DEPT</td><td></td><td></td><td></td><td></td></tr><tr><td>000030</td><td>KWAN</td><td>GRE</td><td>OPERATIONS</td><td>141</td><td></td><td></td></tr><tr><td>000250</td><td>SMITH</td><td>BLU</td><td>PLANNING</td><td>002</td><td>011</td><td>067</td></tr><tr><td>000270</td><td>PEREZ</td><td>RED</td><td>MARKETING</td><td>415</td><td>447</td><td></td></tr><tr><td>000300</td><td>SMITH</td><td>BLU</td><td>PLANNING</td><td>011</td><td>032</td><td></td></tr></table>

Normalized to 1NF - EMPL  

<table><tr><td>EMP</td><td>LAST</td><td>WORK</td><td>DEPTNAME</td></tr><tr><td>NO</td><td>NAME</td><td>DEPT</td><td></td></tr><tr><td>000030</td><td>KWAN</td><td>GRE</td><td>OPERATIONS</td></tr><tr><td>000250</td><td>SMITH</td><td>BLU</td><td>PLANNING</td></tr><tr><td>000270</td><td>PEREZ</td><td>RED</td><td>MARKETING</td></tr><tr><td>000300</td><td>SMITH</td><td>BLU</td><td>PLANNING</td></tr></table>

EMPL_SKILL TABLE  

<table><tr><td>EMPNO</td><td>SKILL</td><td>SKILLDESC</td></tr><tr><td>000030</td><td>141</td><td>RESEARCH</td></tr><tr><td>000250</td><td>002</td><td>BID PREP</td></tr><tr><td>000250</td><td>011</td><td>NEGOTIATION</td></tr><tr><td>000250</td><td>067</td><td>PROD SPEC</td></tr><tr><td>000270</td><td>415</td><td>BENEFITS ANL</td></tr><tr><td>000270</td><td>447</td><td>TESTING</td></tr><tr><td>000300</td><td>011</td><td>NEGOTIATION</td></tr><tr><td>000300</td><td>032</td><td>INV CONTROL</td></tr></table>

# 3. 1NF - Problems of 1NF

Primary Key (Supplier#, Part#)  

<table><tr><td>Supplier#</td><td>Status</td><td>City</td><td>Part#</td><td>Quantity</td></tr><tr><td>S1</td><td>20</td><td>London</td><td>P1</td><td>1600</td></tr><tr><td>S1</td><td>20</td><td>London</td><td>P2</td><td>2000</td></tr><tr><td>S2</td><td>10</td><td>Paris</td><td>P2</td><td>500</td></tr><tr><td>S3</td><td>20</td><td>London</td><td>P3</td><td>3000</td></tr></table>

Insert - cannot insert the fact that a supplier is located in a particular city until supplier supplies at least one part  
Delete - delete the value P3, and we also lose the information that S3 is located in London  
Update - S1 appears in the table more than once, and we must change all of them -- Possibility of producing an inconsistent result.

# 3. 1NF - Dependencies between Attributes

By analyzing a given relation, we can identify some dependencies between its attributes.  
In principle, we want to make attributes independent of each other as far as possible, so that updating one attribute will have no impact on the others.

![](images/d4bd6c153c28250857b84036173bde7a64e144993b66500467127e9b246122dc.jpg)

# 4. Second Normal Form (2NF)

A relation is in 2NF if and only if it is 1NF and every nonkey field is irreducibly dependent on the primary key.

Primary Key (Supplier#, Part#)  

<table><tr><td>Supplier#</td><td>Status</td><td>City</td><td>Part#</td><td>Quantity</td></tr><tr><td>S1</td><td>20</td><td>London</td><td>P1</td><td>1600</td></tr><tr><td>S1</td><td>20</td><td>London</td><td>P2</td><td>2000</td></tr><tr><td>S2</td><td>10</td><td>Paris</td><td>P2</td><td>500</td></tr><tr><td>S3</td><td>20</td><td>London</td><td>P3</td><td>3000</td></tr></table>

Note: City is a non-key field and only dependent on part of the primary key(i.e. supplier#). So this relation is not in 2NF.

# 4. 2NF-Solution to Problems

# The solution is to replace the relation by two new relations (called One and Two)

One: Primary Key (Supplier#)  

<table><tr><td>Supplier#</td><td>Status</td><td>City</td></tr><tr><td>S1</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>20</td><td>London</td></tr></table>

Two: Primary Key (Supplier#, Part#)  

<table><tr><td>Supplier#</td><td>Part#</td><td>Quantity</td></tr><tr><td>S1</td><td>P1</td><td>1600</td></tr><tr><td>S1</td><td>P2</td><td>2000</td></tr><tr><td>S2</td><td>P2</td><td>500</td></tr><tr><td>S3</td><td>P3</td><td>3000</td></tr></table>

This revised structure overcomes all the problems sketched earlier, but:

- Insert - cannot insert the fact that a particular city has a status until a supplier is actually located in that city.  
- Delete - delete the value S2, and we also lose the information that Paris has the status value 10.  
- Update - Status value 20 appears in the table more than once.

# 4. 2NF - Procedure to Get 2NF

Given a relation  $R$  as follows:

$R(A, B, C, D)$  with Primary Key  $(A, B)$

FD:  $A \rightarrow D$

Replace  $R$  by the two projections  $R1$  and  $R2$  as follows:

$R 1(A, D)$  with Primary Key  $A$

$R2(A, B, C)$  with Primary Key  $(A, B)$

Foreign Key A references R1

# 5. Third Normal Form (3NF)

A relation is in 3NF if and only if it is 2NF and all nonkey fields are mutually independent.

One: Primary Key (Supplier#)  

<table><tr><td>Supplier#</td><td>Status</td><td>City</td></tr><tr><td>S1</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>20</td><td>London</td></tr></table>

Two: Primary Key (Supplier#, Part#)  

<table><tr><td>Supplier#</td><td>Part#</td><td>Quantity</td></tr><tr><td>S1</td><td>P1</td><td>1600</td></tr><tr><td>S1</td><td>P2</td><td>2000</td></tr><tr><td>S2</td><td>P2</td><td>500</td></tr><tr><td>S3</td><td>P3</td><td>3000</td></tr></table>

Note: Relation Two is in 3NF (with only one non-key field), but relation One is not in 3NF because Status is dependent on City (both are non-key fields)

# 5.3NF - Converting 2NF into 3NF

We can now normalize relation One into two new relations (called three and four), which both are in 3NF.

Three: Primary Key (Supplier#)  

<table><tr><td>Supplier#</td><td>City</td></tr><tr><td>S1</td><td>London</td></tr><tr><td>S2</td><td>Paris</td></tr><tr><td>S3</td><td>London</td></tr></table>

Four: Primary Key (City)  

<table><tr><td>City</td><td>Status</td></tr><tr><td>London</td><td>20</td></tr><tr><td>Paris</td><td>10</td></tr></table>

Higher Normal Forms (e.g. 4NF and 5NF) do exist, but they are mainly of interest in academic societies rather than in the practical applications of database design.

# 5. 3NF - Procedure to Get 3NF

Given a relation  $R$  as follows:

$R(A, B, C)$  with Primary Key  $A$

FD:  $B \rightarrow C$

Replace  $R$  by the two projections  $R1$  and  $R2$  as follows:

$R 1(B, C)$  with Primary Key  $B$

$R2(A, B)$  with Primary Key  $A$

Foreign Key B references R1

# 6. Dependency Preservation (保持函数依赖)

We expect that the projections are independent of one another, in the following sense: Update can be made to either one without regard for the other.  
The idea that the normalization procedure should decompose relvars into projections that are independent has come to be known as dependency preservation.  
■ In the process of decomposing, no FDs should span two relvars. - enforcing these constraints is very difficulty.  
Projections R1 and R2 of relvar R are independent if and only if:

Every FD in R is a logical consequence(推论) of those in R1 and R2, and  
The common attributes of R1 and R2 form a candidate key for at least one of the pair.

(R1 和 R2 的公共属性至少组成它们之中的一个候选码)

# 6. Dependency Preservation…

SECOND ( S#,STATUS,CITY )

Decomposition

![](images/09bc604e8ce24405358d7052a0aac8365edb631632b52bcf883fc837f85555ab.jpg)

SC (S#, CITY)

CS (CITY, STATUS)

dependency preservation

# 6. Dependency Preservation…

SECOND ( S#,STATUS,CITY )

![](images/93c2722181d31fb9f7797e4e6ccbc48bf33797e724e0b7a21952167ff97194fc.jpg)

dependency preservation

SC (S#, CITY)

SS (S#, STATUS)

- Updates to either of the two projections must be monitored to ensure that the FD CITY  $\rightarrow$  STATUS is not violated (if two suppliers have the same city, then they must have the same status).

# Example

EMP (Eno,Dept,Manager) with FDs

Eno  $\rightarrow$  Dept , Dept  $\rightarrow$  Manager

<table><tr><td>ENO</td><td>Dept</td><td>Manager</td></tr><tr><td>E001</td><td>销售部</td><td>顾冰</td></tr><tr><td>E002</td><td>销售部</td><td>顾冰</td></tr><tr><td>E003</td><td>销售部</td><td>顾冰</td></tr><tr><td>E004</td><td>销售部</td><td>顾冰</td></tr><tr><td>E005</td><td>销售部</td><td>顾冰</td></tr><tr><td>E006</td><td>采购部</td><td>杨俊</td></tr><tr><td>E007</td><td>采购部</td><td>杨俊</td></tr></table>

# Example- Decomposition1

![](images/e185dcc05c706d2f0fffe4205658aafa814aabc41ac290a9046ef8faae9e87c2.jpg)  
E

![](images/89dd5d0b4b470d7b7109034cc96a7df834016af7ec547de89ab87879d2a2c07d.jpg)  
D

![](images/b334bd107706c52f12be62b6ddf9e7aae560dafc9a9f21a5fae819b21e69a47c.jpg)  
M

规范化程度很高，但是却丢失了原来关系模式中的信息

# Example-Decomposition2

<table><tr><td>ENO</td><td>Dept</td></tr><tr><td>E001</td><td>销售部</td></tr><tr><td>E002</td><td>销售部</td></tr><tr><td>E003</td><td>销售部</td></tr><tr><td>E004</td><td>销售部</td></tr><tr><td>E005</td><td>销售部</td></tr><tr><td>E006</td><td>采购部</td></tr><tr><td>E007</td><td>采购部</td></tr></table>

<table><tr><td>Eno</td><td>Manager</td></tr><tr><td>E001</td><td>顾冰</td></tr><tr><td>E002</td><td>顾冰</td></tr><tr><td>E003</td><td>顾冰</td></tr><tr><td>E004</td><td>顾冰</td></tr><tr><td>E005</td><td>顾冰</td></tr><tr><td>E006</td><td>杨俊</td></tr><tr><td>E007</td><td>杨俊</td></tr></table>

ED

具有无损连接性

没有保持函数依赖

EM

部门的经理是谁？- Join  
当雇员“E001”从销售部门转到采购部门时，需同时修改ED中的（“E001”，“销售部”）元组和EM中的（“E001”，“顾冰”）元组。

# Example- Decomposition3

<table><tr><td>ENO</td><td>Dept</td></tr><tr><td>E001</td><td>销售部</td></tr><tr><td>E002</td><td>销售部</td></tr><tr><td>E003</td><td>销售部</td></tr><tr><td>E004</td><td>销售部</td></tr><tr><td>E005</td><td>销售部</td></tr><tr><td>E006</td><td>采购部</td></tr><tr><td>E007</td><td>采购部</td></tr></table>

ED

部门的经理是谁？  
当雇员“E001”从销售部门转到采购部门……

<table><tr><td>Dept</td><td>Manager</td></tr><tr><td>销售部</td><td>顾冰</td></tr><tr><td>采购部</td><td>杨俊</td></tr></table>

DM

既具有无损连接性又保持了函数依赖

# 7. Boyce/Codd Normal Form

Boyce/Codd Normal Form (BCNF): a relation is in BCNF if and only if every non-trivial, left-irreducible FD has a candidate key as its determinant.  
In other words the only arrows in the dependency diagram are arrows out of candidate keys AND no other arrows.

# 3NF vs. BCNF

3NF and BCNF are equivalent if the combination of the following conditions does not occur for a relation that

1. had two (or more) candidate keys, such that  
2. the two keys were composite, and  
3. they overlapped (i.e. at least one attribute in common)

e.g. S (S#, SNAME, STATUS, CITY)

CANDIDATE KEY (S#)

CANDIDATE KEY (SNAME)

![](images/324b1ba8867ba5384ed817a6469350718a9889c939ade338504c2b179369fadd.jpg)

# Not 3NF Not BCNF

e.g. SSP (S#, SNAME, P#, QTY)

CANDIDATE KEY (S#, P#)

CANDIDATE KEY (SNAME, P#)

![](images/ca03ad1a73af2e48ec1a053c0ee7ddb137c46144c18faa252046d9ee08a27445.jpg)

<table><tr><td>S#</td><td>SNAME</td><td>P#</td><td>QTY</td></tr><tr><td>S1</td><td>Smith</td><td>P1</td><td>300</td></tr><tr><td>S1</td><td>Smith</td><td>P2</td><td>200</td></tr><tr><td>S1</td><td>Smith</td><td>P3</td><td>400</td></tr><tr><td>S1</td><td>Smith</td><td>P4</td><td>200</td></tr></table>

$\{\mathrm{S}\# , \mathrm{P}\# \} \rightarrow \mathrm{SNAME}$

But SNAME is not irreducibly dependent on  $\{\mathrm{S}\# , \mathrm{P}\#\}$

Because S# → SNAME

# Example

STJ (S, T, J)

S:学生 T:教师 J:课程

![](images/8003f465069e0488bc1179a9f2ba18249e1ba2f447ae3fb7251920cd241bd081.jpg)

CANDIDATE KEY :

$\{\mathrm{S}, \mathrm{J}\}$

$\{\mathrm{S}, \mathrm{T}\}$

结论：不属于BCNF

Decomposition :

ST{S  $\cdot$  T}

TJ{T，J}

$\in$ BCNF

# Example

EXAM (S, J, P)

S: 学生

J: 课程

P: 名次

![](images/ba556597ccdc9e4a868d3ce191666bb223a11450fc3e833721b25ccdfb440007.jpg)

![](images/64107899aca55e79aa8ece22fa62ad8e54e521f9df1791d668902ee2583324b5.jpg)

候选码:  $\{S, J\}$  和  $\{J, P\}$

EXAM $\in$ BCNF

# 8.Procedure for Normalisation

1) take projections of 1NF relation to eliminate reducible FDs -- giving a set of 2NF relations  
2) take projections of these 2NF relations to eliminate transitive FDs -- giving a set of 3NF relations  
3) take projections of these 3NF relations to eliminate FDs in which the determinant is not a candidate key -- giving a set of BCNF relations  
4) take projections of these BCNF relations to eliminate MVDs which are not also FDs -- giving a set of 4NF relations  
5) take projections of these 4NF relations to eliminate JDs which are not implied by candidate keys -- giving a set of 5NF relations

# 9. Normalization/Denormalization

Are Normal Forms a wholly “good thing”?

Remove a number of serious problems resulting from redundant information.  
■ Can be achieved by following a general procedure.  
■ Decomposition may lead to poor performance (too many small tables).  
■ Decomposition may make it easy to break semantic constraints although constraints of referential integrity could help.

# An introduction to Database Systems

# Questions answer

# Analyze the table's use to evaluate the benefits of denormalizing

Is the data read-only?

Are updates frequent?

Will tables be frequently accessed together?

# Normalization/Denormalization Example

EMPL

(EMPNO, DEPT, LAST, MI, FIRST, JOB)

1,000,000 rows

30 chars / row

DEPT

(DEPT, DEPTNAME, MGRNO)

10,000 rows

25 chars / row

Transaction rate 20,000 / DAY, two tables accessed

SELECT LAST, MI, FIRST, MGRNO

FROM EMPL A, DEPT B

WHERE A.DEPT = B.DEPT AND

EMPNO = '000010'

# Normalization/Denormalization Example…

# Carry MGRNO in both tables

EMPL

(EMPNO, DEPT, LAST, MI, FIRST, JOB, MGRNO)

1,000,000 rows

33 chars / row

DEPT

(DEPT, DEPTNAME, MGRNO)

10,000 rows

25 chars / row

Transaction rate 20,000 / DAY, one table accessed

SELECT LAST, MI, FIRST, MGRNO

FROM EMPL

WHERE EMPNO = '000010'

# Costs and Benefits of Denormalization

# Cost

Storage 1,000,000 rows

x 3 characters

3,000,000 characters (Approx 900 pages)

- Additional updates if MGRNO changes

# Benefit

- Save 20,000 accesses / day

# Exercises

For each of the following relation schemas and sets of functional dependencies:

1.  $\mathrm{R}(\mathrm{A}, \mathrm{B}, \mathrm{C}, \mathrm{D})$  with FDs:  $\mathrm{AB} \rightarrow \mathrm{C}, \mathrm{C} \rightarrow \mathrm{D}$ , and  $\mathrm{D} \rightarrow \mathrm{A}$  
2.  $\mathrm{R}(\mathrm{A}, \mathrm{B}, \mathrm{C}, \mathrm{D})$  with FDs:  $\mathrm{B} \rightarrow \mathrm{C}$ , and  $\mathrm{B} \rightarrow \mathrm{D}$

Do the following:

1. Indicate all the 2NF/3NF/BCNF violations;  
2. Decompose the relations, as necessary, into collections of relations that are in 2NF/3NF/BCNF.

Answer: both of them are in INF.