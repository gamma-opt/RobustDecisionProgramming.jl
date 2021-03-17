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

k = 1
ϵ = 0.1
deviations = [
    s_I => Deviation(X[k].data[s_I..., :], ϵ) for s_I in paths(S[C[k].I_j])
]

model = Model()
z = DecisionVariables(model, S, D)
(min_ev, mpevs) = min_expected_value(deviations, model, S, C, X, U⁺, z, k)
@objective(model, Max, min_ev)

using SCIP
optimizer = optimizer_with_attributes(
    () -> SCIP.Optimizer()
)

set_optimizer(model, optimizer)
optimize!(model)

@info("Extracting results.")
Z = DecisionStrategy(z)

@info("Printing decision strategy:")
print_decision_strategy(S, Z)

@info("Construct minimizing path probability")
X′ = min_probabilities(mpevs, X, k)
P = DefaultPathProbability(C, X′)

@info("Computing utility distribution.")
udist = UtilityDistribution(S, P, U, Z)

@info("Printing utility distribution.")
print_utility_distribution(udist)

@info("Printing statistics")
print_statistics(udist)
