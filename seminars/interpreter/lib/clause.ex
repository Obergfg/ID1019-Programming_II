defmodule Clause do
  def eval_cls([], _, _, _) do
    :error
  end

  def eval_cls([{:clause, pattern, sequence} | clause], value, env, program) do
    case Match.eval_match(pattern, value, env, program) do
      :fail ->
        eval_cls(clause, value, env, program)

      {:ok, env} ->
        Seq.eval_seq(sequence, env, program)
    end
  end
end
