
defmodule Tree do

  def insert(k, v, :nil), do: {:leaf, k, v}
  def insert(k, v, {:leaf, lk, _} = l) do
    cond do
      k <= lk -> 
        {:two, k ,{:leaf, k, v}, l}
      true -> 
        {:two, lk, l, {:leaf, k, v}}
    end
  end
  def insert(k, v, {:two, nk, l, {:leaf, rk, _} = r})do
    cond do
      k <= nk  -> 
        {:three, k, nk, {:leaf, k, v}, l, r}
      k <= rk -> 
        {:three, nk, k, l, {:leaf, k, v}, r}
      true -> 
        {:three, nk, rk, l, r, {:leaf, k, v}}
    end
  end
  def insert(k, v, {:three, lk2, mk2, l, m, {:leaf, rk, _} = r})do
    cond do
      k <= lk2 -> 
        {:four, k, lk2, mk2, {:leaf, k, v}, l, m, r}
      k <= mk2 -> 
        {:four, lk2, k, mk2, l, {:leaf, k, v}, m, r}
      k <= rk -> 
        {:four, lk2, mk2, k, l, m, {:leaf, k, v}, r}
      true -> 
        {:four, lk2 , mk2, rk, l, m, r, {:leaf, k, v}}
    end
  end
  def insert(k, v , {:two, k1, left, right})do
    cond do
      k <= k1 -> case insert(k, v, left) do
                    {:four, q1, q2, q3, t1, t2, t3, t4} -> 
                      {:three, q2, k1, {:two, q1, t1, t2}, {:two, q3, t3, t4}, right}
                    updated -> 
                      {:two, k1, updated, right}
                 end
      true -> case insert(k, v, right) do
                {:four, q1, q2, q3, t1, t2, t3, t4} -> 
                  {:three, k1, q2, left, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
                updated -> 
                  {:two, k1, left, updated}
              end
    end
  end

  def treeinsert(key, value, root)do 
    case insert(key, value, root)do 
      {:four, q1, q2, q3, t1, t2, t3, t4} -> 
        {:two, q2, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
        updated -> updated
    end
  end

  def test do
    treeinsert(14, :grk, {:two, 7, {:three, 2, 5, {:leaf, 2, :foo},
        {:leaf, 5, :bar}, {:leaf, 7, :zot}}, {:three, 13, 16,
        {:leaf, 13, :foo}, {:leaf, 16, :bar}, {:leaf, 18, :zot}}})
  end

end

t = {:three, "C", "S",{:leaf, "C", 1}, {:leaf, "S",123}, {:leaf, "V", 12938}}
s = {:two, "E", {:leaf, "E", 1234},  {:leaf, "G", 1231}}

IO.inspect Tree.treeinsert("T", 1 , s)
IO.inspect Tree.test


#In a three-node the keys of the left branch is smaller or equal to 
#the first key and the keys of the middle branch are less than or equal to 
#the second key.