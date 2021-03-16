using JuMP
using Combinatorics: permutations

"""Deviation"""
struct Deviation
    n::Int
    p::Vector{Float64}
    d⁻::Vector{Float64}
    d⁺::Vector{Float64}
    ϵ::Float64
    function Deviation(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
        n = length(p)
        n ≥ 1 || throw(DomainError(""))
        all(p .≥ 0) || throw(DomainError(""))
        isapprox(sum(p), 1) || throw(DomainError(""))
        length(p) == n || throw(DomainError(""))
        length(d⁻) == n || throw(DomainError(""))
        length(d⁺) == n || throw(DomainError(""))
        all(d⁻ .≥ -p) || throw(DomainError(""))
        all(d⁺ .≤ 1.0.-p) || throw(DomainError(""))
        0 ≤ ϵ ≤ 1 || throw(DomainError(""))
        new(n, p, d⁻, d⁺, ϵ)
    end
end

function Deviation(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64})
    Deviation(p, d⁻, d⁺, 1.0)
end

function Deviation(p::Vector{Float64}, ϵ::Float64)
    Deviation(p, -p, 1.0.-p, ϵ)
end

# FIXME: assume increasing order for consistency with documentation

"""Function that computes the optimal cross-assignment."""
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

function cross_assignment(n, d⁻, d⁺, ϵ)
    d = zeros(n)
    cross_assignment(1, n, d, d⁻, d⁺, ϵ)
end

function cross_assignment(dev::Deviation)
    cross_assignment(dev.n, dev.d⁻, dev.d⁺, dev.ϵ)
end

function polyhedral_uncertainty(mask::Vector{Int}, dev::Deviation)
    q = copy(dev.p)
    q[mask] += cross_assignment(length(mask), dev.d⁻[mask], dev.d⁺[mask], dev.ϵ)
    return q
end

function polyhedral_uncertainty_set(dev::Deviation)::Set{Vector{Float64}}
    p, ϵ = dev.p, dev.ϵ
    if iszero(ϵ)
        return [p]
    else
        i = [i for i in LinearIndices(p) if !iszero(p[i])]
        return Set(polyhedral_uncertainty(mask, dev) for mask in permutations(i))
    end
end

"""Polyhedral uncertainty set."""
struct PolyhedralUncertaintySet
    dev::Deviation
    set::Set{Vector{Float64}}
end

function PolyhedralUncertaintySet(dev::Deviation)
    set = polyhedral_uncertainty_set(dev)
    PolyhedralUncertaintySet(dev, set)
end
