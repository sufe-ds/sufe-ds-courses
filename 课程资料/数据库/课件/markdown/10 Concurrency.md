# Concurrency

# Content

1. Introduction to concurrency  
2. ThreeConcurrency Problems  
3. Locking (锁)  
4. The Three Concurrency Problems Revisited  
5. Deadlock  
6. Serializability  
7. Two-phase locking protocol

# 1. Introduction

concurrency : DBMSs typically allow many transactions to access the same database at the same time.  
■ concurrency control mechanism : ensure that concurrent transactions do not interfere with each other.

# 2. ThreeConcurrency Problems

The lost update problem (丢失修改)  
The uncommitted dependency problem (读“脏”数据问题)  
The inconsistent analysis problem (不可重复读问题)

# The Lost Update Problem

<table><tr><td>Transaction A</td><td>time</td><td>Transaction B</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>RETRIEVE t</td><td>t1</td><td>-</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>-</td><td>t2</td><td>RETRIEVE t</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>UPDATE t</td><td>t3</td><td>-</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>-</td><td>t4</td><td>UPDATE t</td></tr><tr><td>-</td><td>-</td><td>-</td></tr></table>

Transaction A's update is lost at time t4.

# The Uncommitted Dependency Problem

![](images/e1faca80372ef3ab311625916c71ae1549847ff20b14184e52b01f0f4c014226.jpg)

The uncommitted dependency problem arises if one transaction is allowed to retrieve—or, worse, update—a tuple that has been updated by another transaction but not yet committed by that other transaction.

# The Inconsistent Analysis Problem

![](images/0df6d7f5204cbf04126288857c447ad67a24c0d65f4df20a43080825f172be16.jpg)

# 3. Locking (锁)

Two kinds of locks:

• Exclusive locks (X locks) / write locks  
- Shared locks (S locks) / read locks

If transaction A holds an exclusive (X) lock on tuple t, then a request from some distinct transaction B for a lock of either type on t will be denied.  
If transaction A holds a shared (S) lock on tuple t, then:

A request from some distinct transaction B for an X lock on t will be denied;  
A request from some distinct transaction B for an S lock on t will be granted (that is, B will now also hold an S lock on t).

# Lock type compatibility matrix

# (锁相容矩阵)

<table><tr><td></td><td>X</td><td>S</td><td>-</td></tr><tr><td>X</td><td>N</td><td>N</td><td>Y</td></tr><tr><td>S</td><td>N</td><td>Y</td><td>Y</td></tr><tr><td>-</td><td>Y</td><td>Y</td><td>Y</td></tr></table>

# Data access protocol / locking protocol

# (封锁协议)

A transaction that wishes to retrieve a tuple must first acquire an S lock on that tuple.  
A transaction that wishes to update a tuple must first acquire an X lock on that tuple.

- If it already holds an S lock on the tuple, then it must promote that S lock to X level.

# Data access protocol / locking protocol…

If a lock request from transaction B is denied because it conflicts with a lock already held by transaction A, transaction B goes into a wait state. B will wait until A's lock is released.

- The system must guarantee that B does not wait forever.  
A simple way to provide such a guarantee is to service all lock requests on a "first-come, first-served" basis.

X locks are held until end-of-transaction (COMMIT or ROLLBACK). S locks are normally held until that time.

由锁世界的排队规则引出……

1）排队使公共场所有了秩序，使各项服务、工作能有序、高效地运行，课堂要遵守课堂秩序才能保证教学的有序进行，企业员工要遵守企业的规章制度才能保证生产的正常进行，行人、车辆只有遵守交通法规才能保证交通有序、安全地运行，社会有了各种规章制度，人们生活才能安定有序地进行，国家有了各种法律法规，人们的生活才有了安全保障。  
2）我们要懂规矩，守纪律，法治是治国理政的基本方式，依法治国是社会主义民主政治的基本要求。它通过法制建设来维护和保障公民的根本利益，是实现自由平等、公平正义的制度保证。

# 4. The ThreeConcurrency Problems Revisited

![](images/308ba5f27809ce2e0acd21639d72b8c5fe6073268a9fae71470ca68fb93d983e.jpg)

Locking solves the lost update problem.  
Another problem: deadlock

# The Uncommitted Dependency Problem

![](images/b7a3cccd85d315d029cf98f1e59183b21b8c354252fafe0cf67a0269c12e5c3a.jpg)

Transaction A is prevented from seeing an uncommitted change at time t2.

# The Inconsistent Analysis Problem

![](images/ba686aab8312784d55e92cb37fa4d094393d7801348fc83cd9fec01ffecdb412.jpg)

# 5. Deadlock

![](images/d967e4480f85b1c410aa1325e9754df2a3c06ea562e9740dfa0347c424a19b71.jpg)

![](images/7aa2d04a736217a99146f850a32dc735ac423ace757aad30a36d476f6b3a2328.jpg)

![](images/826e228c97c1541c998d40a32e05d9ff2e8ebacb36d875d54b2b2c1223eb7ff6.jpg)

![](images/6de01aabb2b72633d01be0774e24daf18dd152a5ffb4da71d7557cb567434388.jpg)

# 5. Deadlock …

Deadlock is a situation in which two or more transactions are in a simultaneous wait state, each of them waiting for one of the others to release a lock before it can proceed.

<table><tr><td>Transaction A</td><td>time</td><td>Transaction B</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>LOCK r1 EXCLUSIVE</td><td>t1</td><td>-</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>-</td><td>t2</td><td>LOCK r2 EXCLUSIVE</td></tr><tr><td>-</td><td></td><td>-</td></tr><tr><td>LOCK r2 EXCLUSIVE</td><td>t3</td><td>-</td></tr><tr><td>wait</td><td></td><td>-</td></tr><tr><td>wait</td><td>t4</td><td>LOCK r1 EXCLUSIVE</td></tr><tr><td>wait</td><td></td><td>wait</td></tr><tr><td>wait</td><td></td><td>wait</td></tr></table>

# 5. Deadlock …

If a deadlock occurs, it is desirable that the system detect it and break it.  
Detecting the deadlock involves detecting a cycle in the Wait-For Graph.  
- Breaking the deadlock involves choosing one of the deadlocked transactions as the victim and rolling it back, thereby releasing its locks and so allowing some other transaction to proceed.

# 死锁的检测 (补充)

# (1) 超时法

如果一个事务的等待时间超过了规定的时限，就认为发生了死锁。

优点：实现简单。

缺点：一是有可能误判死锁；

二是若时限设置的太长，可能出现死锁发生后不能及时发现的情况。

# (2) 有向等待图法

# 检测死锁

画一个表示事务等待关系的有向等待图  $G = (V, E)$ 。其中  $V$  为结点集合，每个结点表示一个正在运行的事务  $E$  为有向边集合，每条有向边表示事务的等待关系：若 T1 正在等待给被T2锁住的数据项加锁，则在T1和T2之间划一条有向边，方向是T1指向T2。

事务的有向等待图动态地反映了所有事务的等待情况。

若事务依赖图有环 则可能死锁

![](images/c20b89c0cce07bd6c15ed92cd39423cc4fea594461f8655eb340b2c0a2f78203.jpg)

![](images/844d8f979a55e03026b1b56bd45f4c5cd2c8fb49003750bb35c06f499bc9cf15.jpg)

# 6. Serializability(可串行性)

A given execution of a set of transactions is serializable(可串行化的), if it produces the same result as some serial execution of the same transactions, running them one at a time.  
A given execution of a set of transactions is considered to be correct if it is serializable.

# 6. Serializability(可串行性)…

Individual transactions are assumed to be correct:

- transform a correct state of the database into another correct state.

Running the transactions one at a time in any serial order is correct:

- because individual transactions are assumed to be independent of one another.

An interleaved execution is correct if it is equivalent to some serial execution—i.e., if it is serializable.

# 6. Serializability(可串行性)…

# Terminology:

• Given a set of transactions, any execution of those transactions, interleaved or otherwise, is called a schedule(调度).  
• Executing the transactions one at a time, with no interleaving, constitutes a serial schedule(串行调度);  
A schedule that is not serial is an interleaved schedule 并发调度 (or simply a nonserial schedule).  
• Two schedules are said to be equivalent if they are guaranteed to produce the same result, independent of the initial state of the database.

# 6. Serializability(可串行性)…

<table><tr><td>事务T1</td><td>事务T2</td><td>数据库中的值</td><td>事务T1</td><td>事务T2</td><td>数据库中的值</td></tr><tr><td>read (A)</td><td></td><td>A=50</td><td></td><td>read (A)</td><td>A=50</td></tr><tr><td>A:=A-2</td><td></td><td></td><td></td><td>A:=A-2</td><td></td></tr><tr><td>write (A)</td><td></td><td>A=48</td><td></td><td>write (A)</td><td>A=48</td></tr><tr><td>read (B)</td><td></td><td>B=100</td><td></td><td>read (B)</td><td>B=100</td></tr><tr><td>B:=B-1</td><td></td><td></td><td></td><td>B:=B-1</td><td></td></tr><tr><td>write (B)</td><td></td><td>B=99</td><td></td><td>write (B)</td><td>B=99</td></tr><tr><td></td><td>read (A)</td><td>A=48</td><td>read (A)</td><td></td><td>A=48</td></tr><tr><td></td><td>A:=A-2</td><td></td><td>A:=A-2</td><td></td><td></td></tr><tr><td></td><td>write (A)</td><td>A=46</td><td>write (A)</td><td></td><td>A=46</td></tr><tr><td></td><td>read (B)</td><td>B=99</td><td>read (B)</td><td></td><td>B=99</td></tr><tr><td></td><td>B:=B-1</td><td></td><td>B:=B-1</td><td></td><td></td></tr><tr><td></td><td>write (B)</td><td>B=98</td><td>write (B)</td><td></td><td>B=98</td></tr><tr><td colspan="3">串行调度1:先T1后T2</td><td colspan="3">串行调度2:先T2后T1</td></tr></table>

# 6. Serializability(可串行性)…

<table><tr><td>事务T1</td><td>事务T2</td><td>数据库中的值</td><td>事务T1</td><td>事务T2</td><td>数据库中的值</td></tr><tr><td>read (A)</td><td></td><td>A=50</td><td>read (A)</td><td></td><td>A=50</td></tr><tr><td>A:=A-2</td><td></td><td></td><td>A:=A-2</td><td></td><td></td></tr><tr><td>write (A)</td><td></td><td>A=48</td><td>write (A)</td><td></td><td>A=48</td></tr><tr><td></td><td>read (A)</td><td></td><td>read (B)</td><td></td><td>B=100</td></tr><tr><td></td><td>A:=A-2</td><td></td><td></td><td>read (A)</td><td>A=48</td></tr><tr><td></td><td>write (A)</td><td>A=46</td><td></td><td>A:=A-2</td><td></td></tr><tr><td></td><td></td><td>B=100</td><td></td><td>write (A)</td><td>A=46</td></tr><tr><td>read (B)</td><td></td><td></td><td></td><td>read (B)</td><td>B=100</td></tr><tr><td>B:=B-1</td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>write (B)</td><td></td><td>B=99</td><td>B:=B-1</td><td></td><td></td></tr><tr><td></td><td>read (B)</td><td></td><td>write (B)</td><td></td><td>B=99</td></tr><tr><td></td><td>B:=B-1</td><td></td><td></td><td>B:=B-1</td><td></td></tr><tr><td></td><td>write (B)</td><td>B=98</td><td></td><td>write (B)</td><td>98</td></tr></table>

并发调度1

并发调度2

# 可串行化调度

现在有两个事务，分别包含下列操作：

• 事务 T1: 读 B; A=B+1; 写回 A  
• 事务 T2: 读 A; B=A+1; 写回 B

现给出对这两个事务不同的调度策略

# 串行调度, 正确的调度

<table><tr><td>T1</td><td>T2</td></tr><tr><td>Slock B</td><td></td></tr><tr><td>Y=R(B)=2</td><td></td></tr><tr><td>Unlock B</td><td></td></tr><tr><td>Xlock A</td><td></td></tr><tr><td>A=Y+1=3</td><td></td></tr><tr><td>W(A)</td><td></td></tr><tr><td>Unlock A</td><td></td></tr><tr><td></td><td>Slock A</td></tr><tr><td></td><td>X=R(A)=3</td></tr><tr><td></td><td>Unlock A</td></tr><tr><td></td><td>Xlock B</td></tr><tr><td></td><td>B=X+1=4</td></tr><tr><td></td><td>W(B)</td></tr><tr><td></td><td>Unlock B</td></tr></table>

串行调度 (a)

假设A、B的初值均为2。  
按  $\mathrm{T}_{1} \rightarrow \mathrm{T}_{2}$  次序执行结果为  $\mathrm{A} = 3, \mathrm{~B} = 4$  
■ 串行调度策略，正确的调度

# 串行调度, 正确的调度

<table><tr><td>T1</td><td>T2</td></tr><tr><td></td><td>Slock A</td></tr><tr><td></td><td>X=R(A)=2</td></tr><tr><td></td><td>Unlock A</td></tr><tr><td></td><td>Xlock B</td></tr><tr><td></td><td>B=X+1=3</td></tr><tr><td></td><td>W(B)</td></tr><tr><td></td><td>Unlock B</td></tr><tr><td>Slock B</td><td></td></tr><tr><td>Y=R(B)=3</td><td></td></tr><tr><td>Unlock B</td><td></td></tr><tr><td>Xlock A</td><td></td></tr><tr><td>A=Y+1=4</td><td></td></tr><tr><td>W(A)</td><td></td></tr><tr><td>Unlock A</td><td></td></tr></table>

串行调度 (b)

假设 A、B 的初值均为 2。  
T 2 → T 1 次序执行结果为 B=3, A=4  
■ 串行调度策略，正确的调度

# 不可串行化调度，错误的调度

<table><tr><td>T1</td><td>T2</td></tr><tr><td>Slock B</td><td></td></tr><tr><td>Y=R(B)=2</td><td></td></tr><tr><td></td><td>Slock A</td></tr><tr><td></td><td>X=R(A)=2</td></tr><tr><td>Unlock B</td><td></td></tr><tr><td></td><td>Unlock A</td></tr><tr><td>Xlock A</td><td></td></tr><tr><td>A=Y+1=3</td><td></td></tr><tr><td>W(A)</td><td></td></tr><tr><td></td><td>Xlock B</td></tr><tr><td></td><td>B=X+1=3</td></tr><tr><td></td><td>W(B)</td></tr><tr><td>Unlock A</td><td></td></tr><tr><td></td><td>Unlock B</td></tr></table>

不可串行化的调度

执行结果与 (a)、(b)的结果都不同  
是错误的调度

# 可串行化调度，正确的调度

<table><tr><td>T1</td><td>T2</td></tr><tr><td>Slock B</td><td></td></tr><tr><td>Y=R(B)=2</td><td></td></tr><tr><td>Unlock B</td><td></td></tr><tr><td>Xlock A</td><td></td></tr><tr><td></td><td>Slock A</td></tr><tr><td>A=Y+1=3</td><td>等待</td></tr><tr><td>W(A)</td><td>等待</td></tr><tr><td>Unlock A</td><td>等待</td></tr><tr><td></td><td>X=R(A)=3</td></tr><tr><td></td><td>Unlock A</td></tr><tr><td></td><td>Xlock B</td></tr><tr><td></td><td>B=X+1=4</td></tr><tr><td></td><td>W(B)</td></tr><tr><td></td><td>Unlock B</td></tr></table>

可串行化的调度

执行结果与串行调度 (a) 的执行结果相同  
■ 是正确的调度

# 7. Two-phase locking protocol

If all transactions obey the "two-phase locking protocol," all possible interleaved schedules are serializable.  
Two-phase locking protocol:

• Before operating on any object (e.g., a database tuple), a transaction must acquire a lock on that object;  
- After releasing a lock, a transaction must never go on to acquire any more locks.

# “两段”锁的含义

# - 事务分为两个阶段

- 第一阶段是获得加锁，也称为扩展阶段；  
- 第二阶段是释放加锁，也称为收缩阶段。

# 7. Two-phase locking protocol…

T1:

• Slock(A)、Slock(B)、Xlock(C)、Unlock(A)、Unlock(B)、Unlock(C)

obey the two-phase locking protocol

T2: Xlock(B)、Unlock(B)

obey the two-phase locking protocol

T3:

Slock(A)、Slock(B)、Unlock(B)、Xlock(C)、

Unlock(A)、Unlock(C)

not obey the two-phase locking protocol

- 并行执行的所有事务均遵守两段锁协议，则对这些事务的所有并行调度策略都是可串行化的。

![](images/7cb3e83841eeac928bc15cc24af6be86662f8e1562471ca3308e72f93ee66877.jpg)

所有遵守两段锁协议的事务，其并行执行的结果一定是正确的

- 事务遵守两段锁协议是可串行化调度的充分条件，而不是必要条件  
- 可串行化的调度中，不一定所有事务都必须符合两段锁协议。