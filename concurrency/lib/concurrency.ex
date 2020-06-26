# defmodule Concurrency do
#    def get(cell) do
#   send(cell, {:get, self()})
#   receive do
#     {:ok, value} -> value
#   end
# end

# def set(cell, value) do
#   send(cell, {:set, value, self()})
#   receive do
#     :ok -> :ok
#   end
# end

# def do_it(thing, lock) do
#   case Cell.get(lock) do
#     :taken ->
#       do_it(thing, lock)
#     :open ->
#       Cell.set(lock, :taken)
#       do_ya_critical_thing(thing)
#       Cell.set(lock, :open)
#   end
# end

# def do_it(thing, lock) do
#   case Cell.swap(lock, :taken) do
#     :taken ->
#       do_it(thing, lock)
#     :open ->
#       do_ya_critical_thing(thing)
#       Cell.set(lock, :open)
#   end
# end
# end
