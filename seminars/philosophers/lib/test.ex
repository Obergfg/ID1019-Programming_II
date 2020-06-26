defmodule Test do
  def test(n, m) do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    seed = 1234
    Philosopher.start(n, m, c1, c2, "Arendt", ctrl, seed + 1)
    Philosopher.start(n, m, c2, c3, "Hypatia", ctrl, seed + 2)
    Philosopher.start(n, m, c3, c4, "Simone", ctrl, seed + 3)
    Philosopher.start(n, m, c4, c5, "Elisabeth", ctrl, seed + 4)
    Philosopher.start(n, m, c5, c1, "Ayn", ctrl, seed + 5)
    wait(5, [c1, c2, c3, c4, c5])
  end

  def wait(0, chopsticks) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
  end

  def wait(n, chopsticks) do
    receive do
      :done ->
        wait(n - 1, chopsticks)
      :abort ->
        Process.exit(self(), :kill)
    end
  end
end
