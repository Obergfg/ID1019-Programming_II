defmodule Test do
  def test do
    #  I.lookup(:h, {:node, :k, 1,
    #                 {:node, :h, :tea,
    #                   {:node, :a, 3,
    #                     nil,
    #                     nil},
    #                   {:node, :i, 4,
    #                     nil,
    #                     nil}},
    #                 {:node, :p, 5,
    #                   {:node, :o, 6,
    #                     nil,
    #                     nil},
    #                   {:node, :z, 7,
    #                     nil,
    #                     nil}}})

    # AF.insert(11, {:node, 10,
    #           {:node, 7,
    #             {:node, 2, nil, nil},
    #             {:node, 7, nil, nil}},
    #           {:node, 8,
    #             {:node, 5, nil, nil},
    #             {:node, 4, nil, nil}}})

    AG.insert(10, {:node, 4, false, {:node, 2, true, nil, nil}, {:node, 3, true, nil, nil}})
  end
end
