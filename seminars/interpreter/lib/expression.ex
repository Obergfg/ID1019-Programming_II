defmodule Expr do
  def eval_expr({:atm, expression}, _, _) do
    {:ok, expression}
  end

  def eval_expr({:var, expression}, env, _) do
    case Env.lookup(expression, env) do
      nil ->
        :error

      {_, value} ->
        {:ok, value}
    end
  end

  def eval_expr({:cons, head, tail}, env, program) do
    case eval_expr(head, env, program) do
      :error ->
        :error

      {:ok, headvalue} ->
        case eval_expr(tail, env, program) do
          :error ->
            :error

          {:ok, tailvalue} ->
            {:ok, {headvalue, tailvalue}}
        end
    end
  end

  def eval_expr({:case, expression, clause}, env, program) do
    case eval_expr(expression, env, program) do
      :error ->
        :error

      {:ok, value} ->
        Clause.eval_cls(clause, value, env, program)
    end
  end

  def eval_expr({:lambda, parameters, free, sequence}, env, _) do
    case Env.closure(free, env) do
        :error ->
            :error
        closure ->
            {:ok, {:closure, parameters, sequence, closure}}
    end
  end

  def eval_expr({:apply, expression, arguments}, env, program) do
    case Expr.eval_expr(expression, env, program) do
        :error ->
            :error
        {:ok, {:closure, parameters, sequence, closure}} ->
            case Expr.eval_expr(arguments, env, program) do
                :error ->
                    :foo
                structures ->
                    env = Env.args(parameters, structures, closure)
                    Seq.eval_seq(sequence, env, program)
            end
    end
  end

  def eval_expr([], _, _)do 
    []
  end

  def eval_expr([expression | rest], env, program)do 
    case eval_expr(expression, env, program)do 
        :error ->
            :error
        
        {_ , value} -> 
            [{expression, value} | eval_expr(rest, env, program)]
    end
  end

  def eval_expr({:call, id, arguments}, env, program) when is_atom(id) do
    case List.keyfind(program, id, 0) do
        nil ->
            :error
        {_, parameters, sequence} ->
            case eval_args(arguments, env, program) do
                :error ->
                    :error

                structures ->
                    
                    env = Env.args(parameters, structures, [])
                    IO.inspect env
                    Seq.eval_seq(sequence, env, program)
            end
    end
  end

  def eval_args([], _, _)do 
    []
  end

  def eval_args([argument| rest], env, program)do 
    case eval_expr(argument, env, program)do 
        :error ->
            :error

        {:ok, value} ->
            [{argument, value} | eval_args(rest, env, program)]
    end
    
  end
end
