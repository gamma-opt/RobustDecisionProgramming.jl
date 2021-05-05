# [Best Worst-Case Expected Value](@id best-worst-case-expected-value)
## Uncertainty Set
We denote a finite set the **states** for probabilities and utilities as

$$I=\{1,2,...,k\},\quad k∈ℕ.$$

We define a vector of discrete **probabilities** associated with the states as

$$𝐩=(p_1,p_2,...,p_k),$$

such that all elements are greater or equal to zero $𝐩≥0$ and the sum of all elements is one $𝐩⋅𝟏(k)=1$ where $𝟏(k)=(1)^k$ is a vector of $k$ ones and $⋅$ is the dot product.

---

Given two finite sets of discrete probabilities, the **pivot** $𝐩$ and **deviated** $𝐪$ over states $I.$ We define the **difference** between the distributions as

$$𝐝=𝐪-𝐩.$$

Alternatively, we can describe the deviated distribution as the sum of pivot distribution and difference

$$𝐪=𝐩+𝐝.$$

From the properties of discrete probabilities, we have the lower and upper bounds

$$0≤𝐪≤1$$

$$0≤𝐩+𝐝≤1$$

$$-𝐩≤𝐝≤1-𝐩.$$

We define the **lower bounds** $𝐝^{-}$ and **upper bounds** $𝐝^{+}$ as parameters such that $𝐝^{-}≤𝐝≤𝐝^{+}$ where $-𝐩≤𝐝^{-}≤0$ and $0≤𝐝^{+}≤1-𝐩.$

---

As a consequence of the properties of discrete probabilities, we obtain the **conservation of probability mass** as

$$𝐝⋅𝟏(k)=(𝐩-𝐪)⋅𝟏(k)=𝐩⋅𝟏(k)-𝐪⋅𝟏(k)=0.$$

---

Additionally, we can limit the magnitude of the differences with $l∈ℕ$ norm

$$\|𝐝\|_l≤2ϵ,$$

with a **uncertainty radius** parameter $0≤ϵ≤1.$

---

The **ambiguity set** is the set of all difference vectors that satisfy the given conditions

$$\bar{𝐃}_𝐩=\{𝐝∈[𝐝^{-},𝐝^{+}]∣ 𝐝⋅𝟏(k)=0,\, \|𝐝\|_l≤2ϵ\}.$$

The ambiguity set is convex, which makes optimization possible. Decreasing $l$ makes the model more pessimistic. Using $l=1$ we receive a **polyhedral ambiguity set**. By setting $ϵ=1$ we can make the magnitude constraint inactive.

---

Then, we define the **continuous uncertainty set** that consists of all deviated distributions around the pivot distribution

$$\bar{𝐐}_𝐩=\{𝐩+𝐝∣𝐝∈\bar{𝐃}_𝐩\}.$$

An **uncertainty set** $𝐐_{𝐩}$ is a finite subset of $\bar{𝐐}_{𝐩}$ such that it contains all optimizing probabilities.


## [Expected Value](@id expected-value)
We also define **utilities** associated with the states as a vector of real numbers

$$𝐮=(u_1,u_2,...,u_k)∈ℝ^k.$$

Now, we can define **expected value** as the dot product of probabilities and utilities

$$𝔼(𝐩,𝐮)=𝐩⋅𝐮.$$


## Maximin Expected Value
### Over Uncertainty Set
We define the problem as maximizing the minimum expected value over decision variables $Z$

$$\underset{z∈Z}{\operatorname{maximize}}\, \min_{𝐪∈𝐐} 𝔼(𝐪, 𝐮(z)).$$

Next, we linearize the expression to a form

$$\underset{z∈Z}{\operatorname{maximize}}\, x$$

$$x≤𝔼(𝐪, 𝐮(z)),\quad ∀𝐪∈𝐐.$$

### [Over Product Uncertainty Set](@id maximin-expected-value-over-product-uncertainty-set)
Let $𝐏=\{𝐩_1,...,𝐩_m\},\, m∈ℕ$ be a finite set of probability vectors. We define the **product uncertainty set** as

$$𝐐_𝐏^{×}=∏_{l=1}^m 𝐐_{𝐩_l}.$$

The probabilities in decision programming will appear in the product form.

We define the problem as maximizing the minimum expected value over decision variables $Z$

$$\underset{z∈Z}{\operatorname{maximize}}\, \min_{(𝐪_1,...,𝐪_l)∈𝐐_𝐏^{×}} ∑_{l=1}^m 𝔼(𝐪_l, 𝐮_l(z))$$

Next, we linearize the expression to a form

$$\underset{z∈Z}{\operatorname{maximize}}\, ∑_{l=1}^m x_l$$

$$x_l ≤ 𝔼(𝐪, 𝐮_l(z)),\quad ∀𝐪∈𝐐_{𝐩_l},\, l∈\{1,...,m\}$$


## Discrete Uncertainty Set
We have to discretize the uncertainty set to formulate the mathematical model.

We can define the minimum expected value over the continuous uncertainty set with utilities $𝐮$ as

$$\min_{𝐪∈\bar{𝐐}_𝐩} 𝔼(𝐪, 𝐮) = \min_{𝐝∈\bar{𝐃}_𝐩} (𝐩+𝐝)⋅𝐮 = 𝐩⋅𝐮 + \min_{𝐝∈\bar{𝐃}_𝐩} 𝐝⋅𝐮.$$

We can express the minimizing difference as

$$𝐝^{∗}(𝐮)=\argmin_{𝐝∈\bar{𝐃}_𝐩} 𝐝⋅𝐮.$$

Now, we can obtain a discrete ambiguity set

$$𝐃_𝐩=\{𝐝^{∗}(𝐮)∣𝐮∈ℝ^k\}.$$

The discrete set of all possible minimizing distributions

$$𝐐_𝐩=\{𝐩+𝐝∣𝐝∈𝐃_𝐩\}.$$


## Appendix
Proof that an ambiguity set is convex. Let $𝐝_1,𝐝_2∈𝐃_𝐩,$ we must show that $𝐝∈𝐃_𝐩$ where $𝐝=(1-λ)𝐝_1+λ𝐝_2$ with $λ∈[0,1].$

1) Minimum: $𝐝=(1-λ)𝐝_1+λ𝐝_2≥(1-λ)𝐝^{-}+λ𝐝^{-}=𝐝^{-}.$
2) Maximum: $𝐝=(1-λ)𝐝_1+λ𝐝_2≤(1-λ)𝐝^{+}+λ𝐝^{+}=𝐝^{+}.$
3) Conservation of probability mass: $𝐝⋅𝟏(k)=(1-λ)𝐝_1⋅𝟏(k)+λ𝐝_2⋅𝟏(k)=0$
4) Limit for magnitude (Triangle inequality): $\|𝐝\|_l≤(1-λ)\|𝐝_1\|_l+λ\|𝐝_2\|_l≤2ϵ$
