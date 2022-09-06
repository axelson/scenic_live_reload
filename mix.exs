defmodule ScenicLiveReload.MixProject do
  use Mix.Project

  @app :scenic_live_reload
  @version "0.3.0"
  @github_url "https://github.com/axelson/scenic_live_reload/"

  def project do
    [
      app: @app,
      version: @version,
      description: description(),
      package: package(),
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Scenic Live Reload",
      docs: [
        canonical: "https://hexdocs.pm/scenic_live_reload"
      ],
      source_url: @github_url,
      homepage_url: @github_url
    ]
  end

  def package do
    [
      name: @app,
      files: ["lib", "mix.exs", "README*", "LICENSE*", "CHANGELOG.md"],
      maintainers: ["Jason Axelson"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @github_url}
    ]
  end

  def description do
    """
    A library that allows you to live-reload your Scenic code in development,
    utilizes exsync.
    """
  end

  def application do
    [
      mod: {ScenicLiveReloadApplication, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      dep(:exsync, :hex),
      {:scenic, "~> 0.11"}
    ]
  end

  defp dep(:exsync, :hex), do: {:exsync, "~> 0.2"}
  defp dep(:exsync, :github), do: {:exsync, github: "axelson/exsync"}
  defp dep(:exsync, :path), do: {:exsync, path: "../forks/exsync"}
end
