# API Reference
```@docs
Deviation
Deviation(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
Deviation(p::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64})
Deviation(p::Vector{Float64}, ϵ::Float64)
cross_assignment(l::Int, h::Int, Σ::Float64, d::Vector{Float64}, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
cross_assignment(n::Int, d⁻::Vector{Float64}, d⁺::Vector{Float64}, ϵ::Float64)
cross_assignment(dev::Deviation)
polyhedral_uncertainty(mask::Vector{Int}, dev::Deviation)
polyhedral_uncertainty_set(dev::Deviation)
```
