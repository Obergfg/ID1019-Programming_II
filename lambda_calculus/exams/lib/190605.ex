defmodule First do
  def drop(0, list) do
    list
  end

  def drop(n, list) do
    drop(n, n, list)
  end

  def drop(_, _, []) do
    []
  end

  def drop(1, n, [_ | tail]) do
    drop(n, n, tail)
  end

  def drop(k, n, [head | tail]) do
    [head | drop(k - 1, n, tail)]
  end
end

defmodule Second do
  def rotate(list, n) do
    rotate([], list, n)
  end

  def rotate(upper, lower, 0) do
    :lists.append(lower, :lists.reverse(upper))
  end

  def rotate(upper, [head | tail], n) do
    rotate([head | upper], tail, n - 1)
  end
end

defmodule Third do
  @type tree() :: {:leaf, any()} | {:node, tree(), tree()}

  def nth(1, {:leaf, n}) do
    {:found, n}
  end

  def nth(n, {:leaf, _}) do
    {:cont, n - 1}
  end

  def nth(n, {:node, left, right}) do
    case nth(n, left) do
      {:cont, m} ->
        nth(m, right)

      {:found, value} ->
        {:found, value}
    end
  end
end

defmodule Fourth do
  @type op() :: :add | :sub
  @type instr() :: integer() | op()
  @type seq() :: [instr()]
  @spec hp35(seq()) :: integer()

  def hp35(list) do
    hp35([], list)
  end

  def hp35([tot], []) do
    tot
  end

  def hp35([m, n | stack], [:add | rest]) do
    hp35([m + n | stack], rest)
  end

  def hp35([m, n | stack], [:sub | rest]) do
    hp35([n - m | stack], rest)
  end

  def hp35(stack, [n | rest]) do
    hp35([n | stack], rest)
  end
end

defmodule Fifth do
  def pascal(1) do
    [1]
  end

  def pascal(n) do
    pascal(n - 1, fact(n - 1), n - 1)
  end

  def pascal(_, _, 0) do
    [1]
  end

  def pascal(n, fact, k) do
    [Kernel.trunc(fact / (fact(n - k) * fact(k))) | pascal(n, fact, k - 1)]
  end

  def fact(0) do
    1
  end

  def fact(n) do
    n * fact(n - 1)
  end
end

defmodule Seventh do
  @type tree() :: {:node, any(), tree(), tree()} | nil

  @spec trans(tree(), (any() -> any())) :: tree()

  def trans(nil, _) do
    nil
  end

  def trans({:node, n, left, right}, fun) do
    {:node, fun.(n), trans(left, fun), trans(right, fun)}
  end

  def remit(tree, n) do
    trans(tree, fn x -> rem(x, n) end)
  end
end

# defmodule Eighth do

#   @type city() :: atom()
#   @type dist() :: integer() | :inf
#   @spec shortest(city(), city(), map()) :: dist()

#   def shortest(from, to, map) do
#     distances = Map.new([{to, 0}])
#     {_ , dist, _} = check(from, to, map, distances)
#     dist
#   end

#   @spec check(city(), city(), map(), map()) :: {:found, dist(), map()}

#     def check(from, to, map, distances) do
#       case select(from, to, map, distances) do
#         nil ->
#           shortest(from, to, map, distances)
#         distance ->
#           {:found, distance, distances}
#       end
#     end

#   @spec shortest(city(), city(), map(), map()) :: {:found, dist(), map()}

#   def shortest(from, to, map, distances) do
#     .... = Map.put(.... , .... , :inf)
#     .... = Map.get(.... , from)
#     .... = select(neighbours, to, updated, map)
#     ....
#     {:found, dist, updated}
#   end

#   @spec select([{:city, city(), integer()}], city(), map(), map()) :: {:found, dist(), map()}

#   def select([], _,  _, _) do
#     nil
#   end
#   def select([{:city, next, d1} | rest], to, map1, map2) do

#     .... = check(next, to, .... , .... )
#     dist = add(d1,d2)
#     .... = select(rest, to, .... , .... )
#     if sele < dist do
#       {:found, sele, updated}
#     else
#       {:found, dist, updated}
#     end
#   end

#   @spec add(dist(), dist()) :: dist()

#   def add( .... , .... ) do .... end
#   def add( .... , .... ) do .... end
#   def add( .... , .... ) do .... end

# end

# defmodule Ninth do

#     def hp35() do
#       spawn(fn-> calculator(this()) end)
#     end

#     def calculator(process) do

#       send(process, :add, [0])

#       receive do
#         {:add, value} ->

#         :quit ->
#             :ok
#       end

#     end

# end
