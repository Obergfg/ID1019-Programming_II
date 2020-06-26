defmodule Tree do

  def lookup(_, :nil) do 
    :no 
  end
  def lookup(e, {:node, e, v, _, _}) do 
    {:ok, v} 
  end
  def lookup(e, {:node, k, _, left, _ }) when e < k do 
    lookup(e, left)
  end
  def lookup(e, {:node, _, _, _, right}) do 
    lookup(e, right) 
  end

  def remove(e, :nil)do 
    {:no, e} 
  end
  def remove(e, {:node, e, _, :nil, :nil})do 
    :nil 
  end
  def remove(e, {:node, e, _, left, :nil})do 
    left 
  end
  def remove(e, {:node, e, _, :nil, right})do 
    right 
  end
  def remove(e, {:node, e, _, left, right})do
    {k, v} = getright(left)
    {:node, k, v, remove(k, left), right}
  end
  def remove(e ,{:node,k, v, left,  right})when e < k do
    {:node, k, v, remove(e, left), right}
  end
  def remove(e ,{:node, k, v, left, right}) do
    {:node, k, v, left, remove(e, right)}
  end

  def getright({:node, k, v, _, :nil})do 
    {k, v} 
  end
  def getright({:node,_,_,_, right})do 
    getright(right) 
  end

  def add(k, v, :nil)do 
    {:node, k , v, :nil, :nil} 
  end
  def add(k, v, {:node, k, _, left, right})do 
    {:node, k , v, left, right} 
  end
  def add(k, v, {:node, k, _, left, :nil})do 
    {:node, k , v, left, :nil} 
  end
  def add(k, v, {:node, k, _, :nil, right})do 
    {:node, k , v, :nil, right} 
  end
  def add(k, v, {:node, s, t, left, right}) when k<s do 
    {:node, s, t,add(k, v, left), right} 
  end
  def add(k, v, {:node, s, t, left, right})do 
    {:node, s, t, left, add(k, v, right)} 
  end


end

c = {:node, "C", 234, :nil, :nil}
b = {:node, "T", 123098, :nil, :nil}
a = {:node, "B", 12, :nil, c}
t = {:node, "S", 1, a, b}

IO.inspect t
t = Tree.add("Q", 123, t)
IO.inspect t
t = Tree.remove("C", t)
IO.inspect t
