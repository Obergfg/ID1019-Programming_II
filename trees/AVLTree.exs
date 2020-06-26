#{:node, key, value, diff, left, right}

defmodule AVL do 

    def insert(tree, key, value) do
        case insrt(tree, key, value) do
            {:inc, q} -> q
            {:ok, q} -> q
        end
    end

    defp insrt(nil, key, value) do
        {:inc, {:node, key, value, 0, nil, nil}} 
    end
    defp insrt({:node, key, _, f, a, b}, key, value) do
        {:ok, {:node, key, value, f, a, b}}
    end

    defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk < rk do
        case insrt(a, kk, kv) do
        {:inc, q} ->
            {:inc, {:node, rk, rv, -1, q, b}}
        {:ok, q} ->
            {:ok, {:node, rk, rv, 0, q, b}}
        end
    end
    defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk > rk do
        case insrt(b, kk, kv) do
        {:inc, q} ->
            {:inc, {:node, rk, rv, +1, a, q}}
        {:ok, q} ->
            {:ok, {:node, rk, rv, 0, a, q}}
        end
    end

    defp insrt({:node, rk, rv, +1, a, b}, kk, kv) when kk < rk do
        case insrt(a, kk, kv) do
        {:inc, q} ->
            {:ok, {:node, rk, rv, 0, q, b}}
        {:ok, q} ->
            {:ok, {:node, rk, rv, +1, q, b}}
        end
    end
    defp insrt({:node, rk, rv, +1, a, b}, kk, kv) when kk > rk do
        case insrt(b, kk, kv) do
        {:inc, q} ->
            {:ok, rotate({:node, rk, rv, +2, a, q})}
        {:ok, q} ->
            {:ok, {:node, rk, rv, +1, a, q}}
        end
    end

    defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk < rk do
        case insrt(a, kk, kv) do
        {:inc, q} ->
            {:ok, rotate({:node, rk, rv, -2, q, b})}
        {:ok, q} ->
            {:ok, {:node, rk, rv, -1, q, b}}
        end
    end
    defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk > rk do
        case insrt(b, kk, kv) do
        {:inc, q} ->
            {:ok, {:node, rk, rv, 0, a, q}}
        {:ok, q} ->
            {:ok, {:node, rk, rv, -1, a, q}}
        end
    end

    defp rotate({:node, xk, xv, -2, {:node, yk, yv, -1, a, b}, c}) do
        {:node, yk, yv, 0, a, {:node, xk, xv, 0, b, c}}        
    end
    defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, +1, b, c}}) do
        {:node, yk, yv, 0, {:node, xk, xv, 0, a, b}, c}
    end
    defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a, {:node, zk, zv, -1, b, c}}, d}) do
        {:node, zk, zv, 0, {:node, yk, yv, 0, a, b}, {:node, xk, xv, +1, c, d}}
    end
    defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a, {:node, zk, zv, +1, b, c}}, d}) do
        {:node, zk, zv, 0, {:node, yk, yv, -1, a, b}, {:node, xk, xv, 0, c, d}}
    end
    defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a, {:node, zk, zv, 0, b, c}}, d}) do
        {:node, zk, zv, 0, {:node, yk, yv, 0, a, b}, {:node, xk, xv, 0, c, d}}
    end
    defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, +1, b, c}, d}}) do
        {:node, zk, zv, 0, {:node, xk, xv, -1, a, b}, {:node, yk, yv, 0, c, d}}
    end
    defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, -1, b, c}, d}}) do
        {:node, zk, zv, 0, {:node, xk, xv, 0, a, b}, {:node, yk, yv, +1, c, d}}
    end
    defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, 0, b, c}, d}}) do
        {:node, zk, zv, 0, {:node, xk, xv, 0, a, b}, {:node, yk, yv, 0, c, d}}
    end

    def tree()do 
        nil
    end

    def depth(tree, key) do          
        depth(tree, key, 0)          
    end
    def depth({:node, kv, _, _, _, _}, kv, depth)do 
        {:ok, depth}
    end
    def depth({:node, kv, _, _, left, _ }, sv, depth) when sv < kv do
        depth(left, sv, depth + 1)
    end
    def depth({:node, _, _, _, _, right}, sv, depth) do
        depth(right, sv, depth + 1)
    end
    def depth(nil, _, _)do 
        {:fail}
    end

    def maxdepth(tree)do 
        maxdepth(tree, 0, 0)
    end
    def maxdepth(nil, _, max)do 
        max
    end
    def maxdepth({:node, _, _, _, left, right}, current, max) when current >= max do      
        maxdepth(right, current + 1 , maxdepth(left, current + 1, current + 1))  
    end
    def maxdepth({:node, _, _, _, left, right}, current, max) do     
        maxdepth(right, current + 1 , maxdepth(left, current + 1, max))  
    end
    
end

t = {:node, "C", 8, 1, 
        {:node, "B", 8, -1, 
            {:node, "A", 8, 0, nil, nil}, 
            nil},
        {:node, "Q", 8, -1, 
            {:node, "F", 8, 1, 
                nil, 
                {:node, "H", 8, 0, nil, nil}},
            {:node, "T", 8, 0, nil, nil}}}

IO.inspect AVL.maxdepth({:node, "F", 8, 1, nil, {:node, "H", 8, 0, nil, nil}})

