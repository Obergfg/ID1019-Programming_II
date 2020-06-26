defmodule Lists do

  def tak(x)do
    [a|_] = x
    a
  end

  def drop(x)do
    [_|y]=x
    y
  end

  def len([])do 0 end
  def len(l)do
    a = drop(l)
    1 + len(a)
  end

  def len2(l)do
    cond do
      l==[] -> 0
      true -> a = drop(l)
      1 + len2(a)
    end
  end

  def sum([])do 0 end
  def sum(l) do
    tak(l) + sum(drop(l))
  end

  def duplicate(l)do
    cond do
      0 == len(l) -> []
      true -> a = tak(l)
      [a,a| duplicate(drop(l))]
    end
  end

  def duplicate2([])do [] end
  def duplicate2([x|y])do
    [x, x|duplicate2(y)]
  end

  def add(x,[])do [x] end
  def add(x,[head|tail])do
    cond do
      x == head -> [head|tail]
      true -> [head|add(x, tail)]
    end
  end

  def remove(_,[])do [] end
  def remove(x,[h|t])do
    cond do
      x == h -> remove(x,t)
      true -> [h|remove(x,t)]
    end
  end

  def unique([])do [] end
  def unique([h|t]) do
    [h|unique(remove(h,t))]
  end

  def append([],[])do [] end
  def append(l,[])do l end
  def append([], l)do l end
  def append([h|t],l)do
      [h|append(t,l)]
  end

  def nreverse([]) do [] end

def nreverse([h | t]) do
  r = nreverse(t)
  append(r, [h])
end

def reverse(l) do
  reverse(l, [])
end

def reverse([], r) do r end
def reverse([h | t], r) do
  reverse(t, [h | r])
end

def bench() do
  ls = [16, 32, 64, 128, 256, 512]
  n = 100
  # bench is a closure: a function with an environment.
  bench = fn(l) ->
    seq = Enum.to_list(1..l)
    tn = time(n, fn -> nreverse(seq) end)
    tr = time(n, fn -> reverse(seq) end)
    :io.format("length: ~10w  nrev: ~8w us    rev: ~8w us~n", [l, tn, tr])
  end

  # We use the library function Enum.each that will call
  # bench(l) for each element l in ls
  Enum.each(ls, bench)
end

# Time the execution time of the a function.
def time(n, fun) do
  start = System.monotonic_time(:milliseconds)
  loop(n, fun)
  stop = System.monotonic_time(:milliseconds)
  stop - start
end

# Apply the function n times.
def loop(n, fun) do
  if n == 0 do
    :ok
  else
    fun.()
    loop(n - 1, fun)
  end
end

end

IO.inspect Lists.nreverse([4,3,2,1])
