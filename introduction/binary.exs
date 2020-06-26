defmodule Binary do

  def to_binary(n) do
    to_binary(n,[])
  end
  def to_binary(0,[]) do
    [0]
  end
  def to_binary(0,l) do
    l
  end
  def to_binary(n,l) do
    to_binary(div(n,2), append(rem(n,2), l))
  end

  def append(x,l) do
    [x|l]
  end


  def toint([])do
    0
  end
  def toint([h|t])do
    {s,_} = toint(t,h)
    s
  end
  def toint([], n)do
    {n,1}
  end
  def toint([h|t], n)do
    {s,e} = toint(t,h)
    {s + n*prod_exp(2,e), e + 1}
  end

  def prod_exp(m,n) do
    cond do
      n==0 -> 1
      true -> m * prod_exp(m, n-1)
    end
  end

  def to_integer(x) do to_integer(x, 0) end
  def to_integer([], n) do n end
  def to_integer([x | r], n) do
    to_integer(r, 2 * n + x)
  end
end


IO.inspect Binary.to_integer([1,0,1,0])
