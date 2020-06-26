defmodule One do
  def decode([]) do
    []
  end

  def decode([first | rest]) do
    decode(first, rest)
  end

  def decode({atom, 1}, []) do
    [atom]
  end

  def decode({atom, 1}, [first | rest]) do
    [atom | decode(first, rest)]
  end

  def decode({atom, n}, rest) do
    [atom | decode({atom, n - 1}, rest)]
  end
end

defmodule Two do
  def zip([], []) do
    []
  end

  def zip([a | arest], [b | brest]) do
    [{a, b} | zip(arest, brest)]
  end
end

defmodule Three do
  def balance({}) do
    {0, 0}
  end

  def balance(tree) do
    {depth(tree), imbalance(tree)}
  end

  def depth({:node, _, left, right}) do
    max(depth(left) + 1, depth(right) + 1)
  end

  def depth(nil) do
    0
  end

  def imbalance({:node, _, left, right}) do
    max(abs(depth(left) - depth(right)), max(imbalance(left), imbalance(right)))
  end

  def imbalance(nil) do
    0
  end
end

defmodule Four do
  def eval({:add, expr1, expr2}) do
    eval(expr1) + eval(expr2)
  end

  def eval({:mul, expr1, expr2}) do
    eval(expr1) * eval(expr2)
  end

  def eval({:neg, expr}) do
    -eval(expr)
  end

  def eval(n) do
    n
  end
end

defmodule Five do
  def gray(0) do
    [[]]
  end

  def gray(n) do
    list = gray(n - 1)

    reversed = :lists.reverse(list)

    list = update(0, list)
    reversed = update(1, reversed)

    :lists.append(list, reversed)
  end

  def update(_, []) do
    []
  end

  def update(n, [head | rest]) do
    [[n | head] | update(n, rest)]
  end
end

defmodule Seven do
  def fib do
    fn -> fib(0, 1) end
  end

  def fib(n0, n1) do
    {:ok, n1, fn -> fib(n1, n0 + n1) end}
  end
end

defmodule Eight do
  def fac(1) do
    1
  end

  def fac(n) do
    n * fac(n - 1)
  end

  def facl(0) do
    []
  end

  def facl(n) do
    [fac(n) | facl(n - 1)]
  end
end
