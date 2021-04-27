# [Uncertainty Set](@id uncertainty-set)
## Overview

## Continuous Uncertainty Set
Given two finite sets of discrete probabilities, the **pivot** $𝐩$ and **deviated** $𝐪$ over states $I.$ We define the **difference** between the distributions as

$$𝐝=𝐪-𝐩.$$

Alternatively, we can describe the deviated distribution as the sum of pivot distribution and difference

$$𝐪=𝐩+𝐝.$$

Then, we define the **continuous uncertainty set** that consists of all deviated distributions around the pivot distribution

$$\bar{𝐐}_𝐩=\{𝐩+𝐝∣𝐝∈𝐃_𝐩\},$$

where $𝐃_𝐩$ is an ambiguity set for the pivot $𝐩.$


## Ambiguity Set
From the properties of discrete probabilities, we have the lower and upper bounds

$$0≤𝐪≤1$$

$$0≤𝐩+𝐝≤1$$

$$-𝐩≤𝐝≤1-𝐩.$$

We define the **lower bounds** $𝐝^{-}$ and **upper bounds** $𝐝^{+}$ as parameters such that $𝐝^{-}≤𝐝≤𝐝^{+}$ where $-𝐩≤𝐝^{-}≤0$ and $0≤𝐝^{+}≤1-𝐩.$ These bound also quarantee that $𝐩$ belongs to the ambiguity set $𝐃_𝐩.$

---

As a consequence of the properties of discrete probabilities, we obtain the **conservation of probability mass** as

$$𝐝⋅𝟏(k)=(𝐩-𝐪)⋅𝟏(k)=𝐩⋅𝟏(k)-𝐪⋅𝟏(k)=0.$$

---

Additionally, we can limit the magnitude of the differences with $l∈ℕ$ norm

$$\|𝐝\|_l≤2ϵ,$$

with a **radius** parameter $0≤ϵ≤1.$

---

The **ambiguity set** is the set of all difference vectors that satisfy the given conditions

$$𝐃_𝐩=\{𝐝∈[𝐝^{-},𝐝^{+}]∣ 𝐝⋅𝟏(k)=0,\, \|𝐝\|_l≤2ϵ\}.$$

The ambiguity set is convex, which makes optimization possible.

---

Proof of convexity: Let $𝐝_1,𝐝_2∈𝐃_𝐩,$ we must show that $𝐝∈𝐃_𝐩$ where $𝐝=(1-λ)𝐝_1+λ𝐝_2$ with $λ∈[0,1].$

1) Minimum: $𝐝=(1-λ)𝐝_1+λ𝐝_2≥(1-λ)𝐝^{-}+λ𝐝^{-}=𝐝^{-}.$
2) Maximum: $𝐝=(1-λ)𝐝_1+λ𝐝_2≤(1-λ)𝐝^{+}+λ𝐝^{+}=𝐝^{+}.$
3) Conservation of probability mass: $𝐝⋅𝟏(k)=(1-λ)𝐝_1⋅𝟏(k)+λ𝐝_2⋅𝟏(k)=0$
4) Limit for magnitude (Triangle inequality): $\|𝐝\|_l≤(1-λ)\|𝐝_1\|_l+λ\|𝐝_2\|_l≤2ϵ$

---

Decreasing $l$ makes the model more pessimistic. Using $l=1$ we receive a **polyhedral ambiguity set**. By setting $ϵ=1$ we can make the magnitude constraint inactive.


## Discrete Uncertainty Set
We cannot use a continuous uncertainty set directly for formulating the mathematical model. We must obtain a discrete subset of the continuous uncertainty set to linearize the minimum expected value in the [Best Worst-Case Expected Value](@ref best-worst-case-expected-value) page.

We can define the minimum expected value over the continuous uncertainty set with utilities $𝐮$ as

$$\min_{𝐪∈\bar{𝐐}_𝐩} 𝔼(𝐪, 𝐮) = \min_{𝐝∈𝐃_𝐩} (𝐩+𝐝)⋅𝐮 = 𝐩⋅𝐮 + \min_{𝐝∈𝐃_𝐩} 𝐝⋅𝐮.$$

We can express the minimizing difference as

$$𝐝^{∗}(𝐮)=\argmin_{𝐝∈𝐃_𝐩} 𝐝⋅𝐮.$$

Now, we can obtain a discrete ambiguity set

$$Δ_𝐩=\{𝐝^{∗}(𝐮)∣𝐮∈ℝ^k\}.$$

The discrete set of all possible minimizing distributions

$$𝐐_𝐩=\{𝐩+𝐝∣𝐝∈Δ_𝐩\}.$$


## Discrete Polyhedral Uncertainty Set
### Cross-Assignment
The minimization problem over a polyhedral ambiguity set $(l=1)$ is

$$\argmin_{(d_1,...,d_k)∈ℝ^k} \, d_1⋅u_1 +d_2⋅u_2 +...+d_k⋅u_k$$

$$d_i^{-} ≤ d_i ≤ d_i^{+}, \quad ∀i∈\{1,...,k\}$$

$$d_1+d_2+...+d_k=0$$

$$\|𝐝\|_1=|d_1|+|d_2|+...+|d_k|≤2ϵ.$$

The parameters are lower bound $d_i^{-}∈[-p_i,0]$ and upper bound $d_i^{+}∈[0,1-p_i]$ for all $i∈\{1,...,k\},$ the radius parameter is $ϵ∈[0,1]$ and an ordering for the utilities $𝐮=(u_1,...,u_k).$

We define **cross-assignment** for ordering $u_1≤u_2≤...≤u_k$ as an assignment of differences to **positive differences** $d_1,...,d_j≥0$ and **negative differences** $d_{j+1},...,d_k≤0$ where $j∈\{1,...,k-1\}$ such that they satisfy the constraints. An **optimal cross-assignment** finds values for the positive and negative differences that minimize the objective.

### Proof of Negativity
The objective value of cross-assignment is always negative or zero.

---

For a cross-assignment with $k=2$ and $j=1$ we have:

$$\begin{aligned}
u_1⋅d_1 + u_2⋅d_2 &≤ 0 \\
u_1⋅d_1 &≤ u_2⋅(-d_2) \\
u_1⋅d_1 &≤ u_2⋅d_1 \\
u_1 &≤ u_2.
\end{aligned}$$

---

For cross-assignment with $k>2$ and for all $j∈\{1,...,k-1\}$ we have:

$$\begin{aligned}
u_1⋅d_1 + ... + u_k⋅d_k &≤ u_j⋅d_1 + ... + u_j⋅d_j + u_{j+1}⋅d_{j+1} + ... + u_{j+1}⋅d_{k} \\
&= u_j⋅(d_1+...+d_j) + u_{j+1}⋅(d_{j+1}+...+d_k) \\
& ≤ 0.
\end{aligned}$$

We obtain the last step from the result for $k=2.$

### Proof of Minimum
The condition that some cross-assignment is less or equal to another cross-assignment.

Let $u_1≤u_2$ and $d_1+d_2=d_1^{′}+d_2^{′}$ where $d_1=d_1^{′}+d^{′′}$ and $d_2=d_2^{′}-d^{′′}$ with $d^{′′}≥0.$ Then, we have:

$$\begin{aligned}
u_1⋅d_1+u_2⋅d_2 &= u_1⋅(d_1^{′}+d^{′′})+u_2⋅d_2 \\
&= u_1⋅d_1^{′}+u_1⋅d^{′′}+u_2⋅d_2 \\
&≤ u_1⋅d_1^{′}+u_2⋅d^{′′}+u_2⋅d_2 \\
&= u_1⋅d_1^{′}+u_2⋅(d_2+d^{′′}) \\
&= u_1⋅d_1^{′}+u_2⋅d_2^{′}.
\end{aligned}$$

It satisfies the constraint

$$|d_1|+|d_2|=|d_1^{′}+d^{′′}|+|d_2^{′}-d^{′′}|=|d_1^{′}|+|d_2^{′}|$$

If $d_1,d_1^{′}≥0 ∧ d_2,d_2^{′}≤0$ or $d_1,d_1^{′},d_2,d_2^{′}≥0$ or $d_1,d_1^{′},d_2,d_2^{′}≤0.$

### Optimal Cross-Assignment
Proof of minimum cross-assignment

### All Optimal Cross-assignments
The discrete polyhedral uncertainty set is the set of optimal cross-assignments over all utility orderings.

$$Δ_𝐩=\{𝐝^{∗}(𝐮)∣𝐮∈ℝ^k\}=\{𝐝^{∗}(𝐮(I^{′}))∣I^{′}∈\mathcal{P}(I)\}.$$

We generate all possible utility ordering of by generating all permutations of $I$ denoted as $\mathcal{P}(I),$ which has finite size $|\mathcal{P}(I)|=k!.$ For example, utility ordering $I^{′}=(1,2,...,k)∈\mathcal{P}(I)$ corresponds to ordering $u_1≤u_2≤...≤u_k.$

### Number of Optimal Cross-assignments
We can express an optimal cross-assignment as a partition $(I_{+},i_{+},I_{0},i_{-},I_{-})$ of indices $I^{′}∈\mathcal{P}(I)$ where we have subsets $I_{+},I_{0},I_{-}⊆I^{′},$ elements $i_{+},i_{-}∈I^{′}$ and the values of the optimal cross-assignment are

$$\begin{aligned}
& d_i=d_i^{+},\quad ∀i∈I_{+} \\
& 0≤d_{i_{+}}≤d_{i_{+}}^{+} \\
& d_i=0,\quad ∀i∈I_{0} \\
& d_{i_{-}}^{-}≤d_{i_{-}}≤0 \\
& d_i=d_i^{-},\quad ∀i∈I_{-} \\
\end{aligned}$$

Since the internal utility order in the subsets does not change the solution, all partitions in the set

$$\{(I_{+}^{′},i_{+},I_{0}^{′},i_{-},I_{-}^{′})∣ I_{+}^{′}∈\mathcal{P}(I_{+}), I_{0}^{′}∈\mathcal{P}(I_{0}), I_{-}^{′}∈\mathcal{P}(I_{-})\}$$

have the same optimal cross assignment. Therefore, the bound for the size of the uncertainty set is

$$|Δ_𝐩|≤\max_{I_{+},I_{0},I_{-}} \frac{|\mathcal{P}(I)|}{|\mathcal{P}(I_{+})||\mathcal{P}(I_{0})||\mathcal{P}(I_{-})|}≤|\mathcal{P}(I)|.$$

Note that the empty set has one permutation $|\mathcal{P}(∅)|=1.$
