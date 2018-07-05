defmodule GatherContext.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gather_context,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps(),

      name: "GatherContext",
      source_url: "https://github.com/raisebook/gather_context",
      docs: [main: "GatherContext", extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:apex, "~>1.2.0", only: [:dev, :test]},
      {:espec, "~> 1.5.1", only: :test},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
