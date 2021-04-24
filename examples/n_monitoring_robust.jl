using Logging, Random
using JuMP, Gurobi
using DecisionProgramming

include("min_expected_value.jl")

Random.seed!(13)

N = 4
L = [1]
R_k = [k + 1 for k in 1:N]
A_k = [(N + 1) + k for k in 1:N]
F = [2*N + 2]
T = [2*N + 3]
L_states = ["high", "low"]
R_k_states = ["high", "low"]
A_k_states = ["yes", "no"]
F_states = ["failure", "success"]
c_k = rand(N)
b = 0.03
fortification(k, a) = [c_k[k], 0][a]

@info("Creating the influence diagram.")
S = States([
    (length(L_states), L),
    (length(R_k_states), R_k),
    (length(A_k_states), A_k),
    (length(F_states), F)
])
C = Vector{ChanceNode}()
D = Vector{DecisionNode}()
V = Vector{ValueNode}()
X = Vector{Probabilities}()
Y = Vector{Consequences}()

for j in L
    I_j = Vector{Node}()
    X_j = zeros(S[I_j]..., S[j])
    X_j[1] = rand()
    X_j[2] = 1.0 - X_j[1]
    push!(C, ChanceNode(j, I_j))
    push!(X, Probabilities(j, X_j))
end

for j in R_k
    I_j = L
    x, y = rand(2)
    X_j = zeros(S[I_j]..., S[j])
    X_j[1, 1] = max(x, 1-x)
    X_j[1, 2] = 1.0 - X_j[1, 1]
    X_j[2, 2] = max(y, 1-y)
    X_j[2, 1] = 1.0 - X_j[2, 2]
    push!(C, ChanceNode(j, I_j))
    push!(X, Probabilities(j, X_j))
end

for (i, j) in zip(R_k, A_k)
    I_j = [i]
    push!(D, DecisionNode(j, I_j))
end

for j in F
    I_j = L ∪ A_k
    x, y = rand(2)
    X_j = zeros(S[I_j]..., S[j])
    for s in paths(S[A_k])
        d = exp(b * sum(fortification(k, a) for (k, a) in enumerate(s)))
        X_j[1, s..., 1] = max(x, 1-x) / d
        X_j[1, s..., 2] = 1.0 - X_j[1, s..., 1]
        X_j[2, s..., 1] = min(y, 1-y) / d
        X_j[2, s..., 2] = 1.0 - X_j[2, s..., 1]
    end
    push!(C, ChanceNode(j, I_j))
    push!(X, Probabilities(j, X_j))
end

for j in T
    I_j = A_k ∪ F
    Y_j = zeros(S[I_j]...)
    for s in paths(S[A_k])
        cost = sum(-fortification(k, a) for (k, a) in enumerate(s))
        Y_j[s..., 1] = cost + 0
        Y_j[s..., 2] = cost + 100
    end
    push!(V, ValueNode(j, I_j))
    push!(Y, Consequences(j, Y_j))
end

validate_influence_diagram(S, C, D, V)
sort!.((C, D, V, X, Y), by = x -> x.j)

P = DefaultPathProbability(C, X)
U = DefaultPathUtility(V, Y)


@info("Creating the decision model.")
U⁺ = PositivePathUtility(S, U)

k = length(X)  # choose failure node and its probability
# Strategy changes between ϵ 0.8 and 0.9
ϵ = 0.01  # we can try different parameters values here
deviations = [
    s_I => Deviation(X[k].data[s_I..., :], ϵ) for s_I in paths(S[C[k].I_j])
]

model = Model()
z = DecisionVariables(model, S, D)
(min_ev, mpevs) = min_expected_value(deviations, model, S, C, X, U⁺, z, k)
@objective(model, Max, min_ev)

@info("Starting the optimization process.")
optimizer = optimizer_with_attributes(
    () -> Gurobi.Optimizer(Gurobi.Env()),
    "IntFeasTol"      => 1e-9,
    # "LazyConstraints" => 1,
)
set_optimizer(model, optimizer)
optimize!(model)

@info("Construct minimizing path probability")
X′ = min_probabilities(mpevs, X, k)
P = DefaultPathProbability(C, X′)

@info("Reoptimize model with minimum path probability")
model2 = Model()
z2 = DecisionVariables(model2, S, D)
π_s = PathProbabilityVariables(model2, z2, S, P; hard_lower_bound=false)
probability_cut(model2, π_s, P)
# active_paths_cut(model2, π_s, S, P)
ev = expected_value(model2, π_s, U⁺)
@objective(model2, Max, ev)

optimizer2 = optimizer_with_attributes(
    () -> Gurobi.Optimizer(Gurobi.Env()),
    "IntFeasTol"      => 1e-9,
    "LazyConstraints" => 1,
)
set_optimizer(model2, optimizer2)
optimize!(model2)

@info("Extracting results.")
Z = DecisionStrategy(z)

@info("Printing decision strategy:")
print_decision_strategy(S, Z)

@info("Printing state probabilities:")
sprobs = StateProbabilities(S, P, Z)
print_state_probabilities(sprobs, L)
print_state_probabilities(sprobs, R_k)
print_state_probabilities(sprobs, A_k)
print_state_probabilities(sprobs, F)

@info("Computing utility distribution.")
udist = UtilityDistribution(S, P, U, Z)

@info("Printing utility distribution.")
print_utility_distribution(udist)

@info("Printing statistics")
print_statistics(udist)
