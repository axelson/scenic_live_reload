defmodule ScenicLiveReload do
  @moduledoc """
  A simple, generic code reloader for Scenic Scenes
  """
  use GenServer
  require Logger

  defmodule State do
    @moduledoc false
    defstruct [:viewports]
  end

  def start_link(state, name \\ __MODULE__) do
    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl GenServer
  def init(opts) do
    Logger.debug("SceneReloader running #{inspect(self())}")
    viewports = Keyword.fetch!(opts, :viewports)

    state = %State{viewports: viewports}

    {:ok, state}
  end

  def reload_current_scene do
    GenServer.call(__MODULE__, :reload_current_scene)
  end

  @impl GenServer
  def handle_call(:reload_current_scene, _, state) do
    %State{viewports: viewports} = state
    Logger.info("Reloading current scene!")
    reload_current_scenes(viewports)

    {:reply, nil, state}
  end

  defp reload_current_scenes(viewports) do
    viewports
    |> Enum.each(fn
      viewport_config ->
        viewport_name = Keyword.get(viewport_config, :name)
        {:ok, viewport} = Scenic.ViewPort.info(viewport_name)
        %{scene: {scene, param}} = :sys.get_state(viewport.pid)
        Scenic.ViewPort.set_root(viewport, scene, param)
    end)
  end
end
