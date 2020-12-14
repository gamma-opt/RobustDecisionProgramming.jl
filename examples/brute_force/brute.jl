function uncertainty_set_with_index(i, data, ϵ)
    set = uncertainty_set(data[i, :], ϵ)
    return collect(zip(fill(i, length(set)), set))
end

function combine(a::NTuple{K, Tuple{CartesianIndex{M}, Vector{Float64}}}, s::NTuple{N, Int})::Array{Float64, N} where {M, N, K}
    @assert M == N - 1
    p = zeros(s...)
    for (i, v) in a
        p[i, :] = v
    end
    return p
end

function uncertainty_sets(data::Array{Float64, N}, ϵ::Float64)::Vector{Array{Float64, N}} where N
    # TODO: ϵs::Vector{Float64}, size: |S_j|, j::Node
    s = size(data)
    sets = [uncertainty_set_with_index(i, data, ϵ) for i in CartesianIndices(s[1:end-1])];
    prods = vec(map(a -> combine(a, s), product(sets...)));
    return prods
end

function worst_case(model, objs)
    @variable(model, x)
    for obj in objs
        @constraint(model, x ≤ obj)
    end
    return x
end
