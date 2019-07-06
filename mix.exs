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
      exsync_dep(:github)
    ]
  end

  defp exsync_dep(:hex), do: {:exsync, "~> 0.2"}
  defp exsync_dep(:github), do: {:exsync, github: "falood/exsync"}
  defp exsync_dep(:path), do: {:exsync, path: "../forks/exsync"}
end
