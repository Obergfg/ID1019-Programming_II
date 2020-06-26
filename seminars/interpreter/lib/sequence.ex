defmodule Seq do
  def eval_seq([expression], env, program) do
    Expr.eval_expr(expression, env, program)
  end

  def eval_seq([{:match, pattern, expression} | rest], env, program) do
    case Expr.eval_expr(expression, env, program) do
      :error ->
        :error

      {_, value} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)

        case Match.eval_match(pattern, value, env, program) do
          :fail ->
            :error

          {:ok, env} ->
            eval_seq(rest, env, program)
        end
    end
  end

  def extract_vars(pattern) do
    extract_vars(pattern, [])
  end

  def extract_vars({:atm, _}, vars) do
    vars
  end

  def extract_vars(:ignore, vars) do
    vars
  end

  def extract_vars({:var, var}, vars) do
    [var | vars]
  end

  def extract_vars({:cons, head, tail}, vars) do
    extract_vars(tail, extract_vars(head, vars))
  end

end
