defmodule Huffman do 

       def sample() do
          'the quick brown fox jumps over the lazy dog
          this is a sample text that we will use when we build
          up a table we will only handle lower case letters and
          no punctuation symbols the frequency will of course not
          represent english but it is probably not that far off'
       end

        def text()  do
          'hello'
        end
    
      def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
      end

   

    def count([char | rest] = list)do    
      [{char , count(char, rest) + 1}|count(remove(list))]
    end
    def count([])do 
      []
    end
    def count(_,[])do 
      0
    end
    def count( char ,[char | rest])do  
        count(char, rest) + 1
    end
    def count(char,[_ | rest])do 
       count(char, rest)
    end

    def remove([char|rest])do 
      remove(char, rest)     
    end
    def remove(_, [])do 
      []    
     end
    def remove(char, [char|rest])do 
      remove(char, rest)      
    end
    def remove(char, [new|rest])do 
      [new | remove(char, rest)]   
    end

    def tree(sample) do 
      tree = count(sample)
      sorted = Enum.sort(tree, fn({_, x}, {_, y}) -> x < y end)
      huffman(sorted)
     end

    def huffman([{tree, _}])do
      tree 
    end
    def huffman([{c1, v1}, {c2, v2}| rest])do 
      huffman(insert({{c1, c2}, v1 + v2}, rest))
    end

    def insert({a, av}, []), do: [{a, av}]
    def insert({a, av}, [{b, bv}| rest]) when av < bv do 
      [{a, av}, {b, bv}| rest]
    end
    def insert({a, av}, [{b, bv}| rest])do 
      [{b, bv} | insert({a, av}, rest)]
    end

    def encode_table(table)do 
      encode_table(table, [], [])
    end
    def encode_table({left, right}, path, encoded)do 
      le = encode_table(left, path ++ [0], encoded)
      encode_table(right, path ++ [1], le)
    end
    def encode_table(char, path, encoded)do 
      [{char, path} | encoded]
    end

    def decode_table(table)do 
      encode_table(table, [], [])
    end


    def encode([char|rest], encoder)do 
      encode_char(char, encoder) ++ encode(rest, encoder)
    end
    def encode([], _)do 
      []
    end 
    def encode_char(char, [{char, code}| _])do 
        code
    end
    def encode_char(char, [_ | rest])do 
      encode_char(char, rest)
    end

    def decode([], _)do
      [] 
    end
    def decode(seq, table)do 
      {char, rest} = decode_char(seq, 1, table)
      [char | decode(rest, table)]
    end

    def decode_char(seq, n, table) do
      {code, rest} = Enum.split(seq, n)

      case List.keyfind(table, code, 1) do
        {char, _} ->
          {char, rest}
        nil ->
          decode_char(seq, n + 1, table)
      end
    end






      # This is the benchmark of the single operations in the
  # Huffman encoding and decoding process.

  def bench(file, n) do
    {text, b} = read(file, n)
    c = length(text)
    {tree, t2} = time(fn -> tree(text) end)
    {encode, t3} = time(fn -> encode_table(tree) end)
    s = length(encode)
    {decode, _} = time(fn -> decode_table(tree) end)
    {encoded, t5} = time(fn -> encode(text, encode) end)
    e = div(length(encoded), 8)
    r = Float.round(e / b, 3)
    {_, t6} = time(fn -> decode(encoded, decode) end)

    IO.puts("text of #{c} characters")
    IO.puts("tree built in #{t2} ms")
    IO.puts("table of size #{s} in #{t3} ms")
    IO.puts("encoded in #{t5} ms")
    IO.puts("decoded in #{t6} ms")
    IO.puts("source #{b} bytes, encoded #{e} bytes, compression #{r}")
  end

  # Measure the execution time of a function.
  def time(func) do
    initial = Time.utc_now()
    result = func.()
    final = Time.utc_now()
    {result, Time.diff(final, initial, :microsecond) / 1000}
  end

 # Get a suitable chunk of text to encode.
  def read(file, n) do
   {:ok, fd} = File.open(file, [:read])
    binary = IO.read(fd, n)
    File.close(fd)

    length = byte_size(binary)
    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, chars, rest} ->
        {chars, length - byte_size(rest)}
      chars ->
        {chars, length}
    end
  end
  
end

Huffman.bench("kallocain.txt", 1000)
