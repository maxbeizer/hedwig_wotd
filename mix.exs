defmodule HedwigWotd.MixProject do
  use Mix.Project

  def project do
    [
      app: :hedwig_wotd,
      version: "1.0.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "A plugin for Hedwig to get the Word of the Day",
      package: [
        name: "hedwig_wotd",
        files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/maxbeizer/hedwig_wotd"}
      ],
      source_url: "https://github.com/maxbeizer/hedwig_wotd",
      homepage_url: "https://github.com/maxbeizer/hedwig_wotd"
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
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:hedwig, "~> 1.0"},
      {:httpoison, "~> 1.0"},
      {:quinn, "~> 1.1"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
