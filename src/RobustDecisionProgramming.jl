module RobustDecisionProgramming

using JuMP
using Combinatorics: permutations

export cross_assignment, wasserstein_ball, uncertainty_set

function cross_assignment(l::Int, h::Int, d::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    if (h - l ≤ 1) || (ϵ ≤ 0)
        return d
    end
    a = abs(d⁻[l] - d[l])
    b = abs(d⁺[h] - d[h])
    if a < b
        c = min(2*a, ϵ)
        d[l] += c/2
        d[h] -= c/2
        return cross_assignment(l+1, h, d, d⁻, d⁺, ϵ - c)
    elseif a > b
        c = min(2*b, ϵ)
        d[l] += c/2
        d[h] -= c/2
        return cross_assignment(l, h-1, d, d⁻, d⁺, ϵ - c)
    else
        c = min(2*a, ϵ)
        d[l] += c/2
        d[h] -= c/2
        return cross_assignment(l+1, h-1, d, d⁻, d⁺, ϵ - c)
    end
end

function cross_assignment(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    k = length(p)
    @assert length(p) == k
    @assert length(d⁻) == k
    @assert length(d⁺) == k
    @assert all(d⁻ .≥ -p)
    @assert all(d⁺ .≤ 1-p)
    @assert ϵ ≥ 0
    d = zeros(k)
    cross_assignment(1, k, d, d⁻, d⁺, ϵ)
end

function cross_assignment(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64})
    cross_assignment(p, d⁻, d⁺, 2.0)
end

function cross_assignment(p::Vector{Float64}, ϵ::Float64)
    cross_assignment(p, -p, 1-p, ϵ)
end

function wasserstein_ball(indices::Vector{Int}, p::Vector{Float64}, ϵ::Float64)
    k = indices[end]
    r = 2*ϵ
    if r + p[k] > 1
        r = 1 - p[k]
    end
    q = copy(p)
    j = 1
    σ = r
    while σ > 0
        i = indices[j]
        d = -min(σ, p[i])
        σ += d
        q[i] += d
        j += 1
    end
    q[k] += r
    return q
end

function uncertainty_set(p::Vector{Float64}, ϵ::Float64)::Vector{Vector{Float64}}
    @assert all(p .≥ 0)
    @assert isapprox(sum(p), 1)
    @assert 0 ≤ ϵ ≤ 1
    if iszero(ϵ)
        return [p]
    else
        # Exclude iszero(p[i]) indices from the permutations
        i = [i for i in LinearIndices(p) if !iszero(p[i])]
        return [wasserstein_ball(indices, p, ϵ) for indices in permutations(i)]
    end
end

end # module
