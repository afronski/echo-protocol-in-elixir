defmodule Computation do
  defp slow_pow do
    receive do
      { pid, x } ->
        IO.puts "Received #{x}, calculating pow(#{x}, 2)..."

        :timer.sleep(5000)
        send pid, x * x

        slow_pow
    end
  end

  def start_calculator do
    spawn(fn -> slow_pow end)
  end

  defp printer do
    receive do
      x ->
        IO.puts "Received result: #{x}"
        printer
    end
  end

  def start_receiver do
    spawn(fn -> printer end)
  end

  def pow(what, to, receiver) do
    send to, { receiver, what }
  end

  def simulate do
    printer = Computation.start_receiver

    c1 = Computation.start_calculator
    c2 = Computation.start_calculator

    10 .. 12 |> Enum.each &Computation.pow(&1, c1, printer)
     4 ..  6 |> Enum.each &Computation.pow(&1, c2, printer)
  end
end
