defmodule ScenicLiveReload.MixProject do
  use Mix.Project

  def project do
    [
      app: :scenic_live_reload,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ScenicLiveReload.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:scenic, "~> 0.10"},
      dep(:exsync, :github)
    ]
  end

  defp dep(:exsync, :hex), do: {:exsync, "~> 0.2"}
  defp dep(:exsync, :github), do: {:exsync, github: "axelson/exsync"}
  defp dep(:exsync, :path), do: {:exsync, path: "../forks/exsync"}
end
