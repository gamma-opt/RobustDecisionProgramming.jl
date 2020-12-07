module RobustDecisionProgramming

using JuMP
using Base.Iterators: product
using Combinatorics: permutations

export wasserstein_ball, uncertainty_set, uncertainty_sets, worst_case

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
        δ = -min(σ, p[i])
        σ += δ
        q[i] += δ
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

function uncertainty_set_with_index(i, data, ϵ)
    set = uncertainty_set(data[i, :], ϵ)
    return collect(zip(fill(i, length(set)), set))
end

function combine(a::NTuple{K, Tuple{CartesianIndex{M}, Vector{Float64}}}, s::NTuple{N, Int})::Array{Float64, N} where {M, N, K}
    @assert M == N - 1
    p = zeros(s...)
    for (i, v) in a
        p[i, :] = v
    end
    return p
end

function uncertainty_sets(data::Array{Float64, N}, ϵ::Float64)::Vector{Array{Float64, N}} where N
    # TODO: ϵs::Vector{Float64}, size: |S_j|, j::Node
    s = size(data)
    sets = [uncertainty_set_with_index(i, data, ϵ) for i in CartesianIndices(s[1:end-1])];
    prods = vec(map(a -> combine(a, s), product(sets...)));
    return prods
end

function worst_case(model, objs)
    @variable(model, x)
    for obj in objs
        @constraint(model, x ≤ obj)
    end
    return x
end

end # module
