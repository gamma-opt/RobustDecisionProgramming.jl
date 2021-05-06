# [Polyhedral Ambiguity Set](@id polyhedral-ambiguity-set)
## Cross-Assignment
The minimization problem over a polyhedral ambiguity set $(l=1)$ is

$$\argmin_{(d_1,...,d_k)∈ℝ^k} \, d_1⋅u_1 +d_2⋅u_2 +...+d_k⋅u_k$$

$$d_i^{-} ≤ d_i ≤ d_i^{+}, \quad ∀i∈\{1,...,k\}$$

$$d_1+d_2+...+d_k=0$$

$$\|𝐝\|_1=|d_1|+|d_2|+...+|d_k|≤2ϵ.$$

The parameters are lower bound $d_i^{-}∈[-p_i,0]$ and upper bound $d_i^{+}∈[0,1-p_i]$ for all $i∈\{1,...,k\},$ the radius parameter is $ϵ∈[0,1]$ and an ordering for the utilities $𝐮=(u_1,...,u_k).$

We define **cross-assignment** for ordering $u_1≤u_2≤...≤u_k$ as an assignment of differences to **positive differences** $d_1,...,d_j≥0$ and **negative differences** $d_{j+1},...,d_k≤0$ where $j∈\{1,...,k-1\}$ such that they satisfy the constraints. An **optimal cross-assignment** finds values for the positive and negative differences that minimize the objective.

## Proof of Negativity
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

## Proof of Minimum
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

## Optimal Cross-Assignment
Proof of minimum cross-assignment

## All Optimal Cross-assignments
The discrete polyhedral uncertainty set is the set of optimal cross-assignments over all utility orderings.

$$𝐃_𝐩=\{𝐝^{∗}(𝐮)∣𝐮∈ℝ^k\}=\{𝐝^{∗}(𝐮(I^{′}))∣I^{′}∈\mathcal{P}(I)\}.$$

We generate all possible utility ordering of by generating all permutations of $I$ denoted as $\mathcal{P}(I),$ which has finite size $|\mathcal{P}(I)|=k!.$ For example, utility ordering $I^{′}=(1,2,...,k)∈\mathcal{P}(I)$ corresponds to ordering $u_1≤u_2≤...≤u_k.$

## Number of Optimal Cross-assignments
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

$$|𝐃_𝐩|≤\max_{I_{+},I_{0},I_{-}} \frac{|\mathcal{P}(I)|}{|\mathcal{P}(I_{+})||\mathcal{P}(I_{0})||\mathcal{P}(I_{-})|}≤|\mathcal{P}(I)|.$$

Note that the empty set has one permutation $|\mathcal{P}(∅)|=1.$
