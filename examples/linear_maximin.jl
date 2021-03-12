using Random
using JuMP
using DecisionProgramming

include("min_expected_value.jl")

rng = MersenneTwister(22)

S = States([2, 3])
C = [ChanceNode(2, Node[1])]
D = [DecisionNode(1, Node[])]
V = [ValueNode(3, Node[1, 2])]
X = [Probabilities(rng, c, S) for c in C]
Y = [Consequences(rng, v, S) for v in V]

validate_influence_diagram(S, C, D, V)
sort!.((C, D, V, X, Y), by = x -> x.j)

U = DefaultPathUtility(V, Y)
U⁺ = PositivePathUtility(S, U)

model = Model()
z = DecisionVariables(model, S, D)
EV_min = min_expected_value(S, C, X, z, 1, 0.1)
@objective(model, Max, EV_min)

# using Gurobi
# optimizer = optimizer_with_attributes(
#     () -> Gurobi.Optimizer(Gurobi.Env()),
#     "IntFeasTol" => 1e-9,
# )
# set_optimizer(model, optimizer)
# optimize!(model)

# @info("Extracting results.")
# Z = DecisionStrategy(z)

# @info("Printing decision strategy:")
# print_decision_strategy(S, Z)
