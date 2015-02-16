defmodule EchoProtocol.Client do
  def echo_client(what) do
    socket = connect

    write_line(socket, what)
    ^what = read_line(socket)
  end

  defp connect do
    { :ok, socket } = :gen_tcp.connect(:localhost, 7, [ :binary, active: false ])
    socket
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
