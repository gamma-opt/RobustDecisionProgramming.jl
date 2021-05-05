# Drafts
For example, we applied robust decision programming to the [N-monitoring](https://gamma-opt.github.io/DecisionProgramming.jl/dev/examples/n-monitoring/) example from decision programming such that we made the failure node robust.


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
