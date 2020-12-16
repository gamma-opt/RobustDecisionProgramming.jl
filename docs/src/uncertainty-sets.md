# Uncertainty Sets
## Continuous Uncertainty Set
Given two finite sets of discrete probabilities $𝐩$ and $𝐪$ over states $I,$ we define the **difference** between the distributions as

$$𝐝=𝐪-𝐩.$$

As a consequence from the properties of discrete probabilities, the **sum of the differences is zero**

$$𝐝⋅𝟏(k)=(𝐩-𝐪)⋅𝟏(k)=𝐩⋅𝟏(k)-𝐪⋅𝟏(k)=0.$$

We can also obtain the bounds for the values of the differences by taking the minimum and maximum over the set of all possible differences. Since the value of probabilities are between zero and one, we have

$$-1≤𝐝≤1.$$

We can reformulate the difference equation into a form

$$𝐪=𝐩+𝐝$$

The **difference set** consists of all possible difference vectors $𝐝$ that yield a valid distribution when added to the distribution $𝐩.$ Formally,

$$𝐃_𝐩=\{𝐝∣-1≤𝐝≤1,\, 𝐝⋅𝟏(k)=0,\, 𝐩+𝐝≥0\}.$$

Next, we define an **ambiguity set** as a subset of differences set

$$\bar{Δ}_𝐩 = \{𝐝∈𝐃_𝐩∣\mathcal{C}(𝐝)\}$$

The constraint (boolean function) $\mathcal{C}$ limits the elements' magnitude. We need to choose the constraint $\mathcal{C}$ such that the resulting set is convex, which makes optimization possible. We discuss concrete choices that yield polyhedral sets later.

Finally, we define the **continuous uncertainty set** that consists of all distributions within difference $𝐝∈\bar{Δ}$ from $𝐩$

$$\bar{𝐐}=\{𝐩+𝐝∣𝐝∈\bar{Δ}\}.$$

However, we cannot use a continuous uncertainty set directly for formulating the mathematical model. We must discretize it first.


## Discretization
The minimum expected value is

$$\min_{𝐪∈\bar{𝐐}} 𝐪⋅𝐮 = \min_{𝐝∈\bar{Δ}} (𝐩+𝐝)⋅𝐮 = 𝐩⋅𝐮 + \min_{𝐝∈\bar{Δ}} 𝐝⋅𝐮.$$

To formulate the minimization problem as a discrete optimization formulation, we need to reduce $\bar{Δ}$ to a discrete set of possible difference vectors $Δ$ such that with known $𝐮$ we have $𝐝^{∗}∈Δ$ where

$$𝐝^{∗}=\argmin_{𝐝∈\bar{Δ}} 𝐝⋅𝐮.$$

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

$𝐝^{∗}(I^{′})$ assuming order $u_{i_1}≥u_{i_2}≥...≥u_{i_k}$ where $I^{′}=\{i_1,i_2,...,i_k\}$

$$Δ=\{𝐝^{∗}(I^{′})∣I^{′}∈\mathcal{P}(I)\}$$

The discrete set of all possible minimizing distributions

$$𝐐=\{𝐩+𝐝∣𝐝∈Δ\}$$


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

$$𝐝^{∗}=(d_1,d_2,...,d_k)$$

Set of all difference vectors


## Probability Intervals
Means that $\mathcal{C}(𝐝)$ is equivalent to

$$0≤𝐝^{-} ≤ 𝐝 ≤ 𝐝^{+}≤1$$

where $𝐝^{-}$ and $𝐝^{+}$ are parameters
