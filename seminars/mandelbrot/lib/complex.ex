defmodule Cmplx do
  # Creates a complex number
  def new(r, i) do
    {r, i}
  end

  # Adds two complex numbers
  def add({ar, ai}, {br, bi}) do
    {ar + br, ai + bi}
  end

  # Squares a complex number
  def sqr({r, i}) do
    {r * r - i * i, 2 * r * i}
  end

  # The absolut value of a complex number
  def abs({r, i}) do
    :math.sqrt(r * r + i * i)
  end
end
