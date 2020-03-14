include("./bo.jl")
include("../functions/benchmark_function.jl")
using Distributions

mutable struct EI <: BO
  model::Any
  f::BenchmarkFunction
  ymax::Float64
  xi::Float64
  EI(model::Any, f::BenchmarkFunction, ymax::Float64, xi::Float64) = new(model, f, ymax, xi)
end

function acquire(ei::EI, x)
  if x[1] in ei.model.x
    return 0
  end

  mean, var = predict_y(ei.model, reshape(x, length(x), 1))
  mu = mean[1]
  std = sqrt(var[1])

  if std == 0
    return 0
  end

  Z = (mu - ei.ymax - ei.xi) / std
  res = (mu - ei.ymax - ei.xi) * cdf(Normal(), Z) + std * pdf(Normal(), Z)

  -res
end

acquire(ei::EI) = x -> acquire(ei, x)
