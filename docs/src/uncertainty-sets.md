# Uncertainty Sets
## Continuous Uncertainty Set
Given two finite sets of discrete probabilities $𝐩$ and $𝐪$ over states $I,$ we define the **difference** between the distributions as

$$𝐝=𝐪-𝐩.$$

As a consequence of the properties of discrete probabilities, the **sum of the differences is zero**

$$𝐝⋅𝟏(k)=(𝐩-𝐪)⋅𝟏(k)=𝐩⋅𝟏(k)-𝐪⋅𝟏(k)=0.$$

We can also obtain the bounds for the differences' values by taking the minimum and maximum over the set of all possible differences. Since the value of probabilities are between zero and one, we have

$$-1≤𝐝≤1.$$

We can reformulate the difference equation into a form

$$𝐪=𝐩+𝐝$$

The **difference set** consists of all possible difference vectors $𝐝$ that yield a valid distribution when added to the distribution $𝐩.$ Formally,

$$𝐃_𝐩=\{𝐝∣-1≤𝐝≤1,\, 𝐝⋅𝟏(k)=0,\, 𝐩+𝐝≥0\}.$$

Next, we define an **ambiguity set** as a subset of differences set

$$\bar{Δ}_𝐩 = \{𝐝∈𝐃_𝐩∣\mathcal{C}(𝐝)\}$$

The constraint (boolean function) $\mathcal{C}$ limits the difference's magnitude. We need to choose the constraint $\mathcal{C}$ such that the resulting set is convex, which makes optimization possible. We discuss concrete choices that yield polyhedral sets later.

Finally, we define the **continuous uncertainty set** that consists of all distributions within difference $𝐝∈\bar{Δ}_𝐩$ from $𝐩$

$$\bar{𝐐}_𝐩=\{𝐩+𝐝∣𝐝∈\bar{Δ}_𝐩\}.$$

However, we cannot use a continuous uncertainty set directly for formulating the mathematical model. We must obtain a discrete subset of the continuous uncertainty set to linearize the minimum expected value in the [Best Worst-Case Expected Value](@ref) page.


## Discretization
We can define the minimum expected value over the continuous uncertainty set as

$$\min_{𝐪∈\bar{𝐐}_𝐩} 𝔼(𝐪, 𝐮) = \min_{𝐝∈\bar{Δ}_𝐩} (𝐩+𝐝)⋅𝐮 = 𝐩⋅𝐮 + \min_{𝐝∈\bar{Δ}_𝐩} 𝐝⋅𝐮.$$

We can express the minimizing difference as

$$𝐝^{∗}(𝐮)=\argmin_{𝐝∈\bar{Δ}_𝐩} 𝐝⋅𝐮.$$

Now, we can obtain a discrete ambiguity set

$$Δ_𝐩=\{𝐝^{∗}(𝐮)∣∀𝐮\}.$$

The discrete set of all possible minimizing distributions

$$𝐐_𝐩=\{𝐩+𝐝∣𝐝∈Δ_𝐩\}.$$


## Polyhedral Uncertainty Set
We have the minimization problem over polyhedral ambiguity set with the objective

$$\argmin_{(d_1,...,d_k)∈ℝ^k} \, d_1⋅u_1 +d_2⋅u_2 +...+d_k⋅u_k.$$

We have constraints for the difference sum, difference intervals and Wasserstein distance. The difference sum constraint is

$$d_1+d_2+...+d_k=0.$$

The difference interval constraints are

$$d_i^{-} ≤ d_i ≤ d_i^{+}, \quad ∀i∈\{1,...,k\}.$$

The parameters are **lower bound** $-p_i≤d_i^{-}≤0$ and **upper bound** $0≤d_i^{+}≤1-p_i$ for all $i∈\{1,...,k\}.$

The Wasserstein distance constraint is

$$\|𝐝\|_1=|d_1|+|d_2|+...+|d_k|≤2ϵ.$$

The **radius** parameter is $0≤ϵ≤1.$


## Cross-Assignment
Given an ordering of vector $𝐮$, such as $u_1≤u_2≤...≤u_k$ with corresponding vector of indices $I^{′}=(1,2,...,k),$ we can find the minimizing difference vector $𝐝^{∗}$ over polyhedral ambiguity set using **cross-assignment**.

The following sections show that we always have difference vector that evaluates to less or equal to zero. After that, we state the rules for finding the minimizing difference vector.

### Binary cross-assignment
Let $u_1≤u_2$ and $d_1+d_2=0$ where $d_1≥0$ and $d_2≤0$. Then we have

$$\begin{aligned}
u_1⋅d_1 + u_2⋅d_2 &≤ 0 \\
u_1⋅d_1 &≤ u_2⋅(-d_2) \\
u_1⋅d_1 &≤ u_2⋅d_1 \\
u_1 &≤ u_2.
\end{aligned}$$

### $k$-ary cross-assignment
Let $u_1≤u_2≤...≤u_k$ and $d_1+d_2+...+d_k=0$.

Then, for all $j∈\{1,...,k-1\}$ such that $d_1,...,d_j≥0$ and $d_{j+1},...,d_k≤0$ we have

$$\begin{aligned}
u_1⋅d_1 + ... + u_k⋅d_k &≤ u_j⋅d_1 + ... + u_j⋅d_j + u_{j+1}⋅d_{j+1} + ... + u_{j+1}⋅d_{k} \\
&= u_j⋅(d_1+...+d_j) + u_{j+1}⋅(d_{j+1}+...+d_k) \\
& ≤ 0.
\end{aligned}$$

We obtain the last step from binary cross-assignment.

### Minimizing cross-assignment
Let $u_1≤u_2$ and $d_1+d_2=d_1^{′}+d_2^{′}.$ Then

$$u_1⋅d_1+u_2⋅d_2≤u_1⋅d_1^{′}+u_2⋅d_2^{′}$$

---

Let $d_1,d_2,d_1^{′},d_2^{′},d^{′′}≤0.$ Then

$$\begin{aligned}
u_1⋅d_1+u_2⋅d_2 &= u_1⋅d_1+u_2⋅(d_2^{′}+d^{′′}) \\
&= u_1⋅d_1+u_2⋅d^{′′}+u_2⋅d_2^{′} \\
&≤ u_1⋅d_1+u_1⋅d^{′′}+u_2⋅d_2^{′} \\
&= u_1⋅(d_1+d^{′′})+u_2⋅d_2^{′} \\
&= u_1⋅d_1^{′}+u_2⋅d_2^{′},
\end{aligned}$$

where $d_1=d_1^{′}-d^{′′}$ and $d_2=d_2^{′}+d^{′′}.$

---

Let $d_1,d_2,d_1^{′},d_2^{′},d^{′′}≥0.$ Then

$$\begin{aligned}
u_1⋅d_1+u_2⋅d_2 &= u_1⋅(d_1^{′}+d^{′′})+u_2⋅d_2 \\
&= u_1⋅d_1^{′}+u_1⋅d^{′′}+u_2⋅d_2 \\
&≤ u_1⋅d_1^{′}+u_2⋅d^{′′}+u_2⋅d_2 \\
&= u_1⋅d_1^{′}+u_2⋅(d_2+d^{′′}) \\
&= u_1⋅d_1^{′}+u_2⋅d_2^{′},
\end{aligned}$$

where $d_1=d_1^{′}+d^{′′}$ and $d_2=d_2^{′}-d^{′′}.$


## All Cross-assignments
We can construct the set of all minimizing difference vectors by using cross-assignment over all possible orderings of vector $𝐮.$ We can generate all possible ordering of $𝐮$ by generating all permutations of $I.$ Let $\mathcal{P}(I)$ define the set of all permutations of set $I.$

$$Δ_𝐩=\{𝐝^{∗}(𝐮)∣∀𝐮\}=\{𝐝^{∗}(I^{′})∣I^{′}∈\mathcal{P}(I)\}.$$

There are a finite amount of permutations $|\mathcal{P}(I)|=k!$ which implies $|Δ_𝐩|≤k!.$
