# [Local Polyhedral Ambiguity Set](@id local-polyhedral-ambiguity-set)
## Problem
We denote the minimizing deviation as

$$𝐝^{∗}(𝐮)=\argmin_{𝐝∈\bar{𝐃}^{1}_𝐩} 𝔼(𝐝,𝐮).$$

Given the parameters lower bound $d_i^{-}∈[-p_i,0]$ and upper bound $d_i^{+}∈[0,1-p_i]$ for all $i∈\{1,...,k\},$ the uncertainty radius $ϵ∈[0,1],$ and an utility vector $(u_1,...,u_k),$ we can express finding the minimizing deviation over a polyhedral ambiguity set in the form:

$$𝐝^{∗} = \argmin_{(d_1,...,d_k)∈ℝ^k} \, d_1⋅u_1 +d_2⋅u_2 +...+d_k⋅u_k,$$

$$d_i^{-} ≤ d_i ≤ d_i^{+}, \quad ∀i∈\{1,...,k\},$$

$$d_1+d_2+...+d_k=0,$$

$$|d_1|+|d_2|+...+|d_k|≤2ϵ.$$

We can solve the problem if we give an ordering for the utility vector. Since the utility vector is finite, it has a finite number of orderings. Therefore, the set of solutions for all the orderings forms the polyhedral ambiguity set.


## Optimal Cross-Assignment
```julia
function cross_assignment(l::Int, h::Int, Σ::Float64, d::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    if (h - l ≤ 0) || (ϵ-Σ ≤ 0)
        return d
    end
    δ_l = d⁺[l] - d[l]
    δ_h = d[h] - d⁻[h]
    δ = min(δ_l, δ_h, ϵ-Σ)
    d[l] += δ
    d[h] -= δ
    if δ_l < δ_h
        return cross_assignment(l+1, h, Σ+δ, d, d⁻, d⁺, ϵ)
    elseif δ_l > δ_h
        return cross_assignment(l, h-1, Σ+δ, d, d⁻, d⁺, ϵ)
    else
        return cross_assignment(l+1, h-1, Σ+δ, d, d⁻, d⁺, ϵ)
    end
end

function cross_assignment(k::Int, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    d = zeros(k)
    cross_assignment(1, k, 0.0, d, d⁻, d⁺, ϵ)
end
```

The `cross_assignment` algorithm computes the optimal cross-assignment given an **utility ordering** of $u_1≤u_2≤...≤u_k,$ such that the sequence $(𝐝_0, Σ_0),(𝐝_1, Σ_1),...,(𝐝_n, Σ_n)$ converges toward the optimal cross-assignment $𝐝^{∗}=𝐝_n$ where $Σ_n=\|𝐝_n\|_1/2≤ϵ$ in at most $n≤k$ iterations. We have initial $Σ_0=0.$

---

Given $u_1≤u_2≤...≤u_k$ and previous iteration,  $𝐝=(d_1,d_2,...,d_k),$ the new iteration is $𝐝^{′}=(d_1^{′},d_2^{′},...,d_k^{′})$ such that $l,h∈I$ and $δ_l,δ_h∈ℝ$ and $d_l^{′}=d_l+δ_l$ and $d_h^{′}=d_h+δ_h$ and $d_i^{′}=d_i$ for all $i∈I∖\{l,h\}.$ The **conservation of mass** gives us

$$𝐝^{′}⋅𝟏_k=0 ⟹ δ_l=-δ_h=δ.$$

By choosing $δ>0,$ and $u_l≤u_h$ which implies $l≤h$ the expression $δ(u_l-u_h)$ is negative. Therefore the objective value **decreases** as follows:

$$\begin{aligned}
𝐝^{′}⋅𝐮&=d_l^{′}+d_h^{′}+∑_{i}d_i^{′} u_i \\
&=(d_l+δ)u_l+(d_h-δ)u_h+∑_{i}d_i u_i \\
&=𝐝⋅𝐮+δ (u_l-u_h) \\
&≤𝐝⋅𝐮.
\end{aligned}$$

The objective values are **negative** with the following initial value.

$$𝐝^{′}⋅𝐮≤𝐝_0⋅𝐮=𝟎 ⟹ 𝐝_0=𝟎.$$

The **upper** and **lower bound** constraints $δ$ as follows

$$d_l^{′}≤d_l^{+} ⟹ d_l+δ≤d_l^{+} ⟹ δ≤d_l^{+}-d_l,$$

$$d_h^{′}≥d_h^{-} ⟹ d_h-δ≥d_h^{-} ⟹ δ≤d_h-d_h^{-}.$$

We **minimize** the objective by choosing the smallest $l$ and largest $h$ such that $δ>0.$ Then, with fixed $l$ and $h$ we choose large possible $δ$ without violating constraints.

$$δ=\min\{d_l^{+}-d_l,d_h-d_h^{-},ϵ-\|𝐝\|_1/2\}.$$

We repeat this step until $h-l≤0$ for the smallest $l$ and largest $h$ or $ϵ-\|𝐝\|_1/2≤0.$


## Set of All Optimal Cross-assignments
```julia
using Combinatorics: permutations

function ambiguity_set(k, d⁻, d⁺, ϵ)
    Set(cross_assignment(k, d⁻[I′], d⁺[I′], ϵ)[I′] for I′ in permutations(1:k))
end
```

Let $\mathcal{P}(I)$ denote the set of permutations of set $I.$ We denote an invidivual permutation as $I^{′}=(i_1,i_2,...,i_k)∈\mathcal{P}(I).$ Then, we denote the set of all utilities with an ordering given by the permutation as

$$U_{I^{′}}=\{𝐮∈ℝ^k∣u_{i_1}≤u_{i_2}≤...≤u_{i_k}\}.$$

We can express the discretization of local polyhedral ambiguity set is the set of optimal cross-assignments over all utility orderings as

$$𝐃^{1}_𝐩=\{𝐝^{∗}(𝐮)∣𝐮∈ℝ^k\}=⋃_{I^{′}∈\mathcal{P}(I)} \{𝐝^{∗}(𝐮)∣𝐮∈U_{I^{′}}\}$$

Since the deviations for given ordering are equal, we denote

$$𝐝^{∗}(U_{I^{′}})=𝐝^{∗}(𝐮_1)=...=𝐝^{∗}(𝐮_k),\quad 𝐮_1,...,𝐮_k∈U_{I^{′}}$$

Thus, we obtain the local polyhedral ambiguity set as

$$𝐃^{1}_𝐩=\{𝐝^{∗}(U_{I^{′}})∣I^{′}∈\mathcal{P}(I)\}.$$

The set is finite because there are finite number of permutations

$$|𝐃^{1}_𝐩|≤|\mathcal{P}(I)|=k!.$$


## Number of Optimal Cross-assignments
We can express an optimal cross-assignment as a partition $(I_{+},i_{+},I_{0},i_{-},I_{-})$ of indices $I^{′}∈\mathcal{P}(I)$ where we have subsets $I_{+},I_{0},I_{-}⊆I^{′},$ elements $i_{+},i_{-}∈I^{′}$ and the values of the optimal cross-assignment are

$$\begin{aligned}
& d_i=d_i^{+},\quad ∀i∈I_{+} \\
& 0≤d_{i_{+}}≤d_{i_{+}}^{+} \\
& d_i=0,\quad ∀i∈I_{0} \\
& d_{i_{-}}^{-}≤d_{i_{-}}≤0 \\
& d_i=d_i^{-},\quad ∀i∈I_{-} \\
\end{aligned}$$

Since the internal utility order in the subsets does not change the solution, all partitions in the set

$$\{(I_{+}^{′},i_{+},I_{0}^{′},i_{-},I_{-}^{′})∣ I_{+}^{′}∈\mathcal{P}(I_{+}), I_{0}^{′}∈\mathcal{P}(I_{0}), I_{-}^{′}∈\mathcal{P}(I_{-})\}$$

have the same optimal cross assignment. Therefore, the bound for the size of the uncertainty set is

$$|𝐃^{1}_𝐩|≤\max_{I_{+},I_{0},I_{-}} \frac{|\mathcal{P}(I)|}{|\mathcal{P}(I_{+})||\mathcal{P}(I_{0})||\mathcal{P}(I_{-})|}≤|\mathcal{P}(I)|.$$

Note that the empty set has one permutation $|\mathcal{P}(∅)|=1.$
