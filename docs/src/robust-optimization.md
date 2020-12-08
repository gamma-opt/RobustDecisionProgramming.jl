# Robust Optimization
## Discrete Probabilities
We define a set of finite discrete probabilities for states $I=\{1,2,...,k\}$ as

$$𝐩=(p_1,p_2,...,p_k),$$

such that $𝐩≥0$ and $𝐩⋅𝟏(k)=1.$ We denote a vector of $k$ ones as $𝟏(k)=(1)^k.$

We denote vector using boldface symbols. All non-matrix algebra operations on vectors are element-wise.


## Difference
Given two finite sets of probabilities $𝐩=(p_1,p_2,...,p_k)$ and $𝐪=(q_1,q_2,...,q_k).$ We define the difference between the distributions as

$$𝐝=𝐩-𝐪.$$

Given the properties of discrete probabilities, we have

$$𝟏(k)⋅𝐝=𝟏(k)⋅(𝐩-𝐪)=𝟏(k)⋅𝐩-𝟏(k)⋅𝐪=0.$$

The differences are bounded as

$$-1≤𝐝≤1.$$


## Uncertainty Sets
We define the **difference set** as

$$𝐃=\{𝐝∣-1≤𝐝≤1,\, 𝟏(k)⋅𝐝=0,\, 𝐩+𝐝≥0\}.$$

Let $\mathcal{C}:𝐃→\{⊥,⊤\}$ be a constraint (boolean function) that limits the magnitude of the difference. Then

$$Δ = \{d∈𝐃∣\mathcal{C}(𝐝)\}$$

Choosing the constraint $\mathcal{C}$ is a design choise.

**Uncertainty set** defines all distributions $𝐪=𝐩+𝐝$ within difference $𝐝$ from $𝐩.$ Formally,

$$𝐐=\{𝐩+𝐝∣𝐝∈Δ\}$$


## Minimum Expected Value
Let $𝐮=(u_1,u_2,...,u_k)∈ℝ^k$ be a vector of real numbers associated with states $I.$

Then, we define the minimum expected value as

$$\min_{𝐪∈𝐐} 𝐪⋅𝐮 = \min_{𝐝∈Δ} (𝐩+𝐝)⋅𝐮 = 𝐩⋅𝐮 + \min_{𝐝∈Δ} 𝐝⋅𝐮.$$

---

Lemma: If $u_1>u_2$ and $d_1<d_2≤0,$ then:

$$\begin{aligned}
u_1 d_1 + u_2 d_2 &= u_1 d_1^{′}+ u_1 d_1^{′′}+u_2 d_2 \\
&< u_1 d_1^{′} + u_2 d_1^{′′} + u_2 d_2 \\
&= u_1 d_1^{′} + u_2 (d_1^{′′} + d_2)
\end{aligned}$$

where $d_1=d_1^{′}+d_1^{′′}$ such that $d_1^{′}>d_1$ and $d_1^{′′}>d_1.$

---

Using lemma, we can solve the minimization problem

$$\min_{𝐝∈Δ} 𝐝⋅𝐮$$

If we do not have any information about the ordering of $𝐮,$ we can generate all permutations of $\{1,2,...,k\}$ to cover all possible orderings $u_1^{′}≥u_2^{′}≥...≥u_k^{′}$ to obtain discrete uncertainty set $Δ^{′}⊆Δ$ that contains all possible $𝐝$ that can minimize the expected value given constraint $\mathcal{C}$.

Let $\mathcal{P}(𝐮)$ define the set of all permutations of vector $𝐮.$


## Maximin
Maximize the minimum expected value

$$\max_{z∈Z} \min_{𝐪∈𝐐(z)} 𝐪⋅𝐮(z)$$

Linearized

$$\max_{z∈Z} x$$

$$x≤𝐪⋅𝐮(z),\quad ∀𝐪∈𝐐(z)$$


## Wasserstein Distance
$\mathcal{C}(𝐝)$ is equivalent to

$$\|𝐝\|_1=2ϵ$$

where $0≤ϵ≤1$ is parameter


## Intervals
$\mathcal{C}(𝐝)$ is equivalent to

$$0≤𝐝^{-} ≤ 𝐝 ≤ 𝐝^{+}≤1$$

where $𝐝^{-}$ and $𝐝^{+}$ are parameters