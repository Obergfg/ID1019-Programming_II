defmodule A do
  @type key() :: any()

  @type tree() :: {:node, key(), tree(), tree()} | {:leaf, key(), any()} | nil
end

defmodule C do
  def toint(list) do
    toint(0, list)
  end

  def toint(sum, []) do
    sum
  end

  def toint(sum, [:X | rest]) do
    toint(sum + 10, rest)
  end

  def toint(sum, [:V | rest]) do
    toint(sum + 5, rest)
  end

  def toint(sum, [:I | rest]) do
    toint(sum + 1, rest)
  end
end

defmodule D do
  def toint([]) do
    0
  end

  def toint([:I, :X | rest]) do
    9 + toint(rest)
  end

  def toint([:I, :V | rest]) do
    4 + toint(rest)
  end

  def toint([:X | rest]) do
    10 + toint(rest)
  end

  def toint([:V | rest]) do
    5 + toint(rest)
  end

  def toint([:I | rest]) do
    1 + toint(rest)
  end
end

defmodule E do
  def union([], set) do
    set
  end

  def union([first | rest], set) do
    case element(first, set) do
      true ->
        union(rest, set)

      false ->
        [first | union(rest, set)]
    end
  end

  def element(_, []) do
    false
  end

  def element(e, [e | _]) do
    true
  end

  def element(e, [_ | rest]) do
    element(e, rest)
  end

  def isec([], _) do
    []
  end

  def isec([first | rest], set) do
    case element(first, set) do
      true ->
        [first | isec(rest, set)]

      false ->
        isec(rest, set)
    end
  end
end

defmodule F do
  def diff(set, []) do
    set
  end

  def diff(set, [e | rest]) do
    diff(sub(e, set), rest)
  end

  def sub(_, []) do
    []
  end

  def sub(e, [e | rest]) do
    sub(e, rest)
  end

  def sub(e, [k | rest]) do
    [k | sub(e, rest)]
  end
end

defmodule G do
  def map(_, []) do
    []
  end

  def map(f, [e | rest]) do
    [f.(e) | map(f, rest)]
  end
end

defmodule H do
  def tutti_paletti(list) do
    list = Enum.filter(list, fn x -> x > 0 end)

    list = Enum.map(list, fn x -> x * x end)

    List.foldr(list, 0, fn x, y -> x + y end)
  end
end

defmodule I do
  @spec lookup(key(), tree()) :: {:ok, value()} | :notfound

  @type key() :: any()
  @type value() :: integer()
  @type tree() :: {:node, key(), value(), tree(), tree()} | nil

  def lookup(_, nil) do
    :notfound
  end

  def lookup(n, {:node, n, value, _, _}) do
    {:ok, value}
  end

  def lookup(n, {:node, k, _, left, _}) when n < k do
    lookup(n, left)
  end

  def lookup(n, {:node, _, _, _, right}) do
    lookup(n, right)
  end
end

defmodule J do
  def create do
    spawn(fn -> account(0) end)
  end

  def account(balance) do
    receive do
      {:deposit, amount} ->
        account(balance + amount)

      {:withdraw, amount, from} ->
        send(from, :ok)
        account(balance - amount)

      {:check, from} ->
        send(from, {:balance, balance})
        account(balance)
    end
  end
end
