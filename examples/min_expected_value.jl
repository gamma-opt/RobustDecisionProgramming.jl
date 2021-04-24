using JuMP
using DecisionProgramming
using RobustDecisionProgramming

function partial_expected_value(q, s_I, model, S, C, X, U⁺, z, k, hard_lower_bound, fixed)
    X′ = copy(X)
    X′[k].data[s_I..., :] = q
    P = DefaultPathProbability(C, X′)
    π_s = PathProbabilityVariables(model, z, S, P; hard_lower_bound=hard_lower_bound, fixed=fixed)
    pev = expected_value(model, π_s, U⁺)
    return pev
end

function minimum_partial_expected_value(dev, I_j, s_I, model, S, C, X, U⁺, z, k, hard_lower_bound)
    Q = polyhedral_uncertainty_set(dev)
    fixed = Dict{Node, State}(i=>s_i for (i, s_i) in zip(I_j, s_I))
    pevs = [partial_expected_value(q, s_I, model, S, C, X, U⁺, z, k, hard_lower_bound, fixed) for q in Q]
    x = @variable(model)
    for pev in pevs
        @constraint(model, x ≤ pev)
    end
    return (x=x, pevs=pevs, Q=Q, s_I=s_I)
end

"""Minimum expected value over discrete polyhedral uncertainty set."""
function min_expected_value(devs, model::Model, S::States, C::Vector{ChanceNode}, X, U⁺, z::DecisionVariables, k::Int; hard_lower_bound::Bool=false)
    mpevs = [minimum_partial_expected_value(dev, C[k].I_j, s_I, model, S, C, X, U⁺, z, k, hard_lower_bound) for (s_I, dev) in devs]
    min_ev = sum(mpev.x for mpev in mpevs)
    return (min_ev, mpevs)
end

"""Find distribution from uncertainty set that minimizes the partial expected value."""
function min_distribution(pevs, Q)
    return Q[argmin([value(pev) for pev in pevs])]
end

"""Consruct the probabilities that minimize the expected value."""
function min_probabilities(mpevs, X, k)
    X′ = copy(X)
    for (_, pevs, Q, s_I) in mpevs
        X′[k].data[s_I..., :] = min_distribution(pevs, Q)
    end
    return X′
end
