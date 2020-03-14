include("./bo.jl")
include("../functions/benchmark_function.jl")

mutable struct EI <: BO
  f::BenchmarkFunction
  xi::Float64
  EI(f::BenchmarkFunction, xi::Float64) = new(f, xi)
end

function acquire(ei::EI, x)
  mean, var = predict(model, reshape(x, length(x), 1))
  if var == 0
    return 0
  else
    Z = (mean - ymax)/sqrt(var)
    res = -((mean - ymax) * cdf(Normal(), Z) + sqrt(var) * pdf(Normal(), Z))[1]
    return res
  end
end
