include("./bo/bo.jl")
include("./bo/ei.jl")
include("./bo/gpucb.jl")
include("./functions/benchmark_function.jl")
include("./functions/forrester.jl")
using Printf
using Plots
using GaussianProcesses
using Optim

const f = Forrester()

X = rand(Uniform(0, 1), 5)
y = Float64[]
for x in X
     push!(y, value(f, x))
end
const noise_var = -2.0

const iterationnum = 30
for i in 1:iterationnum
  gp_model = GP(X, y, MeanZero(), SE(-2.0, 0.0), noise_var)

  if i == iterationnum
    plot(gp_model; xlabel="x", ylabel="y", title="Gaussian process", legend=false, fmt=:pdf)
    savefig("gp.pdf")
  end

  optimize!(gp_model)

  ymax = maximum(y)

  #= EI =#
  ei = EI(gp_model, f, ymax, 1e-2)
  nextx = next_point(ei)["x"][1]

  #= GPUCB =#
  #= gpucb = GPUCB(gp_model, f) =#
  #= nextx = next_point(gpucb)["x"][1] =#

  nexty = value(f, nextx)

  @printf("next x = %f, next y = %f \n", nextx, nexty)
  push!(X, nextx)
  push!(y, nexty)

end
