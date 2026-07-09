# Functional Dependencies

# Overview of presentation

1 Base definition  
2 Use of Functional Dependencies  
3 Trivial and Nontrivial Dependencies  
4 Closure of a Set of Dependencies  
5 Closure of a Set of Attributes  
6 The Cover and Equivalent of FDs  
7 Irreducible sets of dependencies

# 1. Basic Definitions

- Let  $r$  be a relation, and let  $X$  and  $Y$  be arbitrary subsets of the set of attributes of  $r$ ,  $Y$  is functionally dependent on  $X$ :

$$
X \to Y
$$

If and only if each X value in r has associated with it precisely one Y value in r.

Two tuples of r agree on their X value, they also agree on their Y value.

# 1. Basic Definitions_example

Consider an instance of the revised shipments relation, called SCP:

<table><tr><td>SCP</td><td>S#</td><td>CITY</td><td>P#</td><td>QTY</td></tr><tr><td></td><td>S1</td><td>London</td><td>P1</td><td>100</td></tr><tr><td></td><td>S1</td><td>London</td><td>P2</td><td>100</td></tr><tr><td></td><td>S2</td><td>Paris</td><td>P1</td><td>200</td></tr><tr><td></td><td>S2</td><td>Paris</td><td>P2</td><td>200</td></tr><tr><td></td><td>S3</td><td>Paris</td><td>P2</td><td>300</td></tr><tr><td></td><td>S4</td><td>London</td><td>P2</td><td>400</td></tr><tr><td></td><td>S4</td><td>London</td><td>P4</td><td>400</td></tr><tr><td></td><td>S4</td><td>London</td><td>P5</td><td>400</td></tr></table>

Some FDs satisfied by SCP:

```latex
$\{\mathrm{S}\# ,\mathrm{P}\# \} \to \{\mathrm{QTY}\}$ $\{\mathrm{S}\# ,\mathrm{P}\# \} \to \{\mathrm{CITY}\}$ $\{\mathrm{S}\# ,\mathrm{P}\# \} \to \{\mathrm{CITY},\mathrm{QTY}\}$ $\{\mathrm{S}\# ,\mathrm{P}\# \} \to \{\mathrm{S}\# \}$ $\{\mathrm{S}\# ,\mathrm{P}\# \} \to \{\mathrm{S}\# ,\mathrm{P}\# ,\mathrm{CITY},\mathrm{QTY}\}$ $\{\mathrm{S}\# \} \to \{\mathrm{QTY}\} = = \mathrm{S}\# \to \mathrm{QTY}$ $\{\mathrm{QTY}\} \to \{\mathrm{S}\# \}$
```

# 1. Basic Definitions…

- Let  $R$  be a relation variable, and let  $X$  and  $Y$  be arbitrary subsets of the set of attributes of  $R$ . Then we say that  $Y$  is functionally dependent on  $X$  —in symbols,

$$
\mathrm {X} \rightarrow \mathrm {Y}
$$

(read "X functionally determines Y," or simply "X arrow Y") —if and only if, in every possible legal value of R, each X value has associated with it precisely one Y value. In other words, in every possible legal value of R, whenever two tuples agree on their X value, they also agree on their Y value.

# 1. Basic Definitions_example

Here then are some (time-independent) FDs that apply to relvar SCP:

$$
\begin{array}{l} \{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \mathrm {Q T Y} \\ \{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \mathrm {C I T Y} \\ \{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \{\mathrm {C I T Y}, \mathrm {Q T Y} \} \\ \{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \mathrm {S} \# \\ \{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \{\mathrm {S} \# , \mathrm {P} \# , \mathrm {C I T Y}, \mathrm {Q T Y} \} \\ \{\mathrm {S} \# \} \rightarrow \mathrm {C I T Y} \\ \end{array}
$$

# 2.Use of Functional Dependencies

- Test relations to see if they are legal under a given set of functional dependencies. If a relation  $r$  is legal under a set  $S$  of functional dependencies, we say that  $r$  satisfies  $S$ .  
- Specify constraints on the set of legal relations; we say that S holds on R if all legal relations on R satisfy the set of functional dependencies S.  
Note: A specific instance of a relation schema may satisfy a functional dependency even if the functional dependency does not hold on all legal instances.

# 2.Use of Functional Dependencies…

Even in SCP there is a large number of FDs.  
We need a small number of FDs, since they have to be checked at every update by the DBMS.  
For a given set S of FDs, find a set T of FDs for which it holds that

T is smaller than S  
Every FD in S is implied by the FDs in T

And so the DBMS can just check the FDs in T

Partial answer: eliminate trivial dependencies, e.g. SCP  
Is there a method for finding T?

# 3. Trivial and Nontrivial Dependencies

# （平凡和非平凡的函数依赖）

One obvious way to reduce the size of the set of FDs we need to deal with is to eliminate the trivial dependencies. A dependency is "trivial" if it cannot possibly not be satisfied.  
An FD is trivial if and only if the right-hand side is a subset (not necessarily a proper subset) of the left-hand side

$$
\{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \{\mathrm {S} \# \}
$$

$$
\{\mathrm {S} \# , \mathrm {P} \# \} \rightarrow \{\mathrm {P} \# \}
$$

As the name implies, trivial dependencies are not very interesting in practice

# 4. Closure of a Set of Dependencies

Some FDs imply others:

```javascript
$\{\mathrm{S}\# ,\mathrm{P}\# \} \to \{\mathrm{CITY},\mathrm{QTY}\}$  implies both of the following:  $\{\mathrm{S}\# ,\mathrm{P}\# \} \to \mathrm{CITY}$ $\{\mathrm{S}\# ,\mathrm{P}\# \} \to \mathrm{QTY}$
```

The set of all FDs that are implied by a given set  $S$  of FDs is called the closure of  $S$ , written  $S^{+}$ .

# 4. Closure of a Set of Dependencies…

We can find all of  $S^{+}$  by applying Armstrong's Axioms:

Reflexivity: if  $B \subseteq A$ , then  $A \to B$  (trivial) 自反律

Augmentation: if  $A \to B$ , then  $AC \to BC$  增广律

Transitivity: if  $A \to B$  and  $B \to C$ , then  $A \to C$  传递率

These rules are complete and sound. (完备的, 有效的).

• Complete: given a set S of FDs, all FDs implied by S can be derived from S using the rules.  
Sound: no additional FDs can be so derived.

The rules can be used to derive precisely the closure  $S^{+}$ .

# 4. Closure of a Set of Dependencies…

Several further rules can be derived from the three given above

Self-determination:  $A \rightarrow A$

Decomposition: If  $A \to BC$ , then  $A \to B$  and  $A \to C$ .

Union: If  $A \to B$  and  $A \to C$ , then  $A \to BC$

Composition: If  $A \to B$  and  $C \to D$ , then  $AC \to BD$

These additional rules can be used to simplify the practical task of computing  $S^+$  from  $S$ .

# 4.Closure of a Set of Dependencies _Example1

Suppose we are given relvar R with attributes A, B, C, D, E, F, and the FDs

![](images/f04f5fa43047d984efdc85f6bd4a572da07583ba5922ffc22692e6dff46ade84.jpg)

# 4.Closure of a Set of Dependencies _Example2

$$
\begin{array}{l} R = (A, B, C, G, H, I) \\ S = \{A \rightarrow B \\ \mathbf {A} \rightarrow \mathbf {C} \\ \end{array}
$$

$$
C G \rightarrow H
$$

$$
C G \rightarrow I
$$

$$
B \rightarrow H \}
$$

some members of  $S^{+}$

$$
A \rightarrow H
$$

$$
A G \rightarrow I
$$

$$
C G \rightarrow H I
$$

# 5.Closure of a Set of Attributes

In principle, we can compute the closure  $S^{+}$  of a given set  $S$  of FDs by means of an algorithm that says "Repeatedly apply the rules from the previous section until they stop producing new FDs."  
In practice, there is little need to compute the closure per se.  
We need to calculate closure  $Z^{+}$  of a set of attributes  $Z$ , under a set of FDs  $S$ .

# 5.Closure of a Set of Attributes…

Given  $Z$  and  $S$ , determine the set of attributes  $A$  which are functionally dependent on  $Z$  (i.e. the closure  $Z^+$  of  $Z$  under  $S$ ).  
Algorithm to compute  $\mathbf{Z}^{+}$ , the closure of  $\mathbf{Z}$  under S:

```txt
CLOSURE[Z,S] := Z;  
do "forever";  
for each FD X → Y in S  
    do;  
        if X ≤ CLOSURE[Z,S] /*  $\leq$  = "subset of" */ then CLOSURE[Z,S] := CLOSURE[Z,S] ∪ Y;  
    end;  
    if CLOSURE[Z,S] did not change on this iteration  
        then leave loop; /* computation complete */  
    end;
```

# 5.Closure of a Set of Attributes-Example1

Given  $R$  with attributes  $A, B, C, D, E, F$  and  $S$  as:

$$
\begin{array}{l} A \rightarrow B C \\ \mathbf {E} \rightarrow C \mathbf {F} \\ \boldsymbol {B} \rightarrow \boldsymbol {E} \\ C D \rightarrow E F \\ \end{array}
$$

Calculate the closure to  $\{A, B\}^+$  of the set  $\{A, B\}$  under  $S$ .

# 5.Closure of a Set of Attributes-Example1

1. Initialize the result  $CLOSURE[Z,S]$  to  $\{A,B\}$ .  
2. We now go round the inner loop four times, once for each of the given FDs.

A  $\rightarrow$  BC: CLOSURE[Z,S] is now the set  $\{A,B,C\}$ .

E  $\rightarrow$  CF: unchanged.

B  $\rightarrow$  E: CLOSURE[Z,S] is now the set  $\{A,B,C,E\}$

CD  $\rightarrow$  EF: unchanged.

3. Now we go round the inner loop four times again. On the first iteration, the result does not change; on the second, it expands to  $\{\mathrm{A},\mathrm{B},\mathrm{C},\mathrm{E},\mathrm{F}\}$ ; on the third and fourth, it does not change.  
4. Now we go round the inner loop four times again. CLOSURE[Z,S] does not change, and so the whole process terminates, with  $\{\mathbf{A},\mathbf{B}\}^{+} = \{\mathbf{A},\mathbf{B},\mathbf{C},\mathbf{E},\mathbf{F}\}$ .

# 5.Closure of a Set of Attributes-Example2

Given  $R$  with attributes  $A, B, C, D, E$  and  $S$  as:  $S = \{AB \to C, BC \to AD, D \to E, CF \to B\}$ , Calculate the closure to  $\{A, B\}^+$  of the set  $\{A, B\}$  under  $S$ .

(1)  $\left\{\mathrm{A}, \mathrm{B}\right\}^{+} = \left\{\mathrm{A}, \mathrm{B}\right\}$  
(2)  $\mathrm{AB} \rightarrow \mathrm{C} \quad \Longrightarrow \{\mathrm{A}, \mathrm{B}\}^{+} = \{\mathrm{A}, \mathrm{B}, \mathrm{C}\}$  
(3)  $\mathrm{BC} \rightarrow \mathrm{AD} \Longrightarrow \{\mathrm{A}, \mathrm{B}\}^{+} = \{\mathrm{A}, \mathrm{B}, \mathrm{C}, \mathrm{D}\}$  
D→E  $\longrightarrow \{\mathrm{A},\mathrm{B}\}^{+} = \{\mathrm{A},\mathrm{B},\mathrm{C},\mathrm{D},\mathrm{E}\}$  
(5) 结果:  $\left\{\mathrm{A}, \mathrm{B}\right\}^{+} = \left\{\mathrm{A}, \mathrm{B}, \mathrm{C}, \mathrm{D}, \mathrm{E}\right\}$

# 5.Closure of a Set of Attributes - Important Corollaries

The FD  $X \to Y$  will follows from S if and only if Y is a subset of the closure X+ of X under S.  
K is a superkey if and only if the closure  $\mathbf{K}^{+}$  of K is precisely the set of all attributes.

# 5.Closure of a Set of Attributes-Example3

$$
R = (A, B, C, G, H, I)
$$

$$
S = \{A \rightarrow B
$$

$$
A \rightarrow C
$$

$$
C G \rightarrow H
$$

$$
C G \rightarrow I
$$

$$
B \rightarrow H \}
$$

$$
(A G) ^ {+} = A B C G H I
$$

Is AG a candidate key?

# 5.Closure of a Set of Attributes-Example4

relvar $\{\mathrm{A}, \mathrm{B}, \mathrm{C}, \mathrm{D}, \mathrm{E}, \mathrm{F}, \mathrm{G}\}$  satisfies the following FDs

$\mathrm{A} \rightarrow \mathrm{B}$

BC→DE

$\mathrm{AEF} \rightarrow \mathrm{G}$

the closure of  $\{\mathbf{A},\mathbf{C}\} ?$ $\mathrm{ACF}\rightarrow \mathrm{DG}$  ?

Answer: {ABCDE} Yes

# 6. The Cover and Equivalent of FDs

Given two sets of FDs S1 and S2, if every FD implied by S1 is implied by the FDs in S2 (i.e. if  $\mathsf{S1^{+}}$  is a subset of  $\mathsf{S2^{+}}$ ) then S2 is a cover for S1 (i.e. the DBMS only has to check S2).

- If the DBMS enforce the FDs in S2, then it will automatically be enforcing the FDs in S1.

If S2 is a cover for S1 and S1 is a cover for S2, i.e., if  $\mathrm{S1^{+} = S2^{+}}$ , we say S1 and S2 are equivalent.  
If S1 and S2 are equivalent, then if the DBMS enforce the FDs in S2, it will automatically be enforcing the FDs in S1, and vice versa.

# 7. Irreducible sets of dependencies

# (最小函数依赖集)

# A set of FDs S is irreducible if and only if

- The right-hand side of each FD in S involves one attribute.  
- No attribute in the left-hand side of each FD in S can be removed without changing  $\mathrm{S}^{+}$ .  
- No FD in S can be removed without changing  $\mathrm{S}^{+}$ .

For every set of FDs, there exists at least one equivalent set that is irreducible.

# 7. Irreducible sets of dependencies-example1

This set of FDs is easily seen to be irreducible:

The right-hand side is a single attribute in each case  
The left-hand side is obviously irreducible in turn  
- None of the FDs can be discarded without changing the closure (i.e., without losing some information).

P# PNAME

P#  $\rightarrow$  COLOR

P#  $\rightarrow$  WEIGHT

P# - CITY

the following sets of FDs are not irreducible

P#  $\rightarrow$  { PNAME, COLOR}

P  $\pmb{\varphi}$  WEIGHT

P  $\pmb{\beta}\rightarrow$  CITY

{P#，PNAME}→COLOR

P  $\pmb{\varphi}\rightarrow$  PNAME

WEIGHT

P  $\nrightarrow$  CITY

P→P

P  $\nrightarrow$  PNAME

P  $\pmb{\varphi}\rightarrow$  COLOR

P#→WEIGHT

P#  $\rightarrow$  CITY

# 7. Irreducible sets of dependencies…

A set I of FDs that is irreducible and equivalent to some other set S of FDs is said to be an irreducible equivalent to S.  
Given some particular set  $S$  of FDs that need to be enforced, it is sufficient for the system to find and enforce the FDs in an irreducible equivalent I instead.  
A given set of FDs does not necessarily have a unique irreducible equivalent.

# 7.Irreducible sets of dependencies_Example 2

$$
R = (A, B, C, D)
$$

$$
\begin{array}{l} S = \{A \rightarrow B C \\ B \rightarrow C \\ A \rightarrow B \\ \mathbf {A} \mathbf {B} \rightarrow \mathbf {C} \\ A C \rightarrow D \} \\ \end{array}
$$

the irreducible set

$$
A \rightarrow B
$$

$$
B \rightarrow C
$$

$$
A \rightarrow D
$$

![](images/950be22008108965d2b3ffed178b866f0a541bf5043fd982957c5ac77a352c0a.jpg)

1. Rewrite the FDs such that each has a singleton right-hand side:

$$
\begin{array}{l} A \rightarrow B \\ A \rightarrow C \\ B \rightarrow C \\ A \rightarrow B \\ A B \rightarrow C \\ A C \rightarrow D \\ \end{array}
$$

2. attribute C can be eliminated from the left-hand side of the FD  $AC \rightarrow D$

Because  $A \rightarrow C$  and  $A \rightarrow AC$  and  $A \rightarrow D$

3 FD  $\mathrm{AB} \rightarrow \mathrm{C}$  can be eliminated

Because  $\mathrm{AB} \rightarrow \mathrm{BC}$ ,  $\mathrm{AB} \rightarrow \mathrm{C}$

4 the FD  $\mathrm{A} \rightarrow \mathrm{C}$  is implied by the FDs  $\mathrm{A} \rightarrow \mathrm{B}$  and  $\mathrm{B} \rightarrow \mathrm{C}$ , so it can also be eliminated.

# 7. Irreducible sets of dependencies_Example 3

# Are the two following FDs equivalent?

1) A→B AB→C D→AC D→E  
2) A→BC D→AE

The first is equivalent to the following irreducible set:

$\mathrm{A}\rightarrow \mathrm{B}\quad \mathrm{AB}\rightarrow \mathrm{C}\quad \mathrm{D}\rightarrow \mathrm{A}\quad \mathrm{D}\rightarrow \mathrm{C}\quad \mathrm{D}\rightarrow \mathrm{E}$

$\mathrm{A}\rightarrow \mathrm{AB}$  AB  $\rightarrow$  C SO A  $\rightarrow$  C SO instead of AB  $\rightarrow$  C using A  $\rightarrow$  C

D→A A→C SO eliminate D→C

SO A→B A→C D→AD→E

# Exercises

1)  $R = (A, B, C, D)$

$$
s = 0
$$

the candidate key?

answer: {ABCD}

(2)  $\mathrm{R} = (\mathrm{A}, \mathrm{B}, \mathrm{C})$

$$
\mathrm {S} = \mathrm {A} \rightarrow \mathrm {B}, \mathrm {B} \rightarrow \mathrm {C}
$$

$$
S ^ {+} = ?
$$

answer: Many

# Example

(3)  $\mathrm{R} = (\mathrm{A}, \mathrm{B}, \mathrm{C}, \mathrm{D}, \mathrm{E})$

$$
S = \{A B \rightarrow C, C D \rightarrow A, B C \rightarrow D, D \rightarrow B, E A \rightarrow C \}
$$

$$
\{\mathrm {A B E} \} ^ {+} = ?
$$

4)  $R = (A, B, C, D, E)$

$$
\begin{array}{l} S = \{A \rightarrow B, B \rightarrow D, C E \rightarrow A, C D \rightarrow E \} \\ \mathrm {A C} \rightarrow \mathrm {B E}? \\ \end{array}
$$

the candidate key?

$$
\text {A n s w e r : A \rightarrow D} \quad \mathrm {A C \rightarrow C D} \quad \mathrm {A C \rightarrow E} \quad \mathrm {A C \rightarrow B E}
$$

5) Relation variable R{A,B,C,D,E,F,G} satisfies the following FDs  $\mathrm{FD} = \{\mathrm{A}\rightarrow \mathrm{B},\mathrm{BC}\rightarrow \mathrm{DE},\mathrm{AC}\rightarrow \mathrm{B},\mathrm{AEF}\rightarrow \mathrm{G},\mathrm{AC}\rightarrow \mathrm{DE}\}$ , the irreducible equivalent set of FD.

$$
\mathrm {A E F} \rightarrow \mathrm {G A} \rightarrow \mathrm {B B C} \rightarrow \mathrm {D B C} \rightarrow \mathrm {E}
$$

# 补充

# 候选码的求解理论和算法

对于给定的关系R（A1，A2，...An）和函数依赖集F，可将其属性分为4类：

L类仅出现在函数依赖左部的属性。  
R 类仅出现在函数依赖右部的属性。  
N类在函数依赖左右两边均未出现的属性。  
LR类 在函数依赖左右两边均出现的属性。

(1)定理: 对于给定的关系模式R及其函数依赖集F, 若X (X∈R) 是L类属性, 则X必为R的任一候选码的成员。

因为L类属性不依赖任何其他属性，所以必是候选码成员。

推论：对于给定的关系模式R及其函数依赖集F，若X（X∈R）是L类属性，且X+包含了R的全部属性；则X必为R的唯一候选码。因为L类不依赖于其他类属性，不会被其他属性推出。

例：设有关系模式R（A，B，C，D），其函数依赖集F={D→B，B→D，AD→B，AC→D}，求R的所有候选码。

解：考察F发现，A，C两属性是L类属性，所以AC必是R的候选码成员，又因为(AC)  $+= ABCD$  ，所以AC是R的唯一候选码。

(2) 定理: 对于给定的关系模式R及其函数依赖集F, 若X (X∈R) 是N类属性, 则X必包含在R的任一候选码中。

推论：对于给定的关系模式R及其函数依赖集F，若X（X∈R）是L类和N类组成的属性集且X+包含了R的全部属性；则X是R的唯一候选码。

(3)定理: 对于给定的关系模式R及其函数依赖集F, 若X (X∈R) 是R类属性, 则X不在任何候选码中。

总结：LN均不能由别的属性推出，所以必是候选码成员，若LN类属性闭包包含全部属性，则此属性集为唯一候选码。R类属性只能由别人推出，绝对不会出现在候选码中（候选码是最小的超码）。

例题：

一假设有关系模式R(A，B，C，D，E)，其上的函数依赖集是  $F = \{A\to BC$  ，  $\mathrm{CD}\rightarrow \mathrm{E}$  ，B $\rightarrow D$  ，  $\mathsf{E}\rightarrow \mathsf{A}\}$  ，求R的所有候选码

解：ABCDE在F的各个函数依赖的左侧均出现过，因此，候选码可能包含ABCDE，我们只能试：

(1)先试单个的, (A)  $+ =$  ABCDE, (E)  $+ =$  ABCDE所以A,E是候选码。  
②  $(\mathsf{B}) + = \mathsf{BD}$  ，  $(C) + = C$  ，  $(D) + = D$  所以B,C,D都不是。  
③两个从BCD选,(CD)  $+  =$  ABCDE,(BC)  $+  =$  ABCDE所以BC,CD是

注意：如果（CD）+ = ABCDE单纯这个条件不能判断CD是否是候选码，还要判断  $(C) +$  (D) +是不是候选码，候选码是最小的超码。

设有关系模式 R(A, B, C, D, E, F), 其函数依赖集为:  $\mathrm{F} = \left\{  {\mathrm{E} \rightarrow  \mathrm{D},\mathrm{C} \rightarrow  \mathrm{B},\mathrm{{CE}} \rightarrow  \mathrm{F},\mathrm{B} \rightarrow  \mathrm{A}}\right\}$  。指出  $\mathrm{R}$  的所有候选码并说明原因;

回答：候选码就是主码，即可以作为决定性因素的属性，候选码可以  $\rightarrow$  所有的值，通俗地讲就是只能出现在箭头的前面，不能出现在后面。

那这里 A、B、D、F 四个属性肯定是不行了，只有 C 和 E 了，发现 CE 之间没有依赖关系，并且  $\mathrm{CE} \rightarrow \mathrm{ABCDEF}$ ，所以 CE 就是候选码。