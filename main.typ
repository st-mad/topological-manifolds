#import "@preview/clean-math-paper:0.2.5": *

#import "@preview/great-theorems:0.1.2": *
#import "@preview/rich-counters:0.2.1": *

// for commutative diagrams.
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let date = datetime.today().display("[month repr:long] [day], [year]")

// Modify some arguments, which can be overwritten in the template call
//
#page-args.insert("numbering", "1/1")
#text-args-title.insert("size", 2em)
#text-args-title.insert("fill", black)
#text-args-authors.insert("size", 12pt)
#set text(
  size: 12pt
)
//#show sym.emptyset: set text(font: "Fira Sans")
#show: great-theorems-init
#show: template.with(
  title: "Self-study of Topology and Topological Manifolds",
  authors: (
    (name: "Madhav Singh"),
  ),
  //affiliations: (
    //(id: 1, name: "Affiliation 1, Address 1"),
  //),
  date: date,
  //heading-color: rgb("#0000ff"),
  //link-color: rgb("#008002"),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  //abstract: lorem(30),
  //keywords: ("First keyword", "Second keyword", "etc."),
  //AMS: ("65M70", "65M12"),
  // Pass page-args to change page settings
  // page-args: page-args,
  // Pass text-args-authors to change author name text settings
  // text-args-authors: text-args-authors,
  // Pass text-args-title to change title text settings
  // text-args-title: text-args-title,
)
#let mathcounter = rich-counter(
  identifier: "mathblocks",
  inherited_levels: 2
)
#let construction = mathblock(
  blocktitle: "Construction",
  //bodyfmt: text.with(style: "italic"),
  counter: mathcounter,
)

#let definition = mathblock(
 blocktitle: "Definition",
  bodyfmt: text.with(style: "normal"),
  counter: mathcounter,
)

#let problem = mathblock(
  blocktitle: "Problem",
  counter: mathcounter,
)

#let solution = mathblock(
  blocktitle: "Solution",
  counter: mathcounter,
)

#let ms(x) = {
  set text(fill: color.fuchsia)
  x
} 

#let interval = $[0,1]$

#outline()

= Tutorial Thoughts
== Why is the box topology not good?

First note that in the case of finite products the Box Topology is equivalent to the Product Topology and no problems arise. Also observe that the subbase of the Product Topology is contained in the Box Topology, so as the Product Topology is the coarsest topology that makes projection maps continuous, the projection maps are continuous in Box Topology.

#construction[
    Consider $bb(R)^bb(N)$, consider the Box Topology on such a set. Then for then the set $U = product_(n in bb(N)) (-1/n , 1/n)$ is a cylindrical set and thus open. 
  
    This is a bad open set because maps such as $f : x arrow product_(n in bb(N)) {x}$, that is continuous in the product topology but not in the box topology. $ f^(-1) (U) = {0}, " Which isn't open in" bb(R). $

    If $pi_i$ is the $i^"th"$ projection map, $pi_i f$ is the identity, but $f$ is not continuous.
]



#remark[
  Also note that a good argument for the usefulness of the Product Topology is the $2^bb(N)$ construction of *Cantor Space*, where the topology on $2^bb(N)$ is the Product Topology of the countable product of the discrete topology on the two point space. The Box Topology on the other hand gives you only the discrete topology.
]

= General Topology:

== Bases:

#definition(title: "Neighbourhood base")[
  Let $X$ be a topological space. We say that a point $x in X$ has a neighbourhood base if there exists $cal(B)_x$ a collection of neighbourhoods of $x$, such that for any neighbourhood of $x$, $N$ there exists $B in cal(B)_x$ such that $B subset.eq N$.
]

#definition(title: "First Countable")[
  We say that a topological space $X$ is _first countable_, if for every point $x in X$ there exists a countable neighbourhood base.
]

#lemma(title: "Properties of a countable neighbourhood base")[
  Let $X$ be a first countable topological space. 
   + For each $x in X$, there exists a countable neighbourhood base of open sets.
   + For each $x in X$ there exists a countable neighbourhood base of nested sets.
]
#proof[
  I'm not going to prove this here. For each neighbourhood pick the open set contained in it to get an open neighbourhood base, and then take the finite intersection of sets in the base to get nested base.
]

#ms[Sequence lemma]
#lemma(title: "Sequence lemma")[
  Let $X$ be first countable. If $A subset.eq X$ and $x in X$, the following hold:
  + $x in "cl"(A)$ iff $x$ is a limit of a sequence in $A$.
  + $A$ is closed iff it contains all its limits of sequences.
]
#proof[
  Let $X$ be first countable and $A subset.eq X$ and $x in A$.

  ($=>$)
  Let $x$ not be the limit of any sequence in $A$. Let $B_x$ be $x$'s nested open neighbourhood base. We claim that we can find an open set $U in B_x$ such that $U inter A = emptyset$. To see this, assume that every $U in B_x$ has a point in $A$. Then for each open set containing $x$, we can find a $U in B_x$ subset of that open set as $B_x$ is a neighbourhood base. As $B_x$ is nested we can consider all the values of elements of $A$ in $U$, and we can use these to construct a sequence converging to $x$. So, this cannot be the case.

  Then $X \\ U$ is a closed set not containing $x$ but containing $A$. This implies $x in.not "cl"(A)$.

  ($arrow.double.l$)
  Let $x$ be the limit of $(x_n)_n subset.eq A$. This means that for every open set containing $x$ we can find an element of the sequence in that open set. This means that no open set of $x$ is contained in the complement of $A$. This means that $x$ is not contained in the exterior of $A$, which means it must be contained in the closure of $A$.
]




#problem[
  Let $X,Y$ be topological spaces:
    + Suppose $f : X -> Y$ is continuous and $p_n -> p$ in $X$. Show that $f(p_n) -> f(p)$ in $Y$.
    + If $X$ is *first countable* show that if $f : X -> Y$ is a map such that $p_n -> p => f(p_n) -> f(p)$, then $f$ is continuous. 
]
#solution[
  Let $X,Y$ be topological spaces.
  #proof[Towards a proof of statement (i). Suppose $f : X -> Y$ is continuous and $p_n -> p$ is a convergent sequence in $X$. 
    
    Let $U subset.eq Y$ be an open set in $Y$ containing $f(p)$. Then by continuity, $f^(-1)(U)$ is open in $X$ and contains $p$. By convergence of $(p_n)_n$, there exists $N in bb(N)$ such that for all $n > N : p_n in f^(-1)(U)$, this implies that $n > N : f(p_n) in U$. As $U$ was an arbitrary open set containing $p$, this implies $f(p_n) -> f(p)$.
  ]

  #proof[
    Let $X$ be first countable, and let $f : X -> Y$ be a function such that for any sequence $(p_n)_n : p_n -> p => f(p_n) -> f(p)$.

    Aiming towards a contradiction, assume $f$ is not continuous.
    Then there exists an open set $V$ in $Y$ such that $f^(-1)(V)$ is not open. Fix $x in f^(-1)(V)$. Let $cal(B)_x$ be its countable neighbourhood base.
    #ms[TODO: This is still incorrect]
  ]
]
  
== Connectedness:

#definition(title: "Disconnected")[
  A topological space $X$ is _disconnected_ if there exist $U, V subset.eq X$ non-empty disjoint open subsets of $X$, such that $ X = U union.sq V $ We say that $U, V$ are then a _separation of $X$_

  A space where no separation exists is called a connected space.
]

#example[ 
  Disconnected spaces:
    + Discrete space with at least two points.
    + $bb(Q) subset.eq bb(R)$
  Connected spaces: 
    + The indiscrete space is connected.
    + $bb(R)$ with its usual topology.
    + *The particular point topology*.
]

#definition(title: "Interval")[
  $A subset.eq bb(R)$ is an _interval_ if and only if $u,v in A => [u,v] subset.eq A$.
]

#theorem(title: "Intervals are connected")[
  $A subset.eq bb(R)$ is connected in the subspace topology if and only if it is an interval.
]
#proof[
  The contrapositive of the forwward statement is clear. If $A$ is not an interval, then $exists u,v in A : w in [u,v] \\ A$. Then $A inter (-infinity, w), A inter (w, infinity)$ are a separation.

  To prove the backward direction, let $I$ be an interval.

  We will first prove the case where the interval is all of $bb(R)$, and the other cases will follow from homeomorphisms and a lemma introduced later.
    
  Aiming for a contradiction, let $U,V$ be a separation of $bb(R)$.

  Note that as $U$ is a closed subset of $bb(R)$ and $bb(R)$ is complete, $U$ is also complete.

  Let $u in U$ and $v in V$, then $|u-v| < infinity$. WLOG let $u < v$. Then $S = (-infinity, v] inter U$ is clopen in $U$ with $sup S = v$ Thus, it is a non-empty clopen set with an upper bound. Which is not possible in $bb(R)$.
]

=== Connectivity Toolbox
The following trinity of results forms a good set of tools for proving connectivity.

#lemma[
  Let $X$ be a topological space and $A subset.eq X$. If $A$ is connected and $A subset.eq B subset.eq "cl"(A)$, then $B$ is connected.
] 
#proof[
  Let $A$ be connected.
  Aiming for a contradiction, assume there exists $A subset.eq B subset.eq "cl"(A)$, such that $B$ is disconnected. Then let $U,V$ be a separation for $B$.

  If $A subset.eq U$, then as $U$ is closed, $"cl"(A) subset.eq U$. As $U subset.eq B subset.eq "cl"(A)$, by assumption, we have $U = "cl"(A)$ and then  $U subset.eq B subset.eq "cl"(A) => U = B$, which is a contradiction as $U,V$ separate $B$, so $A inter V$ must be non-empty.

  This means that $A subset.eq (A inter U) union (A inter V)$, where both of these sets are non-empty. As $U,V$ are clopen and disjoint, this is a separation in $A$, which is impossible as $A$ is connected.

  This implies that $B$ must be connected.
 ]
#lemma[
  If $f : X -> Y$ is a continuous map and $X$ is connected, then $f(X) subset.eq Y$ is connected.
]
#proof[
  Aiming to show the contrapositive, let $f : X -> Y$ be continuous and let $U,V$ be a separation for $f(X)$. Note that the restriction of the codomain $f : X -> f(X)$ is still continuous.(These are the same function but over different topological spaces so this isn't (entirely) trivial.)
  Then $f^(-1)(U), f^(-1)(V)$ are non-empty disjoint sets that are open in the subspace of $f(X)$ that cover $f(X)$, thus they form a separation for $X$, thus $X$ is disconnected.
]
#lemma[
  For $X = union.big_(i in I) X_i$, where each $X_i$ is connected and $inter.big_(i in I) X_i != emptyset$, then $X$ is connected.
]
#proof[
  Let $(X_i)_i$ be such a collection of sets. Assume their union $X$ has a separation $U,V$. Fix $z in inter.big_(i) X_i$. 

  W.L.O.G let $z in U$. As $U, V$ is a separation $exists k in V$. Then there exists $j$ such that $k in X_j$. 

  Consider $X_j inter U$ , $X_j inter V$. They are disjoint as $U,V$ are disjoint. Both are open in $X_j$ as $U,V$ are each open in $X$, and both non-empty as $z in X_j inter U$ and $k in X_j inter V$. Thus, they form a separation of $X_j$, which is a contradiction as $X_j$ is connected. So the separation $U,V$ cannot exist, thus $X$ is connected.
]

#definition(title: "Connected component")[
  Let $X$ be a topological space and $x in X$. The _connected component_ of $x$ is the union of all connected subsets of $X$ containing $x$.
]

#lemma(title: "Properties of connected components")[
  + Each connected component is connected.
  + Connected components partition the space.
]
#proof[
  The union of connected sets with a shared point is connected.

  They are necessarily disjoint and every point has a connected component that contains it.
]

#theorem(title:"Intermediate Value Theorem")[
  Let $X$ be a topological space and let $f : X -> bb(R)$ be continuous. If $a,b in f(X)$ with $a < b$, then for every $c in (a,b)$ there exists $x in X$ such that $f(x) = c$.
]
#proof[
  Let $X$ be connected and $f : X -> bb(R)$ be continuous.

  Let $a,b in f(X)$, with $a < b$.
  Assume that there exists $c in (a,b)$ such that $forall x: f(x) != c$. Consider $f^(-1) ((-infinity,c))$ and $f^(-1) ((c,infinity))$, these are open sets and must partition $X$ as $f$ misses $c$. Thus this is a separation of $X$ which leads us to a contradiction. Thus the result follows.
]

#example(title: "Fixed points")[
  Let $f : [0,1] -> [0,1]$ be continuous. Then $f$ has a fixed point.

  We can see this by setting $g(x) = f(x) - x$. IVT gives us a fixed point.
]

=== Path connectivity:

#definition(title: "Path connected space")[
  We say that a topological space $X$ is path connected if for every pair of points $x,y in X$ there exists a continuous map $gamma : [0,1] -> X$, such that $gamma (0) = x$ and $gamma (1) = y$. We say that $gamma$ is a path from $x$ to $y$.
]

#theorem[Every Path connected space is connected.]
#proof[
  Let $X$ be path connected. 

  Let $U,V$ be disjoint non-empty open sets such that $X = U union.sq V$. Let $u in U " and " v in V$. Let $gamma$ be a path from $u$ to $v$. Then observe that $gamma^(-1) (U)$, $gamma^(-1) (V)$ are disjoint non-empty open sets that partition $[0,1]$. This implies that $[0,1]$ is disconnected which is false.
]

#example(title: "Connected but not path connected")[
  Topologist's sine curve. #ms[I'm not the biggest fan of this example.]
]

#definition(title:"Path component")[
  Let $X$ be a topological space and $x in X$. The _path component_ of $x$ is the set of all points $y in X$ such that there exists a path from $x$ to $y$.
]

#definition(title: "Locally path connected")[
  A topological space $X$ is _locally path connected_ if for every point $x in X$, $x$ has a path-connected neighbourhood base.
]

#lemma(title: "Properties of path components")[
  + Path components partition $X$
  + Each path component is contained in a connected component.
  + If $X$ is locally path-connected, path components are open.
]
#ms[Todo]

== Compactness:


#definition(title: "Compact Space")[
  Let $X$ be a topological space, we say it is a _compact space_ if every open cover of $X$ has a finite subcover.

]


#lemma(title: "Closed set of a compact space is always compact.")[
  Let $X$ be a compact space and $F subset.eq X$ be closed. Then $F$ is a compact space in its subspace topology.
]
#proof[
  Let $X$ be a compact space with $F$ a closed subset. 

  Let ${U_i}_(i in I)$ be an open cover of $F$. Each $U_i$ is then open in $F$'s subspace topology. 

  This implies that for each $i in I$, there exists $V_i$ open in $X$ such that $U_i = V_i inter F$. As $F$ is closed in $X$, $X\\F$ is open in $X$. 

  Note now that ${V_i : i in I} union {X\\F}$ is an open cover of $X$. As $X$ is compact, there is a finite subcover, call it $cal(V)$. Then we observe that the set ${F inter  V : V in cal(V)} \\ {emptyset}$ is a finite open cover of $F$, and is, in fact, a subcover of ${U_i}_(i in I)$, as $(X \\ F) inter F = emptyset$ and every other element of $cal(V)$ is of the form $V_i$, and thus $V_i inter F  = U_i$.
]

#definition(title : "FIP")[
  Let $cal(F)$ be a collection of sets we say it has the _finite intersection propery_ (*FIP*), if every finite intersection of sets from $cal(F)$ has non-empty intersection.
]

#example[
  Let $cal(F) = {(0,1/n], n in bb(N)_(>0)}$. $cal(F)$ has *FIP* but has empty intersection overall.
]

#theorem(title: "FIP characterisation of compactness")[
  A topological space $X$ is compact iff. every collection of closed sets with *FIP* has non-empty intersection.
]
#proof[
  $X$ is a compact topological space. $<=>$ Every open cover has a finite subcover. $<=>$ Every collection of closed sets that intersect to the empty set, have a finite subcollection that intersect to the empty set. $<=>$ Every collection of closed sets with *FIP* has non-empty intesection.

  In the second implication, we consider complements of the open cover, and in the third implication we take the contrapositive of the statement. 
]

#theorem(title: "Closed subsets of Hausdorff spaces are compact")[
    If $X$ is a Hausdorff space and $K subset.eq X$ is closed, then $K$ is a compact space.
]
#proof[
  Let $X$ be Hausdorff and let $K subset.eq X$ be compact.

  Consider $x in X\\K$, for each $y in K$ there exist disjoint open sets, $U_y, V_y$, such that $x in U_y$ and $y in V_y$. By compactness of $K$, we can find a finite subcover of ${V_y : y in K}$, let this be ${V_(y_i) : 1 <= i <= n}$. Then $U = inter.big_(i = 1)^n U_(y_i)$ is an open set that is disjoint from every $V_(y_i)$, which cover $K$, which implies $U$ is contained in $X\\K$. As $x$ is arbitrary, $X\\K$ is open $=>$ $K$ is closed.
]

#lemma[
  Let $X$ be a compact space and let $Y$ be Hausdorff, and $f : X -> Y$ be a continuous bijection. Then $f$ is a homeomorphism.
]
#proof[
  Let $C$ be closed in $X$, as $X$ is compact, it is also compact. We want to show $f(C)$ is closed. Let ${V_i}_(i in I)$ be an open cover of $f(C)$. Then by continuity of $f$, ${f^(-1) (V_i)}_(i in I)$ is an open cover of $C$, by compactness, there exists a finite subcover, ${f^(-1) (V_i)}_(i in I')$. Then note ${V_i}_(i in I')$ is a finite subcover of $f(C)$. This implies that $f(C)$ is compact, and as $Y$ is Hausdorff, $f(C)$ is closed.
]
#example[Every set in the cofinite topology is compact]

#theorem(title: "Continuous images of compact spaces are compact.")[
  Let $f : X -> Y$ be a continuous map. If $X$ is compact then $f(X)$ is compact.
]
#proof[
  #ms[TODO]
]

== Metrisation and Separation:
#definition[
  For a topological space $X$, a subset $D subset.eq X$ is dense iff $"cl"(D) = X$.
]

#lemma[
  A subset $D subset.eq X$ is dense iff. for every non-empty open set $U$, $D inter U != emptyset$.
]
#proof[
  Let $X$ be a topological space.

  ($=>$) Let $D$ be dense in $X$. Let $U$ be a non-empty open set in $X$. Aiming for a contradiction assume $D inter U  = emptyset$. $X\\U$ is closed and contained $D$, so this implies $"cl"(D) subset.eq X\\U$, as $D$ is dense, this implies $X subset.eq X\U => U = emptyset$. Which is a contradiction.

  ($arrow.l.double$) Let $D$ be a set such that every non-empty open set in $X$ has non-empty intersection with $D$. Observe $X\\"cl"(D)$ is an open set and cannot have non-empty intersection with $D$, which implies $X\\"cl"(D) = emptyset$, which implies $D$ is dense.
]

#lemma[
  Every secound countable space is separable.
]
#proof[
  Let $X$ be second countable. Then let $cal(B) = {B_i}_(i in bb(N))$be a base for $X$. Use the Axiom of Countable choice, to choose $x_n in B_n$ for each $n in bb(N)$. This is a countable dense subset, as every open set contains one of these points and there are countably many of these. Thus, $X$ is separable.
]

#definition(title: "Regular")[
  A topological space $X$ is called _regular_ if for every point $x in X$ and closed set $F subset.eq X$ such that $x in.not F$, there exist disjoint open sets $U_x, U_F$ such that $x in U_x$ and $F subset.eq U_F$.
]
#lemma(title: "Characterisation of regular")[
  $X$ is regular iff for each point $x in X$ and every open set $U$ containing $x$ there exists an open set $V$ such that $x in V subset.eq "cl"(V) subset.eq U$.
]
#proof[
  Let $X$ be a topological space.
  ($=>$) Let $X$ be regular. Let $x$ be a point in $X$ and let $U$ be an open neighbourhood of $x$.

  Observe that $X\\U$ is a closed set not containing $U$, so by regularity there is are disjoint open sets $V_x, V_(X\\U)$ that separate $x$ and $X\\U$.
  $ X\\U subset.eq V_(X\\U) => X\\V_(X\\U) subset.eq U $
  $X\\V_(X\\U)$ is then a closed set containing $V_x$. 

  $ x in V_x subset.eq "cl"(V_x) subset.eq X\\V_(X\\U) subset.eq U $

  So $V_x$ is the required set.
  
  ($arrow.l.double$) Assume the second condition. Let $x$ be a point and $F$ be a closed set not containing $x$.

  Note that $x in X\\F$ and observe that this set is open. Then there exists $V : x in V subset.eq "cl"(V) subset.eq X\\F$, by the assumed condition. $F subset.eq X\\"cl"(V)$ and $x in V$ give the separating open sets.

]

#definition(title: "Normal")[A topological space $X$ is called _normal_ if for every pair of disjoint closed sets $F,G subset.eq X$ there exist disjoint open sets $U_F, U_G$ such that $F subset.eq U_F$ and $G subset.eq U_G$].
#lemma(title: "Normal shrinking lemma")[
  If $X$ is a normal topological space. If $F$ is a closed subset of $X$ and $U$ is an open subset of $X$ such that $F subset.eq U$, then there exists an open set $V$ such that $F subset.eq V subset.eq "cl"(V) subset.eq U$.
]
#proof[
  Let $F subset.eq U subset.eq X$ where $F$ is closed and $U$ is open.
  Then $X\\U$ is a closed set disjoint from $F$, so by normality there exists disjoint open sets $V_F, V_(X\\U)$ that separate the two closed sets. Then $X\\V_(X\\U) subset.eq U$ is a closed set and contains $V_F$. Then $F subset.eq V_F subset.eq "cl"(V_F) subset.eq X\\V_(X\\U) subset.eq U$.
]

#theorem(title: "Urysohn's Lemma")[ 
  Let $X$ be a normal topological space. For $A,B$ closed subsets of $X$, there exists a continuous function $f : X -> bb(R)$ such that $f(A) = {0}$ and $f(B) = {1}$.
]
#proof[
  Let $cal(D) = {k/(2^n) : k in bb(Z), n in bb(N)} inter [0,1]$ be the set of dyadic rationals in $[0,1]$.

  By NLS, there exists an open set $U_0$ containing $A$ and not intersecting $B$. (Apply it to $X\\B$.) Then define $U_1 = X\\B$.
  
  By induction, we will attempt to construct a set of open sets indexed by $cal(D)$ such that for $r < s in cal(D): "cl"(U_r) subset.eq U_s$. 

  For each $r < s$ we can use NLS to find an open set that we index as, $U_(r + (s-r)/2)$ such that 
  $ U_r subset.eq  U_(r + (s-r)/2) subset.eq "cl"(U_(r + (s-r)/2)) subset.eq U_s $ 

  Starting with $U_0, U_1$ we can define $B = {U_d : d in cal(D)}$ inductively.

  Now we define:
  $ f(x) := cases(
    "inf"{d : x in U_d } "if" x in.not B,
    1 "otherwise",
  ) $
  Note that $f(A) = {0}$.

  We claim that $f$ is continuous. It suffices to show that $f$ is continuous on the subbase generated by ${[0, a), (b, 1] : a,b in bb(R)}$. Observe the following: 
  $ f^(-1) ([0,a)) &= {x in X : "inf"{d : x in U_d} in [0,a)} \ &= union.big_(0 <= r < a){x in X : "inf"{d : x in U_d} = r} \ &= union.big_( 0 <= r < a) U_r $
  This is true as for $x in U_r$, $U_r$ is definitionally the first $r$ such that $f(x) mapsto r$.

  In the case of $f^(-1) ((b, 1])$, we observe that:
  $ f^(-1) ((b, 1]) &= {x in X : "inf"{d : x in U_d} in (b, 1]} union B \ 
  &= union.big_(1 > s > b) {x in X : "inf"{d : x in U_d} > s} union (X\\U_1) \
  &= union.big_(1 > s > b) X\\{x in X : "inf"{d : x in U_d <= s}} union X\\U_1 \ 
  &= union.big_(1 > s > b) X\\U_s union X\\U_1 \ 
  &= union.big_(1 >= s > b) X\\U_s \ $
  
  As both of these are unions of open sets they are open, thus $f$ is continuous.
]

#lemma[
  A $T_0$ regular and second countable space is normal.
]
#proof[
  #ms[ I'm suspiscoisu of this proof ]

  Let $X$ be such a space. Let $cal(B)$ be its countable base. 

  Observe that for any $x,y in X$, by $T_0$ there exists an open set containing $x$ and not $y$. This means there is a closed set containing $y$ and not $x$. By regularity, we can find disjoin open sets separating them. This implies that the space is Hausdorff. (Just a fun fact, we don't use this in this proof.)

   Let $A,B$ be disjoint closed sets. For each $x in A$, we can find disjoint open sets that separate $x$ from $B$. Let $V_x$ be this set.
   This gives us a collection of sets ${V_x : x in A}$, for each $V_x$, we can find an element of the basis that contains $x$ and call that $A_x$. There are only countably many distinct $A_x$'s. Observe now that we have $ A_x subset.eq V_x subset.eq "cl"(V_x) subset.eq X \\ B $

   We have ${A_x : x in A}$, similarly construct a ${B_x : x in B}$. As these are countable, we can index both collections by $bb(N)$. Then we set $X_n = A_n \\ union.big_(i = 1)^n "cl"(B_i)$ and $Y_n = B_n \\ union.big_(i = 1)^n "cl"(A_i)$. These are both open sets, as we are taking the set difference of an open set with a closed set.

   $union.big_n X_n$ and $union.big_n Y_n$ are then disjoint open sets that separate $A$ and $B$.
]

#theorem(title: "Urysohn's Metrisation Theorem")[
  Every $T_0$ and regular second countable space is metrisable.  
]

#definition(title:"Tychonoff space or completely regular space")[
  A space $X$ is called *Tychonoff or completely regular* if for any point $x$ and a closed set $C$ not containing it, we can find a continuous function $f : X -> [0,1]$ where $f(x) = 0$ and $f(C) = {1}$.
]

== Subspaces:
== Product Spaces:
== Disjoint Union Spaces:
== Quotient Spaces:
#problem(title: "Exercise 3.55")[
  Show that every wedge sum of Hausdorff spaces is Hausdorff.
]

#ms[adding more content to the point-set topology course]
== Tychonoff's theorem:

In this section, we want to prove a fundamental result in General Topology that is also a famous consequence of Choice. This result is Tychonoff's theorem.

#theorem(title:"Tychonoff's theorem")[
  The product of a family of compact topological spaces is compact with the product topology.
]<tychonoff>

There are a few different approaches that can be taken to prove this. Instead of following the historical approach involving nets, I will focus on building up the theory of ultrafilter convergence, as it comes up in other places as well.

=== Introducing filters:
#definition(title:"Filter")[
  Given a set $X$ an *filter* is a non-empty collection of subsets of $X$ that is upwards-closed (if a set is in the collection then every set containing it is also in the collection) and closed under binary intersection. A filter is called proper if it is not the entire powerset of $X$.

  A proper filter that is a maximal under $subset.eq$ with respect to all proper filters is called an *ultrafilter*.
]

#lemma[
  An ultrafilter either contains $A$ or $X \\ A$ for every subset $A subset.eq X$.
]
#proof[If it didn't contain both, we could then extend the filter, contradicting maximality.]

Throughout this section, we will work with closed sets more than open sets. We should recall that all notions in topology regarding open sets can be replaced with dual notions regarding closed sets. Recall FIP compactness and the notion of a basic closed set.

The following result tells us that it suffices to check compactness only on basic closed sets. This is not a difficult result but it is useful as an example of the 'dual-reasoning' we need to do to work in terms of closed sets.
#lemma[A topological space $X$ is compact iff it has the finite intersection property for every collection of basic closed sets.]

#ms[ugly ass proof ngl]
#proof[
  Let $X$ be a topological space. Let $frak(C)$ be a collection of closed sets of $X$ such that any other closed set is an intersection of sets from $frak(C)$. These are our basic closed sets.

  Assume that any collection of basic closed sets such that any finite subcollection of them has non-empty intersection must have non-empty intersection. (This is FIP compactness restricted only to basic closed sets.)

  Let $cal(F)$ be a collection of closed sets with non-empty finite intersections.

  Consider the collection $ cal(X) = {C in frak(C) : exists F in cal(F), F subset.eq C} $ 

  We will show that $cal(X)$ has non-empty finite intersections. Towards this, let $cal(Y)$ be a finite subcollection of $cal(X)$.

  Now for each $Y in cal(Y)$, we can consider $F_Y in cal(F)$ such that $F_Y subset.eq Y$. This exists by construction of $cal(X)$. As ${F_Y : Y in cal(Y)}$ is a finite subcollection of $cal(F)$, it has non-empty intersection. This implies that $ inter.big_(Y in cal(Y)) Y != emptyset $

  As $cal(Y)$ was arbitrary, every finite subcollection of $cal(X)$ has non-empty intesection, so by assumption: 
  $ inter.big_(Z in cal(X)) Z != emptyset $

  This means that there exists $x in X$ such that $x$ is in every basic closed set that intersects with $cal(F)$. As for each $F in cal(F)$, we can write it as $ F = inter.big_(C in cal(D)) C $ for some collection of basic closed sets $cal(D)$.

  This must then imply that $x in F$ for each $F$. Therefore, $ inter.big_(F in cal(F)) F != emptyset. $
  
  So by FIP compactness, $X$ is compact.

  The converse direction follows trivially from FIP compactness.
]

#ms[Maybe proof the ultrafilter lemma first.]
#theorem[(UFL) If $cal(A)$ is a subset of a set $X$ that has non-empty finite intersections, then there exists an ultrafilter that extends $cal(A)$.]

=== Topological properties of Ultrafilters:
In this section, we'll prove ultrafilter-variants of classic theorems about sequences. It will be a repeating theme that theorems that normally hold for Hausdorff or T_1 spaces will hold in general when we replace sequential concepts with their ultrafilter analogues.

We will start by connecting ultrafilters on the set to the topology.

#definition(title : "Convergence of ultrafilters")[
  Let $X$ be a topological space and $cal(U)$ be an ultrafilter on $X$. We say that $cal(U)$ *converges to a point* $x in X$ iff every open neighbourhood $U$ of $x$ is in $cal(U)$. This is written as $cal(U) arrow.br x$.
]
#theorem[ Let $X$ be a topological space.
  + $X$ is Hausdorff iff. every ultrafilter converges to at most one point.
  + $X$ is compact iff. every ultrafilter converges to atleast one point.
]<ultrafilter-characterisation-of-hausdorff-and-compact>
#proof[
  ($=>$): First assume that $X$ is Hausdorff. Aiming for a contradiction, then assume that there exists an ultrafilter $cal(U)$ that converges to two distinct points $x,y in X$. By the Hausdorff property, there exist disjoint open sets $U_x, U_y$ that separate $x$ and $y$. As the ultrafilter converges to both points, we must have that $U_x, U_y in cal(U)$. Then as ultrafilters are closed under finite intersections, as $U_x inter U_y = emptyset$, we have $emptyset in cal(U)$. This is a contradiction, as ultrafilters cannot contain the empty set.

  ($arrow.double.l$): Towards proving the contrapositive, let $x,y$ be two distinct points in $X$ such that every open neighbourhood of $x$ has non-trivial intersection with every open neighbourhood of $y$.

  Then consider the collection $ cal(G) = {U^("open") subset.eq X : x in U "or" y in U} $

  By assumption, $cal(G)$ is closed under finite intersections and by definition it is upward closed and does not contain the empty set. This means that $cal(G)$ is a proper filter. Using the ultrafilter lemma, we know that there exists an ultrafilter that extends $cal(G)$. Now consider open neighbourhoods $U_x$ and $U_y$ of $x$ and $y$. $U_x$ and $U_y$ are both in $cal(G)$, so then they are both in the ultrafilter that extends it. This means that we have found an ultrafilter that converges to two distinct points.

  ($=>$): Now towards the second statement, assume that $X$ is compact. Let $cal(U)$ be an ultrafilter that converges to no points. This means that for any point we can find an open neighbourhood of the point that is not in the ultrafilter. By the property of being an ultrafilter, the complements of these neighbourhoods are in the ultrafilter.

  Consider the collection $ cal(C) = {X \\ A subset.eq X : x in X "and" A "is an open neighbouhood of" x "such that" A in.not cal(U)} $

  Observe that each set in $cal(C)$ is a closed set in $cal(U)$. Given a finite subcollection of $cal(C)$, as $emptyset in.not cal(U)$ and $cal(U)$ is closed under finite intersections, any finite subcollection of $cal(C)$ is non-empty. Then by FIP compactness, $ inter.big cal(C) != emptyset $

  This means that there exists a point $z in X$ that lies in the complement of an open neighbourhood of every point in $X$. This is absurd as $z$ must then lie in the complement of its own open neighbourhood.

  ($=>$): To prove the converse, assume that every ultrafilter converges. Suppose that there exists a collection of closed sets $cal(C)$ with non-empty finite intersection, but with $inter.big cal(C) = emptyset$.

  So we can extend $cal(C)$ into an ultrafilter $cal(U)$. Then there exists a point $x$ such that $cal(U) arrow.br x$. As $cal(C)$ has empty intesection, there then exists a $C in cal(C)$ such that $x in X \\ C$. This gives us that $X \\ C$ is an open neighbourhood of $x$ that does not lie in the ultrafilter. This is a contradiction as $cal(U)$ converges to $x$.
]

#theorem(title : "Ultrafilters can fully capture the topology.")[
  Let $X$ be topological space. A subset $U subset.eq X$ is open iff. for every ultrafilter $cal(U)$, $cal(U)$ converges to a point in $U$ implies that $U in cal(U)$.
]<ultrafilter-characterisation-of-open-sets>
#proof[
  Let $X$ be a topological space.

  ($=>$): Let $U$ be an open set in $X$ and let $cal(U)$ be an ultrafilter that converges to a point in $U$. Then by definition $U in cal(U)$ as it is an open neighbourhood of the convergence point.
  
  ($arrow.l.double$): Let $U$ be a subset such that every ultrafilter that converges to a point in $U$ contains $U$.

  If $U$ is not open there exists a point $x in U$ such that every neighbourhood of point has non-empty intersection with $X \\ U$. 
  Consider the collection $ cal(G) = {X \\ U} union {"all open neighbourhoods of" x} $
  This collection then has non-empty finite intersections. We can then extend $cal(G)$ into an ultrafilter $cal(U)$. By construction $cal(U)$ converges to $x$, but this, by assumption, implies that $U in cal(U)$. This is a contradiction as an ultrafilter cannot contain $U$ and $X \\ U$.

  This means that $U$ must be open.
]

This result gives us that the convergence properties of the ultrafilters on a set fully capture the topology of the set. Ultrafilters unfortunately are a highly non-constructive tool, however. Everytime we say 'we can extend this set to an ultrafilter' we are making a secret invocation to choice. This is important to keep in mind, as the convergence of sequences may not always fully determine your topology, but in choosing a stronger convergence structure, we lost the constructibility.

#definition(title: "Pushforwards of ultrafilters")[
  Given an ultrafilter $cal(U)$ on $X$ and a map $f : X -> Y$, we say that $f_*[cal(U)]$ is the *pushforward of* $cal(U)$ *along* $f$, where $f_*[cal(U)]$ is the set of subsets $V subset.eq Y$ such that $f^(-1)(V) in cal(U)$.
]

#theorem[
  The pushforward of an ultrafilter is a an ultrafilter.
]
#proof[
  Let $X,Y$ be sets, $f : X -> Y$ be a map, and $cal(U)$ be an ultrafilter on $X$.

  First observe $f^(-1) (emptyset) = emptyset in.not cal(U)$.

  Then if $U,V in f_*[cal(U)]$, we know that $f^(-1) (U), f^(-1) (V) in cal(U)$ which implies that $f^(-1) (U inter V) = f^(-1) (U) inter f^(-1) (V) in cal(U)$. This gives us that $f_*[cal(U)]$ is closed under binary intersection.

  Now assume that $A in f_*[cal(U)]$. If $A subset.eq B$, it follows that the preimage of $A$ is contained in the preimage of $B$. As $f^(-1) (A) in cal(U)$, by upwards-closure of the filter $f^(-1) (B) in cal(U)$. Which gives that $B in f_*[cal(U)]$.

  Now we have the $f_*[cal(U)]$ is a proper filter. If $A, X \\A$ are both contained in $f_*[cal(U)]$, then we have that $f^(-1) (A) in cal(U)$, which must then mean that $X \\ f^(-1) (A)$ is not in $cal(U)$. This gives a contradiction as this exactly is $f^(-1) (X \\ A)$.
]

//Note that if $f$ was an arbitrary relati, we only used that the relation is functional. Given a surjective function, we can equivalently define the pullback filter, but we won't use that here as for an arbitrary function we cannot guarantee that this is an ultrafilter.

#remark[
  The functor $X mapsto {"Ultrafilters on" X}$, with $f mapsto f_*$ is a covariant functor from *Set* to *Set*.
]

Convergent continuity holds in all spaces!
#theorem[
  Let $X, Y$ be topological space. A function $f : X -> Y$ is continuous iff. for every ultrafilter $cal(U)$, $cal(U) arrow.br x$ implies $f_*(cal(U)) arrow.br f(x)$.
]<ultrafilter-convergence-continuity>
#proof[
  Let $X,Y$ be topological spaces. 

  ($=>$): Let $f : X -> Y$ be a continuous map. Let $cal(U)$ be an ultrafilter over $X$ that converges to a point $x in X$.

  Consider $f_*(cal(U))$ and $f(x)$. Let $V^("open") subset.eq Y$ be an open neighbourhood of $f(x)$.

  By continuity of $f$ the preimage $f^(-1) (V)$ is an open neighbourhood of $x$, so it is contained in the ultrafilter $cal(U)$ by its convergence to $x$. Then by the definition of pushforward, the set $V$ must then be in $f_* (cal(U))$. As $V$ was an arbitrary open neighbourhood of $f(x)$, we have that $f_* (cal(U)) arrow.br f(x)$.

  ($arrow.l.double$): Let $f : X -> Y$ be a function such that for every ultrafilter that converges to a point in $X$, the pushforward ultrafilter converges to the image of that point in $Y$.

  Let $V$ be an open set in $Y$, if $"im" f inter V = emptyset$, then we are done as $f^(-1) (V) = emptyset$.

  So assume otherwise that $f^(-1) (V) != emptyset$. Let $cal(U)$ be an ultrafilter that converges to a point $x in f^(-1) (V)$. This implies that $V in f_* (cal(U))$, as the pushforward converges to $f(x)$, then by the definition of the pushforward $f^(-1) (V) in cal(U)$. Then by @ultrafilter-characterisation-of-open-sets, as every ultrafilter that converges to a point in $f^(-1) (V)$ contains $f^(-1) (V)$, we have that $f^(-1) (V)$ is open. Therefore, $f$ is continuous.
]

Now we need another final result connecting ultrafilter convergence to products, and then we can present the proof of @tychonoff.

#theorem[Let $cal(U)$ be an ultrafilter on a product space $X = product_alpha X_alpha$. Then $cal(U)$ converges to a vector $(x_alpha)_alpha$ iff. for every index $alpha$, the pushforward of $cal(U)$ along the projection map $pi_alpha$ converges to $x_alpha$.
]<ultrafilter-product-spaces>
#proof[
  Let $cal(U)$ be an ultrafilter on $X = product_alpha X_alpha$.
  
  ($=>$):
  Let $cal(U)$ converge to a point $(x_alpha)_alpha in X$.
  As $pi_alpha$ is continuous, as all projection maps are, this is a direct result of @ultrafilter-convergence-continuity.

  ($arrow.l.double$): Let $cal(U)$ be an ultrafilter on $X$ such that for every index $alpha$, the pushforward of $cal(U)$ along $pi_alpha$ converges to some point $x_alpha$.

  Now consider the point $(x_alpha)_alpha in X$ and let $V$ be an open neighbourhood of it. Considering the standard basis of the product topology (infinite products of open sets where only finitely many entries are proper open subsets), there exists $product_alpha V_alpha$ be this open set where only finitely many $V_alpha$'s are not equal to $X_alpha$, such that $(x_alpha)_alpha in product_alpha V_alpha subset.eq V$.

  Let ${n_0, n_1, ..., n_r}$ be the finite set of indices such that $V_n_j != X_n_j$, then we can write $product_alpha V_alpha = inter.big_(j=0)^r pi_n_j^(-1) (V_n_j)$. That is we can write the product as a finite intersection of products of sets, where only one entry is a proper open set and all others are entire sets.

  Now if we can show that one such set is in the ultrafilter, by closure under finite intersections and upwards closedness, we will have that $V in cal(U)$.

  Observe that for each $j$, $V_n_j$ is an open neighbourhood of $x_n_j$. This means that by assumption $V_n_j in (pi_n_j)_*[cal(U)]$, and by the definition of pushforwards we have that $pi_n_j^(-1) in cal(U)$, and we are done.
]

#proof[(@tychonoff)
  Let $X_alpha$ be a compact topological space for any $alpha in I$ and let $X = product_alpha X_alpha$ be given the product topology.
   
  Let $cal(X)$ be an ultrafilter on $X$ (UFL: this is the only invocation of a choice principle).

  For each $alpha$, the pushforward along $pi_alpha$ is a is an ultrafilter on a compact space, so by @ultrafilter-characterisation-of-hausdorff-and-compact, it converges to at least one point, call it $x_alpha$.

  Then by @ultrafilter-product-spaces, the ultrafilter $cal(U)$ must then converge to the point $alpha mapsto x_alpha in X$. As $cal(U)$ was an arbitrary ultrafilter, every ultrafilter converges to atleast one point in $X$, so by @ultrafilter-characterisation-of-hausdorff-and-compact again $X$ is compact.
]

== Tietze's extension theorem

== Compactifications: 
The overall goal here is to find something analogous to a completion of a metric space. Given a sufficiently nice space $X$, we wish to find a compact space such that $X$ is a dense subspace of it.

For example, we can consider $(0,1)$. We can then _'compactify'_ this space either into a circle $S^1$ or into $[0,1]$.

=== One-point compactifications:
//==== Alexandroff extension.
#definition(title:"Alexandroff extension")[
  Let $(X, tau)$ be a topological space, we say that the *Alexanderoff extension of $X$* is the space $X union {infinity}$ with the topology $tau'$, where:
  + $tau subset.eq tau'$ 
  + $(X \\ K) union {infinity} in tau'$ where $K$ is closed and compact.

  When $X$ is completely regular and locally compact, we call this the *one-point compactification of $X$*.
]

#theorem[
  One-point compactifications are compact.
]
#proof[
  We can prove this simply. Let $cal(O)$ be an open cover of $X' := X union {infinity}$. There must then be at least one open set $U in cal(O)$ where $infinity in U$. This means that $U$ has the form $(X \\ K) union {infinity}$ for a closed and compact set $K$. We will now attempt to construct a finite subcover $cal(O)' subset.eq cal(O)$.

  We will include $U$, and then consider $X' \\ U$. This is exactly $K$. Now as $K$ is compact, we can consider the open sets in $cal(O)$ that cover $X$ but do not contain $infinity$. Then this is also an open cover of $K$, so by compactness, we can find a finite subcover. Then $U$ along with this finite subcover must then be a finite subcover of $X'$.

  Therefore, $X'$ is compact.
]
//==== Open extension topology

#definition(title: "Open extension topology")[
  Let $X$ be a topological space and let $P$ be some set that is disjoint from $X$. We will define a topology on $X^* = X union P$ where we add all open sets of the from ${X union A : A subset.eq P}$.

  We call this space the *open extension topology*. This is a type of one-point compactification when $P$ is a singleton.
]

#theorem[
  If $|P| < infinity$, then the open extension topology is compact.
]
#proof[
  Let $X$ be a topological space and $P$ be a finite set.

  Let $cal(O)$ be an open cover of $X^* = X union P$. Then we can find a subcollection that covers $P$. As $P$ is finite there is a finite  subcollection that covers $P$, and as every open set that contains a point of $P$ covers all of $X$ this suffices as a finite subcover of the whole space.
]

//==== Comparing topologies on $X union {infinity}$

#ms[TODO]
#theorem[
  The Alexandroff extension is the finest topology that makes $X union {infinity}$ compact.
]

#theorem[
  The open extension topology is the coarsest topology on $X union {infinity}$ that makes it compact.
]


=== Stone–Čech Compactifications


= Filling the gaps: Brouwer's Fixed Point theorem.

The discussion of manifolds and CW-complexes and a rigorous idea of dimension is something we handwaved away in this course. Now, we can fill the gaps a bit by stating and proving Brouwer's Fixed Point theorem (*BFPT*). We will follow #link("https://math.uchicago.edu/~may/REU2017/REUPapers/Katz.pdf") in their proof.

We will start with simplices. Then prove Sperner's Lemma which is a combinatorial result about colouring simplices, and then use it to derive a proof of the (*BFPT*).

#lemma(title: "Sperner's Lemma")[#ms[Todo]]

#theorem(title: "Brouwer's fixed point theorem")[
  For any continuous function $f : D^n -> D^n$, there exists $x in D^n$ such that $f(x) = x$. Where $D^n$ is the $n$-dimensional closed disc in $bb(R)^n$
]

= What ever is a manifold?

== Introducing Manifolds:

#definition(title: "Locally Euclidean Spaces")[A topological space $(M, tau)$ is _$n$-dimensional locally Euclidean_, iff. for every point $p in M$, there exists a _coordinate chart_ $(U, phi)$, where $p in U$ and $U$ is an open set in $M$ and $phi$ is a homeomorphism from $U$ to an open subset of $bb(R)^n$.

For a coordinate chart $(U,phi)$: $U$ is then called a _coordinate domain_ and $phi$ is called a _coordinate map_.
]

#definition(title: "Manifold")[A second countable, Hausdorff, locally Euclidean space of $n$-dimension is called an _$n$-dimensional manifold_.
]

#theorem(title: "Invariance of Domain")[
  #ms[TODO]
]

#theorem(title: "Dimension is invariant")[If $m != n$, a non-empty topological space cannot be an $n$-dimensional manifold and an $m$-dimensional manifold]

#proof[
  #ms[TODO]
]

#remark[Empty set is an $n$-dimensional manifold for all $n$]



#definition(title: "Closed n-dimensional upper halfspace")[
  The set: $ bb(H)^n = {(x_1,x_2,...,x_n) in bb(R)^n : x_n >= 0} $
  endowed with the subspace topology of $bb(R)$'s usual topology is called the _closed $n$-dimensional upper halfspace_.
]

#definition(title: "Manifold with boundary")[A second countable, Hausdorff topological space where for every point $p$ there exists a coordinate chart $(U, phi)$, where $U$ is open and $phi$ is a homeomorphism from $U$ to an open subset of $bb(R)^n$ or $bb(H)^n$ is called a _$n$-dimensional manifold with boundary_. We say a chart $(U, phi)$ is an _interior chart_ if $phi(U) inter partial bb(H)^n = emptyset$, otherwise we say it is a _boundary chart_.

We say that a point $p$ is a _boundary point_ there is a chart ($U, phi)$ with $p in U$, such that $phi(p) in partial bb(H)^n$. If a point $p$ is in the domain of an interior chart, then we say it is an _interior point._ The interior of a manifold $M$, written $"Int"(M)$, is the set of interior points. The boundary of a manifold, written as $partial M$, is the set of boundary points.
]

#remark[
  _Manifold interior_ and _manifold boundaries_ may not correspond with the topological definition of these terms in the subspace topology. The boundary of the closed ball in $bb(R)^2$ as a manifold is the circle, but if we consider this space as a subspace of $bb(R)^3$, the boundary is the whole ball.
]

#theorem[For a manifold with boundary $M$, $"Int"(M)$ and $partial M$ are disjoint.]
#proof[
  #ms[TODO]
]

#theorem[If $M$ is a manifold with boundary, $"Int"(M)$ is open in $M$ and is itself a manfold without boundary.]

#ms[TODO]
#problem[Suppose $f,g : X arrow Y$ be continuous function and $Y$ be Hausdorff. Show that the set ${x in X : f(x) = g(x)}$ is closed in $X$. Give a counterexample with $Y$ not being Hausdorff where this doesn't hold.]
#solution[
  Let $f,g: X arrow Y$ be as given and $Y$ be Hausdorff.

  Consider $A = X \\ {x in X : f(x) = g(x)}$. For $x in A$, $f(x), g(x)$ are distinct points in $Y$, then as $Y$ is Hausdorff, $U_f, U_g$ are two disjoint open sets in $Y$ with $f(x) in U_f, g(x) in U_g$.
  Then consider $f^(-1)(U_f) inter g^(-1)(U_g)$ which is an open set in $X$ that contains $x$ and if there was a $y$ in this set that was not in $A$. Then $f(y) in U_f, g(y) in U_g$ but as $y in.not A, f(y) = g(y)$. So $g(y) in U_f inter U_g$, which is a contradiction as these sets were disjoint. So every point in $A$ has an open set contained in it, so $A$ is open in $X$ so $X \\ A$ is closed.

  Counterexample: Consider $f,g : (bb(R), tau_("cofin.")) arrow.long (bb(R), tau_("indisc."))$
  $ f(x) &= 0 \ 
   g(x) &= sin(x) $
   Both are continuous as they map into the indiscrete topology, and the set $ {x in bb(R) : f(x) = g(x)} = {n pi : n in bb(N)} $ which is infinite thus not closed in the cofinite topology.
]

== CW complexes
#definition(title: "CW complex")[
  A _CW-complex_ is a Hausdorff topological space with subspaces called the _skeleta_, which are given by $X^n$ for $n in {-1, 0, 1, ...}$. $emptyset =  X^(-1) subset.eq X^0 subset.eq ...$ such that the following hold:
  + For each $n >= 0$ the $n$-skeleton $X^n$ is obtained from $X^(n-1)$ by attaching a collection of $n$-cells. That is $X^(n+1) = X^n union.big.sq_phi (union.sq.big_i D_i)$ where $phi : partial (union.sq_i D_i) -> X^n$ is the continuous map used as an adjunction map, where each $D_i$ is a closed $n$-cell (homeomorphic to a closed $n$-ball). We obtain $X^(n+1)$ by attaching a collection of closed $n$-cells by their boundary to $X^n$.
  + *Closure-finite:* The closure of any open cell intersects only finitely many open cells.
  + *Weak topology:* A set $A subset.eq X$ is closed if and only if $A inter "cl"(e)$ is closed in $"cl"(e)$ for every open cell $e$. 
  + $X = union.big_(n=0)^(infinity) X^n$
] 

#definition(title: "Characteristic map")[
  For each cell $e_alpha^n$ the _characteristic map_ is a map $Phi_alpha : D^n -> X$ where:
  + $Phi_alpha$ restricted to the $"Int"(D^n)$ is a homeomorphism onto the open cell $e^n_alpha$.
  + $Phi_alpha (partial D^n) subset.eq X^(n-1)$

  The restriction of $Phi_alpha$ to $partial D^n -> X^(n-1)$ is called the _attachment map_.
]

#theorem[A CW-complex is compact iff. it is finite.]
#ms[proof todo]

#theorem[A connected CW-complex is path-connected.]

#definition(title: "Subcomplex")[$Y subset.eq X$ for a CW-complex $X$ is a _subcomplex_ is a union of cells of $X$ such that if $e in Y$, $"cl"(e) in Y$].

== Classification of 1-manifolds:
#theorem[Every 1-manifold is a CW-complex.]
#ms[This proof is very annoying.]

== Classification of compact 2-manifolds:

We have to define a bunch of things for this to work.
=== Simplical complexes
#definition[
  A set of points $V subset.eq bb(R)^n$ is _affinely independent_ if for $v in V$, $V - v$ is a linearly independent set without $0$.
]

#definition(title: $n"-simplex"$)[Given an affinely independent set of points $v_0, dots, v_n$, the _$n$-simplex_ they span is: 
    $ [v_0, dots, v_n] = {sum_(i = 0)^(n) t_i v_i : t_i >= 0, sum_(i = 0)^(n) t_i = 1} $

    This is the convex hull of this affinely independent set of points.
]

#definition[
  The face of a simplex is the simplex spanned by any non-empty subset of its vertex.
]

Observe that any $n$-simplex is homeomorphic to an $n$-dimensional closed ball.

#definition(title : "Simplical complex")[
  A finite simplical complex $K$ is a finite collection of simplices such that: 
  + Every face of a simplex in $K$ is also in $K$.
  + If $p,q in K$, then $p inter q$ is empty or a common face of $p,q$.

  We have a collection of simplices closed under taking faces that we join at only at faces.
]

The geometric realisation of $K$ is the union of the complex with the subspace topology.

=== Triangulation:

#definition[A _triangulation_ of a topological space $X$ is a pair $(K,h)$ where $K$ is a simplical complex and $h : K -> X$ is a homeomorphism.
]

#theorem(title: "Bing-Moise-Radó")[ Every compact $2$-manifold without boundary admits a triangulation.
]
#ms[Proof was omitted from the course.]

#theorem[Every finite simplical complex has a CW-complex structure.]
#ms[TODO]

#definition[
  Let $K$ be a simplical complex and $p in K$. The link of $p$ is $ "Lk"_K(p) = {q in K : p inter q = emptyset" and " p union q in K} $

  #ms[TODO: what the fuck is a link.]
]

#theorem[
  Let $K$ be a $2$-dimensional simplical complex. Its geometric realisation is a $2$-manifold without boundary iff:
  + Every edge of $K$ lies in exactly two $2$-simplices of $K$.
  + For every vertex $v in K$, the geometric realisation of $"Lk"_K(v)$ is homeomorphic to $S^1$.
]
#ms[TODO proof and a modification can be made for boundary]

=== Euler Characteristics:

#definition(title: "Euler characteristic")[
  Let $X$ be a CW-complex and let $c_k$ be the number of $k$-cells in  $X$. The _Euler characteristic_ of $X$ is:
  $ chi(X) = c_0 - c_1 + c_2 - c_3 + dots $
] 

Polygonal models and things.

#theorem[Compact connected 2-manifold has a polygonal model]
#proof[
  This proof has a really nice geometric idea, so that's all we can talk about. Let $M$ be a compact connected 2-manifold. We can then find a triangulation for it. Then consider the dual graph of it. This is well defined as this is the simplical complex of a $2$-manifold without boundary.

  Then we can take a maximum spanning tree of this dual graph. We then cut around the faces, not making any cuts at edges in the triangulation with edges in the spanning tree.

  This gives a polygonal model if we assign the same edge label for each cut we make.
]

=== Orientability from edge word:

#definition[A connected 2-manifold $S$ is non-orientable if one can embed a Möbius band $M$ into $S$.]

#theorem[A polygonal model for a surface $S$ represents an orientable surface only if every edge label appears exactly twice with opposite sign.]

#definition(title: "Connect sum")[
  #ms[TODO]
]

#lemma[
  $ chi(S_1 \# S_2) = chi(S_1) + chi(S_2) - 2 $
]

=== Subdivision:

Move 1: Edge subdivision 

Move 2: Face subdivision
#ms[homeomorphism from the boundary]

Move 3: Barycentric subdivision

#theorem[Let $M$ be a compact 2-manifold with two finite CW-structures $K_1, K_2$. Then there exists a finite CW-structure $K$ that is a subdivision of both $K_1$ and $K_2$.]

#theorem[Euler characteristic is invariant of CW-structure.]

=== Classification:

#theorem[Every compact connected 2-manifold is homeomorphic to one of the following:
  + $S^2$
  + For $g in bb(Z)^+$, $Sigma_g = T^2 \# T^2 \# dots \# T^2$ $g$ times. 
  + For $k in bb(Z)^+$, $N_k = bb(R)P^2 \# bb(R)P^2 \# dots \# bb(R)P^2$ $k$ times. 
]

= Hatcher's Algebraic Topology

== Chapter 0: Introduction to basic concepts

Homeomorphism is a nice concept while working with continuous maps, homotopy is a slightly different formulation that gives us some of the same strengths while allowing for a more flexible framework to comparing topologies.

#definition(title: "Homotopy")[
  Given two topological spaces $X$ and $Y$. 
  A *homotopy* between two maps $f,g : X -> Y$ is a family of functions ${f_t : X -> Y_(t in [0,1])}$ where $f_0 = f$ and $f_1 = g$ such that the map $F : [0,1] times X -> Y$ given by $F(t, x) = f_t (x)$ is continuous in the product topology.

  If two maps $f,g$ have a homotopy between them, we write $f tilde.eq g$. We can easily confirm that this is an equivalence relation.
]

#definition(title: "Deformation retraction")[
  A *retraction* is a map $r : X -> X$ such that $r^2 = r$. 
  That is, $r$ projects the whole space onto some subspace $"im"(r)$, this image is then called a retract of the space $X$.

  A *deformation retraction* is a homotopy from the identity map on a space to a retraction. Intuitively, it captures the idea of continuously deforming a space into a subspace of itself.
]

#example(title: "Not all retractions can be results of deformation retractions")[

  If we take $X$ to a space that is not path connected, we can find $y,x in X$ such that there is no continuous map $gamma : [0,1] -> X$ that has $gamma (0) = y, gamma (1) = x$.

  We can consider the retraction $r(X) = {x}$.

  If there is a homotopy ${f_t}_t$ from the identity map to $r$. We can consider the following map $gamma (t) = f_t (y)$. This is then a continuous map that gives up a path from $y$ to $x$. This contradicts that $y,x$ have no path between them. So no homotopy can exist between the identity and the constant map in a non-path connected space.
]

We can now consider a construction that is pretty useful.
#definition(title: "Mapping Cylinder")[
  Let $f : X -> Y$ be a continuous function. Then define $M_f$ to be a quotient space on the disjoint union space $(X times [0,1]) union.sq Y$  where we make the identification $(x,1) ~ f(x)$. This is called the *mapping cylinder* of $f$.
]

The intuition behind the mapping cylinder is that we create a space that as we move along $[0,1]$, continuously transforms the space $X$ into $f(X)$, and then glues it to $Y$.


#definition(title:"Homotopy relative to subspaces")[
  Given a homotopy ${f_t : X -> Y }_t$ and a subspace $A subset.eq X$ we say that $f$ is a *homotopy relative* to $A$ if for every $t$ $f_t$ restricted to $A$ is the same map.

  In other words, the homotopy's action on $A$ is independent of $t$. Observe that in a deformation retraction the image of the retraction is this subspace.
]

#definition(title:"Homotopy equivalence")[
  A map $f : X -> Y$ is called a *homotopy equivalence* if there exists another map $g : Y -> X$ such that $g compose f$ has a homotopy to the identity, and $f compose g$ has a homotopy to the identity.

  If there is a homotopy equivalence between two spaces $X,Y$ we write $X tilde.eq Y$.
]

  We can take consider this equivalence in a categorical way. If *Top* is the category of topological spaces with continuous functions as morphisms, we can define the category *hTop* that has the same objects but the morphisms are now homotopy classes of maps. In this new category, homotopy equivalence corresponds to the notion of isomorphism. This gives us the comparision between homeomorphism and homotopy, homotopy can be thought of as a looser definition that bundles together similar but not the same continuous maps in order to give us a more flexible definition of topological similarity.

#definition(title:"Contractible")[
  We say that a space $X$ is *contractible* if it is homotopy equivalent to the one point space. 

  This is equivalent to saying that that the identity map is homotopy equivalent to some constant function. We also then say that the identity map is *nullhomotopic* when such a homotopy to a constant map exists.
]

#example(title: "House with two rooms")[
  #ms[This is a weird example to take notes about.]
]

=== Cell complexes: Revisited

In this section, I want to build up the notion of cell complexes and iteratively defined spaces in a slightly more general way. The main definition revolves around CW-complexes but I will also merge ideas from Hatcher's 'Algebraic Topology' and R. Brown's 'Topology and groupoids.'


#lemma[The closure of open cells in a CW-complex are the closed cells.]

#theorem[A CW-complex is compact iff. it is finite.]


=== Homotopy Extension Property:

#definition(title:"Homotopy extension property")[
  Let $f_0 : X -> Y$ be a map and $f_t : A -> Y$ be a homotopy to $f_0|_A$ for a subspace $A subset X$.

  If this $(X,A)$ is a pair such that any homotopy of this form on $A$ can always be extended to a homotopy $f_t : X -> Y$, then we say $(X,A)$ has the *homotopy extension property*.

  Therefore, we say that $(X,A)$ has the homotopy extension property if every pair of maps $X times {0} -> Y$ and $A times [0,1] -> Y$ that agree on $A times {0}$ can be extended to a map on $X times [0,1] -> Y$.
]
// https://q.uiver.app/#r=typst&q=WzAsNSxbMCwwLCJBIHRpbWVzIHswfSJdLFswLDIsIlggdGltZXMgezB9Il0sWzIsMCwiQSB0aW1lcyBbMCwxXSJdLFsyLDIsIlkiXSxbMSwxLCJYIHRpbWVzIFswLDFdIl0sWzAsMSwiaW90YSIsMl0sWzAsMiwiaW90YSJdLFsxLDMsImZfMCIsMl0sWzIsMywiZl90Il0sWzQsMywiZXhpc3RzIGYiLDIseyJzdHlsZSI6eyJib2R5Ijp7Im5hbWUiOiJkYXNoZWQifX19XSxbMiw0LCJpb3RhIiwyXSxbMSw0LCJpb3RhIiwxXV0=
#align(center, diagram({
	node((1, 4), [$A times {0}$])
	node((1, 6), [$X times {0}$])
	node((3, 4), [$A times [0,1]$])
	node((3, 6), [$Y$])
	node((2, 5), [$X times [0,1]$])
	edge((1, 4), (1, 6), [$iota$], label-side: right, "->")
	edge((1, 4), (3, 4), [$iota$], label-side: left, "->")
	edge((1, 6), (3, 6), [$f_0$], label-side: right, "->")
	edge((3, 4), (3, 6), [$f_t$], label-side: left, "->")
	edge((2, 5), (3, 6), [$exists f$], label-side: right, "-->")
	edge((3, 4), (2, 5), [$iota$], label-side: right, "->")
	edge((1, 6), (2, 5), [$iota$], label-side: center, "->")
}))

This can be illustrated in this commutative diagram. Where the non-dotted lines commuting implies the existence of $f$ which makes this diagram commute.

#lemma[A pair $(X,A)$ has homotopy extension property if and only if $(X times {0}) union (A times [0,1])$ is a retract of $X times [0,1]$.]

#proof[

($arrow.double$):
  Let $(X,A)$ have the homotopy extension property. Let $Y = (X times {0}) union (A times interval)$ and let $f_0$ be the identity map $(X times {0}) union (A times interval) -> (X times {0}) union (A times interval)$. This then extends to a homotopy $f_t : X times interval -> (X times {0}) union (A times interval)$. This is precisely a retraction map, as it extends the identity on the retract so it fixes it.

($arrow.double.l$): Let $(X times {0}) union (A times interval)$ be a retract of $X times interval$.
#ms[TODO]
]

