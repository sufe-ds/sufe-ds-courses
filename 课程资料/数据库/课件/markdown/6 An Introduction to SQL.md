# An Introduction to SQL

# Chapter 4

![](images/01e0068960235e96097d6f435ec22430b2df64a8a4d49e860de31732aeecbf3b.jpg)

# What will you learn?

1. Why SQL?  
2. Query

--Basic Structure  
--Set Operations  
--Aggregate Functions  
--Null Values  
--Nested Subqueries  
--Views

3. Modification of the Database  
4. Data Definition Language

# 1. Why SQL? …

SQL was initially developed by IBM round 1976.  
It has clear link to relational algebra.  
- SQL includes both data definition operations and data manipulation operations.

Data definition language (DDL)  
Data manipulation language (DML)

There are many different SQL implementations; available in Oracle, DB2,SQL Server, Sybase, Access, JDBC etc. Most are a superset of a subset of one of the standards (ISO, ANSI, BSI ...)  
- Learn SQL and can learn most databases.  
It can be embedded within other high-level programming languages such as C, Pascal and PL/I

# Banking Example

branch (branch-name, branch-city, assets)

customer (customer-name, customer-street, customer-city)

account (account-number, branch-name, balance)

loan (loan-number, branch-name, amount)

depositor (customer-name, account-number)

borrower (customer-name, loan-number)

# Banking Example

<table><tr><td colspan="3">branch</td></tr><tr><td>branch-name</td><td>branch-city</td><td>assets</td></tr><tr><td>Downtown</td><td>Brooklyn</td><td>9000000</td></tr><tr><td>Redwood</td><td>Palo Alto</td><td>2100000</td></tr><tr><td>Perryridge</td><td>Horseneck</td><td>1700000</td></tr><tr><td>Mianus</td><td>Horseneck</td><td>400000</td></tr><tr><td>Round Hill</td><td>Horseneck</td><td>8000000</td></tr><tr><td>Pownal</td><td>Bennington</td><td>300000</td></tr><tr><td>North Town</td><td>Rye</td><td>3700000</td></tr><tr><td>Brighton</td><td>Brooklyn</td><td>7100000</td></tr></table>

<table><tr><td colspan="3">account</td></tr><tr><td>branch-name</td><td>account-number</td><td>balance</td></tr><tr><td>Downtown</td><td>A-101</td><td>500</td></tr><tr><td>Mianus</td><td>A-215</td><td>700</td></tr><tr><td>Perryridge</td><td>A-102</td><td>400</td></tr><tr><td>Round Hill</td><td>A-305</td><td>350</td></tr><tr><td>Brighton</td><td>A-201</td><td>900</td></tr><tr><td>Redwood</td><td>A-222</td><td>700</td></tr><tr><td>Brighton</td><td>A-217</td><td>750</td></tr></table>

<table><tr><td colspan="2">borrow</td></tr><tr><td>customer-name</td><td>loan-number</td></tr><tr><td>Jones</td><td>L-17</td></tr><tr><td>Smith</td><td>L-23</td></tr><tr><td>Hayes</td><td>L-15</td></tr><tr><td>Johnson</td><td>L-14</td></tr><tr><td>Curry</td><td>L-93</td></tr><tr><td>Smith</td><td>L-11</td></tr><tr><td>Williams</td><td>L-17</td></tr><tr><td>Adams</td><td>L-16</td></tr></table>

<table><tr><td colspan="3">customer</td></tr><tr><td>customer-name</td><td>customer-street</td><td>customer-city</td></tr><tr><td>Jones</td><td>Main</td><td>Harrison</td></tr><tr><td>Smith</td><td>North</td><td>Rye</td></tr><tr><td>Hayes</td><td>Main</td><td>Harrison</td></tr><tr><td>Curry</td><td>North</td><td>Rye</td></tr><tr><td>Lindsay</td><td>Park</td><td>Pittsfield</td></tr><tr><td>Turner</td><td>Putnam</td><td>Stamford</td></tr><tr><td>Williams</td><td>Nassau</td><td>Princeton</td></tr><tr><td>Adams</td><td>Spring</td><td>Pittsfield</td></tr><tr><td>Johnson</td><td>Alma</td><td>Palo Alto</td></tr><tr><td>Glenn</td><td>Sand Hill</td><td>Woodside</td></tr><tr><td>Brooks</td><td>Senator</td><td>Brooklyn</td></tr><tr><td>Green</td><td>Walnut</td><td>Stamford</td></tr></table>

<table><tr><td colspan="3">loan</td></tr><tr><td>branch-name</td><td>loan-number</td><td>amount</td></tr><tr><td>Downtown</td><td>L-17</td><td>1000</td></tr><tr><td>Redwood</td><td>L-23</td><td>2000</td></tr><tr><td>Perryridge</td><td>L-15</td><td>1500</td></tr><tr><td>Downtown</td><td>L-14</td><td>1500</td></tr><tr><td>Mianus</td><td>L-93</td><td>500</td></tr><tr><td>Round Hill</td><td>L-11</td><td>900</td></tr><tr><td>Perryridge</td><td>L-16</td><td>1300</td></tr></table>

<table><tr><td colspan="2">depositor</td></tr><tr><td>customer-name</td><td>account-number</td></tr><tr><td>Johnson</td><td>A-101</td></tr><tr><td>Smith</td><td>A-215</td></tr><tr><td>Hayes</td><td>A-102</td></tr><tr><td>Turner</td><td>A-305</td></tr><tr><td>Johnson</td><td>A-201</td></tr><tr><td>Jones</td><td>A-217</td></tr><tr><td>Lindsay</td><td>A-222</td></tr></table>

# 2. QUERY -basic structure

A typical SQL query has the form:

select  $A_{1}, A_{2}, \ldots, A_{n}$

from  $r_1, r_2, \ldots, r_m$

where  $\rho$ ;

The result of an SQL query is a relation.

# 2. Query-The select Clause

The select clause corresponds to the projection operation of the relational algebra. It is used to list the attributes desired in the result of a query.

e.g. Find the names of all branches in the loan relation.

select branch-name

from loan;

In the "pure" relational algebra syntax, the query would be: loan{branch-name}

An asterisk in the select clause denotes "all attributes"

select *

from loan;

# 2. Query -The select Clause…

- SQL allows duplicates in relations as well as in query results. To force the elimination of duplicates, insert the keyword distinct after select.

e.g. Find the names of all branches in the loan relations, and remove duplicates

select distinct branch-name from loan;

The keyword all specifies that duplicates not be removed.

select all branch-name from loan;

The select clause can contain arithmetic expressions involving the operation,  $+, -, *, \text{and} /,$  and operating on constants or attributes of tuples.

e.g. select branch-name, loan-number, amount*100

from loan;

# 2. Query - The where Clause

The where clause corresponds to the selection predicate of the relational algebra.  
and, or, not

e.g. Find all loan number for loans made by the Perryridge branch with loan amounts greater than $1200.

select loan-number

from loan

where branch-name = "Perryridge" and amount> 1200;

between

e.g. Find the loan number of those loans with loan amounts between  $90,000 and$ 100,000 (that is, ≥$90,000 and ≤$100,000)

select loan-number

from loan

where amount between 90000 and 100000;

# 2. Query - The from Clause

The from clause corresponds to the Cartesian product operation of the relational algebra. It lists the relations to be scanned in the evaluation of the expression.

e.g. Find the Cartesian product borrower JOIN loan

select *

from borrower, loan ;

e.g. Find the name and loan number of all customers having a loan at the Perryridge branch.

Select distinct customer-name, borrower. loan-number

from borrower, loan

where borrowerLoan-number = loanLoan-number and

branch-name = "Perryridge";

# 2. Query - Rename Operation

The SQL mechanism for renaming relations and attributes is accomplished through the as clause:

# old-name as new-name

e.g. Find the name and loan number of all customers having a loan at the Perryridge branch; replace the column name loan-number with the name loan-id.

select distinct customer-name, borrowerLoan-number as loan-id

from borrower, loan

where borrowerLoan-number = loanLoan-number and branch-number = "Perryridge"

# 2. Query - Tuple Variables

- Tuple variables are defined in the from clause via the use of the as clause.

e.g. Find the customer names and their loan numbers for all customers having a loan at some branch.

select distinct customer-name, TLoan-number

from borrower as  $T$ , loan as  $S$

where  $T$ .loan-number = S.loan-number

e.g. Find the names of all branches that have greater assets than some branch located in Brooklyn.

select distinct T_branch-name

from branch as  $T$ , branch as  $S$

Where T_assets > S_assets and Sbranch-city = "Brooklyn" ?

branch as T  

<table><tr><td>branch-name</td><td>branch-city</td><td>assets</td></tr><tr><td>Downtown</td><td>Brooklyn</td><td>9000000</td></tr><tr><td>Redwood</td><td>Palo Alto</td><td>2100000</td></tr><tr><td>Perryridge</td><td>Horseneck</td><td>1700000</td></tr><tr><td>Mianus</td><td>Horseneck</td><td>400000</td></tr><tr><td>Round Hill</td><td>Horseneck</td><td>8000000</td></tr><tr><td>Pownal</td><td>Bennington</td><td>300000</td></tr><tr><td>North Town</td><td>Rye</td><td>3700000</td></tr><tr><td>Brighton</td><td>Brooklyn</td><td>7100000</td></tr></table>

T_assets > S_assets and S_branch-city = “ Brooklyn”

Times

![](images/6ddf0a2367cf041c7f79ab08b44ce7a1b25299fe745457e30eeda4f46012be1b.jpg)

branch as S  

<table><tr><td>branch-name</td><td>branch-city</td><td>assets</td></tr><tr><td>Downtown</td><td>Brooklyn</td><td>9000000</td></tr><tr><td>Redwood</td><td>Palo Alto</td><td>2100000</td></tr><tr><td>Perryridge</td><td>Horseneck</td><td>1700000</td></tr><tr><td>Mianus</td><td>Horseneck</td><td>400000</td></tr><tr><td>Round Hill</td><td>Horseneck</td><td>8000000</td></tr><tr><td>Pownal</td><td>Bennington</td><td>300000</td></tr><tr><td>North Town</td><td>Rye</td><td>3700000</td></tr><tr><td>Brighton</td><td>Brooklyn</td><td>7100000</td></tr></table>

# 2. Query - String Operations

SQL includes a string-matching operator for comparisons on character strings. Patterns are described using two special characters:

percent (%). The % character matches any substring.  
• underscore (_). The _ character matches any character.

e.g. Find the names of all customers whose street includes the substring "Main".

select customer-name

From customer

where customer-street like "%%";

e.g. Match the name “Main%”

like "Main\%" escape "\%"

# 2. Query- Ordering the Display of Tuples

List in alphabetic order the names of all customers having a loan in Perryridge branch

select distinct customer-name

from borrower, loan

where borrower loan-number = loanLoan-number and

branch-name = "Perryridge"

order by customer-name desc;

We may specify desc for descending order or asc for ascending order, for each attribute; ascending order is the default.

# 2. Query - Set Operations

The set operations union, intersect, and minus operate on relations correspond to the relational algebra operations union, intersect, and minus.  
Each of the above operations automatically eliminates duplicates.

e.g. Find all customers who have a loan, an account, or both:

(select customer-name from depositor)

Union

(select customer-name from borrower);

# 2. Query- Set Operations…

e.g. Find all customers who have both a loan and an account.

select customer-name from depositor)

Intersect

(select customer-name from borrower);

e.g. Find all customers who have an account but no loan.

(select customer-name from depositor)

Minus

(select customer-name from borrower);

# 2. Query - Aggregate Functions

These functions operate on the multiset of values of a column of a relation, and return a value.

Avg(): average value  
• min ( ): minimum value  
• max(): maximum value  
sum(): sum of values  
count  $(^{*})$  : number of values  
- COUNT(DISTINCT column-name): Determine the number of unique non-null values in a column

# 2. Query- Aggregate Functions…

e.g.Find the average account balance at the Perryridge branch.

select avg (balance) from account

where branch-name = "Perryridge";

e.g. Find the number of tuples in the customer relation.

select count (*)

from customer; count(*) 计算所有行，包括空值；

e.g. Find the number of depositors in the bank.

select count (distinct customer-name)

from depositor;

当对一个包含 NULL 值的列使用 COUNT 函数时，这个列中的 NUpdate 值将会被去除掉。

# 2. Query-Aggregate Functions-Group By

e.g. Find the number of depositors for each branch.

select branch-name, count (distinct customer-name)

from depositor, account

where depositoraccount-number  $=$  accountaccountnumber

group by branch-name

Note: Attributes in select clause outside of aggregate functions must appear in group by list.

account (account-number, branch-name, balance)

depositor (customer-name, account-number)

# 2. Query-Aggregate Functions-Group By

<table><tr><td colspan="3">account</td></tr><tr><td>branch-name</td><td>account-number</td><td>balance</td></tr><tr><td>Downtown</td><td>A-101</td><td>500</td></tr><tr><td>Mianus</td><td>A-215</td><td>700</td></tr><tr><td>Perryridge</td><td>A-102</td><td>400</td></tr><tr><td>Round Hill</td><td>A-305</td><td>350</td></tr><tr><td>Brighton</td><td>A-201</td><td>900</td></tr><tr><td>Redwood</td><td>A-222</td><td>700</td></tr><tr><td>Brighton</td><td>A-217</td><td>750</td></tr></table>

<table><tr><td colspan="2">depositor</td></tr><tr><td>customer-name</td><td>account-number</td></tr><tr><td>Johnson</td><td>A-101</td></tr><tr><td>Smith</td><td>A-215</td></tr><tr><td>Hayes</td><td>A-102</td></tr><tr><td>Turner</td><td>A-305</td></tr><tr><td>Johnson</td><td>A-201</td></tr><tr><td>Lindsay</td><td>A-222</td></tr><tr><td>Jones</td><td>A-217</td></tr></table>

<table><tr><td>branch-name</td><td>customer-name</td></tr><tr><td>Brighton</td><td>Jones</td></tr><tr><td>Brighton</td><td>Johnson</td></tr><tr><td>Downtown</td><td>Johnson</td></tr><tr><td>Mianus</td><td>Smith</td></tr><tr><td>Perryridge</td><td>Hayes</td></tr><tr><td>Redwood</td><td>Lindsay</td></tr><tr><td>Round Hill</td><td>Turner</td></tr></table>

result  

<table><tr><td>branch-name</td><td>count</td></tr><tr><td>Brighton</td><td>2</td></tr><tr><td>Downtown</td><td>1</td></tr><tr><td>Mianus</td><td>1</td></tr><tr><td>Perryridge</td><td>1</td></tr><tr><td>Redwood</td><td>1</td></tr><tr><td>Round Hill</td><td>1</td></tr></table>

# 2. Query-Aggregate Functions - Having Clause

# e.g. Find the names of all branches where the average account balance is more than $600.

select branch-name, avg (balance)

from account

group by branch-name

having avg (balance) > 600 ;

Note: predicates in the having clause are applied after the formation of groups.

<table><tr><td colspan="3">account</td></tr><tr><td>branch-name</td><td>account-number</td><td>balance</td></tr><tr><td>Downtown</td><td>A-101</td><td>500</td></tr><tr><td>Mianus</td><td>A-215</td><td>700</td></tr><tr><td>Perryridge</td><td>A-102</td><td>400</td></tr><tr><td>Round Hill</td><td>A-305</td><td>350</td></tr><tr><td>Brighton</td><td>A-201</td><td>900</td></tr><tr><td>Redwood</td><td>A-222</td><td>700</td></tr><tr><td>Brighton</td><td>A-217</td><td>750</td></tr></table>

<table><tr><td colspan="2">account</td></tr><tr><td>branch-name</td><td>balance</td></tr><tr><td>Downtown</td><td>500</td></tr><tr><td>Mianus</td><td>700</td></tr><tr><td>Perryridge</td><td>400</td></tr><tr><td>Round Hill</td><td>350</td></tr><tr><td>Redwood</td><td>700</td></tr><tr><td>Brighton</td><td>900</td></tr><tr><td>Brighton</td><td>750</td></tr></table>

<table><tr><td colspan="2">account</td></tr><tr><td>branch-name</td><td>balance</td></tr><tr><td>Downtown</td><td>500</td></tr><tr><td>Mianus</td><td>700</td></tr><tr><td>Perryridge</td><td>400</td></tr><tr><td>Round Hill</td><td>350</td></tr><tr><td>Redwood</td><td>700</td></tr><tr><td>Brighton</td><td>825</td></tr></table>

# EMP and DEPT Example

I need the sum of all salaries for workdepts beginning with the letter D

SELECT SUM(SALARY) AS SUM FROM EMPLOYEE WHERE WORKDEPT LIKE 'D%'

![](images/516ee7bde057558b0210c4fa5e892f2b12004fd4428ed07290a5cf9995273a85.jpg)

SUM

373020.00

![](images/d80f7ade66290b61562101bbe114f33cd87d0939f0dc0f26d0bf6d7b74fe0db5.jpg)

# EMP and DEPT Example

I need a listing of the salaries for all employees in the departments A00, B01, and C01. In addition, for these departments, I want the totals spent for salaries.

# Group By

![](images/7393a80b96d54c459c7e52e3d38276ba0ca6df43c98c55c33a35b896de3c31db.jpg)

SELECT WORKDEPT, SALARY

FROM EMPLOYEE

WHERE WORKDEPT IN (A00', B01', C01')

ORDER BY WORKDEPT

![](images/49b0cf4ea755f26f60adf2355548ad33fc14f3516308085d80842c861b13219b.jpg)

WORKDEPT SALARY

![](images/84372f8ec79bf9aafc8c277b2dac305d9f5a7b36eb80b4597a8aafec477f393b.jpg)

SELECT WORKDEPT, SUM(SALARY) AS SUM

FROM EMPLOYEE

WHERE WORKDEPT IN (A00', B01', C01')

GROUP BY WORKDEPT

ORDER BY WORKDEPT

![](images/2ea568862ab959dfe5b3d93e0f4454dd90e04ea40d4d93e2e35802f4382e721c.jpg)

![](images/e942d0cfca0d2f228d858926ca22620296c1d9ed7193e8c8b88688648c0c1685.jpg)

WORKDEPT SUM

A00 128500.00

B01 41250.00

C01 90470.00

# EMP and DEPT Example

Now, I just want to see departments with total spent for salaries higher than 50000

![](images/69ca1a47d07c92fd519b986d0e4f9f3561f184d9bc9a0b8d0116be08b8b6d908.jpg)

# GROUP BY, HAVING

SELECT WORKDEPT, SUM(SALARY) AS SUM FROM EMPLOYEE

WHERE WORKDEPT IN (A00', B01', C01')

GROUP BY WORKDEPT

ORDER BY WORKDEPT

SELECT WORKDEPT, SUM(SALARY) AS SUM

FROM EMPLOYEE

WHERE WORKDEPT IN (A00', B01', C01')

GROUP BY WORKDEPT

HAVING SUM(SALARY) > 50000

ORDER BY WORKDEPT

![](images/f83aec7b0f92d243abd849b7c5afbd3a84c4f33a0fcb2a717a03c6acd9f80d92.jpg)

<table><tr><td>WORKDEPT</td><td>SUM</td></tr><tr><td>A00</td><td>128500.00</td></tr><tr><td>B01</td><td>41250.00</td></tr><tr><td>C01</td><td>90470.00</td></tr></table>

![](images/5ae849fb6752413805a03962e2d61be2581622cb75057304fc6a9569bcd9723a.jpg)

# EMP and DEPT Example

SELECT DEP, JOB, AVG(SAL)

FROM EMPL

WHERE JOB <> 'M'

GROUP BY DEP, JOB

HAVING AVG(SAL) > 28000

ORDER BY 3 DESC

![](images/f12e93d85333b341fe40c16941170e7d2e0d870c54153112593a869d7cfd85e9.jpg)

# Conceptual Execution

BASE TABLE  

<table><tr><td>JOB</td><td>SAL</td><td>DEP</td></tr><tr><td>S</td><td>31000</td><td>BLU</td></tr><tr><td>M</td><td>32000</td><td>RED</td></tr><tr><td>S</td><td>30000</td><td>BLU</td></tr><tr><td>C</td><td>27000</td><td>GRE</td></tr><tr><td>S</td><td>33000</td><td>GRE</td></tr><tr><td>M</td><td>31000</td><td>BLU</td></tr><tr><td>S</td><td>32000</td><td>RED</td></tr><tr><td>C</td><td>28000</td><td>GRE</td></tr><tr><td>S</td><td>30000</td><td>RED</td></tr><tr><td>M</td><td>33000</td><td>GRE</td></tr><tr><td>S</td><td>31000</td><td>RED</td></tr><tr><td>S</td><td>35000</td><td>GRE</td></tr><tr><td>C</td><td>27000</td><td>BLU</td></tr><tr><td>S</td><td>29000</td><td>RED</td></tr><tr><td>S</td><td>29000</td><td>BLU</td></tr></table>

WHERE  

<table><tr><td>JOB</td><td>SAL</td><td>DEP</td></tr><tr><td>S</td><td>31000</td><td>BLU</td></tr><tr><td>S</td><td>30000</td><td>BLU</td></tr><tr><td>C</td><td>27000</td><td>GRE</td></tr><tr><td>S</td><td>33000</td><td>GRE</td></tr><tr><td>S</td><td>32000</td><td>RED</td></tr><tr><td>C</td><td>28000</td><td>GRE</td></tr><tr><td>S</td><td>30000</td><td>RED</td></tr><tr><td>S</td><td>31000</td><td>RED</td></tr><tr><td>S</td><td>35000</td><td>GRE</td></tr><tr><td>C</td><td>27000</td><td>BLU</td></tr><tr><td>S</td><td>29000</td><td>RED</td></tr><tr><td>S</td><td>29000</td><td>BLU</td></tr></table>

GROUP BY  

<table><tr><td>JOB</td><td>SAL</td><td>DEP</td></tr><tr><td>C</td><td>27000</td><td>BLU</td></tr><tr><td>S</td><td>31000</td><td>BLU</td></tr><tr><td>S</td><td>29000</td><td>BLU</td></tr><tr><td>S</td><td>30000</td><td>BLU</td></tr><tr><td>C</td><td>27000</td><td>GRE</td></tr><tr><td>C</td><td>28000</td><td>GRE</td></tr><tr><td>S</td><td>33000</td><td>GRE</td></tr><tr><td>S</td><td>35000</td><td>GRE</td></tr><tr><td>S</td><td>32000</td><td>RED</td></tr><tr><td>S</td><td>30000</td><td>RED</td></tr><tr><td>S</td><td>31000</td><td>RED</td></tr><tr><td>S</td><td>29000</td><td>RED</td></tr></table>

# Conceptual Execution

HAVING  

<table><tr><td>JOB</td><td>SAL</td><td>DEP</td><td>DEP</td><td>JOB</td><td>AVG(SAL)</td><td>DEP</td><td>JOB</td><td>AVG(SAL)</td></tr><tr><td></td><td></td><td></td><td></td><td></td><td></td><td>GRE</td><td>S</td><td>34000</td></tr><tr><td>S</td><td>31000</td><td>BLU</td><td>BLU</td><td>S</td><td>30000</td><td>RED</td><td>S</td><td>30500</td></tr><tr><td>S</td><td>29000</td><td>BLU</td><td></td><td></td><td></td><td>BLU</td><td>S</td><td>30000</td></tr><tr><td>S</td><td>30000</td><td>BLU</td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>S</td><td>33000</td><td>GRE</td><td>GRE</td><td>S</td><td>34000</td><td></td><td></td><td></td></tr><tr><td>S</td><td>35000</td><td>GRE</td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>S</td><td>32000</td><td>RED</td><td>RED</td><td>S</td><td>30500</td><td></td><td></td><td></td></tr><tr><td>S</td><td>30000</td><td>RED</td><td></td><td></td><td></td><td></td><td rowspan="3" colspan="2">Change AVG(SAL) to SUM(SAL)?</td></tr><tr><td>S</td><td>31000</td><td>RED</td><td></td><td></td><td></td><td></td></tr><tr><td>S</td><td>29000</td><td>RED</td><td></td><td></td><td></td><td></td></tr></table>

ORDER BY

# EMP and DEPT Example

Display the departments with more than one employee

SELECT

WORKDEPT,

COUNT(*) AS NUMB

EMPLOYEE

FROM

GROUP BY

ORDER BY

WORKDEPT

NUMB,WORKDEPT

![](images/8810ade16bf5592bef8d26ea884066cd76db3a36ad6514982790d4521f3ebddf.jpg)

SELECT

WORKDEPT,

COUNT(*) AS NUMB

FROM

EMPLOYEE

GROUP BY

WORKDEPT

HAVING

COUNT\*>1

ORDER BY

NUMB, WORKDEPT

![](images/9eee20f01c1d1caa7899f0d1fe582f5154fc5838c6e90c971a95685e782cd8d2.jpg)

<table><tr><td>WORKDEPT</td><td>NUMB</td></tr><tr><td>B01</td><td>1</td></tr><tr><td>E01</td><td>1</td></tr><tr><td>A00</td><td>3</td></tr><tr><td>C01</td><td>3</td></tr><tr><td>E21</td><td>4</td></tr><tr><td>E11</td><td>5</td></tr><tr><td>D21</td><td>6</td></tr><tr><td>D11</td><td>9</td></tr></table>

![](images/0fe4d0161dc5f6bd71b91e5c631689d6cf0cd828fa3a3e4dc3dd10e637db2156.jpg)

<table><tr><td>WORKDEPT</td><td>NUMB</td></tr><tr><td>A00</td><td>3</td></tr><tr><td>C01</td><td>3</td></tr><tr><td>E21</td><td>4</td></tr><tr><td>E11</td><td>5</td></tr><tr><td>D21</td><td>6</td></tr><tr><td>D11</td><td>9</td></tr></table>

# Product and Ptype Example

Product  

<table><tr><td>Pno</td><td>Pname</td><td>Tno</td><td>Price</td><td>Stock</td></tr><tr><td>A001</td><td>文件夹</td><td>1</td><td>20</td><td>500</td></tr><tr><td>A002</td><td>笔筒</td><td>1</td><td>15</td><td>300</td></tr><tr><td>A003</td><td>三色圆珠笔</td><td>1</td><td>10</td><td>1000</td></tr><tr><td>B001</td><td>宠物小精灵丛书</td><td>2</td><td>100</td><td>2000</td></tr><tr><td>B002</td><td>白雪公主</td><td>2</td><td>15</td><td>300</td></tr><tr><td>B003</td><td>迪斯尼套书</td><td>2</td><td>200</td><td>200</td></tr><tr><td>C001</td><td>小儿西裤</td><td>3</td><td>40</td><td>200</td></tr><tr><td>C002</td><td>小儿短裙</td><td>3</td><td>60</td><td>500</td></tr></table>

Ptype  

<table><tr><td>Tno</td><td>Tname</td></tr><tr><td>1</td><td>文具</td></tr><tr><td>2</td><td>儿童书籍</td></tr><tr><td>3</td><td>儿童服装</td></tr></table>

# Product and Ptype Example

# Find the maximal price of each types .

SELECT Tno, MAX(Price)

FROM Product

GROUP BY Tno;

<table><tr><td>Pno</td><td>Pname</td><td>Tno</td><td>Price</td><td>Stocks</td></tr><tr><td>A001</td><td>文件夹</td><td>1</td><td>20</td><td>500</td></tr><tr><td>A002</td><td>笔筒</td><td>1</td><td>15</td><td>300</td></tr><tr><td>A003</td><td>三色圆珠笔</td><td>1</td><td>10</td><td>1000</td></tr><tr><td>B001</td><td>宠物小精灵丛书</td><td>2</td><td>100</td><td>2000</td></tr><tr><td>B002</td><td>白雪公主</td><td>2</td><td>15</td><td>300</td></tr><tr><td>B003</td><td>迪斯尼套书</td><td>2</td><td>200</td><td>200</td></tr><tr><td>C001</td><td>小儿西裤</td><td>3</td><td>40</td><td>200</td></tr><tr><td>C002</td><td>小儿短裙</td><td>3</td><td>60</td><td>500</td></tr></table>

按Tno相等的原则进行分组

组1:Tno="1"

Tno Max(Price)

1 20

组1:Tno="2"

2 200

组1:Tno="3"

3 60

<table><tr><td>Tno</td><td>Max(Price)</td></tr><tr><td>1</td><td>20</td></tr><tr><td>2</td><td>200</td></tr><tr><td>3</td><td>60</td></tr></table>

# Product and Ptype Example

Find the number of all orders which ordered at least two products.

SELECT Ono FROM Order item GROUP BY Ono HAVING COUNT(

![](images/550da7f2b8d480f6c6a2720c78e89e1ec8f71d90b6016e468da5d01cfe29708e.jpg)

<table><tr><td>0no</td></tr><tr><td>0001</td></tr><tr><td>0002</td></tr><tr><td>0006</td></tr><tr><td>0008</td></tr></table>

<table><tr><td>Ono</td><td>Pno</td><td>Quantity</td></tr><tr><td>0001</td><td>A001</td><td>100</td></tr><tr><td>0001</td><td>A002</td><td>200</td></tr><tr><td>0002</td><td>A001</td><td>100</td></tr><tr><td>0002</td><td>A002</td><td>200</td></tr><tr><td>0002</td><td>A003</td><td>300</td></tr><tr><td>0003</td><td>B001</td><td>500</td></tr><tr><td>0004</td><td>B002</td><td>500</td></tr><tr><td>0005</td><td>B003</td><td>1000</td></tr><tr><td>0006</td><td>C001</td><td>200</td></tr><tr><td>0006</td><td>C002</td><td>300</td></tr><tr><td>0007</td><td>A001</td><td>200</td></tr><tr><td>0008</td><td>C001</td><td>300</td></tr><tr><td>0008</td><td>C002</td><td>500</td></tr></table>

挑选“Pno的个数大于等于2”的组的Onc

组1:  $0 \mathrm{no} = {}^{\prime \prime} 0 0 0 1$

0001

组2:  $0 \mathrm{no} = {}^{\prime \prime} 0 0 0 2^{\prime \prime}$

0002

组3: 0no="0003"

组4: 0no="0004"

组5·Ono="0005"

组6: 0no="0006"

组7: 0no="0007"

组8: 0no="0008"

0006

0008

# 2. Query-Null Values

It is possible for tuples to have a null value, denoted by null, for some of their attributes, null signifies an unknown value or that a value does not exist.  
The result of any arithmetic expression involving null is null.  
- Roughly speaking, all comparisons involving null return false.  
- More precisely, Any comparison with null returns unknown

- (unknown or unknown) = unknown,  
(true and unknown) = unknown,  
false and unknown) = false,  
(unknown and unknown) = unknown

Note: Result of where clause predicate is treated as false if it evaluates to unknown

# 2. Query-Null Values…

e.g. Find all loan number which appear in the loan relation with null values for amount.

select loan-number

from loan

where amount is null ;

Total all loan amounts

select sum (amount)

from loan ;

Note: Above statement ignores null amounts; result is null if there is no non-null amount.  
Note: All aggregate operations except count(*) ignore tuples with null values on the aggregated attributes.

# 2. Query-Null Values…

SUM(SALARY) + SUM(BONUS) + SUM(COMM)

VERSUS

SUM(SALARY+BONUS+COMM)

<table><tr><td>EMPNO</td><td>SALARY</td><td>BONUS</td><td>COMM</td><td>SALARY+BONUS+COMM</td></tr><tr><td>000010</td><td>1000</td><td>500</td><td>100</td><td>1600</td></tr><tr><td>000020</td><td>2000</td><td>NULL</td><td>300</td><td>NULL</td></tr><tr><td>000030</td><td>2500</td><td>400</td><td>NULL</td><td>NULL</td></tr><tr><td>000040</td><td>1500</td><td>100</td><td>400</td><td>2000</td></tr><tr><td>-----</td><td>-----</td><td>-----</td><td>-----</td><td>-----</td></tr><tr><td>Sum:</td><td>7000</td><td>1000</td><td>800</td><td>---&gt; 8800</td></tr><tr><td></td><td>-----</td><td>-----</td><td>-----</td><td>-----</td></tr></table>

# 2. Query- Nested Subqueries

SQL provides a mechanism for the nesting of subqueries.  
A subquery is a select-from-where expression that is nested within another query.  
A common use of subqueries is to perform tests for set membership and set comparisons.

# 2. Query- Nested Subqueries- Set Membership

$$
\mathrm {F i n} r \Leftrightarrow \exists t \in r (t = \mathrm {F})
$$

(5 in

0

4

5

) = true

(5 in

0

4

6

$) = \text{false}$

(5 not in

0

4

6

$) = \text{true}$

# 2. Query- Nested Subqueries- Set Membership

e.g. Find all customers who have both an account and a loan at the bank.

select distinct customer-name

from borrower

where customer-name in (select customer-name

from depositor);

e.g. Find all customers who have a loan at the bank but do not have an account at the bank

select distinct customer-name

from borrower

where customer-name not in (select customer-name

from depositor);

# 2. Query- Nested Subqueries- Set Membership

e.g. Find all customers who have both an account and a loan at the North Town branch.

select distinct customer-name  
from borrower, loan  
where borrowerLoan-number = loanLoan-number and branch-name = "North Town" and (branch-name, customer-name) in (select branch-name, customer-name from depositor, account where depositor_account-number = account_account-number);

account (account-number, branch-name, balance)  
loan (loan-number, branch-name, amount)  
depositor (customer-name, account-number)  
borrower (customer-name, loan-number)

# Subquery Using IN

List the people in Smith's department that have the same job as Smith

![](images/d77820c4cac035c1224833cc3b4c2146299e43490be8771495449978f7764e2e.jpg)

SELECT FIRSTNME, LASTNAME, WORKDEPT, JOB

FROM EMPLOYEE

WHERE (WORKDEPT, JOB) IN

(SELECT WORKDEPT, JOB

FROMEMPLOYEE

WHERE LASTNAME = 'SMITH')

# FIRSTNME

JAMES

SALVATORE

DANIEL

SYBIL

MARIA

ETHEL

JOHN

PHILIP

MAUDE

# LASTNAME

JEFFERSON

MARINO

SMITH

JOHNSON

PEREZ

SCHNEIDER

PARKER

SMITH

SETRIGHT

# WORKDEPT

D21

D21

D21

D21

D21

E11

E11

E11

E11

# JOB

CLERK

CLERK

CLERK

CLERK

CLERK

OPERATOR

OPERATOR

OPERATOR

OPERATOR

# Subquery Using NOT IN

Which departments do not have projects assigned to them?

![](images/9def27a4424cb8171663fa2998970898ae704806eed6fb06aaba505c06571839.jpg)

DEPARTMENT Table

DEPTNO DEPTNAME

A00 SPIFFY COMPUTER SERVICE

B01 PLANNING

C01 INFORMATIONCENTER

#

SELECT DEPTNO, DEPTNAME

FROM DEPARTMENT

WHERE DEPTNO NOT IN (SELECT DEPTNO

FROM PROJECT

WHERE DEPTNO IS NOT NULL)

![](images/2d825b942793308e7c0b0c9212abb29ee88acb03148b600395475a3d2483620b.jpg)

![](images/f74e4b2f03fe3d995f12d0acc93a3a5eaf9e8e07016392767c8e626f83750cdf.jpg)

Result of Subquery

Final Result

DEPTNO DEPTNAME

A00 SPIFFYCOMPUTERSERVICE

B01

C01

D01

D11

D21

E01

E11

E21

# Subquery within HAVING Clause

I need a list of the departments whose average salary for non-managers is higher than the company-wide average for non-managers. The department with the highest average should be listed first.

![](images/493129e4a9846dac2b78b0b5de60286dcf25d5e07531f890ef23d6e731401138.jpg)

SELECT WORKDEPT, AVG(SALARY) AS AVG_WORKDEPT

FROM EMPLOYEE

WHERE JOB <> 'MANAGER'

GROUP BY WORKDEPT

HAVING AVG(SALARY) > (SELECT AVG(SALARY)

FROM EMPLOYEE

WHERE JOB <> 'MANAGER')

ORDER BY AVG_WORKDEPT DESC

![](images/d4d217296cbd7ab89f0eba5182f480c99408869c285f7a2cbf854a8276be2352.jpg)

Final Result

WORKDEPT AVG_WORKDEPT

A00 42833.33333333

C01 26110.00000000

![](images/2a0ae3d64c743c95dd5c0e3d108bdfb4cecfc3382ca013ff75d1fe07680c4c1f.jpg)

Result of Subquery

25188.8000000

# 2. Query- Nested Subqueries- The Some Clause

<table><tr><td>0</td><td rowspan="3">) = true</td><td rowspan="3">(read: 5 &lt; some tuple in the relation)</td></tr><tr><td>5</td></tr><tr><td>6</td></tr></table>

<table><tr><td>(5 = some</td><td>0
5) = true</td><td>(= some) ≡ in</td></tr><tr><td></td><td></td><td>However, (≠ some) ≠ not in</td></tr><tr><td>(5 ≠ some</td><td colspan="2">0
5) = true (since 0 ≠ 5)</td></tr></table>

# 2. Query- Nested Subqueries- Set Comparison

# e.g. Find all branches that have greater assets than some branch located in Brooklyn.

select distinct T_branch-name

from branch as  $T$ , branch as  $S$

where  $T$  .assets > S. assets and

S_branch-city = "Brooklyn" and

Tbranch-city <> "Brooklyn;

branch as T  

<table><tr><td>branch-name</td><td>branch-city</td><td>assets</td></tr><tr><td>Downtown</td><td>Brooklyn</td><td>9000000</td></tr><tr><td>Redwood</td><td>Palo Alto</td><td>2100000</td></tr><tr><td>Perryridge</td><td>Horseneck</td><td>1700000</td></tr><tr><td>Mianus</td><td>Horseneck</td><td>400000</td></tr><tr><td>Round Hill</td><td>Horseneck</td><td>8000000</td></tr><tr><td>Pownal</td><td>Bennington</td><td>300000</td></tr><tr><td>North Town</td><td>Rye</td><td>3700000</td></tr><tr><td>Brighton</td><td>Brooklyn</td><td>7100000</td></tr></table>

Times  

<table><tr><td>branch-name</td><td>branch-city</td><td>assets</td></tr><tr><td>Downtown</td><td>Brooklyn</td><td>9000000</td></tr><tr><td>Redwood</td><td>Palo Alto</td><td>2100000</td></tr><tr><td>Perryridge</td><td>Horseneck</td><td>1700000</td></tr><tr><td>Mianus</td><td>Horseneck</td><td>400000</td></tr><tr><td>Round Hill</td><td>Horseneck</td><td>8000000</td></tr><tr><td>Pownal</td><td>Bennington</td><td>300000</td></tr><tr><td>North Town</td><td>Rye</td><td>3700000</td></tr><tr><td>Brighton</td><td>Brooklyn</td><td>7100000</td></tr></table>

T_assets > S_assets and S_branch-city = "Brooklyn"

e.g. Find all branches that have greater assets than some branch located in Brooklyn.

select branch-name  
from branch  
where assets > some  
(select assets  
from branch  
where branch-city = "Brooklyn");  
??

# 2. Query- Nested Subqueries- The All Clause

$$
\begin{array}{l} (5 <   \mathrm {a l l} \quad \begin{array}{c c} \hline 0 \\ \hline 5 \\ \hline 6 \end{array} \quad) = \mathrm {f a l s e} \\ (5 <   \mathrm {a l l} \quad \begin{array}{c c} \hline 6 \\ \hline 1 0 \end{array} \quad) = \mathrm {t r u e} \\ (5 = \mathrm {a l l} \quad \begin{array}{c c} \framebox {4} \\ \framebox {5} \end{array} ) = \mathrm {f a l s e} \\ (5 \neq \text {a l l} \quad \begin{array}{c} 4 \\ 6 \end{array} ) = \text {t r u e (s i n c e 5 \neq 4 a n d 5 \neq 6)} \\ \end{array}
$$

e.g. Find the names of all branches that have greater assets than all branches located in Brooklyn.

select branch-name  
from branch  
where assets > all  
(select assets  
from branch  
where branch-city = "Brooklyn");

# 2. Query- Test for Empty Relations

The exists construct returns the value true if the argument subquery is nonempty.

带有 EXISTS 和 NOT EXISTS 谓词的查询的子查询不返回任何数据，只返回逻辑真和假。

$$
\begin{array}{c} \text {e x i s t s} r \Leftrightarrow r \neq \emptyset \\ \text {n o t e x i s t s} r \Leftrightarrow r = \emptyset \end{array}
$$

# 2. Query- Test for Empty Relations

# 查询所有选修了 1 号课程的学生姓名

Select Sname

from Student

whereExists

(select\*

from SC

√ 由 exists 引出的子查询，其目标列表达式通常都用 *  
✓ 子查询的查询条件依赖于父查询的某个属性值（相关子查询）  
✓ 反复求值  
√ 不能被其他形式的子查询等价替换

Where Sno=Student.Sno and Cno='1');

学生表：Student(Snumber,Sname,Ssex,Sage,Sdept)

课程表：Course(Cno,Cname,Cpno,Ccredit)

学生选课表 :SC (Sno,Cno,Grade)

# 2. Query- Test for Empty Relations

查询没有选修了 1 号课程的学生姓名

Select Sname

from Student

where not EXISTS

(select\*

from SC

Where Sno=Student.Sno and Cno='1');

学生表：Student(Snumber,Sname,Ssex,Sage,Sdept)

课程表：Course(Cno,Cname,Cpno,Ccredit)

学生选课表 :SC (Sno,Cno,Grade)

# 2. Query- Test for Empty Relations

# 查询选修了全部课程的学生姓名

Select Sname 把全称量词转换成等价的使用存在量词的形式。

from Student  $= = \rangle$  没有一门课程是他不选修的。

where not exists

(select \*)

from Course Sno 不选的所有课

where not exists

(select \*

from SC

where Sno=Student.Sno

Sno 不选的某个课

学生表:

and Cno=Course.Cno));

Student(Snumber,Sname,Ssex,Sage,Sdept)

课程表：Course(Cno,Cname,Cpno,Ccredit)

学生选课表 :SC (Sno,Cno,Grade)

# Product and Ptype Example

Product  

<table><tr><td>Pno</td><td>Pname</td><td>Tno</td><td>Price</td><td>Stock</td></tr><tr><td>A001</td><td>文件夹</td><td>1</td><td>20</td><td>500</td></tr><tr><td>A002</td><td>笔筒</td><td>1</td><td>15</td><td>300</td></tr><tr><td>A003</td><td>三色圆珠笔</td><td>1</td><td>10</td><td>1000</td></tr><tr><td>B001</td><td>宠物小精灵丛书</td><td>2</td><td>100</td><td>2000</td></tr><tr><td>B002</td><td>白雪公主</td><td>2</td><td>15</td><td>300</td></tr><tr><td>B003</td><td>迪斯尼套书</td><td>2</td><td>200</td><td>200</td></tr><tr><td>C001</td><td>小儿西裤</td><td>3</td><td>40</td><td>200</td></tr><tr><td>C002</td><td>小儿短裙</td><td>3</td><td>60</td><td>500</td></tr></table>

Ptype  

<table><tr><td>Tno</td><td>Tname</td></tr><tr><td>1</td><td>文具</td></tr><tr><td>2</td><td>儿童书籍</td></tr><tr><td>3</td><td>儿童服装</td></tr></table>

# Product and Ptype Example

Find the number of all orders which ordered “A001 ” product.

SELECT DISTINCT Ono

FROM Order

WHERE EXISTS

(SELECT *

FROM Order_item

WHERE Ono=Order.Ono

AND

Pno="A001");

![](images/0aed163c5f245506a19c54880f6e1a1896cc36f56dcd843864f65112790e4c35.jpg)

Cno

C001

C002

C004

# Product and Ptype Example

![](images/6b96100223ed0012239ae8c9b985fc23f19a01b78ed5e5ade5bdb8a3c0d0b781.jpg)

# Product and Ptype Example

Find the number of all orders which didn't order "A001" product.

SELECT DISTINCT Ono

FROM Order

WHERE NOT EXISTS

(SELECT *

FROM Order_item

WHERE Ono=Order.Ono AND

Pno="A001");

# 2. Query- Test for Empty Relations

e.g. Find all customers who have an account at all branches located in Brooklyn.

select distinct S customer-name

from depositor as S

where not exists (

(select branch-name

from branch // Find branch-name located in

where branch-cityBrooklyoklyn")

minus

(select R_branch-name

from depositor as  $T$ , account as  $R$

where  $T$ .account-number = Raccount-number

and

// Find S customer

name) );

Note:  $X$  minus  $Y = \emptyset \Leftrightarrow X \subseteq Y$

# 3. Modification- Deletion

e.g. Delete all account records at the Perryridge branch.

delete from account

where branch-name = "Perryridge";

e.g. Delete all accounts at every branch located in Needham.

delete from depositor

//The order is important

where account-number in

(select account-number

from branch, account

where branch-city = "Needham"

and branch_branch-name = account/Branch-name)

delete from account

where branch-name in (select branch-name

from branch

where branch-city = "Needham");

# 3. Modification- Deletion

e.g. Delete the record of all accounts with balances below the average at the bank.

delete from account

where balance  $<$  (select avg (balance) from account);

Problem: as we delete tuples from deposit, the average balance changes

Solutions used in SQL:

1. First, compute avg balance and find all tuples to delete  
2. Next, delete all tuples found above (without recomputing avg or retesting the tuples)

# 3. Modification- Insertion

e.g. Add a new tuple to account.

insert into account

values (A-9732, "Perryridge", 1200);

insert into account (branch-name, balance, account-number)

values ("Perryridge", 1200, A-9732);

e.g. Add a new tuple to account with balance set to null.

insert into account

values (A-777, "Perryridge", null)

# 3. Modification- Insertion

e.g. Provide as a gift for all loan customers of the Perryridge branch, a $200 savings account. Let the loan number serve as the account number for the new savings account

insert into account

select loan-number,branch-name, 200

from loan

where branch-name = "Perryridge";

insert into depositor

select customer-name, loan-number

from loan, borrower

where branch-name = "Perryridge" and

loanLoan-number  $=$  borrower.loan-number;

# 3. Modification – Updates

e.g Increase all accounts with balances over  $10,000 by 6 \%$ , all other accounts receive  $5 \%$

Write two update statements:

update account

set balance = balance * 1.06

where balance  $> 10000$ ;

update account

set balance = balance * 1.05

where balance <=10000;

NOTE: The order is important.

# 4. Data Definition -Create Table

# An SQL relation is defined using the create table command:

create table R (A₁ D₁, A₂ D₂, ..., An Dₙ,

(integrity-constraint $_1$ ),...,(integrity-constraint $_k$ );

- R is the name of the relation  
each  $A_{i}$  is an attribute name in the schema of relation R  
-  $D_{i}$  is the data type of values in the domain of attribute  $A_{i}$

e.g.

create table branch

(branch-name char(15) not null,

branch-city char(30),

assets integer);

# 4. Data Definition -Create Table Integrity Constraints

not null  
primary key  $(A_{1},\dots ,A_{n})$  
check  $(P)$ , where  $P$  is a predicate

e.g. Declare branch-name as the primary key for branch and ensure that the values of assets are non-negative.

create table branch

(branch-name char(15),

branch-city char(30),

assets integer,

primary key (branch-name),

check (assets > = 0));

NOTE:primary key declaration on an attribute automatically

ensures not null in SQL-92

# 4. Data Definition - Drop and Alter Table

The drop table command deletes all information about the dropped relation from the database.

drop table emp

The alter table command is used to add attributes to an existing relation.

alter table R add A D

- A is the name of the attribute to be added to relation R and D is the domain of A.  
- All tuples in the relation are assigned null as the value for the new attribute.

The alter table command can also be used to drop attributes of a relation

alter table R drop A

A is the name of an attribute of relation RPage 64

# 4. Data Definition - Views

- Provide a mechanism to hide certain data from the view of certain users.

create view v as <query expression>

- <query expression> is any legal expression  
- The view name is represented by  $v$

# 4. Data Definition - Views

Create a view consisting of branches and their customers

create view all-customer as

(select branch-name, customer-name

from depositor, account

where depositor account-number =account_account-

number)

union

(select branch-name, customer-name

from borrower, loan

where borrowerLoan-number  $=$  loanLoan-number);

Find all customers of the Perryridge branch

select customer-name

from all-customer

where branch-name = "Perryridge"

# 4. Data Definition - Views

Create a view of all loan data in loan relation, hiding the amount attribute create view branch-loan as select branch-name, loan-number from loan ;  
- Add a new tuple to branch-loan insert into branch-loan values ("Perryridge", "L-307");

insert into loan

values("Perryridge", "L-307, null");

- Updates on more complex views are difficult or impossible to translate, and hence are disallowed.

# 4. Data Definition - Views

# DB2 不允许更新视图规定:

1 视图由两个以上基本表导出  
2 视图字段来自字段表达式或常数，不可执行 insert 和 update，但允许执行 delete  
3 视图字段来自聚集函数  
4 视图中含 group by  
5 视图中含 distinct  
6 视图定义中含有嵌套查询;  
7 不允许更新的视图上定义的视图

```sql
CREATE TABLE S
( S# CHAR(5), 
SNAME CHAR(20), 
STATUS NUMERIC(5), 
CITY CHAR(15), 
PRIMARY KEY (S#)) ;
```

```sql
CREATE TABLE P
( P# CHAR(6), PNAME CHAR(20), COLOR CHAR(6), WEIGHT NUMERIC(5,1), CITY CHAR(15), PRIMARY KEY (P#)) ;
```

```sql
CREATE TABLE SP  
( S# CHAR(5),  
P# CHAR(6),  
QTY NUMERIC(9),  
PRIMARY KEY (S#, P# ),  
FOREIGN KEY (S# ) REFERENCES S,  
FOREIGN KEY (P# ) REFERENCES P;
```

# More Examples

8

<table><tr><td>S#</td><td>SNAME</td><td>STATUS</td><td>CITY</td></tr><tr><td>S1</td><td>Smith</td><td>20</td><td>London</td></tr><tr><td>S2</td><td>Jones</td><td>10</td><td>Paris</td></tr><tr><td>S3</td><td>Blake</td><td>30</td><td>Paris</td></tr><tr><td>S4</td><td>Clark</td><td>20</td><td>London</td></tr><tr><td>S5</td><td>Adams</td><td>30</td><td>Athens</td></tr></table>

SP

<table><tr><td>S#</td><td>P#</td><td>QTY</td></tr><tr><td>S1</td><td>P1</td><td>300</td></tr><tr><td>S1</td><td>P2</td><td>200</td></tr><tr><td>S1</td><td>P3</td><td>400</td></tr><tr><td>S1</td><td>P4</td><td>200</td></tr><tr><td>S1</td><td>P5</td><td>100</td></tr><tr><td>S1</td><td>P6</td><td>100</td></tr><tr><td>S2</td><td>P1</td><td>300</td></tr><tr><td>S2</td><td>P2</td><td>400</td></tr><tr><td>S3</td><td>P2</td><td>200</td></tr><tr><td>S4</td><td>P2</td><td>200</td></tr><tr><td>S4</td><td>P4</td><td>300</td></tr><tr><td>S4</td><td>P5</td><td>400</td></tr></table>

P

<table><tr><td>P#</td><td>PNAME</td><td>COLOR</td><td>WEIGHT</td><td>CITY</td></tr><tr><td>P1</td><td>Nut</td><td>Red</td><td>12.0</td><td>London</td></tr><tr><td>P2</td><td>Bolt</td><td>Green</td><td>17.0</td><td>Paris</td></tr><tr><td>P3</td><td>Screw</td><td>Blue</td><td>17.0</td><td>Rome</td></tr><tr><td>P4</td><td>Screw</td><td>Red</td><td>14.0</td><td>London</td></tr><tr><td>P5</td><td>Cam</td><td>Blue</td><td>12.0</td><td>Paris</td></tr><tr><td>P6</td><td>Cog</td><td>Red</td><td>19.0</td><td>London</td></tr></table>

# More Examples

7.7.1 Get color and city for "nonParis" parts with weight greater than ten pounds.

```sql
SELECT PX.COLOR, PX.CITY FROM P AS PX WHERE PX.CITY <> 'Paris' AND PX.WEIGHT > 10.0;
```

7.7.2 For all parts, get the part number and the weight of that part in grams.

```sql
SELECT P.P#, P.WEIGHT * 454 AS GMWT FROM P;
```

7.7.3 Get all combinations of supplier and part information such that the supplier and part in question are colocated.

```sql
SELECT S.*, P.P#, P.PNAME, P.COLOR, P.WEIGHT
FROM S, P
WHERE S.CITY = P.CITY;
```

# More Examples

7.7.4 Get all pairs of city names such that a supplier located in the first city supplies a part stored in the second city.

select distinct s.city as scity, p.city as pcity

from s,sp,p

where s.s#=sp.s# and sp.p#=p.p#

Note: The following is not correct (because it includes CITY as a joining column in the second join):

SELECT DISTINCT S.CITY AS SCITY, P.CITY AS PCITY FROM S NATURAL JOIN SP NATURAL JOIN P;

# More Examples

7.7.5 Get all pairs of supplier numbers such that the two suppliers concerned are colocated.

```sql
SELECT A.S# AS SA, B.S# AS SB  
FROM S AS A, S AS B  
WHERE A.CITY = B.CITY  
AND A.S# < B.S#;
```

7.7.6 Get the total number of suppliers.

```sql
SELECT COUNT(*) AS N FROM S;
```

# More Examples

7.7.7 Get the maximum and minimum quantity for part P2.

```sql
SELECT MAX (SP.QTY) AS MAXQ, MIN (SP.QTY) AS MINQ
FROM SP
WHERE SP.P# = 'P2';
```

7.7.8 For each part supplied, get the part number and the total shipment quantity.

```sql
SELECT SP.P#, SUM (SP.QTY) AS TOTQTY
FROM SP
GROUP BY SP.P#;
```

# More Examples

7.7.9 Get part numbers for parts supplied by more than one supplier.

```sql
SELECT SP.P# FROM SP GROUP BY SP.P# HAVING COUNT (SP.S#) > 1;
```

7.7.10 Get supplier names for suppliers who supply part P2.

```sql
SELECT DISTINCT S.SNAME FROM S WHERE S.S# IN (SELECT SP.SFROM SP WHERE SP.P  $=$  'P2')
```

# More Examples

7.7.11 Get supplier names for suppliers who supply at least one red part.

```sql
SELECT DISTINCT S.SNAME
FROM S
WHERE S.S# IN
( SELECT SP.S#
FROM SP
WHERE SP.P# IN
( SELECT P.P#
FROM P
WHERE P.COLOR = 'Red') ) ;
```

# More Examples

7.7.12 Get supplier numbers for suppliers with status less than the current maximum status in the S table. SELECT S.S#

```sql
SELECT S.S#FROM SWHERE S.STATUS<（SELECT MAX（S.STATUS）FROM S）;
```

7.7.13 Get supplier names for suppliers who supply part P2. SELECT DISTINCT S.SNAME

```sql
SELECT DISTINCT S.SNAME FROM S WHERE EXISTS SELECT  $\star$  FROM SP WHERE SP.S# = S.S# AND SP.P# = 'P2'
```

# More Examples

7.7.14 Get supplier names for suppliers who do not supply part P2.

```sql
SELECT DISTINCT S.SNAME FROM S WHERE NOT EXISTS (SELECT \* FROM SP WHERE SP.S# = S.S# AND SP.P# = 'P2')
```

Alternatively:

```sql
SELECT DISTINCT S.SNAME FROM S WHERE S.S# NOT IN (SELECT SP.SFROM SP WHERE SP.P# = 'P2')
```

# More Examples

7.7.15 Get supplier names for suppliers who supply all parts.

```sql
SELECT DISTINCT S.SNAME FROM S WHERE NOT EXISTS (SELECT \* FROM P WHERE NOT EXISTS (SELECT \* FROM SP WHERE SP.Sf = S.SF AND SP.Pf = P.Pf) ）；
```

# More Examples

7.7.16 Get part numbers for parts that either weigh more than 16 pounds or are supplied by supplier S2, or both.

```sql
SELECT P.P# FROM P WHERE P.WEIGHT > 16.0   
UNION SELECT SP.P# FROM SP WHERE SP.S# = 'S2'
```

# Group project—section 3

- Analyze the common query requirements (operations) based on your application background.  
- Do you need some views in your background? why? What is their functions?  
Express them in SQL language.