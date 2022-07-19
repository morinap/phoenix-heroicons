defmodule PhoenixHeroicons.MixProject do
  use Mix.Project

  @version "0.2.0"
  @source_url "https://github.com/morinap/phoenix-heroicons.git"

  def project do
    [
      app: :phoenix_heroicons,
      version: @version,
      elixir: "~> 1.7",
      deps: deps(),
      description: "Package for rendering Heroicons in Phoenix applications",
      package: [
        links: %{
          "GitHub" => @source_url,
          "heroicons" => "https://heroicons.com/"
        },
        licenses: ["MIT"],
        maintainers: ["Andrew Morin"]
      ],
      docs: [
        main: "PhoenixHeroicons",
        source_url: @source_url,
        source_ref: "v#{@version}",
        formatters: ["html", "epub"],
        extras: ["CHANGELOG.md"]
      ],
      # Prevent our Fetcher from spitting out warnings
      xref: [
        exclude: [:httpc, :public_key]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_html, ">= 3.0.0"},
      {:phoenix_live_view, ">= 0.16.0"},
      {:floki, ">= 0.25.0"},
      {:castore, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
