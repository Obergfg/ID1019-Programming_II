defmodule Interpreter do
  def test() do
    prgm = [{:append, [:x, :y],
           [{:case, {:var, :x}, 
               [{:clause, {:atm, []}, [{:var, :y}]},
                {:clause, {:cons, {:var, :hd}, {:var, :tl}}, 
                   [{:cons, {:var, :hd}, {:call, :append, [{:var, :tl}, {:var, :y}]}}]
                }]
            }]
         }]
         
seq = [{:match, {:var, :x},{:cons, {:atm, :a}, {:cons, {:atm, :b}, {:atm, []}}}},
       {:match, {:var, :y}, {:cons, {:atm, :c}, {:cons, {:atm, :d}, {:atm, []}}}},
       {:call, :append, [{:var, :x}, {:var, :y}]}
      ]
    
Seq.eval_seq(seq, [], prgm)
  end
end
