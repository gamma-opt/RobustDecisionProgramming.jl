# [Polyhedral Ambiguity Set](@id polyhedral-ambiguity-set)
## Problem
Given the parameters lower bound $d_i^{-}∈[-p_i,0]$ and upper bound $d_i^{+}∈[0,1-p_i]$ for all $i∈\{1,...,k\},$ the uncertainty radius $ϵ∈[0,1],$ and an utility vector $(u_1,...,u_k),$ we can express finding the minimizing deviation over a polyhedral ambiguity set in the form:

$$𝐝^{∗} = \argmin_{(d_1,...,d_k)∈ℝ^k} \, d_1⋅u_1 +d_2⋅u_2 +...+d_k⋅u_k,$$

subject to

$$d_i^{-} ≤ d_i ≤ d_i^{+}, \quad ∀i∈\{1,...,k\},$$

$$d_1+d_2+...+d_k=0,$$

$$|d_1|+|d_2|+...+|d_k|≤2ϵ.$$

We can solve the problem if we give an ordering for the utility vector. Since the utility vector is finite, it has a finite number of orderings. Therefore, the set of solutions for all the orderings forms the polyhedral ambiguity set.


## Optimal Cross-Assignment
```julia
function cross_assignment(l::Int, h::Int, d::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    if (h - l ≤ 0) || (ϵ ≤ 0)
        return d
    end
    δ_l = d⁺[l] - d[l]
    δ_h = d[h] - d⁻[h]
    δ = min(δ_l, δ_h, ϵ)
    d[l] += δ
    d[h] -= δ
    if δ_l < δ_h
        return cross_assignment(l+1, h, d, d⁻, d⁺, ϵ-δ)
    elseif δ_l > δ_h
        return cross_assignment(l, h-1, d, d⁻, d⁺, ϵ-δ)
    else
        return cross_assignment(l+1, h-1, d, d⁻, d⁺, ϵ-δ)
    end
end

function cross_assignment(k::Int, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    d = zeros(k)
    cross_assignment(1, k, d, d⁻, d⁺, ϵ)
end
```

The `cross_assignment` algorithm computes the optimal cross-assignment given an **utility ordering** of $u_1≤u_2≤...≤u_k,$ such that the sequence $𝐝_0,𝐝_1,𝐝_2,...,𝐝_n$ converges toward the optimal cross-assignment $𝐝^{∗}=𝐝_n$ in at most $n≤k$ iterations.

---

Given $u_1≤u_2≤...≤u_k$ and previous iteration,  $𝐝=(d_1,d_2,...,d_k),$ the new iteration is $𝐝^{′}=(d_1^{′},d_2^{′},...,d_k^{′})$ such that $l,h∈I$ and $δ_l,δ_h∈ℝ$ and $d_l^{′}=d_l+δ_l$ and $d_h^{′}=d_h+δ_h$ and $d_i^{′}=d_i$ for all $i∈I∖\{l,h\}.$

---

Conservation of mass

$$𝐝^{′}⋅𝟏(k)=0 ⟹ δ_h=-δ_l.$$

---

Minimum:

$$\begin{aligned}
𝐝^{′}⋅𝐮&=d_l^{′}+d_h^{′}+∑_{i}d_i^{′} u_i \\
&=(d_l+δ_l)u_l+(d_h-δ_l)u_h+∑_{i}d_i u_i \\
&=𝐝⋅𝐮+δ_l (u_l-u_h) \\
&≤𝐝⋅𝐮
\end{aligned}$$

By choosing $δ_l>0$ and $u_l≤u_h$ which implies $l≤h.$

---

Negativity:

$$𝐝^{′}⋅𝐮≤𝐝_0⋅𝐮=𝟎 ⟹ 𝐝_0=𝟎.$$

---

Bounds:

$$d_l^{′}≤d_l^{+} ⟹ d_l+δ_l≤d_l^{+} ⟹ δ_l≤d_l^{+}-d_l$$

$$d_h^{′}≥d_h^{-} ⟹ d_h-δ_h≥d_h^{-} ⟹ δ_l≤d_h-d_h^{-}$$

---

In each step, we can minimize $𝐝^{′}⋅𝐮$ by choosing smallest $l$ and largest $h$ such that $δ_l>0.$ Then, choose largest $δ_l$ with fixed $l$ and $h$ without violating constraints. We obtain

$$δ_l=\min\{d_l^{+}-d_l,d_h-d_h^{-},ϵ-\|𝐝\|/2\}.$$


## Set of All Optimal Cross-assignments
```julia
using Combinatorics: permutations

function ambiguity_set(k, d⁻, d⁺, ϵ)
    Set(cross_assignment(k, d⁻[I′], d⁺[I′], ϵ)[I′] for I′ in permutations(1:k))
end
```

We can the derive all the other solutions as permutations of inputs values.

The discrete polyhedral uncertainty set is the set of optimal cross-assignments over all utility orderings.

$$𝐃_𝐩=\{𝐝^{∗}(𝐮)∣𝐮∈ℝ^k\}=\{𝐝^{∗}(𝐮(I^{′}))∣I^{′}∈\mathcal{P}(I)\}.$$

We generate all possible utility ordering of by generating all permutations of $I$ denoted as $\mathcal{P}(I),$ which has finite size $|\mathcal{P}(I)|=k!.$ For example, utility ordering $I^{′}=(1,2,...,k)∈\mathcal{P}(I)$ corresponds to ordering $u_1≤u_2≤...≤u_k.$

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

$$|𝐃_𝐩|≤\max_{I_{+},I_{0},I_{-}} \frac{|\mathcal{P}(I)|}{|\mathcal{P}(I_{+})||\mathcal{P}(I_{0})||\mathcal{P}(I_{-})|}≤|\mathcal{P}(I)|.$$

Note that the empty set has one permutation $|\mathcal{P}(∅)|=1.$
