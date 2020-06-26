defmodule LZW do

  @alphabet 'abcdefghijklmnopqrstuvwxyz '

    def table do
        n = length(@alphabet)
        numbers = Enum.to_list(1..n)
        map = List.zip([@alphabet, numbers])
        {n + 1, map}
    end

    def encode([]), do: []

    def encode([word | rest]) do
        table = table()
        {:found, code} = encode_word(word, table)
        encode(rest,[word], code, table)
    end

    def encode([], _sofar, code, _table), do: [code]
    def encode([word | rest], sofar, code, table) do
        extended = [word | sofar]
        case encode_word(extended, table) do
            {:found, ext} ->
                encode(rest, extended, ext, table);
            {:notfound, updated} ->
                {:found, cd} = encode_word(word, table)
                [code | encode(rest, [word], cd, updated)]
        end
    end

    def encode_word([], _), do: :na
    def encode_word(word, {_, list} = table)do 
        encode_word(word, list, table)
    end
    def encode_word(word, [{word, code}| _], _)do 
        {:found, code}
    end
    def encode_word(word, [_|rest], table)do 
        encode_word(word, rest, table)
    end
    def encode_word(word, [], {n, list} )do 
      {:notfound, {n + 1 , [{word, n}| list]}}  
    end

    def decode(codes)do 
      table = table()
      decode(codes, table)
    end
    def decode([], _)do [] end
    def decode([code | [] ], {_, list})do 
      {:found, word} = decode_word(code, list)
       [word]
    end
    def decode([code|rest], {n, list})do  

       {:found, word} = decode_word(code, list)
       [next | _] = rest  
       
       next_char = 
        case decode_word(next, list)do 
          {:found, char} -> 
            case is_list(char)do 
              true -> 
                [first|_] = char
                first
              false -> 
                char 
            end
          {:notfound} -> 
            [char| _] = word
            char
        end

        [[word] | [decode(rest, {n + 1, [{[word] ++ [next_char], n} | list]})]]
    end


    def decode_word([], _),do: :na 
    def decode_word(code, [{word, code}|_]) do 
      {:found, word}
    end
    def decode_word(code,[_| rest])do 
      decode_word(code, rest)
    end
    def decode_word(_, [])do 
      {:notfound}
    end

    def test()do 
      a = encode('hi everybody')
     # IO.inspect a
     to_string decode(a)
    end
end

IO.inspect  LZW.test()