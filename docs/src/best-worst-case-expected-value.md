# Best Worst-Case Expected Value
## Introduction
We explore an approach to robust optimization referred to as **distributionally robust optimization**. It finds the best worst-case expected value when there is uncertainty in the probability distribution. In this case, best means maximizing over decision variables, and worst-case expected value means minimum expected value over an uncertainty set that accounts for the distribution's uncertainty. In this work, we only consider discrete probability distributions.


## Expected Value
We denote a finite set the **states** for probabilities and utilities as

$$I=\{1,2,...,k\},\quad k∈ℕ.$$

We define a vector of discrete **probabilities** associated with the states as

$$𝐩=(p_1,p_2,...,p_k),$$

such that all elements are greater or equal to zero $𝐩≥0$ and the sum of all elements is one $𝐩⋅𝟏(k)=1$ where $𝟏(k)=(1)^k$ is a vector of $k$ ones and $⋅$ is the dot product. We also define **utilities** associated with the states as a vector of real numbers

$$𝐮=(u_1,u_2,...,u_k)∈ℝ^k.$$

Finally, we define **expected value** as a function of probabilities and utilities

$$𝔼(𝐩,𝐮)=𝐩⋅𝐮.$$


## Best Worst-Case over Uncertainty Set
The uncertainty set encapsulates the uncertainty in the probabilities. Given probabilities $𝐩,$ we define the **uncertainty set** $𝐐_𝐩$ as a finite set of discrete probabilities near $𝐩.$ We will explain how to form a finite uncertainty sets on [Uncertainty Sets](@ref) page.

### Maximin Expected Value
We define the problem as maximizing the minimum expected value over decision variables $Z$

$$\max_{z∈Z} \min_{𝐪∈𝐐} 𝔼(𝐪, 𝐮(z)).$$

Next, we linearize the expression to a form

$$\max_{z∈Z} x$$

$$x≤𝔼(𝐪, 𝐮(z)),\quad ∀𝐪∈𝐐.$$

### Minimax Regret
Solve the original, non-robust problem by maximizing the expected value over decision variables $Z$

$$μ^{∗}=\max_{z∈Z} 𝔼(𝐩,𝐮).$$

We formulate the minimization of the maximum regret as

$$\min_{z∈Z} \max_{𝐪∈𝐐_𝐩} (μ^{∗}-𝔼(𝐪, 𝐮(z)))$$

Next, we linearize the expression to a form

$$\min_{z∈Z} x$$

$$x≥μ^{∗}-𝔼(𝐪, 𝐮(z)),\quad ∀𝐪∈𝐐_𝐩$$


## Best Worst-Case over Product Uncertainty Set
Let $𝐏=\{𝐩_1,...,𝐩_m\},\, m∈ℕ$ be a finite set of probability vectors. We define the **product uncertainty set** as

$$𝐐_𝐏^{×}=∏_{l=1}^m 𝐐_{𝐩_l}.$$

The probabilities in decision programming will appear in the product form.

### Maximin Expected Value
We define the problem as maximizing the minimum expected value over decision variables $Z$

$$\max_{z∈Z} \min_{(𝐪_1,...,𝐪_l)∈𝐐_𝐏^{×}} ∑_{l=1}^m 𝔼(𝐪_l, 𝐮_l(z))$$

Next, we linearize the expression to a form

$$\max_{z∈Z} ∑_{l=1}^m x_l$$

$$x_l ≤ 𝔼(𝐪, 𝐮_l(z)),\quad ∀𝐪∈𝐐_{𝐩_l},\, l∈\{1,...,m\}$$

### Minimax Regret
Solve the original, non-robust problem by maximizing the expected value over decision variables $Z$

$$μ^{∗}=\max_{z∈Z} ∑_{l=1}^m 𝔼(𝐩_l, 𝐮_l(z))$$

We formulate the minimization of the maximum regret as

$$\min_{z∈Z} \max_{(𝐪_1,...,𝐪_l)∈𝐐_𝐏^{×}} (μ^{∗}-∑_{l=1}^m 𝔼(𝐪_l, 𝐮_l(z)))$$

Next, we linearize the expression to a form

$$\min_{z∈Z} ∑_{l=1}^m x_l$$

$$x_l ≥ μ^{∗} - 𝔼(𝐪, 𝐮_l(z)),\quad ∀𝐪∈𝐐_{𝐩_l},\, l∈\{1,...,m\}$$
