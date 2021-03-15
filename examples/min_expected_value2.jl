using JuMP
using DecisionProgramming
using RobustDecisionProgramming

struct MinimumPartialExpectedValue
    s_I::Vector{State}  # information path
    x::VariableRef      # minimum partial expected value
    Q::Vector{Float64}  # uncertainty set
    pevs::Vector{Expr}  # partial expected values
end

function MinimumPartialExpectedValue(I_j::Vector{Node}, s_I::Vector{State}, model::Model, S::States, C::Vector{ChanceNode}, X::Vector{Probabilities{N}}, z::DecisionVariables, k::Int, ϵ::Float64; hard_lower_bound=false)
    # Probability
    p = X[k].data[s_I..., :]
    # Fix information path `s_I`
    fixed = Dict{Node, State}(i=>s_i for (i, s_i) in zip(I_j, s_I))
    # Minimum partial expected value
    x = @variable(model)
    # For all probabilities in the uncertainty set around `p`
    Q = uncertainty_set(p, ϵ)
    pevs = Vector{Expr}()
    for q in Q
        X′ = copy(X)
        X′[k].data[s_I..., :] = q
        P = DefaultPathProbability(C, X′)
        # Partial path probability variables
        π_s = PathProbabilityVariables(model, z, S, P; hard_lower_bound=hard_lower_bound, fixed=fixed)
        # Partial expected value upper bound constraint
        ev = expected_value(model, π_s, U⁺)
        @constraint(model, x ≤ ev)
        push!(pevs, ev)
    end
    MinimumPartialExpectedValue(s_I, x, Q, pevs)
end

struct MinimumExpectedValue{N}
    k::Node     # robust decision node
    ϵ::Float64  # radius of uncertainty
    pevs::Vector{MinimumPartialExpectedValue}
    mev::Expr   # minimum expected value
    X::Vector{Probabilities{N}}
end

function MinimumExpectedValue(model::Model, S::States, C::Vector{ChanceNode}, X::Vector{Probabilities{N}}, z::DecisionVariables, k::Node, ϵ::Float64; hard_lower_bound=false) where N
    I_j = C[k].I_j
    pevs = [MinimumPartialExpectedValue(I_j, s_I, model, S, C, X, z, k, ϵ; hard_lower_bound) for s_I in paths(S[I_j])]
    pmev = sum(ev.x for ev in pevs)
    MinimumExpectedValue(k, ϵ, pevs, pmev, X)
end

"""Minimum discrete probabilities"""
function min_distribution(pev::MinimumPartialExpectedValue)
    i = argmin([value(ev.x) for ev in pev.pevs])
    return pev.Q[i]
end

"""Minimum Probabilities

# Examples
```julia
X′ = min_probabilities(X, ...)
P = DefaultPathProbability(C, X′)
```
"""
function min_probabilities(mev::MinimumExpectedValue)
    X′ = copy(mev.X)
    k = mev.k
    for pev in mev.pevs
        s_I = mev.s_I
        X′[k].data[s_I..., :] = min_distribution(pev)
    end
    return X′
end
