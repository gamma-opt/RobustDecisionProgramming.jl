using JuMP
using Combinatorics: permutations

"""Stores and validates the values of a deviation for discrete probabilities `p`.

# Arguments
- `n::Int`: Length of discrete probabilities
- `p::Vector{Float64}`: Vector of discrete probabilities
- `d⁻::Vector{Float64}`: Vector of lower bounds
- `d⁺::Vector{Float64}`: Vector of uppper bounds
- `ϵ::Float64`: Radius of uncertainty

The arguments should satisfy the following conditions:

```julia
n ≥ 1
all(p .≥ 0)
isapprox(sum(p), 1)
length(p) == length(d⁻) == length(d⁺) == n
all(d⁻ .≥ -p)
all(d⁺ .≤ 1.0.-p)
0 ≤ ϵ ≤ 1
```

# Examples
Arguments

```julia
n = 2
p = [0.4, 0.6]
d⁻ = [-0.2, -0.2]
d⁺ = [0.2, 0.2]
ϵ = 0.1
```
"""
struct Deviation
    n::Int
    p::Vector{Float64}
    d⁻::Vector{Float64}
    d⁺::Vector{Float64}
    ϵ::Float64
    function Deviation(n::Int, p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
        n ≥ 1 || throw(DomainError(""))
        all(p .≥ 0) || throw(DomainError(""))
        isapprox(sum(p), 1) || throw(DomainError(""))
        length(p) == length(d⁻) == length(d⁺) == n || throw(DomainError(""))
        all(d⁻ .≥ -p) || throw(DomainError(""))
        all(d⁺ .≤ 1.0.-p) || throw(DomainError(""))
        0 ≤ ϵ ≤ 1 || throw(DomainError(""))
        new(n, p, d⁻, d⁺, ϵ)
    end
end

"""Constructs a deviation.

Examples
```julia
Deviation(p, d⁻, d⁺, ϵ)
```
"""
function Deviation(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    n = length(p)
    Deviation(n, p, d⁻, d⁺, ϵ)
end

"""Constructs a deviation.

```julia
Deviation(p, d⁻, d⁺)
```
"""
function Deviation(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64})
    Deviation(p, d⁻, d⁺, 1.0)
end

"""Constructs a deviation.

```julia
Deviation(p, ϵ)
```
"""
function Deviation(p::Vector{Float64}, ϵ::Float64)
    Deviation(p, -p, 1.0.-p, ϵ)
end

"""Computes the optimal cross-assignment recursively."""
function cross_assignment(l::Int, h::Int, d::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    if (h - l ≤ 0) || (ϵ ≤ 0)
        return d
    end
    δ_l = abs(d⁺[l] - d[l])
    δ_h = abs(d⁻[h] - d[h])
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

"""Compute cross-assignment."""
function cross_assignment(k::Int, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    d = zeros(k)
    cross_assignment(1, k, d, d⁻, d⁺, ϵ)
end

"""Computes the optimal cross assignment from deviation.

# Examples
```julia
dev = Deviation(...)
cross_assignment(dev)
```
"""
function cross_assignment(dev::Deviation)
    cross_assignment(dev.n, dev.d⁻, dev.d⁺, dev.ϵ)
end

"""Polyhedral uncertainty"""
function polyhedral_uncertainty(perm::Vector{Int}, dev::Deviation)
    q = copy(dev.p)
    q[perm] += cross_assignment(length(perm), dev.d⁻[perm], dev.d⁺[perm], dev.ϵ)
    return q
end

"""Polyhedral uncertainty set."""
function polyhedral_uncertainty_set(dev::Deviation)::Array{Vector{Float64}}
    p, ϵ = dev.p, dev.ϵ
    if iszero(ϵ)
        return [p]
    else
        i = [i for i in LinearIndices(p) if !iszero(p[i])]
        s = Set(polyhedral_uncertainty(perm, dev) for perm in permutations(i))
        return collect(s)
    end
end
