# Morse signals decoder

# The table is represented as a tree were each node is on the form
# {:node, character, left, right}. 
# An empty tree is represented by the nil value.
# The signal is in the form of a string with dots and dashes .-. .-..
# (i.e. a list with ASCII characters 45, 46 and 32 (dash, dot and space)).
defmodule Morse do

      defp decode_table() do
        {:node, :na,
            {:node, 116,
            {:node, 109,
                    {:node, 111,
                    {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
                    {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
                    {:node, 103,
                    {:node, 113, nil, nil},
                    {:node, 122,
                        {:node, :na, {:node, 44, nil, nil}, nil},
                        {:node, 55, nil, nil}}}},
                    {:node, 110,
                    {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
                    {:node, 100,
                    {:node, 120, nil, nil},
                    {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
            {:node, 101,
            {:node, 97,
                {:node, 119,
                {:node, 106,
                    {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
                    nil},
                {:node, 112,
                    {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
                    nil}},
                {:node, 114,
                {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
                {:node, 108, nil, nil}}},
            {:node, 105,
                {:node, 117,
                {:node, 32,
                    {:node, 50, nil, nil},
                    {:node, :na, nil, {:node, 63, nil, nil}}},
                {:node, 102, nil, nil}},
                {:node, 115,
                {:node, 118, {:node, 51, nil, nil}, nil},
                {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
    end

    defp codes() do
        [{32,'..--'},
        {37,'.--.--'},
        {44,'--..--'},
        {45,'-....-'},
        {46,'.-.-.-'},
        {47,'.-----'},
        {48,'-----'},
        {49,'.----'},
        {50,'..---'},
        {51,'...--'},
        {52,'....-'},
        {53,'.....'},
        {54,'-....'},
        {55,'--...'},
        {56,'---..'},
        {57,'----.'},
        {58,'---...'},
        {61,'.----.'},
        {63,'..--..'},
        {64,'.--.-.'},
        {97,'.-'},
        {98,'-...'},
        {99,'-.-.'},
        {100,'-..'},
        {101,'.'},
        {102,'..-.'},
        {103,'--.'},
        {104,'....'},
        {105,'..'},
        {106,'.---'},
        {107,'-.-'},
        {108,'.-..'},
        {109,'--'},
        {110,'-.'},
        {111,'---'},
        {112,'.--.'},
        {113,'--.-'},
        {114,'.-.'},
        {115,'...'},
        {116,'-'},
        {117,'..-'},
        {118,'...-'},
        {119,'.--'},
        {120,'-..-'},
        {121,'-.--'},
        {122,'--..'}]
    end

    def encode_table()do 
        codes()
        |> fill(0)
        |> List.to_tuple
    end
  
    # Takes a signal and the decoding table 
    # and returns a decoded message.
    def decode(signal)do 
        decode(signal, decode_table())
    end
    def decode([], _), do: []
    def decode([code|rest], {:node, char, left, right})do
        cond do 
            code == 32 and char == :na or
            code == 13 or code == 10 -> decode(rest)
            true -> case code do
                        45 -> decode(rest, left)
                        46 -> decode(rest, right)
                        32 -> [char|decode(rest)]         
                    end
        end  
    end

    # Encodes a message into morse code.
    def encode(text) do
        encode(text, encode_table)
    end
    def encode([], _), do: []
    def encode([char | message], table) do 
       # code = lookup(char, table)
       code = tuple_lookup(char, table)
        append(code ++ ' ', encode(message, table))
    end


    defp tuple_lookup(char, tuple)do 
        elem(char, tuple)
    end

    defp lookup(char, table) do
        encoding = List.keyfind(table, char, 0)
        elem(encoding, 1)
    end
    
    defp append(c1, c2)do 
        c1 ++ c2
    end

    def fill(list)do 
        fill(list, 0)
    end
    def fill([], _)do 
        []
    end
    def fill([{c, char}| rest], n) when c == n do 
        [char | fill(rest, n + 1)]
    end
    def fill(list, n)do 
        [:na | fill(list, n + 1)]
    end
 
    def test()do 
        IO.inspect decode('.- .-.. .-..  
                          ..-- -.-- --- ..- .-. ..-- -... .- ... . 
                          ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- 
                          ..-- ..- ... ')
        IO.inspect decode('.... - - .--. ... ---... .----- .----- .-- .-- .-- 
                            .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- 
                            .----- .-- .- - -.-. .... ..--.. ...- .----. -.. 
                            .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... 
                            --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- ')
    end
end

Morse.test()