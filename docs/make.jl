using Documenter
using RobustDecisionProgramming

makedocs(
    sitename = "RobustDecisionProgramming.jl",
    format = Documenter.HTML(),
    modules = [RobustDecisionProgramming],
    pages = [
        "Home" => "index.md",
        "Distributional Robustness" => Any[
            "distributional_robustness/best-worst-case-expected-value.md",
            "distributional_robustness/polyhedral-uncertainty-set.md",
            "distributional_robustness/distributionally-robust-decision-model.md"
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
