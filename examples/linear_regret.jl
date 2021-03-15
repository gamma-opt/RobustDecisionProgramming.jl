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

# --- Maximize expected value ---

model = Model()
z = DecisionVariables(model, S, D)
P = DefaultPathProbability(C, X)
π_s = PathProbabilityVariables(model, z, S, P; hard_lower_bound=false)
EV = expected_value(model, π_s, U⁺)
@objective(model, Max, EV)

using SCIP
optimizer = optimizer_with_attributes(
    () -> SCIP.Optimizer()
)
set_optimizer(model, optimizer)
optimize!(model)

# --- Minimize regret ---

model = Model()
z = DecisionVariables(model, S, D)
μ = value(EV)
k = 1
ϵ = 0.1
regret = μ - min_expected_value(model, S, C, X, z, k, ϵ)
@objective(model, Min, regret)

optimizer = optimizer_with_attributes(
    () -> SCIP.Optimizer()
)
set_optimizer(model, optimizer)
optimize!(model)

# --- Results ---

@info("Extracting results.")
Z = DecisionStrategy(z)

@info("Printing decision strategy:")
print_decision_strategy(S, Z)
