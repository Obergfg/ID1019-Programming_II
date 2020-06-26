defmodule Hej do
  def hej(value) do
    IO.inspect(value)

    receive do
      x ->
        IO.inspect(value)
        IO.inspect(x, [])
        value
    end
  end
end
