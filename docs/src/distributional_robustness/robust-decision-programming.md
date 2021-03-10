# Robust Decision Programming
## Introduction
Decision programming model with **a single robust chance node**.

We follow the notation used in [DecisionProgramming.jl documentation](https://gamma-opt.github.io/DecisionProgramming.jl/dev/).

Express the best worst-base expected value and uncertainty sets in the decision programming context.


## Difference
Let $i∈C$ be a **robust chance node**. The probability for state $s_i$ with information path $s_{I(i)}$ is denoted as

$$ℙ(X_i=s_i∣X_{I(i)}=s_{I(i)})$$

and difference is denote as

$$𝔻(X_i=s_i∣X_{I(i)}=s_{I(i)}).$$

They correspond to values $p_i$ and $d_i.$ Then, we obtain the probability vector as

$$𝐩(s_{I(i)})=(ℙ(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i)$$

and difference vector as

$$𝐝(s_{I(i)})=(𝔻(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i).$$

They correspond to vectors $𝐩$ and $𝐝.$ We can use probability vector $𝐩(s_{I(i)})$ to form the ambiguity set $Δ_{𝐩(s_{I(i)})}.$


## Path Probability
Upper bound of path probability with uncertainty is

$$p(𝐬,i,d) = (ℙ(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})+d) ⋅ ∏_{j∈C∖\{i\}} ℙ(X_j=𝐬_j∣X_{I(j)}=𝐬_{I(j)})$$

**Path probability variables** $π(𝐬,i,d)$ are equivalent to the path probability

$$ℙ(X=𝐬,i,d∣Z)=p(𝐬,i,d)⋅q(𝐬∣Z).$$

See [Path Probability Variables](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/decision-model/#Path-Probability-Variables) section.


## Maximin Expected Value
We maximize the minimum expected value over all possible combinations of difference vectors

$$\underset{Z∈ℤ}{\text{maximize}} \min_{𝐃∈Δ^{×}} ∑_{s_{I(i)}∈S_{I(i)}} 𝔼^{′}(Z,i,𝐃(s_{I(i)}))$$

where the product uncertainty set is 

$$Δ^{×}=∏_{s_{I(i)}∈S_{I(i)}}Δ_{𝐩(s_{I(i)})}$$

and the partial expected value is

$$𝔼^{′}(Z,i,𝐝)= ∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} ℙ(X=𝐬,i,𝐝_{𝐬_i}∣Z)⋅\mathcal{U}(𝐬)$$

---

The linearized maximin is

$$\underset{Z∈ℤ}{\text{maximize}} ∑_{s_{I(i)}∈S_{I(i)}} x_{s_{I(i)}}$$

$$x_{s_{I(i)}} ≤ ∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} π(𝐬,i,𝐝_{𝐬_i})⋅\mathcal{U}(𝐬),\quad ∀𝐝∈Δ_{𝐩(s_{I(i)})},\, s_{I(i)}∈S_{I(i)}$$
