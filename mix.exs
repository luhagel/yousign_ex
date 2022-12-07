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
      source_url: @source_url,
      package: package(),
      description: description()
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
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.29", only: [:dev, :docs], runtime: false},
      {:finch, "~> 0.14"},
      {:uri_query, "~> 0.1.2"}
    ]
  end

  defp description() do
    "A thin layer around the yousign.fr API"
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "yousign_ex",
      # These are the default files included in the package
      files: ~w(lib mix.exs README*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/luhagel/yousign_ex"}
    ]
  end
end
