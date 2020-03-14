abstract type BO end

function next_point(bo::BO)
  lower, upper = bo.f.lower, bo.f.upper
  splits = bo.f.splits

  root, x0 = analyze(bo.acquire, splits, lower, upper)
  box = minimum(root)
  x_next = position(box, x0)

  x_next
end
