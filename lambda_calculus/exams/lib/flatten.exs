defmodule Flatten do

  def flatten([]) do
    []
  end

  def flatten([a|b]) do
    flatten(a) ++ flatten(b)
  end

  def flatten(a) do
    [a]
  end

end

defmodule Toggle do

  def toggle([]) do
    []
  end

  def toggle(rest) do
    rest
  end

  def toggle([a,b|rest]) do
    [b, a | toggle(rest)]
  end



end

IO.inspect Toggle.toggle([:a,:b,:c,:d,:e,:f,:g,:h, :i])
