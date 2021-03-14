# Robust Decision Model
## Introduction
We follow the notation used in `DecisionProgramming.jl`'s [documentation](https://gamma-opt.github.io/DecisionProgramming.jl/dev/) for sections *Influence Diagram* and *Decision Model*.

We extend the Decision Model to **locally robust** Decision Model, that is, decision model with **one robust chance node**.


## Optimal Discrete Polyhedral Uncertainty Set
We can extend the [Probabilities](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/influence-diagram/#Probabilities) from `DecisionProgramming.jl` to form an optimal discrete polyhedral uncertainty set.

Let $i∈C$ be a **robust chance node**. The probability for state $s_i∈S_i$ with information path $s_{I(i)}∈𝐒_{I(i)}$ is denoted as $ℙ(X_i=s_i∣X_{I(i)}=s_{I(i)})$ and difference is denote as $𝔻(X_i=s_i∣X_{I(i)}=s_{I(i)}).$ Then, we obtain the probability vector as

$$𝐩(s_{I(i)})=(ℙ(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i)$$

Then, we can compute the optimal discrete ambiguity set using cross-assignment on the probability vector $Δ_{𝐩(s_{I(i)})}.$ We denote the elements as $𝐝∈Δ_{𝐩(s_{I(i)})}$ where

$$𝐝=(𝔻(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i).$$

We ignore all inactive chance states when forming the ambiguity set.


## Best Worst-Case Expected Value
### Path Probability with Uncertainty
We extend the [Path Probability](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/influence-diagram/#Path-Probability) to include uncertainty by introducing the difference $d$ to the probability of robust chance node $i.$

The **path probability with uncertainty** becomes

$$ℙ(X=𝐬∣Z,i,𝐝)=p(𝐬,i,𝐝)⋅q(𝐬∣Z)$$

where **upper bound of path probability with uncertainty** is

$$p(𝐬,i,𝐝) = (ℙ(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})+𝐝_{𝐬_i}) ⋅ ∏_{j∈C∖\{i\}} ℙ(X_j=𝐬_j∣X_{I(j)}=𝐬_{I(j)}).$$

### Partial Expected Value
For all $s_{I(i)}∈𝐒_{I(i)}$

$$𝔼^{′}(X∣Z,i,𝐝,s_{I(i)})= ∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} ℙ(X=𝐬∣Z,i,𝐝)⋅\mathcal{U}(𝐬)$$

---

Distribution $q$

$$ℙ(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})+𝐝_{𝐬_i}$$

Utility $u$

$$∏_{j∈C∖\{i\}} ℙ(X_j=𝐬_j∣X_{I(j)}=𝐬_{I(j)})⋅q(𝐬∣Z)⋅\mathcal{U}(𝐬)$$

### Maximin Expected Value
We maximize the minimum expected value over all possible combinations of difference vectors

$$\underset{Z∈ℤ}{\text{maximize}} \min_{𝐃∈Δ^{×}} ∑_{s_{I(i)}∈𝐒_{I(i)}} 𝔼^{′}(X∣Z,i,𝐃_{s_{I(i)}},s_{I(i)})$$

where the product uncertainty set is 

$$Δ^{×}=∏_{s_{I(i)}∈𝐒_{I(i)}}Δ_{𝐩(s_{I(i)})}.$$

---

The linearized maximin is

$$\underset{Z∈ℤ}{\text{maximize}} ∑_{s_{I(i)}∈𝐒_{I(i)}} x_{s_{I(i)}}$$

$$x_{s_{I(i)}} ≤ 𝔼^{′}(X∣Z,i,𝐝,s_{I(i)}),\quad ∀𝐝∈Δ_{𝐩(s_{I(i)})},\, s_{I(i)}∈𝐒_{I(i)}$$


### Path Probability Variables with Uncertainty
**Path probability variables with uncertainty** $π(𝐬,i,𝐝)$ are equivalent to the path probability $ℙ(X=𝐬,i,𝐝∣Z)$ similar to [Path Probability Variables](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/decision-model/#Path-Probability-Variables) section.

Use upper bound of path probability with uncertainty

For all $s_{I(i)}∈𝐒_{I(i)}$

$$0≤π(𝐬,i,𝐝)≤p(𝐬,i,𝐝),\quad ∀𝐬∈𝐒, 𝐬_{I(i)}=s_{I(i)}$$

$$π(𝐬,i,𝐝)≤z(𝐬_j∣𝐬_{I(j)}),\quad ∀j∈D,𝐬∈𝐒, 𝐬_{I(i)}=s_{I(i)}$$

$$π(𝐬,i,𝐝)≥p(𝐬,i,𝐝)+∑_{j∈D}z(𝐬_j∣𝐬_{I(j)})-|D|,\quad ∀𝐬∈𝐒, 𝐬_{I(i)}=s_{I(i)}$$

---

For all $s_{I(i)}∈𝐒_{I(i)}$, expected value $𝔼^{′}(X∣Z,i,𝐝,s_{I(i)})$ is equivalent to

$$∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} π(𝐬,i,𝐝)⋅\mathcal{U}(𝐬)$$
