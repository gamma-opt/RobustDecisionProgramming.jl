module RobustDecisionProgramming

using JuMP
using Combinatorics: permutations

export cross_assignment, uncertainty_set

# FIXME: assume increasing order for consistency with documentation

function cross_assignment(l::Int, h::Int, d::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    if (h - l ≤ 0) || (ϵ ≤ 0)
        return d
    end
    a = abs(d⁻[l] - d[l])
    b = abs(d⁺[h] - d[h])
    if a < b
        c = min(a, ϵ)
        d[l] -= c
        d[h] += c
        return cross_assignment(l+1, h, d, d⁻, d⁺, ϵ - c)
    elseif a > b
        c = min(b, ϵ)
        d[l] -= c
        d[h] += c
        return cross_assignment(l, h-1, d, d⁻, d⁺, ϵ - c)
    else
        c = min(a, ϵ)
        d[l] -= c
        d[h] += c
        return cross_assignment(l+1, h-1, d, d⁻, d⁺, ϵ - c)
    end
end

function cross_assignment(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
    k = length(p)
    @assert k ≥ 1
    @assert length(p) == k
    @assert length(d⁻) == k
    @assert length(d⁺) == k
    @assert all(d⁻ .≥ -p)
    @assert all(d⁺ .≤ 1.0.-p)
    @assert 0 ≤ ϵ ≤ 1
    d = zeros(k)
    cross_assignment(1, k, d, d⁻, d⁺, ϵ)
end

function cross_assignment(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64})
    cross_assignment(p, d⁻, d⁺, 1.0)
end

function cross_assignment(p::Vector{Float64}, ϵ::Float64)
    cross_assignment(p, -p, 1.0.-p, ϵ)
end

"""Polyhedral uncertainty set."""
function uncertainty_set(p::Vector{Float64}, ϵ::Float64)::Vector{Vector{Float64}}
    @assert all(p .≥ 0)
    @assert isapprox(sum(p), 1)
    @assert 0 ≤ ϵ ≤ 1
    if iszero(ϵ)
        return [p]
    else
        i = [i for i in LinearIndices(p) if !iszero(p[i])]
        Q = Vector{Vector{Float64}}()
        for indices in permutations(i)
            q = copy(p)
            q[indices] += cross_assignment(p[indices], ϵ)
            push!(Q, q)
        end
        return Q
    end
end

end # module
