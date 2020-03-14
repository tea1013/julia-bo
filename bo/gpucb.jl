include("./bo.jl")
include("../functions/benchmark_function.jl")
using Distributions

mutable struct GPUCB <: BO
  model::Any
  f::BenchmarkFunction
  t::Int64
  GPUCB(model::Any, f::BenchmarkFunction) = new(model, f, 1)
end

function acquire(gpucb::GPUCB, x)
  if x[1] in gpucb.model.x
    return 0
  end

  mean, var = predict_y(gpucb.model, reshape(x, length(x), 1))
  mu = mean[1]
  std = sqrt(var[1])

  beta = log(gpucb.t^2 + 0.1)
  gpucb.t = gpucb.t + 1
  res = mu + sqrt(beta) * std

  -res
end

acquire(gpucb::GPUCB) = x -> acquire(gpucb, x)

