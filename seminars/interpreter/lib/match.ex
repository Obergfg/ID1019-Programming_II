defmodule Match do
  def eval_match(:ignore, _, env, _) do
    {:ok, env}
  end

  def eval_match({:atm, expression}, expression, env, _) do
    {:ok, env}
  end

  def eval_match({:var, expression}, value, env, _) do
    case Env.lookup(expression, env) do
      nil ->
        {:ok, Env.add(expression, value, env)}

      {_, ^value} ->
        {:ok, env}

      {_, _} ->
        :fail
    end
  end

  def eval_match({:cons, a, b}, {c, d}, env, program) do
    case eval_match(a, c, env, program) do
      :fail ->
        :fail

      {:ok, env} ->
        eval_match(b, d, env, program)
    end
  end

  def eval_match(_, _, _, _) do
    :fail
  end
end
