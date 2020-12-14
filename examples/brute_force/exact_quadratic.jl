using Random
using JuMP
using Gurobi
using DecisionProgramming
using RobustDecisionProgramming
using Base.Iterators: product

include("brute.jl")

rng = MersenneTwister(22)

S = States([2, 2, 3])
C = [ChanceNode(1, Node[]), ChanceNode(3, Node[2])]
D = [DecisionNode(2, Node[1])]
V = [ValueNode(4, Node[2, 3])]
X = [Probabilities(rng, c, S) for c in C]
Y = [Consequences(rng, v, S) for v in V]

validate_influence_diagram(S, C, D, V)
sort!.((C, D, V, X, Y), by = x -> x.j)

ks = [1, 2]
ϵs = [0.1, 0.07]
rs = [[x] for x in X]
for (k, ϵ) in zip(ks, ϵs)
    rs[k] = [Probabilities(X[k].j, d) for d in uncertainty_sets(X[k].data, ϵ)]
end
Xs = vec(map(x -> [x...], product(rs...)))

U = DefaultPathUtility(V, Y)
U⁺ = PositivePathUtility(S, U)

model = Model()
z = DecisionVariables(model, S, D)
Ps = Vector{DefaultPathProbability}()
EVs = Vector{GenericAffExpr}()
for X′ in Xs
    P = DefaultPathProbability(C, X′)
    π_s = PathProbabilityVariables(model, z, S, P; hard_lower_bound=false)
    EV = expected_value(model, π_s, U⁺)
    push!(Ps, P)
    push!(EVs, EV)
end
f = worst_case(model, EVs)
@objective(model, Max, f)

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
