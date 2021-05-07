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
