defmodule Chopstick do
  def start do
    stickid = spawn_link(fn -> available() end)
    {:stick, stickid}
  end

  def request({:stick, stickid}) do
    send(stickid, {:request, self()})

    receive do
      :granted ->
        :ok
    end
  end

  def request({:stick, stickid}, timeout) do
    send(stickid, {:request, self()})
    receive do
      :granted ->
        :ok
      after timeout ->
        :no
    end
  end

  def request({:stick, s1}, {:stick, s2}, timeout) do

  end

  def return({:stick, stickid}) do
    send(stickid, :return)
  end

  def quit({:stick, stickid}) do
    send(stickid, :quit)
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, :granted)
        gone()

      :quit ->
        :ok
    end
  end

  def gone() do
    receive do
      :return ->
        available()

      :quit ->
        :ok
    end
  end
end
