defmodule ScenicLiveReload do
  @moduledoc """
  A simple, generic code reloader for Scenic Scenes
  """
  use GenServer
  require Logger

  defmodule State do
    @moduledoc false
    defstruct []
  end

  def start_link(state, name \\ __MODULE__) do
    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl GenServer
  def init(_opts) do
    Logger.debug("SceneReloader running #{inspect(self())}")

    state = %State{}

    {:ok, state}
  end

  def reload_current_scene do
    GenServer.call(__MODULE__, :reload_current_scene)
  end

  @impl GenServer
  def handle_call(:reload_current_scene, _, state) do
    Logger.info("Reloading current scene!")
    reload_current_scenes()

    {:reply, nil, state}
  end

  defp reload_current_scenes do
    ScenicLiveReload.Private.GetViewPorts.view_port_pids()
    |> Enum.each(fn pid ->
      {:ok, view_port} = Scenic.ViewPort.info(pid)
      # WARNING: Private API
      %{scene: {scene, param}} = :sys.get_state(view_port.pid)
      Scenic.ViewPort.set_root(view_port, scene, param)
    end)
  end
end
