include("./benchmark_function.jl")

mutable struct Forrester <: BenchmarkFunction
    dim::Int64
    bounds::Array{Array{Float64, 1}, 1}
end

Forrester() = Forrester(1, [[0.0, 1.0]])

function value(f::Forrester, x)
    obj = ((6 * x - 2)^2) * sin(12 * x - 4)
    -obj
end
