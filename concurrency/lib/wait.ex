defmodule Wait do
  def wait do
    receive do
      x -> IO.puts("aaa! surprise, a message: #{x}")
    end
  end
end
