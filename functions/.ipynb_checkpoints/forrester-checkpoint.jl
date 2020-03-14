include("./benchmark_function.jl")

mutable struct Forrester <: BenchmarkFunction
    dim::Int64
    lower::Array{Float64, 1}
    upper::Array{Float64, 1}
    splits::Array{Array{Float64, 1}, 1}
    Forrester() = Forrester(1, [0.0], [1.0], [[0.5], [0.5]])
end


function value(f::Forrester, x)
    obj = (6 * x^2)^2 * sin(12 * x)
    -obj
end
