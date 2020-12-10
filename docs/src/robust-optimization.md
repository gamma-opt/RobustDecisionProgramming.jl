# Robust Optimization
## Introduction
Focus on distributionally robust over discrete probability distributions. Best worst-case analysis.

We denote scalar using lower-case math italics, vectors using lower-case boldface symbols, and sets using upper-case symbols. All non-matrix algebra operations on vectors are element-wise.

We denote vector constructors using $(element∣condition)$ and set constructors using $\{element∣condition\}.$

## Discrete Probabilities
We denote a finite set of discrete probabilities for states $I=\{1,2,...,k\}$ as

$$𝐩=(p_1,p_2,...,p_k),$$

such that $𝐩≥0$ and $𝐩⋅𝟏(k)=1$ where $𝟏(k)=(1)^k$ is a vector of $k$ ones.


## Difference
Given two finite sets of discrete probabilities $𝐩$ and $𝐪$ over states $I,$ we define the difference between the distributions as

$$𝐝=𝐩-𝐪.$$

From the properties of discrete probabilities, we have

$$𝐝⋅𝟏(k)=(𝐩-𝐪)⋅𝟏(k)=𝐩⋅𝟏(k)-𝐪⋅𝟏(k)=0.$$

We obtain the bounds for the values of the differences by taking the minimum and maximum over the set of all possible differences. Since the value of probabilities are between zero and one, we have

$$-1≤𝐝≤1.$$


## Uncertainty Sets
We can reformulate the difference equation such when difference $𝐝$ added to the original distribution $𝐩$ yield the new distribution $𝐪$ as

$$𝐪=𝐩+𝐝$$

The **difference set** consists of all possible difference vectors that yield a valid distribution when added to the original distribution

$$𝐃=\{𝐝∣-1≤𝐝≤1,\, 𝐝⋅𝟏(k)=0,\, 𝐩+𝐝≥0\}.$$

We can define a boolean function to limit the magnitude of the difference vectors as

$$\mathcal{C}:𝐃→\{⊥,⊤\}.$$

We filter the difference set using the boolean function as a constraint into an **ambiguity set**

$$Δ = \{d∈𝐃∣\mathcal{C}(𝐝)\}$$

The function $\mathcal{C}$ is a design choice. We discuss concrete choices of the function later.

Properties of $\mathcal{C}$, convexity of $Δ$, polyhedral sets.

The **uncertainty set** consists of all distributions  within difference $𝐝∈Δ$ from $𝐩$ as

$$𝐐=\{𝐩+𝐝∣𝐝∈Δ\}.$$


## Minimum Expected Value
We define a vector of real numbers associated with states $I$ as

$$𝐮=(u_1,u_2,...,u_k)∈ℝ^k$$

Then, we define the minimum expected value as

$$\min_{𝐪∈𝐐} 𝐪⋅𝐮 = \min_{𝐝∈Δ} (𝐩+𝐝)⋅𝐮 = 𝐩⋅𝐮 + \min_{𝐝∈Δ} 𝐝⋅𝐮.$$

To formulate the minimization problem as a discrete optimization formulation, we need to reduce $Δ$ to a discrete set of possible difference vectors $Δ^{-}$ such that $𝐝^{-}∈Δ^{-}$ where

$$𝐝^{-}=\argmin_{𝐝∈Δ} 𝐝⋅𝐮.$$

We define the following lemma for solving the problem:

---

Lemma: If $u_1>u_2$ and $d_1<d_2≤0,$ then:

$$\begin{aligned}
u_1 d_1 + u_2 d_2 &= u_1 d_1^{′}+ u_1 d_1^{′′}+u_2 d_2 \\
&< u_1 d_1^{′} + u_2 d_1^{′′} + u_2 d_2 \\
&= u_1 d_1^{′} + u_2 (d_1^{′′} + d_2)
\end{aligned}$$

where $d_1=d_1^{′}+d_1^{′′}$ such that $d_1^{′}>d_1$ and $d_1^{′′}>d_1.$

Assign smallest $d$ to highest $u$ and vice versa.

---

Generate solution for each permutation

$$u_{1}≥u_{2}≥...≥u_{k}$$

If we do not have any information about the ordering of $𝐮,$ we can generate all permutations to cover all possible orderings

Let $\mathcal{P}(I)$ define the set of all permutations of set $I.$

$𝐝^{-}(I^{′})$ assuming order $u_{i_1}≥u_{i_2}≥...≥u_{i_k}$ where $I^{′}=\{i_1,i_2,...,i_k\}$

$$Δ^{-}=\{𝐝^{-}(I^{′})∣I^{′}∈\mathcal{P}(I)\}$$


## Maximin over Uncertainty Set
The discrete set of all possible minimizing distributions

$$𝐐^{-}=\{𝐩+𝐝∣𝐝∈Δ^{-}\}$$

Maximize the minimum expected value

$$\max_{z∈Z} \min_{𝐪∈𝐐^{-}(z)} 𝐪⋅𝐮(z)$$

Now we can linearize the objective as

$$\max_{z∈Z} x$$

$$x≤𝐪⋅𝐮(z),\quad ∀𝐪∈𝐐^{-}(z)$$


## Maximin over Product of Uncertainty Sets

$$\max_{z∈Z} x$$

$$x ≤ \min_{(𝐪_1,...,𝐪_m)∈𝐐^{×}(z)} ∑_{i=1}^m 𝐪_i⋅𝐮_i(z),\quad 𝐐^{×}(z)=∏_{i=1}^m 𝐐_i^{-}(z)$$

Linearized

$$x ≤ ∑_{i=1}^m x_i$$

$$x_i ≤ 𝐪_i⋅𝐮_i(z),\quad ∀i∈\{1,...,m\}$$


## Wasserstein Distance
Mean that $\mathcal{C}(𝐝)$ is equivalent to

$$\|𝐝\|_1≤2ϵ$$

where $0≤ϵ≤1$ is a parameter

---

$$\begin{aligned}
\min &\, d_1 u_1 +d_2 u_2 +...+d_k u_k \\
& d_1+d_2+...+d_k=0 \\
& |d_1|+|d_2|+...+|d_k|≤2ϵ \\
& p_i + d_i ≥ 0,\quad ∀i∈\{1,2,...,k\} \\
& d_i∈ℝ,\quad ∀i∈\{1,2,...,k\}
\end{aligned}$$

---

Solution. Let $u_1≥u_2≥...≥u_k$ and $k>1.$

$$ϵ^{′}=\min\{ϵ,1-p_k\}$$

Decrease the probability of best outcomes:

$$\begin{aligned}
m_1 &= ϵ^{′} \\
d_1 &= -\min\{m_1,p_1\} \\
m_2 &= m_1 + d_1 \\
d_2 &= -\min\{m_2,p_2\},\quad m_2 > 0 \\
&⋮
\end{aligned}$$

Increase the probability of worst outcomes.

$$d_k=ϵ^{′}$$

Difference vector

$$𝐝^{-}=(d_1,d_2,...,d_k)$$

Set of all difference vectors


## Intervals
Means that $\mathcal{C}(𝐝)$ is equivalent to

$$0≤𝐝^{-} ≤ 𝐝 ≤ 𝐝^{+}≤1$$

where $𝐝^{-}$ and $𝐝^{+}$ are parameters
