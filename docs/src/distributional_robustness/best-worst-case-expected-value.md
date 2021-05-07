# [Best Worst-Case Expected Value](@id best-worst-case-expected-value)
## Probability Distribution
We denote a finite set of **states** for probabilities and utilities as

$$I=\{1,2,...,k\},\quad k∈ℕ.$$

We define a vector of discrete **probabilities** associated with the states as

$$𝐩=(p_1,p_2,...,p_k),$$

such that all elements are greater or equal to zero $𝐩≥0$ and the sum of all elements is one $𝐩⋅𝟏(k)=1$ where $𝟏(k)=(1)^k$ is a vector of $k$ ones and $⋅$ is the dot product. We also define **utilities** associated with the states as a vector of real numbers

$$𝐮=(u_1,u_2,...,u_k)∈ℝ^k.$$

Together, a vector of probabilities and utilities define a **probability distribution**.


## [Maximin Expected Value](@id maximin-expected-value)
We can define the **expected value** as the dot product of probabilities and utilities

$$𝔼(𝐩,𝐮)=𝐩⋅𝐮.$$

We define an **uncertainty set** as a set of probability vectors $𝐐.$ In decision programming, a chance node has multiple states and each state is associated with a probability distribution. Hence, in robust decision programming, each probability vector is associated with an uncertainty set. We need to account for all combinations of the uncertainty sets by formulating the maximin expected value to over a product of the uncertainty sets.

We denote multiple uncertainty sets as $𝐐_1,...,𝐐_m$ with indices $L=\{1,...,m\}$ where $m∈ℕ.$ Then, a **product uncertainty set** is

$$𝐐_L^{×}=∏_{l∈L} 𝐐_{l}.$$

Given multiple utility vectors $𝐮_1,...,𝐮_m$, we define the problem as maximizing the minimum expected value over the product uncertainty set over decision variables $Z$ similar to [Wald's maximin model](https://en.wikipedia.org/wiki/Wald%27s_maximin_model)

$$\max_{z∈Z}\, \min_{(𝐪_1,...,𝐪_m)∈𝐐_L^{×}} ∑_{l∈L} 𝔼(𝐪_l, 𝐮_l(z)).$$

We can simplify the formulation to a more computationally tractable form

$$\max_{z∈Z}\, ∑_{l∈L} \min_{𝐪∈𝐐_l} 𝔼(𝐪, 𝐮_l(z)).$$

Now, we can reformulate the maximin over product uncertainty set in mathematical programming as

$$\max_{z∈Z}\, ∑_{l∈L} x_l$$

$$x_l ≤ 𝔼(𝐪, 𝐮_l(z)),\quad ∀𝐪∈𝐐_{l},\, l∈L$$


## Local Uncertainty Set
We can formulate a **local uncertainty set** $𝐐_{𝐩}$ around a **pivot probability** $𝐩$ by formulating a **local ambiguity set** $𝐃_{𝐩}$ of **deviations** $𝐝$ such that each element of the uncertainty set satisfies

$$𝐪=𝐩+𝐝.$$

We can express the uncertainty set in terms of the ambiguity set as

$$𝐐_𝐩=\{𝐩+𝐝∣𝐝∈𝐃_𝐩\}.$$

We can also define the minimum expected value over the local uncertainty set in terms of the local ambiguity set

$$\min_{𝐪∈𝐐_𝐩} 𝔼(𝐪, 𝐮) = \min_{𝐝∈𝐃_𝐩} 𝔼(𝐩+𝐝, 𝐮) = 𝔼(𝐩,𝐮) + \min_{𝐝∈𝐃_𝐩} 𝔼(𝐝,𝐮).$$

Therefore, we can focus on forming the local ambiguity set and minimizing expected value over it.


## Local Ambiguity Set
We define the **lower bounds** $𝐝^{-}≤0$ and **upper bounds** $𝐝^{+}≥0$ for deviations $𝐝$ as parameters such that

$$𝐝^{-}≤𝐝≤𝐝^{+}.$$

As a consequence from the properties of discrete probabilities, we obtain

$$𝐪^{+}=𝐩+𝐝^{+}≤1 ⇒\quad 𝐝^{+}≤1-𝐩,$$

$$𝐪^{-}=𝐩+𝐝^{-}≥0 ⇒\quad 𝐝^{-}≥-𝐩.$$

We also obtain the **conservation of probability mass** as

$$𝐝⋅𝟏(k)=(𝐩-𝐪)⋅𝟏(k)=𝐩⋅𝟏(k)-𝐪⋅𝟏(k)=0.$$

Finally, we can limit the Wasserstein distance of uncertainty set elements from the pivot by constraining the magnitude of the deviation to $l∈ℕ$ norm less or equal to an **uncertainty radius** $0≤ϵ≤1$ as

$$\|𝐝\|_l≤2ϵ.$$

By setting $ϵ=1$ we can make the magnitude constraint inactive.

---

Given parameters lower bound $-𝐩≤𝐝^{-}≤0$, upper bound $0≤𝐝^{+}≤1-𝐩$, and uncertainty radius $0≤ϵ≤1,$ the **continuous local ambiguity set** is the set of all deviations that satisfy the defined constraints

$$\bar{𝐃}_𝐩=\{𝐝∈[𝐝^{-},𝐝^{+}]∣ 𝐝⋅𝟏(k)=0,\, \|𝐝\|_l≤2ϵ\}.$$

The ambiguity set is convex, which makes optimization tractable. Smaller values of $l$ make the ambiguity set more pessimistic and larger values more optimistic. We refer to the ambiguity set as **polyhedral** when $l=1.$

To form an explicit formulation of the mathematical programming model, we have to **discretize** the ambiguity set. A **discrete local ambiguity set** $𝐃_𝐩$ is a finite subset of $\bar{𝐃}_𝐩$ such that it contains all deviations $𝐝$ for all utility vectors $𝐮∈ℝ^{k}$ that can minimize the expected value. We can solve the discretization for [local polyhedral ambiguity set](@ref polyhedral-ambiguity-set) using the **cross-assignment** algorithm.


## Proof of Convexity of Ambiguity Set
Let $𝐝_1,𝐝_2∈𝐃_𝐩,$ we must show that $𝐝∈𝐃_𝐩$ where $𝐝=(1-λ)𝐝_1+λ𝐝_2$ with $λ∈[0,1].$

1) Minimum: $𝐝=(1-λ)𝐝_1+λ𝐝_2≥(1-λ)𝐝^{-}+λ𝐝^{-}=𝐝^{-}.$
2) Maximum: $𝐝=(1-λ)𝐝_1+λ𝐝_2≤(1-λ)𝐝^{+}+λ𝐝^{+}=𝐝^{+}.$
3) Conservation of probability mass: $𝐝⋅𝟏(k)=(1-λ)𝐝_1⋅𝟏(k)+λ𝐝_2⋅𝟏(k)=0$
4) Limit for magnitude (Triangle inequality): $\|𝐝\|_l≤(1-λ)\|𝐝_1\|_l+λ\|𝐝_2\|_l≤2ϵ$
