defmodule Sorting do

  def insert([], e)do
    [e]
  end
  def insert([h|t],e) do
    cond do
      e > h -> [h|insert(t,e)]
      true -> [e,h|t]
    end
  end

  def isort(l)do
    isort([],l)
  end
  def isort(sorted, [])do
    sorted
  end
  def isort(sorted, [h|t])do
    isort(insert(sorted, h), t)
  end

  def msort([]) do
    []
  end
  def msort([x]) do
    [x]
  end
  def msort(l) do
    {l1,l2} = split(l,[],[])
    merge(msort(l1), msort(l2))
  end

  def split([], l1, l2) do
    {l1,l2}
  end
  def split([h|t],l1,l2) do
    split(t,[h|l2],l1)
  end

  def merge([],l2) do
    l2
  end
  def merge(l1,[]) do
    l1
  end
  def merge([h1|t1], [h2|_] = t2) when h1 < h2 do
    [h1|merge(t1, t2)]
  end
  def merge(t1, [h2|t2]) do
    [h2|merge(t1,t2)]
  end

  def quick([]) do
    []
  end
  def quick(([p|l])) do
    {l1,l2} = qsplit(p,l,[],[])
    small = quick(l1)
    large= quick(l2)
    append(small, [p|large])
  end

  def qsplit(_, [], small, large) do {small, large} end
  def qsplit(p, [h | t], small, large) do
    if h < p  do
      qsplit(p, t, [h | small], large)
    else
      qsplit(p, t, small, [h | large])
    end
  end

  def append(list1, list2) do
   case list1 do
     [] -> list2
     [h | t] -> [h | append(t, list2)]
   end
 end

 def qsort_enum([]) do [] end
  def qsort_enum([head | tail]) do
    {smaller, greater} = Enum.split_with(tail, &(&1 < head))
    qsort_enum(smaller) ++ [head] ++ qsort_enum(greater)
  end

end


IO.inspect Sorting.qsort_enum([3,2,4,5,1,0,15,23,564,1,2,3])
