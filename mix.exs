defmodule EchoProtocol.Mixfile do
  use Mix.Project

  def project do
    [ app: :echo_protocol,
      version: "0.0.1",
      elixir: "~> 1.0",
      deps: deps ]
  end

  def application do
    [ mod: { EchoProtocol, [] } ]
  end

  defp deps do
    [ { :erlubi, github: "krestenkrab/erlubi" } ]
  end
end
