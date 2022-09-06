defmodule ScenicLiveReloadApplication do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScenicLiveReload
    ]

    opts = [strategy: :one_for_one, name: :scenic_live_reload_supervisor]
    Supervisor.start_link(children, opts)
  end
end
