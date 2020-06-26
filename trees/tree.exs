defmodule Tree do

  def tree(), do: nil

  def member(_, :nil) do
    :no
  end
  def member(e, {:leaf, e}) do
    :yes
  end
  def member(_, {:leaf, _}) do
    :no
  end
  def member(e, {:node, e, _, _}) do
    :yes
  end
  def member(e, {:node, v, left, _}) when e < v do
    member(e,left)
  end
  def member(e, {:node, _, _, right})  do
    member(e, right)
  end

  def insert(e, :nil)  do
    {:leaf , e}
  end
  def insert(e, {:leaf, v}) when e < v do
    {:node , v,{:leaf, e}, :nil}
  end
  def insert(e, {:leaf, v}) do
    {:node , v, :nil, {:leaf, e}}
  end
  def insert(e, {:node, v, left, right }) when e < v do
    {:node, v, insert(e, left), right}
  end
  def insert(e, {:node, v, left, right })  do
    {:node, v, left, insert(e, right)}
  end

  def delete(e, {:leaf, e}) do
    :nil
  end
  def delete(e, {:node, e, :nil, right}) do
    right
  end
  def delete(e, {:node, e, left, :nil}) do
    left
  end
  def delete(e, {_, e, left, right}) do
    n = rightmost(left)
    {:node, n, delete(n, left), right}
  end
  def delete(e, {_, v, left, right}) when e < v do
    {:node, v,  delete(e, left),  right}
  end
  def delete(e, {_, v, left, right})  do
    {:node, v,  left,  delete(e, right)}
  end

  def rightmost({:leaf, e}) do
    e
  end
  def rightmost({:node, e, _ , :nil})do
    e
  end
  def rightmost({:node, _, _ , right}) do
    rightmost(right)
  end

end

e = {:node, 2, :nil, {:leaf, 3}}
d = {:node, 1, :nil, e}
b = {:node, 8, :nil, {:leaf, 9}}
a = {:node, 5, d, b}
c = {:node, 15, {:leaf, 12}, :nil}
t = {:node, 10, a, c}

#IO.inspect t
#IO.inspect Tree.member(5, t)
IO.inspect Tree.delete(5, t)
