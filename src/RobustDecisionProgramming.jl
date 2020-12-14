module RobustDecisionProgramming

using JuMP
using Combinatorics: permutations

export wasserstein_ball, uncertainty_set

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
