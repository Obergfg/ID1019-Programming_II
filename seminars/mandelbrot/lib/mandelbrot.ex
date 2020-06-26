defmodule Mandelbrot do
  defp mandelbrotdepth(c, m) do
    z0 = Cmplx.new(0, 0)
    depth(0, z0, c, m)
  end

  defp depth(i, zn, c, m) when i < m do
    cond do
      Cmplx.abs(zn) >= 2 ->
        i

      true ->
        zm = Cmplx.add(Cmplx.sqr(zn), c)
        depth(i + 1, zm, c, m)
    end
  end

  defp depth(m, _, _, m) do
    0
  end

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn w, h ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, depth, [])
  end

  defp rows(_, 0, _, _, rows), do: rows

  defp rows(w, h, tr, depth, rows) do
    row = row(w, h, tr, depth, [])
    rows(w, h - 1, tr, depth, [row | rows])
  end

  defp row(0, _, _, _, row), do: row

  defp row(w, h, tr, depth, row) do
    c = tr.(w, h)
    res = mandelbrotdepth(c, depth)
    color = Color.convert(res, depth)
    row(w - 1, h, tr, depth, [color | row])
  end

  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("mandel.ppm", image)
  end
end
