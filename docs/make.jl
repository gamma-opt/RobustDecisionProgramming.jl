using Documenter
using RobustDecisionProgramming

makedocs(
    sitename = "RobustDecisionProgramming.jl",
    format = Documenter.HTML(),
    modules = [RobustDecisionProgramming],
    pages = [
        "Home" => "index.md",
        "robust-optimization.md",
        "robust-decision-programming.md",
        "api.md"
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/jaantollander/RobustDecisionProgramming.jl.git"
)
