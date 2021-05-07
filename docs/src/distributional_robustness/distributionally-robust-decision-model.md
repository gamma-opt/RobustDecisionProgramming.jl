# [Distributionally Robust Decision Model](@id distributionally-robust-decision-model)
## Discrete Polyhedral Ambiguity Set
To solve the best worst-case expected value, we must form the discrete polyhedral ambiguity set as discussed in Uncertainty Sets for the [Probabilities](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/influence-diagram/#Probabilities) of a **robust chance node** $i∈C.$

We denote the probability of state $s_i∈S_i$ with information path $s_{I(i)}∈𝐒_{I(i)}$ as $ℙ(X_i=s_i∣X_{I(i)}=s_{I(i)})$ and difference as $𝔻(X_i=s_i∣X_{I(i)}=s_{I(i)}).$ Then, we can denote the probability vector of given information path as

$$𝐩(s_{I(i)})=(ℙ(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i)$$

Furthermore, we can use cross-assignment on the probability vector to form the optimal [Polyhedral Ambiguity Set](@ref polyhedral-ambiguity-set)

$$𝐃_{𝐩(s_{I(i)})}.$$

We should ignore all inactive chance states when forming the ambiguity set. The elements of the ambiguity set are difference vectors, denoted as $𝐝∈𝐃_{𝐩(s_{I(i)})}$ where

$$𝐝=(𝔻(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i).$$

We will refer to them as uncertainty.


## Path Probability with Uncertainty
Before we can formulate the expected value, we must formulate the path probability with uncertainty by reformulating the [Path Probability](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/influence-diagram/#Path-Probability) such that we add the difference $𝐝_{𝐬_i}$ to the probabilities of robust chance node $i.$  Then, the **upper bound of path probability with uncertainty** becomes

$$p(𝐬,i,𝐝) = (ℙ(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})+𝐝_{𝐬_i}) ⋅ ∏_{j∈C∖\{i\}} ℙ(X_j=𝐬_j∣X_{I(j)}=𝐬_{I(j)}).$$

Furthermore, we have the **path probability with uncertainty** as

$$ℙ(X=𝐬∣Z,i,𝐝)=p(𝐬,i,𝐝)⋅q(𝐬∣Z),$$


## Partial Expected Value
We can formulate the **partial expected value** for all information path $s_{I(i)}∈𝐒_{I(i)},$ in terms of the path probability with uncertainty and path utility

$$𝔼^{′}(X∣Z,i,𝐝,s_{I(i)})= ∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} ℙ(X=𝐬∣Z,i,𝐝)⋅\mathcal{U}(𝐬).$$

The expected value is the sum of partial expected values over all information paths.

---

In relation to the notation used when defining the expected value, we have the elements of discrete probabilities $𝐪$ as

$$ℙ(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})+𝐝_{𝐬_i},$$

and elements of utility vector $𝐮$ as

$$∏_{j∈C∖\{i\}} ℙ(X_j=𝐬_j∣X_{I(j)}=𝐬_{I(j)})⋅q(𝐬∣Z)⋅\mathcal{U}(𝐬).$$


## Path Probability Variables with Uncertainty
To formulate the linear optimization model for the partial expected value, we need to define the **path probability variables with uncertainty** as equivalent to the path probability with uncertainty similar to the definition of [Path Probability Variables](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/decision-model/#Path-Probability-Variables).

$$0≤π(𝐬,i,𝐝)≤p(𝐬,i,𝐝),\quad ∀𝐬∈𝐒$$

$$π(𝐬,i,𝐝)≤z(𝐬_j∣𝐬_{I(j)}),\quad ∀j∈D,𝐬∈𝐒$$

$$π(𝐬,i,𝐝)≥p(𝐬,i,𝐝)+∑_{j∈D}z(𝐬_j∣𝐬_{I(j)})-|D|,\quad ∀𝐬∈𝐒$$

The symbol $z(𝐬_j∣𝐬_{I(j)})$ denotes the decision variables.


## Maximin Expected Value
As defined in the [Best Worst-Case Expected Value](@ref best-worst-case-expected-value), we can define the maximin expected value and minimax regret formulations of the robust decision model.

We maximize the minimum expected value over all possible combinations of difference vectors

$$\underset{Z∈ℤ}{\text{maximize}} \min_{𝐃∈𝐃^{×}} ∑_{s_{I(i)}∈𝐒_{I(i)}} 𝔼^{′}(X∣Z,i,𝐃_{s_{I(i)}},s_{I(i)})$$

where the product ambiguity set is

$$𝐃^{×}=∏_{s_{I(i)}∈𝐒_{I(i)}}𝐃_{𝐩(s_{I(i)})}.$$

---

The linearized maximin is

$$\underset{Z∈ℤ}{\text{maximize}} ∑_{s_{I(i)}∈𝐒_{I(i)}} x_{s_{I(i)}}$$

$$x_{s_{I(i)}} ≤ 𝔼^{′}(X∣Z,i,𝐝,s_{I(i)}),\quad ∀𝐝∈𝐃_{𝐩(s_{I(i)})},\, s_{I(i)}∈𝐒_{I(i)}$$

---

By substituting the path probability variables with uncertainty to the definition of partial expected value and, we obtain the linearized maximin in linear optimization model form as

$$\underset{Z∈ℤ}{\text{maximize}} ∑_{s_{I(i)}∈𝐒_{I(i)}} x_{s_{I(i)}}$$

$$x_{s_{I(i)}} ≤ ∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} π(𝐬,i,𝐝)⋅\mathcal{U}(𝐬),\quad ∀𝐝∈𝐃_{𝐩(s_{I(i)})},\, s_{I(i)}∈𝐒_{I(i)}.$$
