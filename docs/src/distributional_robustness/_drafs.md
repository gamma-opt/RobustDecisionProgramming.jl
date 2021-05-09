# Drafts
For example, we applied robust decision programming to the [N-monitoring](https://gamma-opt.github.io/DecisionProgramming.jl/dev/examples/n-monitoring/) example from decision programming such that we made the failure node robust.

Then, we define the **continuous uncertainty set** that consists of all deviated distributions around the pivot distribution

$$\bar{𝐐}_𝐩=\{𝐩+𝐝∣𝐝∈\bar{𝐃}_𝐩\}.$$

An **uncertainty set** $𝐐_{𝐩}$ is a finite subset of $\bar{𝐐}_{𝐩}$ such that it contains all minimizing probabilities for the **maximin expected value** objective.

---

We begin by denoting the continuous uncertainty set as

$$\bar{𝐐}_𝐩=\{𝐩+𝐝∣𝐝∈\bar{𝐃}_𝐩\}.$$

We can define the minimum expected value over the continuous uncertainty set as

$$\min_{𝐪∈\bar{𝐐}_𝐩} 𝔼(𝐪, 𝐮) = \min_{𝐝∈\bar{𝐃}_𝐩} 𝔼(𝐩+𝐝, 𝐮) = 𝔼(𝐩,𝐮) + \min_{𝐝∈\bar{𝐃}_𝐩} 𝔼(𝐝,𝐮).$$

---

We define **cross-assignment** for ordering $u_1≤u_2≤...≤u_k$ as an assignment of deviations to **positive deviations** $d_1,...,d_j≥0$ and **negative deviations** $d_{j+1},...,d_k≤0$ where $j∈\{1,...,k-1\}$ such that they satisfy the constraints. An **optimal cross-assignment** finds values for the positive and negative deviations that minimize the objective.


### Over Uncertainty Set
We define an **uncertainty set** as a finite set of probability vectors $𝐐.$ Then, similar to [Wald's maximin model](https://en.wikipedia.org/wiki/Wald%27s_maximin_model), the problem as maximizing the minimum expected value over the uncertainty set over decision variables $Z$ is

$$\max_{z∈Z}\, \min_{𝐪∈𝐐} 𝔼(𝐪, 𝐮(z)).$$

We can reformulate the **maxmin over uncertainty set** in mathematical programming as

$$\max_{z∈Z}\, x$$

---

$$x≤𝔼(𝐪, 𝐮(z)),\quad ∀𝐪∈𝐐.$$

Regarding to the computational complexity, the number of constraints in the above formulation is proportional to the total size of the uncertainty sets

$$∑_{l∈L} |𝐐_l|.$$


### Minimax Regret
Solve the original, non-robust problem by maximizing the expected value over decision variables $Z$

$$μ^{∗}=\underset{z∈Z}{\operatorname{maximize}}\, 𝔼(𝐩,𝐮(z)).$$

We formulate the minimization of the maximum regret as

$$\underset{z∈Z}{\operatorname{minimize}}\, \max_{𝐪∈𝐐_𝐩} (μ^{∗}-𝔼(𝐪, 𝐮(z)))$$

$$\underset{z∈Z}{\operatorname{minimize}}\, (μ^{∗} - \min_{𝐪∈𝐐_𝐩} 𝔼(𝐪, 𝐮(z))$$

Next, we linearize the expression to a form

$$\underset{z∈Z}{\operatorname{minimize}}\, (μ^{∗}-x)$$

$$x≤𝔼(𝐪, 𝐮(z)),\quad ∀𝐪∈𝐐_𝐩$$


### Minimax Regret
Solve the original, non-robust problem by maximizing the expected value over decision variables $Z$

$$μ^{∗}=\underset{z∈Z}{\operatorname{maximize}}\, ∑_{l=1}^m 𝔼(𝐩_l, 𝐮_l(z))$$

We formulate the minimization of the maximum regret as

$$\underset{z∈Z}{\operatorname{minimize}}\, \max_{(𝐪_1,...,𝐪_l)∈𝐐_𝐏^{×}} (μ^{∗}-∑_{l=1}^m 𝔼(𝐪_l, 𝐮_l(z)))$$

$$\underset{z∈Z}{\operatorname{minimize}}\, (μ^{∗} - \min_{(𝐪_1,...,𝐪_l)∈𝐐_𝐏^{×}} ∑_{l=1}^m 𝔼(𝐪_l, 𝐮_l(z)))$$

Next, we linearize the expression to a form

$$\underset{z∈Z}{\operatorname{minimize}}\, (μ^{∗} - ∑_{l=1}^m x_l)$$

$$x_l ≤ 𝔼(𝐪, 𝐮_l(z)),\quad ∀𝐪∈𝐐_{𝐩_l},\, l∈\{1,...,m\}$$


## Proof of Negativity
The objective value of cross-assignment is always negative or zero.

We define **cross-assignment** for ordering $u_1≤u_2≤...≤u_k$ as an assignment of deviations to **positive deviations** $d_1,...,d_j≥0$ and **negative deviations** $d_{j+1},...,d_k≤0$ where $j∈\{1,...,k-1\}$ such that they satisfy the constraints.

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

2) Smallest $l$: $d_1,d_1^{′},d_2,d_2^{′}≥0$
3) Largest $h$: $d_1,d_1^{′},d_2,d_2^{′}≤0$
1) Largest $δ$: $d_1,d_1^{′}≥0 ∧ d_2,d_2^{′}≤0$

---

Given an initial cross-assignment $𝐝=(d_1,d_2,...,d_k),$ the recursive step updates it to a new cross-assignment $𝐝_{l,h,δ}^{′}=(d_1^{′},d_2^{′},...,d_k^{′})$ such that $d_l^{′}=d_l+δ$, $d_h^{′}=d_h-δ$ and $d_i^{′}=d_i, ∀i∈I∖\{l,h\}$ with $l∈I$ and $h∈I$ and $δ≥0.$

-  $𝐝_{l,h,δ}^{′}⋅𝐮≤𝐝⋅𝐮$ if $l≤h$ and $δ≥0$
-  $𝐝_{l_1,h_1,δ_1}^{′}⋅𝐮≤𝐝_{l_2,h_2,δ_2}⋅𝐮$ if
    -  $l_1≤l_2$ and $δ_1=δ_2$ or
    -  $h_1≥h_2$ and $δ_1=δ_2$ or
    -  $δ_1≥δ_2$ where $l_1=l_2$ and $h_1=h_2$
