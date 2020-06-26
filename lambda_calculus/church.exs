defmodule Church do

  def to_church(0) do
    fn(_, x) -> x end
  end
  def to_church(n) do
    fn(f, x) -> f.(to_church(n - 1).(f, x)) end
  end

  def to_integer(church) do
    church.(fn(x) -> 1 + x end, 0)
  end

  def succ(n) do
    fn(f, x) -> f.(n.(f, x)) end
  end

  def mul(n, m) do
    fn(f, x) -> n.(fn(y) -> m.(f, y) end, x) end
  end

  def pred(n) do
    fn(f, x) ->
      ( n.(  # n is a Church numeral
          fn(g) -> fn(h) -> h.(g.(f)) end end,  # apply this function n times 
          fn(_) -> x end)  # to this function 
      ).(fn(u) -> u end)  # apply it to thee identity function
  end
end

  def add(n, m) do
    fn(f, x) -> n.(f, m.(f, x)) end
  end

  def minus(n, m) do 
     m.(fn(x) -> pred(x) end , n)  
  end

  def totrue()do 
    fn(x,_)-> x end
  end

  def tofalse()do 
    fn(_,y)-> y end
  end

  def boolean(bool)do 
    bool.(true , false)
  end
end

number = Church.to_church(10)
nmbr = Church.to_church(5)
successor = Church.pred(number)
bool = Church.totrue()
IO.inspect Church.boolean(bool)
IO.inspect Church.to_integer(Church.minus(number, nmbr))
#IO.puts Church.to_integer(number)
