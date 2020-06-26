defmodule Philosopher do

  def start(hunger, strength, left, right, name, controller, seed) do
      spawn_link(fn -> dreaming(hunger, strength, left, right, name, controller, seed) end)
  end

  # Philosopher is in a dreaming state.
  defp dreaming(0, strength, _left, _right, name, ctrl, _seed) do
    IO.puts("#{name} is happy, strength is still #{strength}!")
    send(ctrl, :done)
  end

  defp dreaming(hunger, 0, _left, _right, name, ctrl, _seed) do
    IO.puts("#{name} has starved to death, hunger is down to #{hunger}!")
    send(ctrl, :done)
  end
  defp dreaming(hunger, strength, left, right, name, controller, seed) do
    IO.puts("#{name} is dreaming...")
    sleep(seed)
    waiting(hunger, strength, left, right, name, controller, seed)
  end


  # Philosopher is waiting for chopsticks.
  defp waiting(hunger, strength, left, right, name, controller, seed) do
    IO.puts("#{name} is waiting, #{hunger} to go!")

    case Chopstick.request(left, seed) do
      :ok ->
        sleep(seed)

        case Chopstick.request(right, seed) do
          :ok ->
            IO.puts("#{name} received both sticks!")
            eating(hunger, strength, left, right, name, controller, seed)

          :no ->
            IO.puts("#{name} waited for to long. Goes back dreaming")
            Chopstick.return(left)
            dreaming(hunger, strength - 1, left, right, name, controller, seed)
        end

      :no ->
        IO.puts("#{name} waited for to long. Goes back dreaming")
        dreaming(hunger, strength - 1, left, right, name, controller, seed)
    end
  end

  defp eating(hunger, strength, left, right, name, ctrl, seed) do
    IO.puts("#{name} is eating...")

    sleep(seed)

    Chopstick.return(left)
    Chopstick.return(right)

    dreaming(hunger - 1, strength, left, right, name, ctrl, seed)
  end

  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end
