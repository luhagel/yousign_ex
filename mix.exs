defmodule Yousign.MixProject do
  use Mix.Project

  @source_url "https://github.com/luhagel/yousign_ex"
  @version "0.1.0"

  def project do
    [
      app: :yousign_ex,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      source_url: @source_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :jason, :uri_query],
      mod: {Yousign.Application, []}
    ]
  end

  defp docs() do
    [
      extras: [
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "trunk",
      formatters: ["html"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.3"},
      {:ex_doc, "~> 0.28.4", only: [:dev, :docs], runtime: false},
      {:finch, "~> 0.12"},
      {:uri_query, "~> 0.1.2"}
    ]
  end
end
