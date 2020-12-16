# Best Worst-Case Expected Value
## Introduction
Focus on distributionally robust over discrete probability distributions. Best worst-case analysis.


## Expected Value
We denote a finite set of discrete probabilities for states $I=\{1,2,...,k\}$ as

$$𝐩=(p_1,p_2,...,p_k),$$

such that $𝐩≥0$ and $𝐩⋅𝟏(k)=1$ where $𝟏(k)=(1)^k$ is a vector of $k$ ones.

We define a vector of real numbers associated with states $I$ as

$$𝐮=(u_1,u_2,...,u_k)∈ℝ^k$$

We define expected value as

$$𝔼(𝐩,𝐮)=𝐩⋅𝐮.$$


## Maximin over Uncertainty Set
We define **uncertainty set** $𝐐$ as a finite set of discrete probabilities.

Maximize the minimum expected value over decision variables $Z$

$$\max_{z∈Z} \min_{𝐪∈𝐐} 𝔼(𝐪, 𝐮(z))$$

Now we can linearize the objective as

$$\max_{z∈Z} x$$

$$x≤𝔼(𝐪, 𝐮(z)),\quad ∀𝐪∈𝐐$$


## Maximin over Product Uncertainty Set
We define the **product uncertainty set** as

$$𝐐^{×}=∏_{l=1}^m 𝐐_l$$

Maximize the minimum expected value

$$\max_{z∈Z} \min_{(𝐪_1,...,𝐪_m)∈𝐐^{×}} ∑_{l=1}^m 𝔼(𝐪_l, 𝐮_l(z))$$

Linearized

$$\max_{z∈Z} ∑_{l=1}^m x_l$$

$$x_l ≤ 𝔼(𝐪, 𝐮_l(z)),\quad ∀𝐪∈𝐐_l,\, l∈\{1,...,m\}$$
