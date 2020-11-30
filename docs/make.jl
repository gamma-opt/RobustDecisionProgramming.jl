using Documenter
using RobustDecisionProgramming

makedocs(
    sitename = "RobustDecisionProgramming",
    format = Documenter.HTML(),
    modules = [RobustDecisionProgramming]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/jaantollander/RobustDecisionProgramming.jl.git"
)
