defmodule Splay do 

    #{:node, key, value, left, right}
    
    def update(nil, key, value) do
        {:node, key, value, nil, nil}
      end
    def update({:node, key, _, a, b}, key, value) do
        {:node, key, value, a, b}
    end
    def update({:node, rk, rv, zig, c}, key, value) when key < rk do
        # The general rule where we will do the Zig transformation.
        {:splay, _, a, b} = splay(zig, key)
        {:node, key, value, a, {:node, rk, rv, b, c}} 
    end
    def update({:node, rk, rv, a, zag}, key, value) when key >= rk do
        # The general rule where we will do the Zag transformation.
        {:splay, _, b, c} = splay(zag, key)
        {:node, key, value, {:node, rk, rv, a, b}, c}
    end

    defp splay(nil, _)do 
        {:splay, :na, nil, nil}
    end
    defp splay({:node, key, value, a, b}, key)do 
        {:splay, value, a, b}
    end
    defp splay({:node, rk, rv, nil, b}, key) when key < rk do
        {:splay, :na, nil, {:node, rk, rv, nil, b}}
    end
    defp splay({:node, rk, rv, a, nil}, key) when key >= rk do
        {:splay, :na, {:node, rk, rv, a, nil}, nil}
    end
    defp splay({:node, rk, rv, {:node, key, value, a, b}, c}, key) do
        {:splay, value, a, {:node, rk, rv, b, c}}
    end
    defp splay({:node, rk, rv, a, {:node, key, value, b, c}}, key) do
        {:splay, value, {:node, rk, rv, a, b}, c}
    end
    defp splay({:node, gk, gv, {:node, pk, pv, zig_zig, c}, d}, key) when key < gk and key < pk do
        # Going down left-left, this is the so called zig-zig case. 
        {:splay, value, a, b} = splay(zig_zig, key)
        {:splay, value, a, {:node, pk, pv, b, {:node, gk, gv, c, d}}}
    end
    defp splay({:node, gk, gv, {:node, pk, pv, a, zig_zag}, d}, key) when key < gk and key >= pk do
         # Going down left-right, this is the so called zig-zag case. 
        {:splay, value, b, c} = splay(zig_zag, key)
        {:splay, value, {:node, pk, pv, a, b}, {:node, gk, gv, c, d}}
    end
    defp splay({:node, rk, rv, a, {:node, pk, pv, b, zag_zag}}, key) when key >= rk and key >= pk do 
        {:splay, value, c, d} = splay(zag_zag, key)
        {:splay, value, {:node, rk, rv, a, {:node, pk, pv, b, c}}, d}
    end
    defp splay({:node, rk, rv, a, {:node, pk, pv, zag_zig, d}}, key) when key >= rk and key < pk do 
        {:splay, value, b, c} = splay(zag_zig, key)
        {:splay, value, {:node, rk, rv, a, b},{:node, pk, pv, c, d}}
    end
    
    def test() do
        insert = [{3, :c}, {5, :e}, {2, :b}, {1, :a}, {7, :g}, {4, :d}, {5, :e}]
        empty = nil
        List.foldl(insert, empty, fn({k, v}, t) -> IO.inspect update(t, k, v) end)
    end
   
end

t = t = {:node, "C", 8, 
            {:node, "B", 8, 
                {:node, "A", 8, nil, nil}, 
                nil},
            {:node, "Q", 8, 
                {:node, "F", 8, 
                    nil, 
                    {:node, "H", 8, nil, nil}},
                {:node, "T", 8, nil, nil}}}

#IO.inspect Splay.update(t,"F", 10)
IO.inspect Splay.test()