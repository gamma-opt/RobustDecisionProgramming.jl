using JuMP
using DecisionProgramming
using RobustDecisionProgramming

"""Objective to minimize expected value.

- `k`: Index for the robust chance node
- `ϵ`: Radius of uncertainty
"""
function min_expected_value(S::States, C::Vector{ChanceNode}, X::Vector{Probabilities{N}}, z::DecisionVariables, k::Int, ϵ::Float64) where N
    # Information set of chance node `k`
    I_j = C[k].I_j

    xs = Vector{VariableRef}()

    # For all information paths `S[I(i)]`
    for s_I in paths(S[I_j])
        # Probability
        p = X[k].data[s_I..., :]

        # Fixed path
        fixed = Dict{Node, State}(i=>s_i for (i, s_i) in zip(I_j, s_I))

        # Partial minimum expected value
        x = @variable(model)

        # For all probabilities in the uncertainty set around `p`
        for q in uncertainty_set(p, ϵ)
            # ...
            X′ = copy(X)
            X′[k].data[s_I..., :] = q
            P = DefaultPathProbability(C, X′)

            # Partial path probability variables
            π_s = PathProbabilityVariables(model, z, S, P; hard_lower_bound=false, fixed=fixed)

            # Partial expected value constraint
            EV = expected_value(model, π_s, U⁺)
            @constraint(model, x ≤ EV)
        end
        push!(xs, x)
    end

    # Minimum expected value
    return sum(x for x in xs)
end
