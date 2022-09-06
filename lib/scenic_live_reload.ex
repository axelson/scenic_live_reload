defmodule ScenicLiveReload do
  @moduledoc """
  A simple, generic code reloader for Scenic Scenes
  """
  require Logger
  use GenServer

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

  def reload_current_scenes do
    GenServer.call(__MODULE__, :reload_current_scenes)
  end

  @impl GenServer
  def handle_call(:reload_current_scenes, _, state) do
    Logger.info("ScenicLiveReload reloading current scenes!")
    reload_current_scenes()

    {:reply, nil, state}
  end

  def reload_current_scenes do
    ScenicLiveReload.Private.FetchScenicInfo.view_port_pids()
    |> Enum.each(fn pid ->
      {:ok, view_port} = Scenic.ViewPort.info(pid)
      {scene, params} = ScenicLiveReload.Private.FetchScenicInfo.get_current_scene(view_port)
      Scenic.ViewPort.set_root(view_port, scene, param)
    end)
  end
end
