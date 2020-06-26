defmodule Tic do
  def first do
    receive do
      {:tic, x} ->
        IO.puts("tic: #{x}")
        second()
    end
  end

  defp second do
    receive do
      {:tac, x} ->
        IO.puts("tac: #{x}")
        last()
    end
  end

  defp last do
    receive do
      {:toe, x} ->
        IO.puts("toe: #{x}")
    end
  end
end
