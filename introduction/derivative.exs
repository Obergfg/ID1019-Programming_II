defmodule Derivative do

  @type literal() :: {:const, number()} | {:const, atom()} | {:var, atom()}
  @type expr() :: {:add, expr(), expr()} | {:mul, expr(), expr()} | literal()

  def deriv({:const, _}, _)do
    {:const, 0}
  end
  def deriv({:var, v}, v)do
    {:const, 1}
  end
  def deriv({:var, _y}, _)do
    {:const ,0}
  end
  def deriv({:mul, e1, e2}, v)do
    {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
  end
  def deriv({:add, e1, e2}, v)do
    {:add, deriv(e1, v) , deriv(e2, v)}
  end
  def deriv({:exp, {:var, v}, {:const, c}}, v)do
      {:mul, {:const, c}, {:exp, {:var, v}, {:const, c - 1}}}
  end
  def deriv({:ln, {:var, v}}, v)do
      {:div, {:const, 1}, {:var, v}}
  end
  def deriv({:div, {:const, c},{:exp, {:var, v}, {:const, d}}}, v)do
    {:div, {:const, -c*d}, {:exp, {:var, v}, {:const, d+1}}}
  end
  def deriv({:root, e}, v)do
    {:div, {:const , 1}, {:mul, {:const, 2}, {:root, e}}}
  end
  def deriv({:sin, {:var, v}}, v)do
    {:cos, {:var, v}}
  end

  def simplify({:const, c}) do
    {:const, c}
  end
  def simplify({:var, c}) do
    {:var, c}
  end
  def simplify({:exp, e1, e2}) do
    case simplify(e2) do
      {:const, 0} ->
        {:const, 1}

      {:const, 1} ->
        simplify(e1)

      s2 ->
        case simplify(e1) do
          {:const, 0} ->
            {:const, 0}

          {:const, 1} ->
            {:const, 1}

          s1 ->
            {:exp, s1, s2}
        end
    end
  end
  def simplify({:mul, e1, e2}) do
    case simplify(e1) do
      {:const, 0} ->
        {:const, 0}

      {:const, 1} ->
        simplify(e2)

      s1 ->
        case simplify(e2) do
          {:const, 0} ->
            {:const, 0}

          {:const, 1} ->
            s1

          s2 ->
            {:mul, s1, s2}
        end
    end
  end
  def simplify({:add, e1, e2}) do
    case simplify(e1) do
      {:const, 0} ->
        simplify(e2)

      s1 ->
        case simplify(e2) do
          {:const, 0} ->
            s1

          s2 ->
            {:add, s1, s2}
        end
    end
  end
end

test =  {:add,
          {:mul,
            {:const, 4},
            {:exp,
              {:var, :x}, {:const, 2}}},
          {:add,
            {:mul, {:const, 3}, {:var, :x}},
            {:const, 42}}}

der =  Derivative.deriv( test , :x)

IO.inspect Derivative.simplify(der)
