defmodule Env do
  def new() do
    []
  end

  def add(expression, value, env) do
    [{expression, value} | env]
  end

  def lookup(_, []) do
    nil
  end

  def lookup(expression, [{expression, value} | _]) do
    {expression, value}
  end

  def lookup(expression, [_ | rest]) do
    lookup(expression, rest)
  end

  def remove(_, []) do
    []
  end

  def remove(expression, [{expression, _} | rest]) do
    remove(expression, rest)
  end

  def remove(expression, [other | rest]) do
    [other | remove(expression, rest)]
  end

  def remove([expression | next], env) do
    updated = remove(expression, env)
    remove(next, updated)
  end

  def remove([], env) do
    env
  end

  def closure([], _)do 
    []
  end

  def closure([free | rest], env)do 
      case lookup(free, env)do 
        nil -> 
            :error

        {_, value} ->
            [{free, value} | closure(rest, env)]
      
      end
  end

  def args([], [], closure)do 
    closure
  end
  def args([parameter | parest], [{_ ,structure} | strest], closure)do 
      [{parameter, structure} | args(parest, strest, closure)]
  end
end
