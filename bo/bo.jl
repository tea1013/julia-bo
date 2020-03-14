using PyCall
direct = pyimport("scipydirect")

abstract type BO end

function next_point(bo::BO)
  res = direct.minimize(acquire(bo), bo.f.bounds, maxf=1000*bo.f.dim, algmethod=1)
  res
end
