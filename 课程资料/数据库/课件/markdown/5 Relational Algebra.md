# Relational Algebra

![](images/bdd90f3409e4bf8adcff1a4b5589f39ded62cecfaafe0ceaf85a731359af1353.jpg)

# What will you learn?

Codd's original eight operators  
closure property  
semantics  
what is the Algebra for?

# 1. Introduction

Relational algebra is basically just a set of operators that take relations as their operands and return a relation as their result.  
Codd's original eight operators

The traditional set operators:

○ Union (并)  
• Intersection (交)  
Difference (差)  
Cartesian product (迪卡尔积)

The special relational operators:

o restrict/select (选择)  
Project (投影)  
Join (连接)  
○ Divide (除)

![](images/7f15b283c4fa98c651fd162dec75659830a42965b1fc29127aee4ac90e31a947.jpg)  
Fig. 6.1 The original eight operators (overview)

# 2. Closure property

# Closure property:

- The output from any given relational operation is another relation.  
- Nested relational expressions

# RENAME operator:

- Rename attributes within a specified relation. e.g. S RENAME CITY AS SCITY

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>SCITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr><tr><td>S5</td><td>Adams</td><td>30</td><td>Athens</td></tr></table>

# 3. Semantics（关系操作的语义）-- Union

![](images/a210d83304aebd99b46d55b1ddf173a7605189eb590aabc25220ea4767d54a38.jpg)  
A

Two relations are type-compatible if they have the same set of attribute names which are defined on the same domains

# The union of two (type-compatible) relations  $A$  and  $B$ :

A UNION B = {t | t∈A v t∈B}

-is a relation with the same heading as each of  $A$  and  $B$  and with a  
-body consisting of the set of all tuples  $t$  belonging to  $A$  or  $B$  or both.

# Example of Union

Airport1  

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>Pisa</td><td>Italy</td></tr></table>

Airport2  

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Manchester</td><td>England</td></tr></table>

Airport1 UNION Airport2  

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>Pisa</td><td>Italy</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Manchester</td><td>England</td></tr></table>

# 3. Semantics-- Intersection

![](images/d1a7802fe002e4ea0513e4624f0876b4113644b26162684990c4fe767c23517b.jpg)

The intersection of two (type-compatible) relations  $A$  and  $B$ :

$$
A I N T E R S E C T I O N B = \{t | t \in A \land t \in B \}
$$

- is a relation with the same heading as each of  $A$  and  $B$  and with a

body consisting of the set of all tuples  $t$  belonging to both  $A$  and  $B$ .

# Example of Intersection

# Airport1

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>Pisa</td><td>Italy</td></tr></table>

# Airport2

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Manchester</td><td>England</td></tr></table>

# Airport1 INTERSECTION Airport2

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr></table>

# 3. Semantics-- Difference

![](images/1e33b51e7151e831df5007d919878b96bfbd395847815bd233ac60e5e37709b8.jpg)

The difference of two (type-compatible) relations  $A$  and  $B$  in that order:

$$
A M I N U S B = \{t | t \in A \land ! t \in B \}
$$

- is a relation with the same heading as each of  $A$  and  $B$  and with a

body consisting of the set of all tuples  $t$  belonging to  $A$  and not to  $B$ .

# Example of Difference

# Airport1

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>Pisa</td><td>Italy</td></tr></table>

# Airport2

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Manchester</td><td>England</td></tr></table>

# Airport1 MINUS Airport2

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>Pisa</td><td>Italy</td></tr></table>

What about Airport2 MINUS Airport1?

# Example of Union/Intersection/Difference

A

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr></table>

B

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr></table>

a. Union (A UNION B)

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr></table>

b. Intersection (A INTERSECT B)

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr></table>

c. Difference (A MINUS B)

d. Difference (B MINUS A)

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr></table>

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr></table>

Fig. 6.2 Union, intersection, and difference examples

# 3. Semantics - Product

a1 a2

TIMES

b1 b2

二

a1

b1

a1

b2

a2

b1

a2

b2

Let relations  $A$  and  $B$  have headings  $\{X\}$  and  $\{Y\}$  respectively.

The Cartesian product of  $A$  and  $B$  where they have no common attribute names:

$$
A T I M E S B = \{a b | a \in A \land b \in B \}
$$

- is a relation with the heading that is the sum of the headings of  $A$  and  $B$  and body consisting of the set of all tuples  $t$  such that  $t$  is the coalescing of a tuple  $a$  in  $A$  and a tuple  $b$  in  $B$ .

# More about Product…

- The cardinality of the result of  $A$  TIMES  $B$  is the product of the cardinalities of  $A$  and  $B$  
- The degree of the result is the sum of the degrees of  $A$  and  $B$  
- The Cartesian product is not very important in practice  
- The result is often large and space-costly but produces no more information than there was in the input

# Example of Product…

![](images/28c19a5f502d36f8b45100d40f2c1a2d7dfaef1d3a24047a327a6468a793d530.jpg)  
Fig. 6.3 Cartesian product example

# 3. Semantics - Restrict

A

<table><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr></table>

# The restriction of relation  $A$  on the condition:

# A WHERE condition

-is a relation with the same heading as  $A$  and with a  
-body consisting

of the set of all tuples  $t$  of  $A$  such that the condition is true for  $t$

# Restriction Condition

A WHERE X θ Y

X, Y are attributes of A, and must be defined on the same domain

$\theta$  is any simple scalar comparison operator like  $=, \neq, >, \geq$  etc.

In fact, the restriction condition can be an arbitrary Boolean combination of simple comparisons connected by AND, OR, NOT.

Take note: Unlike the traditional set operators, restrict takes a relation and an

expression as input, and produces a relation as output. Some concepts like

commutativity and associativity no longer applicable.

Airports  

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Pisa</td><td>Italy</td></tr><tr><td>Venice/MP</td><td>Italy</td></tr><tr><td>Manchester</td><td>England</td></tr><tr><td>Kai Tak</td><td>Hong Kong</td></tr><tr><td>Changi</td><td>Singapore</td></tr></table>

Airports WHERE airport_name = 'London/GK'

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr></table>

Airports WHERE country_name = 'England'

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Manchester</td><td>England</td></tr></table>

# Example of Restrictions

S WHERE CITY = 'London'

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr></table>

P WHERE WEIGHT< WEIGHT (14.0)

<table><tr><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td><td>CITY</td></tr><tr><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td><td>Paris</td></tr></table>

SP WHERE S# = S# ('S6') OR P# = P# ('P7')

<table><tr><td>S#</td><td>P#</td><td>QTY</td></tr><tr><td></td><td></td><td></td></tr></table>

Fig. 6.4 Restriction examples

# 3. Semantics - Project

A

![](images/b30c3852b606f7c1fd3bca20a0ea220a71dee227f4873ce4c9bdbca7204f1f23.jpg)

The projection of relation  $A$  on attributes  $X, Y, \ldots, Z$ :

A  $\{X, Y, \ldots, Z\}$

- is a relation with the heading  $\{X, Y, \dots, Z\}$  and with the a body

consisting of the set of all tuples  $\{X : x, Y : y, \ldots, Z : z\}$  such that a

tuple appears in  $A$  with  $X$ -value  $x$ ,  $Y$ -value  $y$ , ...,  $Z$ -value  $z$ .

# More about Projection

The projection operator produces the output table by 1) eliminating all attributes not specified, and 2) eliminating any duplicated tuples

A -- identity projection

A{} -- nullary projection (both not very useful but legal)

We may project some attributes away instead of the standard way

This operator can be used to 1) rename attributes, and 2) permute attributes

# Example of Projections

Airports  

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Pisa</td><td>Italy</td></tr><tr><td>Venice/MP</td><td>Italy</td></tr><tr><td>Manchester</td><td>England</td></tr><tr><td>Kai Tak</td><td>Hong Kong</td></tr><tr><td>Changi</td><td>Singapore</td></tr></table>

Airports {country_name, airport_name}

<table><tr><td>country_name</td><td>airport_name</td></tr><tr><td>England</td><td>London/Gk</td></tr><tr><td>… …</td><td>… …</td></tr></table>

Airports {country_name} a unary relation

<table><tr><td>country_name</td></tr><tr><td>Italy
England
Hong Kong
Singapore</td></tr></table>

(We could rename the attribute at the same time using the below expression: Airport [RENAME country-name AS country]

# Example of project

S {CITY}

CITY

London Paris Athens

P {COLOR, CITY}

COLOR

Red Green Blue Blue

CITY

London Paris Rome Paris

(S WHERE CITY = 'Paris') { S#}

S#

s2 s3

Fig. 6.5 Projection examples

# 3. Semantics - Natural Join

<table><tr><td>a1
a2</td><td>b1
b1</td><td>join</td><td>b1
b1</td><td>c1
c2</td><td>=</td><td>a1
a1
a2
a2</td><td>b1
b1
b1
b1</td><td>c1
c2
c1
c2</td></tr><tr><td colspan="9">tions A and B have headings {X, Y} and where X, Y and Z are composite attributes).</td></tr></table>

# The (natural) join of  $A$  and  $B$ : A JOIN B

- is a relation with the heading  $\{X, Y, Z\}$  and body consisting of the set of all tuples  $\{X : x, Y : y, Z : z\}$  such that a tuple appears in  $A$  with  $X$ -value  $x$  and  $Y$ -value  $y$  and a tuple appears in  $B$  with  $Y$ -value  $y$  and  $Z$ -value  $z$ .

# More about Natural Join

A JOIN B JOIN C = (A JOIN B) JOIN C  
= A JOIN (B JOIN C) (associative)

A JOIN B = B JOIN A (commutative)

If  $A$  and  $B$  have no attribute names in common,

A JOIN B = ?

= A TIMES B

# Example of Natural Join

Airports  

<table><tr><td>airport_name</td><td>country_name</td></tr><tr><td>Naples</td><td>Italy</td></tr><tr><td>London/Gk</td><td>England</td></tr><tr><td>London/Hw</td><td>England</td></tr><tr><td>Pisa</td><td>Italy</td></tr><tr><td>Venice/MP</td><td>Italy</td></tr><tr><td>Manchester</td><td>England</td></tr><tr><td>Kai Tak</td><td>Hong Kong</td></tr><tr><td>Changi</td><td>Singapore</td></tr></table>

Stop  

<table><tr><td>flight_number</td><td>airport_name</td><td>stop_number</td></tr><tr><td>BA383</td><td>Kai Tak</td><td>1</td></tr><tr><td>BA01</td><td>Changi</td><td>2</td></tr></table>

Stops JOIN Airports  

<table><tr><td>flight_number</td><td>airport_name</td><td>stop_number</td><td>country_name</td></tr><tr><td>BA383</td><td>Kai Tak</td><td>1</td><td>Hong Kong</td></tr><tr><td>BA019</td><td>Changi</td><td>2</td><td>Singapore</td></tr></table>

# Example of Natural Join

S

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr><tr><td>S5</td><td>Adams</td><td>30</td><td>Athens</td></tr></table>

<table><tr><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td><td>CITY</td></tr><tr><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>P2</td><td>Bolt</td><td>Green</td><td>17.0</td><td>Paris</td></tr><tr><td>P3</td><td>Screw</td><td>Blue</td><td>17.0</td><td>Rome</td></tr><tr><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td><td>London</td></tr><tr><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td><td>Paris</td></tr><tr><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td><td>London</td></tr></table>

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td><td>P2</td><td>Bolt</td><td>Green</td><td>17.0</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td><td>P2</td><td>Bolt</td><td>Green</td><td>17.0</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td></tr></table>

Fig. 6.6 The natural join S JOIN P

# 3. Semantics -θ-Join(θ 连接)

# A TIMES B WHERE R0S

e.g.

((S RENAME CITY AS SCITY) TIMES

(P RENAME CITY AS PCITY))

WHERE SCITY>PCITY

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>SCITY</td><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td><td>PCITY</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td><td>London</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td><td>London</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td><td>London</td></tr></table>

Fig. 6.7 Greater-than join of suppliers and parts on cities

# 3. Semantics -equivjoin(等值连接)

If  $\theta$  is  $'' = ''$ , the  $\theta$ -join is called an equijoin.

S JOIN P

-is equivalent to the following more complex expression:

```txt
（S TIMES（P RENEACITYASPCITY）WHERECITY=PCITY{ALLBUTPCITY}
```

# 3. Semantics – Divide

![](images/e69fc9ee0e4bad8ec42b420eb0d37f22244cd13faf45d2eb25e66d5c12702004.jpg)

Let relations  $A, B$  and  $C$  have headings  $\{X\}, \{Y\}$ , and  $\{X, Y\}$  (where  $X$  and  $Y$  are composite attributes).

The division of  $A$  by  $B$  per  $C$ :

A DIVIDEBY B PER C

-is a relation with the heading  $\{X\}$  and   
- body consisting of all tuples  $\{X:x\}$  such that a tuple  $\{X:x,$ $Y:y\}$  appears in  $C$  for all tuples   
 $\{Y:y\}$  appearing in  $B$

# Example of Division

# Airports

Suppose that we wish to know airports to which we can fly from both London/Gk and London/Hw

destination

London/Gk

Pisa

Manchester

Kai Tak

London/Hw

DIVIDEBY

# Airport_London

origin

London/Gk

London/

Hw

PER

destination

origin

London/Gk

Naples

Pisa

London/Gk

Pisa

London/Hw

London/Gk

Pisa

Manchester

Venice/MP

Kai Tak

Manchester

Manchester

Kai Tak

London/Hw

Changi

‘Both’, ‘All’ etc. hint the division operator: ex. Get suppliers who supply all parts

# Destin

destination

Pisa

# Example of Division

# A DIVIDEBY B PER C

![](images/49b6fc8e287d9017cad92f10067b80b22aeea820e1d38a8315e7d9bc8a5d49da.jpg)  
Fig. 6.8 Division examples

# 3. Semantics – Associativity and Commutativity
结合律和交换律

A UNION B UNION C = (A UNION B) UNION C = A UNION (B UNION C) (associative)

(Applicable to INTERSECT and TIMES but not to MINUS)

A UNION B = B UNION A (commutative)

(Applicable to INTERSECT and TIMES but not to MINUS)

Note that the Cartesian product operation of set theory is neither associative nor commutative, but the relational version as we have defined it IS both.

# Note:

Some of Codd eight operators are not primitive  
- {restrict, project, product, union, difference}→minimal set

# 4. Examples

S

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr><tr><td>S5</td><td>Adams</td><td>30</td><td>Athens</td></tr></table>

SP

<table><tr><td>S#</td><td>P#</td><td>QTY</td></tr><tr><td>S1</td><td>P1</td><td>300</td></tr><tr><td>S1</td><td>P2</td><td>200</td></tr><tr><td>S1</td><td>P3</td><td>400</td></tr><tr><td>S1</td><td>P4</td><td>200</td></tr><tr><td>S1</td><td>P5</td><td>100</td></tr><tr><td>S1</td><td>P6</td><td>100</td></tr><tr><td>S2</td><td>P1</td><td>300</td></tr><tr><td>S2</td><td>P2</td><td>400</td></tr><tr><td>S3</td><td>P2</td><td>200</td></tr><tr><td>S4</td><td>P2</td><td>200</td></tr><tr><td>S4</td><td>P4</td><td>300</td></tr><tr><td>S4</td><td>P5</td><td>400</td></tr></table>

P

<table><tr><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td><td>CITY</td></tr><tr><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>P2</td><td>Bolt</td><td>Green</td><td>17.0</td><td>Paris</td></tr><tr><td>P3</td><td>Screw</td><td>Blue</td><td>17.0</td><td>Rome</td></tr><tr><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td><td>London</td></tr><tr><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td><td>Paris</td></tr><tr><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td><td>London</td></tr></table>

Fig. 3.8. The Suppliers and parts database(sample values)

# 4. Examples

1. Get supplier names for suppliers who supply part P2.

```txt
（SP JOIN S）WHERE  $\mathbf{P}\# = \mathbf{P}\#$  （‘P2’）{SNAME}
```

2. Get supplier names for suppliers who supply at least one red part.

```javascript
（PWHERECOLOR=COLOR('Red')）JOINSP）{S#}JOINs）{SNAME}
```

```txt
{P WHERE COLOR  $=$  COLOR('Red')} {P#} JOIN SP JOIN S }SNAME
```

# 4. Examples…

3. Get supplier names for suppliers who supply all parts.

```txt
（S{S#}DIVIDEBYP{P#}PERSP{S#,P#}） JOIN S）{SNAME}
```

4. Get supplier numbers for suppliers who supply at least all those parts supplied by supplier S2.

```txt
S{SF}DIVIDEBY（SPWHERE  $s\neq s$  （‘S2））{P}PERSP{S#，P#}
```

5. Get all pairs of supplier numbers such that the two suppliers concerned are "colocated" (i.e., located in the same city).

```txt
（S RENAME S# AS SA）{SA,CITY}JOIN （S RENAME S# AS SB）{SB,CITY}WHERE SA<SB）{SA,SB}
```

ge 37

# 4. Examples…

6. Get supplier names for suppliers who do not supply part P2.

```txt
（S{SF}MINUS（SPWHEREP  $\text{日}$  P（'P2））{S}）JOIN S）{SNAME}
```

# 5. What is the Algebra for?

The fundamental intent of the algebra is to allow the writing of the relational expressions.

Defining a scope for retrieval  
Defining a scope for update  
Defining integrity constraint  
Defining derived relvars  
Defining stability requirements  
Defining security constraints

# 5. What is the Algebra for?…

serve as a convenient basis for optimization the expressions serving as a high-level, symbolic representation of the user’s intent, can be transformed into the logically equivalent.

((SP JOIN S) WHERE P#=P#('P2')){SNAME}  
三

((SP WHERE P#=P#('P2')) JOIN S){SNAME}

yardstick to measure the expressive power of some given language.

relational complete

# 关系运算有助于查询优化

通过对关系代数表达式的等价交换，减少多次扫描和读取文件以节省运行时间  
尽可能早的执行选择运算，以期得到较少的中间结果  
用连接运算代替乘积再选择运算  
一连串的选择和一连串的投影同时运算，分开会多次扫描文件  
预先计算并保存多次出现的子表达式结果  
建立索引，提高关系连接的速度

# 课堂练习

Student  

<table><tr><td>学号</td><td>姓名</td><td>性别</td><td>年龄</td><td>系</td></tr><tr><td>00301</td><td>李勇</td><td>男</td><td>20</td><td>CS</td></tr><tr><td>00302</td><td>刘晨</td><td>女</td><td>19</td><td>IS</td></tr><tr><td>00303</td><td>王明</td><td>女</td><td>18</td><td>MA</td></tr><tr><td>00304</td><td>张力</td><td>男</td><td>19</td><td>IS</td></tr></table>

Course  

<table><tr><td>课程号</td><td>课程名</td><td>先行课</td><td>学分</td></tr><tr><td>1</td><td>数据库</td><td>5</td><td>4</td></tr><tr><td>2</td><td>数学</td><td></td><td>2</td></tr><tr><td>3</td><td>信息系统</td><td>1</td><td>4</td></tr><tr><td>4</td><td>操作系统</td><td>6</td><td>3</td></tr><tr><td>5</td><td>数据结构</td><td>7</td><td>4</td></tr><tr><td>6</td><td>数据处理</td><td></td><td>2</td></tr><tr><td>7</td><td>C语言</td><td>6</td><td>1</td></tr></table>

SC  

<table><tr><td>学号</td><td>课程号</td><td>成绩</td></tr><tr><td>00301</td><td>1</td><td>92</td></tr><tr><td>00301</td><td>2</td><td>85</td></tr><tr><td>00301</td><td>3</td><td>88</td></tr><tr><td>00302</td><td>2</td><td>90</td></tr><tr><td>00302</td><td>3</td><td>80</td></tr></table>

# 课堂练习

# 求解:

1. 所有学生的姓名、性别;  
2. 信息系学生的姓名、性别;  
3. 选修了“数学”课的学生姓名、性别;  
4. 同时选修了“数学”和“信息系统”课的学生姓名;  
5. 至少选修了课程 1、3 的学生学号；  
6. 上例中的学生学号、姓名、系;  
7. 选修了课程2的学生学号；  
8. 至少选修了一门其直接先行课为 6 的课程的学生姓名;  
9. 选修了全部先行课为6的课程的学生姓名;  
10. 选修了“刘晨”所选全部课程的学生姓名；  
11. 年龄最大 (or 成绩最高) 的学生姓名;  
12. 与“刘晨”同系的学生姓名;  
13. 同系学生对。

# 关系运算 (拓展)

$\succ$  关系模型与关系运算密切相关，关系运算理论是关系数据库技术的基础。  
关系运算包括关系代数和关系演算。关系代数是以关系为运算对象的一组高级运算的集合；关系演算基于数理逻辑谓词演算。  
> 关系操作包括查询、插入、删除和修改，它们的数学基础是关系代数，关系代数又以集合理论为基础。  
> 关系代数分为：五种基本运算并、差、乘积、选择、投影构成完备运算集，其他非基本运算可用五种基本运算合成。

# 1、关系代数

# 关系代数:

设关系 R 和 S 的目（属性或分量数目）分别为 r 和 s，t 为元组变量。

1）并union运算：关系R和S相容（具有相同的关系模式，目及值域相同），两者并是由属于R和S的元组构成的集合：

$$
\mathrm {R U S} = \{\mathrm {t} | \mathrm {t} \in \mathrm {R V t} \in \mathrm {S} \}
$$

注意：两个相容关系的列数相同，对应列同质；合并结果中若含有重复的元组，必须除掉多余的元组。

2）差 difference 运算：关系 R 和 S 相容，两者差是由属于 R 但不属于 S 的元组构成的集合：

$$
R - S = \{t | t \in R \land t \in S \}
$$

3）乘积 product 运算：R 为 r 元（目）关系，S 为 s 元关系，两者乘积是一个  $(r + s)$  元的元组集合：

$$
R X S = \left\{t \mid t = \langle t _ {r}, t _ {s} \rangle \wedge t _ {r} \in R \wedge t _ {s} \in S \right\}
$$

积的每个元组  $\left\langle t_{r}, t_{s} \right\rangle$  均由原来的两个元组组成, 前  $r$  个分量来自  $R$ , 后  $s$  个分量来自  $S$  。

积的算法: 用 R 的第 i 个元组分别与 S 的全部元组连接而成积的元组, 因此乘积的基即元组个数等于 R 的基和 S 的基的乘积。R 和 S 有相同属性时, 乘积的属性名不能相同, 则用 “R. 属性名” 和 “S. 属性名” 以示区别。

4）选择运算：对关系进行水平分割，即从原关系中选取符合给定条件的那些元组：

$$
\sigma_ {\mathrm {F}} (\mathrm {R}) = = \{\mathrm {t} | \mathrm {t} \in \mathrm {R} \land \mathrm {F} (\mathrm {t}) = \text {t r u e} \}, \mathrm {F} \text {为 逻 辑 表 达 式 。}
$$

Select ALL from R where F

F 包含两种成分：运算对象如常数、元组分量；运算符如算术比较运算符、逻辑运算符。

5）投影运算：对关系进行垂直分割，即从原关系中取出某些列并重新排序：

$\pi_{\mathrm{A}}(\mathbf{R}) = \{\mathbf{t}[\mathbf{A}]\mid \mathbf{t}\in \mathbf{R}\}$  ，A为R中的属性列。

Select A from R

投影结果往往含有重复的元组，必须除掉多余的。

6）交运算：关系 R 和 S 相容，两者交是由属于 R 且属于 S 的元组构成的集合：

$$
R \cap S = = \{t | t \in R \land t \in S \} 。
$$

7）连接：从两个关系模式中选取属性间满足一定条件的元组。

$$
R _ {\triangleright} S = \left\{t \mid t = <   t _ {r}, t _ {s} > \wedge t _ {r} \in R \wedge t _ {s} \in S \wedge t _ {r} [ A ] \theta t _ {s} [ B ] \right\}
$$

A 和 B 分别为 R 和 S 上可比较的分量或属性（组）， $\theta$  为比较运算符。

用 R 的第 i 个元组的 A 分量依次与 S 的每个元组的 B 分量进行  $\theta$  比较, 若满足则把 S 的那个元组接在 R 的第 i 个元组之后, 作为连接关系的一个元组。

连接运算是 在乘积运算的基础上增加了比较条件。

乘积运算在时间空间上开销大，优化连接可减少。

等值连接是  $\theta$  为“=”的连接, 它是从 R 和 S 的乘积中选取 A 和 B 属性值相等的那些元组。

$$
R \bowtie S = \left\{t \mid t = \langle t _ {r}, t _ {s} \rangle \wedge t _ {r} \in R \wedge t _ {s} \in S \wedge t _ {r} [ A ] = t _ {s} [ B ] \right\}
$$

自然连接运算：两个关系具有一个以上的公共属性（组）A，公共属性相等时连接对应元组构成一个新元组，从连接结果中除掉重复的属性列。

$$
R \triangleright S = \left\{t \mid t = \langle t _ {r}, t _ {s} \rangle \wedge t _ {r} \in R \wedge t _ {s} \in S \wedge t _ {r} [ A ] = t _ {s} [ A ] \right\}
$$

自然连接是一种特殊的等值连接。

8）除法运算：关系R（X，Y），关系S（Y，Z），其中X，Y，Z为属性组，R的Y和S的Y属性名可以不同，但必须出自相同的域集，则  $\mathrm{R} / \mathrm{S} =$  关系P（X）。  
9）外连接运算：连接运算中如果把舍弃的元组也保存在结果中，无值的属性上填空值（NULL）。左外连接和右外连接。  
10）外部并运算：关系 R 和 S 不相容，外部并是由 R 或 S 的所有属性组成，没有具体值的属性为 NULL。

# 2、关系演算

- 关系演算是以数理逻辑的谓词演算为基础，分为元组关系演算和域关系演算。  
命题逻辑：能够用于判断的陈述句被称为命题。命题逻辑包含原子命题、用联结词及括号构成的分子命题，命题公式和函数，以及等价、蕴含、推理理论。  
对原子命题的进一步解析产生了谓词逻辑。  
谓词演算：原子命题是由一个谓词及若干个体两部分组成的，称为谓词命题。引入量词（全称和存在）的命题公式称为谓词命题公式，包含等价、蕴含、推理论。

# 1）元组关系演算

形式化表达:  $\{t \mid P(t)\}$ ,  $t$  是元组变量,  $P$  是条件表达式, 其结果是一个满足公式  $P$  的所有元组  $t$  的集合或关系。  
演算公式同谓词逻辑。  
谓词运算符： $\exists -$  存在， $\forall -$  所有， $\neg -$  非， $\land -$  与， $\lor -$  或， $\rightarrow -$  如果…那么…  
元组关系演算语言 ALPHA。

# 2）域关系演算

类似于元组关系演算，但变量不是元组而是元组中各个分量的域变量。  
形式化表达:  $\left\{\left\langle t_{1}, t_{2}, \ldots, t_{k} \right\rangle \mid P\left(t_{1}, t_{2}, \ldots, t_{k}\right) \right\}, \quad t_{1}, t_{2}, \ldots, t_{k}$  是元组变量  $t$  的各个分量。  
域关系演算语言 QBE。  
元组演算表达式与域演算表达式可相互转换。

SQL 语言建立在关系代数和关系演算的数学基础上