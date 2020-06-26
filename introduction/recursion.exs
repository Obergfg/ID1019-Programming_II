defmodule Recursion do

  def prod(m,n)do
    cond do
      m == 0 -> 0
      m < 0  -> prod(m*-1, n*-1)
      m < 0 and n < 0 -> prod(m*-1, n*-1)
      true -> n + prod(m-1, n)
    end
  end

  def prod_exp(m,n) do
    cond do
      n==0 -> 1
      true -> m * prod_exp(m, n-1)
    end
  end


  def exp_faster(_, 0) do
    1
  end
  def exp_faster(x, n) do
    case rem(n, 2) do
      0 -> e = exp_faster(x, div(n, 2))
      e * e
      1 -> exp_faster(x, n - 1) * x
    end
  end

  def fib(0) do
    0
  end
  def fib(1) do
    1
  end
  def fib(n)do
    fib(n-1) + fib(n-2)
  end

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

  def bench_fib() do
    ls = [8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40]
    n = 10

    bench = fn(l) ->
      t = time(n, fn() -> fib(l) end)
      :io.format("n: ~4w  fib(n) calculated in: ~8w us~n", [l, t])
    end

    Enum.each(ls, bench)
  end

  def acker(0,n)do
    n+1
  end
  def acker(m,n)do
    cond do
      m > 0 and n == 0 -> acker(m-1, 1)
      true -> acker(m-1, acker(m, n-1))
    end
  end
end

IO.puts Recursion.bench_fib()
