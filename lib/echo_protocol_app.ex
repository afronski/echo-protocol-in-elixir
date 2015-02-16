defmodule EchoProtocol.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Task.Supervisor, [ [ name: EchoProtocol.Connection.Supervisor ] ]),
      worker(Task, [ EchoProtocol.Application, :accept, [ 7 ]])
    ]

    options = [
      strategy: :one_for_one,
      name: EchoProtocol.Supervisor
    ]

    Supervisor.start_link(children, options)
  end

  def accept(port) do
    { :ok, socket } = :gen_tcp.listen(port, [ :binary, packet: :line, active: false ])
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    { :ok, client } = :gen_tcp.accept(socket)

    Task.Supervisor.start_child(
      EchoProtocol.Connection.Supervisor,
      fn -> echo(client) end
    )

    loop_acceptor(socket)
  end

  defp echo(socket) do
    response = read_line(socket)
    handle_response(socket, response)
  end

  defp handle_response(_, "crash\n"), do: raise "Boom!"
  defp handle_response(_, :closed), do: IO.puts "Client closed connection."
  defp handle_response(socket, response) do
    socket |> write_line(response) |> echo
  end

  defp read_line(socket) do
    { _, message } = :gen_tcp.recv(socket, 0)
    message
  end

  defp write_line(socket, message) do
    :gen_tcp.send(socket, message)
    socket
  end
 end
