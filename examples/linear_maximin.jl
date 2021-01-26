using Random
using JuMP
using Gurobi
using DecisionProgramming
using RobustDecisionProgramming
using Base.Iterators: product

rng = MersenneTwister(22)

S = States([2, 3])
C = [ChanceNode(2, Node[1])]
D = [DecisionNode(1, Node[])]
V = [ValueNode(3, Node[1, 2])]
X = [Probabilities(rng, c, S) for c in C]
Y = [Consequences(rng, v, S) for v in V]

validate_influence_diagram(S, C, D, V)
sort!.((C, D, V, X, Y), by = x -> x.j)

function min_expected_value(S, C, X, z, k, ϵ)
    xs = Vector{VariableRef}()
    I_j = C[k].I_j
    for s_I in paths(S[I_j])
        p = X[k].data[s_I..., :]
        fixed = Dict{Node, State}(i=>s_i for (i, s_i) in zip(I_j, s_I))
        x = @variable(model)
        for q in uncertainty_set(p, ϵ)
            X′ = copy(X)
            X′[k].data[s_I..., :] = q
            P = DefaultPathProbability(C, X′)
            # Partial path probability variables
            π_s = PathProbabilityVariables(model, z, S, P; hard_lower_bound=false, fixed=fixed)
            # Partial expected value
            EV = expected_value(model, π_s, U⁺)
            @constraint(model, x ≤ EV)
        end
        push!(xs, x)
    end
    return sum(x for x in xs)
end

U = DefaultPathUtility(V, Y)
U⁺ = PositivePathUtility(S, U)

model = Model()
z = DecisionVariables(model, S, D)
EV_min = min_expected_value(S, C, X, z, 1, 0.1)
@objective(model, Max, EV_min)

optimizer = optimizer_with_attributes(
    () -> Gurobi.Optimizer(Gurobi.Env()),
    "IntFeasTol" => 1e-9,
)
set_optimizer(model, optimizer)
optimize!(model)

@info("Extracting results.")
Z = DecisionStrategy(z)

@info("Printing decision strategy:")
print_decision_strategy(S, Z)
