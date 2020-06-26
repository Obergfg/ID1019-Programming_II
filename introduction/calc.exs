defmodule Calc do

  def eval({:int, n})do
    n
  end
  def eval({:add, a, b}) do
    eval(a) + eval(b)
  end
  def eval({:sub, a, b}) do
    eval(a) - eval(b)
  end
  def eval({:mul, a, b}) do
    eval(a)*eval(b)
  end
  def eval({:var, var}, bindings) do
    eval(lookup({:var, var}, bindings))
  end
  def eval({expr, v1, v2}, bindings) do
    eval({expr, lookup(v1, bindings), lookup(v2, bindings)})
  end

  def lookup({:var, var}, [{:bind, var, value} | _]) do
    {:int, value}
  end
  def lookup(var, [_| t]) do
    lookup(var, t)
  end
end

varlist = [{:bind, :x, 6}, {:bind, :y, 2}, {:bind, :z, 3}]
IO.inspect Calc.eval({:var, :x}, varlist)
IO.inspect Calc.lookup({:var, :z}, varlist)
IO.inspect Calc.eval({:mul, {:var, :x}, {:var, :z}} , varlist)
