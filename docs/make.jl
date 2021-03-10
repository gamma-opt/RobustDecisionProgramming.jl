using Documenter
using RobustDecisionProgramming

makedocs(
    sitename = "RobustDecisionProgramming.jl",
    format = Documenter.HTML(),
    modules = [RobustDecisionProgramming],
    pages = [
        "Home" => "index.md",
        "robust-optimization.md",
        "Distributional Robustness" => Any[
            "distributional_robustness/best-worst-case-expected-value.md",
            "distributional_robustness/uncertainty-sets.md",
            "distributional_robustness/robust-decision-programming.md"
            ],
        "api.md"
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/gamma-opt/RobustDecisionProgramming.jl.git"
)
