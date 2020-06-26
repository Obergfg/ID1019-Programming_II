defmodule Bitonic do
  def comp(low, high) do
    spawn(fn -> comp(0, low, high) end)
  end

  def comp(n, low, high) do
    receive do
      {:done, ^n} ->
        send(low, {:done, n})
        send(high, {:done, n})

      {:epoc, ^n, x1} ->
        receive do
          {:epoc, ^n, x2} ->
            if x1 < x2 do
              send(low, {:epoc, n, x1})
              send(high, {:epoc, n, x2})
            else
              send(low, {:epoc, n, x2})
              send(high, {:epoc, n, x1})
            end

            comp(n + 1, low, high)
        end
    end
  end

  def each([], _) do
    []
  end

  def each([element | rest], function) do
    [function.(element) | each(rest, function)]
  end

  def zip([], []) do
    []
  end

  def zip([a | ares], [b | bres]) do
    [{a, b} | zip(ares, bres)]
  end

  def sorter(sinks) do
    spawn(fn -> init(sinks) end)
  end

  def init(sinks) do
    netw = setup(sinks)
    sorter(0, netw)
  end

  def sorter(n, netw) do
    receive do
      {:sort, this} ->
        each(zip(netw, this), fn {cmp, x} -> send(cmp, {:epoc, n, x}) end)
        sorter(n + 1, netw)

      :done ->
        each(netw, fn cmp -> send(cmp, {:done, n}) end)
    end
  end

  def setup(sinks) do
    n = length(sinks)
    setup(n, sinks)
  end

  def setup(2, [s1, s2]) do
    cmp = comp(s1, s2)
    [cmp, cmp]
  end

  def start(n) do
    spawn(fn() -> init(n) end)
  end
end


