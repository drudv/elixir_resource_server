defmodule ElixirResourceServer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_resource_server,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [applications: [:cowboy, :logger, :mongodb, :poolboy, :httpoison], mod: {ElixirResourceServer, []}]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:httpoison, "~> 1.4"},
      {:mongodb, "~> 0.4.7"},
      {:poolboy, "~> 1.5.1"},
      {:poison, "~> 4.0.1"},
      {:elixir_uuid, "~> 1.2"}
    ]
  end
end
