defmodule AA do

   """
    y=[2,3]
    error
    [3]
    42
    [head | tail]
  """

end

defmodule AB do

  @type färg() :: :hjärter | :spader | :klöver | :ruter
  @type spelkort() :: {:spelkort, färg(), integer()}

  @type kthid() :: integer()
  @type namn() :: charlist()
  @type student() :: {:student, namn(), kthid()}

  @type studenter() :: [student()]

  @type kurs() :: {:kurs, kthid(), kurs(), kurs()} | nil
end

defmodule AC do

  # def rovare([]) do
  #   []
  # end

  # def rovare([32 | rest]) do
  #     [ 32 | rovare(rest)]
  # end

  # def rovare([first | rest]) do
  #   case sound(first) do
  #     :cons ->
  #       [first, :o, first | rovare(rest)]

  #     :vowel ->
  #       [first | rovare(rest)]
  #   end
  # end


end

defmodule AD do


  def pop({:node, value, {:node, l, _, _} = left, {:node, r, _, _} = right}) when l < r do
      {root, heap} = pop(right)
      {value, {:node, root, left, heap}}
  end

  def pop({:node, value, {:node, _, _, _} = left, {:node, _, _, _} = right}) do
      {root, heap} = pop(left)
      {value, {:node, root, heap, right}}
  end

  def pop({:node, value, _, {:node, _, _, _} = right }) do
    {value, right}
  end

  def pop({:node, value, {:node, _, _, _} = left, _}) do
    {value, left}
  end

  def pop({:node, value, _, _}) do
    {value, :false}
  end

  def pop(_) do
    :false
  end

end

defmodule AF do

    def insert(value, {:node, n, left, right})when value > n do
      {:node, value, insert(n, left), right}
    end

    def insert(value, {:node, n, left, right})do
      {:node, n, insert(value, left), right}
    end

    def insert(value, _) do
      {:node, value, nil, nil}
    end

end

defmodule AG do

  def insert(value, {:node, n, path, left, right}) when value > n do
    cond do
      path ->
        {:node, value, !path, insert(n, left), right}

       not path ->
        {:node, value, !path, left, insert(n, right)}
    end
  end

  def insert(value, {:node, n, path, left, right})do
    cond do
      path ->
        {:node, n, !path, insert(value, left), right}

       not path ->
        {:node, n , !path, left, insert(value, right)}
    end
  end

  def insert(value, _) do
    {:node, value, true, nil, nil}
  end

end
